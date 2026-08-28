-- 食契联动活动 歼灭战组件

local UIModule = CS.Engine.UI.UIModule
local cs_coroutine = require("XLua.cs_coroutine")
local ECSComponent = import("Frame.ECS.ECSComponent")
local GlobalTalentAddType = Constants.GlobalTalentAddType
---@type GlobalTalentMgr
GlobalTalentMgr = GlobalTalentMgr or import('Game.GlobalTalent.GlobalTalentMgr')
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")

---@class HomelandCheckInComponent
local HomelandCheckInComponent = Class('HomelandCheckInComponent', ECSComponent)

function HomelandCheckInComponent:__init()
    self:CleanProperties()
    local isOpened = GameUtils.IsSwitchedBySystemTogId(Constants.SystemToggleIds.Id6003)
    local isUnlock = GameUtils.IsUnlockedBySystemTogId(Constants.SystemToggleIds.Id6003)
    if isOpened and isUnlock then
        self:AddListener()
    end
end

function HomelandCheckInComponent:__delete()
    self:RemoveListener()
    self:CleanProperties()
end

function HomelandCheckInComponent:CleanProperties()
    self.allGroupVos = nil

    -- 服务器上记录的已经录入的小组和等级，数组的下标索引是玩家解锁的顺序
    -- [
    --     {
    --         "groupId" = 1,
    --         "level" = 3,
    --     },
    -- ]
    self.checkInData = nil                  -- 已经录入的数据
    self.unlockCheckInNum = nil             -- 当前可以录入的小组数
    self.checkInActiveInfoByGroup = nil     -- 当前已经激活的信息
    self.groupTotalUpgradeAttr = nil        -- 每个小组升满级以后，能加多少属性

    self.eventGetNewCard = nil
    self.eventCardProgressionChanged = nil
end

function HomelandCheckInComponent:AddListener()
    self.eventGetNewCard = Events.AddListener(Constants.EventNames.GetNewCard, Bind(self, self.RefreshActiveInfo))
    self.eventCardProgressionChanged = Events.AddListener(CardProgressionConstants.EventNames.RequestSuccess, Bind(self, self.OnCardProgressionChanged))
    self.eventOnGoodsChanged = Events.AddListener(Constants.EventNames.EveryThingChangeEventName, Bind(self, self.RefreshRedPoint))
end

function HomelandCheckInComponent:RemoveListener()
    Events.RemoveListener(Constants.EventNames.GetNewCard, self.eventGetNewCard)
    Events.RemoveListener(CardProgressionConstants.EventNames.RequestSuccess, self.eventCardProgressionChanged)
    Events.RemoveListener(Constants.EventNames.EveryThingChangeEventName, self.eventOnGoodsChanged)
end

--- 卡牌养成变化时
---@param interface any
---@param data any
function HomelandCheckInComponent:OnCardProgressionChanged(interface, data)
    if interface == Interfaces.OverseaCardStarUp then
        self:RefreshActiveInfo()
    end
end

--- 服务器登陆时下发的checkIn数据
---@param data any
function HomelandCheckInComponent:InitCheckInData(data, unlockNum)
    print("[信息录入] 初始化", unlockNum, table.dump(data, nil, 3))
    self.checkInData = data
    self.unlockCheckInNum = unlockNum
    self:RefreshActiveInfo()
    self:RefreshRedPoint()
end

--- 刷新激活的信息
function HomelandCheckInComponent:RefreshActiveInfo()
    self.checkInActiveInfoByGroup = {}

    for index, groupData in ipairs(self.checkInData) do
        if isNotNull(groupData) then
            local groupId = checkNumber(groupData.groupId)
            local level = checkNumber(groupData.level)
            local active1Index, active1Vo = self:GetActiveAttr1(groupId)
            local active2Index, active2Vo = self:GetActiveAttr2(groupId)
            local active3Vo = self:GetGroupUpgradeVoByLevel(groupId, level)
            local activeInfo = {
                index1 = active1Index,  -- 模块1激活的索引
                vo1 = active1Vo,        -- 模块1激活的vo
                index2 = active2Index,  -- 模块2激活的索引
                vo2 = active2Vo,        -- 模块2激活的vo
                level = level,          -- 当前等级
                vo3 = active3Vo,        -- 等级激活的vo
            }
            self.checkInActiveInfoByGroup[groupId] = activeInfo
        end
    end

    -- 刷新全局加成数据
    self:RefreshGlobalAttrAddition()
end

--- 刷新全局属性加成
function HomelandCheckInComponent:RefreshGlobalAttrAddition()
    if isNull(self.checkInActiveInfoByGroup) then
        return
    end

    local addtionSource = Constants.GlobalTalentSource.CheckIn
    ---@type GlobalTalentMgr
    local globalTalentMgr = GlobalTalentMgr:GetInstance()
    -- 先清理加成
    globalTalentMgr:RemoveTalentBySource(addtionSource)
    -- 再重新加一遍
    for groupId, activeInfo in pairs(self.checkInActiveInfoByGroup) do
        -- 人数加成
        local multi1 = 0
        if activeInfo.index1 > 0 then
            multi1 = activeInfo.vo1.attrNums[1]  -- 模块1的加成
        end

        -- 星级加成
        local multi2 = 1
        if activeInfo.index2 > 0 then
            multi2 = activeInfo.vo2.attrNums[1]  -- 模块2的加成
        end

        -- 等级加成
        if isNotNull(activeInfo.vo3) then
            local totalAttr = self:GetGroupTotalUpgradeAttr(groupId, activeInfo.level)
            -- -- 加成类型
            -- local addType = isPercentage and GlobalTalentAddType.BaseAdd or GlobalTalentAddType.Percent
            local addType = GlobalTalentAddType.BaseAdd

            for color, attrs in pairs(totalAttr) do
                for attrId, num in pairs(attrs) do
                    local addValue = math.floor(num * multi1 * multi2)
                    local condition = {
                        stackType = 1,  -- 叠加
                        param1 = color,
                    }
                    local talentEffectId = GameUtils.CalculateBattleAttrTalentEffectId(attrId)
                    -- print("[信息录入] 全局加成", attrId, talentEffectId, num, addValue, color)
                    globalTalentMgr:AppendTalent(talentEffectId, addtionSource, addType, addValue, {}, condition)
                end
            end
        end
    end
end

--- 获取已录入的战斗员的激活信息
---@param groupId any
function HomelandCheckInComponent:GetCheckInActiveInfo(groupId)
    return self.checkInActiveInfoByGroup[groupId]
end

--- 获取信息录入系统加成
---@param attrAddId any
function HomelandCheckInComponent:GetGlobalAttrAddition(attrAddId)
    ---@type GlobalTalentMgr
    local globalTalentMgr = GlobalTalentMgr:GetInstance()

    local talentEffectId = GameUtils.CalculateBattleAttrTalentEffectId(attrAddId)
    local value = globalTalentMgr:CalcNumBySource(Constants.GlobalTalentSource.CheckIn, 0, talentEffectId, false, function(info) return true end)
    return value
end

--- 刷新小红点
function HomelandCheckInComponent:RefreshRedPoint()
    local unlockInfo = self:GetNextUnlockInfo()
    local new = unlockInfo.hasNext and unlockInfo.isUnlocked
    local isGoodsEnough = GoodsUtils.CheckGoodConsumeCondition(unlockInfo.costItems)
    GameUtils.SetRedPointNum(Constants.RedPointConst.HomelandCheckInUnlockBtn, (new and isGoodsEnough) and 1 or 0)
end

---------------- 请求服务器

--- 请求解锁小队数量
function HomelandCheckInComponent:RequestUnlock(costItems)
    GameUtils.Request(Interfaces.HomelandCheckInUnlock, {}, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        local jsonData = response.data
        self.unlockCheckInNum = checkNumber(jsonData.collectionCheckinNum)
        -- 通知界面刷新
        Events.Broadcast(Constants.EventNames.HomelandCheckInDataRefresh)
        self:RefreshRedPoint()
        -- 前端扣道具
        if isNotNull(costItems) then
            GoodsUtils.ConsumeGoods(costItems, true)
        end
    end)
    -- -- 测试数据
    -- self.unlockCheckInNum = self.unlockCheckInNum + 1
    -- -- 通知界面刷新
    -- Events.Broadcast(Constants.EventNames.HomelandCheckInDataRefresh)
    -- self:RefreshRedPoint()
end

--- 请求建立小队
---@param groupId any
function HomelandCheckInComponent:RequestBuild(groupId, callback)
    GameUtils.Request(Interfaces.HomelandCheckInBuild, {groupId = groupId}, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        table.insert(self.checkInData, 1, {groupId = groupId, level = 1})
        xTry(function()
            self:RefreshActiveInfo()
        end)
        Events.Broadcast(Constants.EventNames.HomelandCheckInDataRefresh)
        if isNotNull(callback) then
            callback()
        end
        self:RefreshRedPoint()
    end)

    -- table.insert(self.checkInData, 1, {groupId = groupId, level = 1})
    -- xTry(function()
    --     self:RefreshActiveInfo()
    -- end)
    -- Events.Broadcast(Constants.EventNames.HomelandCheckInDataRefresh)
    -- if isNotNull(callback) then
    --     callback()
    -- end
    -- self:RefreshRedPoint()
end

--- 请求升级小队
---@param groupId any
function HomelandCheckInComponent:RequestUpgrade(groupId, consumes, callback)
    GameUtils.Request(Interfaces.HomelandCheckInUpgrade, {groupId = groupId}, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        -- 刷新数据
        GoodsUtils.ConsumeGoods(consumes, true)
        local jsonData = response.data
        
        for index, groupData in ipairs(self.checkInData) do
            if groupData.groupId == groupId then
                self.checkInData[index].level = checkNumber(jsonData.level)
            end
        end
        xTry(function()
            self:RefreshActiveInfo()
        end)

        -- 刷新界面
        Events.Broadcast(Constants.EventNames.HomelandCheckInDataRefresh)
        if isNotNull(callback) then
            callback() -- 数据刷新要放前面，防止刷新界面时数据还没有刷新
        end
        self:RefreshRedPoint()
    end)

    -- GoodsUtils.ConsumeGoods(consumes, true)
    -- for index, groupData in ipairs(self.checkInData) do
    --     if groupData.groupId == groupId then
    --         self.checkInData[index].level = groupData.level + 1
    --     end
    -- end
    -- xTry(function()
    --     self:RefreshActiveInfo()
    -- end)
    -- Events.Broadcast(Constants.EventNames.HomelandCheckInDataRefresh)
    -- if isNotNull(callback) then
    --     callback()
    -- end
end

--- 请求信息录入的数据
function HomelandCheckInComponent:RequestInfo()
    local success = false
    GameUtils.Request(Interfaces.HomelandCheckInInfo, {}, function(request, response)
        success = true
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        local jsonData = response.data
        local info = checkTable(jsonData.info)
        local checkInData = checkTable(info.collectionCheckin)
        local unlockCheckInNum = checkNumber(info.collectionCheckinNum)
        self.checkInData = checkInData
        self.unlockCheckInNum = unlockCheckInNum
        self:RefreshActiveInfo()
        self:RefreshRedPoint()
    end)
    while not success do
        cs_coroutine.yield_return()
    end
end
---------------- 数据逻辑

function HomelandCheckInComponent:GetOpenGroupCount()
    return #self:GetAllGroupVo()
end

--- 获取已经解锁的小队的ids
function HomelandCheckInComponent:GetUnlockedGroupIds()
    local ids = {}
    for i, data in ipairs(self.checkInData) do
        if isNotNull(data) then
            table.insert(ids, checkNumber(data.groupId))
        end
    end
    return ids
end

--- 获取已经解锁的小队的vos
function HomelandCheckInComponent:GetUnlockedGroupVos()
    local vos = {}
    local ids = self:GetUnlockedGroupIds()
    for i, id in ipairs(ids) do
        local vo = self:GetGroupVo(checkNumber(id))
        table.insert(vos, vo)
    end
    return vos
end

--- 获取当前已经解锁的小队数量
function HomelandCheckInComponent:GetCurUnlockNum()
    return #self.checkInData
end

--- 获取下一个解锁的信息
---@param curUnlockNum any
function HomelandCheckInComponent:GetNextUnlockInfo()
    local curUnlockNum = self:GetCurUnlockNum()
    local nextUnlockNum = curUnlockNum + 1

    local hasNext = true

    -- 如果房间数量超过了开放的小队的数量，也不再显示下一个房间
    if nextUnlockNum > self:GetOpenGroupCount() then
        hasNext = false
        return {hasNext = false}
    end

    local vo = self:GetGroupUnlockVoByUnlockNum(nextUnlockNum)
    if isNull(vo) then
        hasNext = false
        return {hasNext = false}
    end

    if vo.unlockType == 0 then
        printError("[信息录入] 有小组的解锁条件类型为0")
        return {hasNext = false}
    end

    local isUnlocked = GameUtils.IsUnlockedSingle(vo.unlockType, vo.unlockNum, vo.unlockId)
    local unlockDesc = GameUtils.GetUnlockDescr(vo.unlockType, vo.unlockNum, vo.unlockId)

    local needCost = curUnlockNum >= self.unlockCheckInNum
    local costItems = vo.costItems

    return {
        hasNext = hasNext,
        isUnlocked = isUnlocked,
        unlockDesc = unlockDesc,
        needCost = needCost,
        costItems = costItems,
    }
end

--- 获取组里面玩家已经拥有的卡牌数量
---@param groupId any
function HomelandCheckInComponent:GetHasCardNum(groupId)
    local hasNum = 0
    local vo = self:GetGroupVo(groupId)
    if isNull(vo) then
        return hasNum
    end

    ---@type CardComponent
    local cardComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)

    local members = vo.members
    for i, memberId in ipairs(members) do
        local has = cardComp:IsHasCard(memberId)
        if has then
            hasNum = hasNum + 1
        end
    end
    return hasNum
end

--- 获取组里面玩家已经拥有的卡牌列表
---@param groupId any
function HomelandCheckInComponent:GetHasCardList(groupId)
    local vo = self:GetGroupVo(groupId)
    if isNull(vo) then
        return {}
    end

    ---@type CardComponent
    local cardComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)

    local hasList = {}
    local members = vo.members
    for i, memberId in ipairs(members) do
        local has = cardComp:IsHasCard(memberId)
        if has then
            local cardDojo = cardComp:GetCardByConfId(memberId)
            table.insert(hasList, cardDojo)
        end
    end
    return hasList
end

--- 获取小组成员总数
---@param groupId any
function HomelandCheckInComponent:GetGroupMember(groupId)
    local vo = self:GetGroupVo(groupId)
    if isNull(vo) then
        return 0
    end
    local members = vo.members
    return members, table.count(members)
end

--- 获取小组里的卡牌数和星星数
---@param groupId any
function HomelandCheckInComponent:GetCardNumAndStarNum(groupId)
    local hasList = self:GetHasCardList(groupId)
    local _, cardNumMax = self:GetGroupMember(groupId)
    local cardNum = table.count(hasList)
    local starNumMax = cardNumMax * Constants.CardMaxStar
    local starNum = 0
    for i, cardDojo in ipairs(hasList) do
        starNum = starNum + cardDojo.star
    end
    return cardNum, cardNumMax, starNum, starNumMax
end

--- 获取小组的等级
---@param groupId any
function HomelandCheckInComponent:GetGroupLevel(groupId)
    local level = 1
    for i, data in ipairs(self.checkInData) do
        if groupId == checkNumber(data.groupId) then
            level = checkNumber(data.level)
            return level
        end
    end
    return level
end

--- 获取临近的一个小组的id
---@param groupId any
---@param lastOrNext any
function HomelandCheckInComponent:GetSiblingGroupId(groupId, lastOrNext)
    local curIndex = 1
    for i, data in ipairs(self.checkInData) do
        local curGroupId = checkNumber(data.groupId)
        if groupId == curGroupId then
            curIndex = i
            break
        end
    end
    local count = #self.checkInData
    if lastOrNext == 1 then
        -- 上一个
        return curIndex == 1 and self.checkInData[count].groupId or self.checkInData[curIndex - 1].groupId
    elseif lastOrNext == 2 then
        -- 下一个
        return curIndex == count and self.checkInData[1].groupId or self.checkInData[curIndex + 1].groupId
    end
end

--- 获取成员数量可以激活的最大属性
---@param groupId any
function HomelandCheckInComponent:GetActiveAttr1(groupId)
    local hasNum = self:GetHasCardNum(groupId)

    local vos = self:GetBonusVos(groupId, 1)
    table.sort(vos, function(a, b)
        return a.num < b.num
    end)

    local maxIndex = 0
    local activeVo = nil
    local count = #vos
    for i = 1, count, 1 do
        local needNum = vos[i].num
        if hasNum >= needNum then
            maxIndex = i
            activeVo = vos[i]
        end
    end

    return maxIndex, activeVo
end

--- 获取成员星级可以激活的最大属性
---@param groupId any
---@param memberList any
function HomelandCheckInComponent:GetActiveAttr2(groupId)
    local dojoList = self:GetHasCardList(groupId)
    local cardComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
    local totalStar = 0
    for i, dojo in ipairs(dojoList) do
        local star = 0
        local cardDojo = dojo
        star = cardDojo.star
        if star >= 0 then
            totalStar = totalStar + star
        end
    end

    local vos = self:GetBonusVos(groupId, 2)
    table.sort(vos, function(a, b)
        return a.num < b.num
    end)

    local maxIndex = 0
    local activeVo = nil
    local count = #vos
    for i = 1, count, 1 do
        local needNum = vos[i].num
        if totalStar >= needNum then
            maxIndex = i
            activeVo = vos[i]
        end
    end

    return maxIndex, activeVo
end

--- 获取属性加成，加满的时候是多少
---@param groupId any
function HomelandCheckInComponent:GetAttrAdditionalMax(groupId, type)
    local vos = self:GetBonusVos(groupId, type)
    table.sort(vos, function(a, b)
        return a.num > b.num
    end)

    local attrNumMax = vos[1].attrNums[1]
    return attrNumMax
end

--- 获取小队属性，加满是多少
---@param groupId any
function HomelandCheckInComponent:GetGroupTotalUpgradeAttr(groupId, level)
    if isNull(self.groupTotalUpgradeAttr) then
        self.groupTotalUpgradeAttr = {}
    end

    local levelMax = self:GetGroupUpgradeLevelMax(groupId)
    level = level or levelMax
    level = math.min(level, levelMax)

    if isNotNull(self.groupTotalUpgradeAttr[groupId]) then
        if isNotNull(self.groupTotalUpgradeAttr[groupId][level]) then
            return self.groupTotalUpgradeAttr[groupId][level]
        end
    else
        self.groupTotalUpgradeAttr[groupId] = {}
    end
    local attrAdd = {}
    local vos = self:GetGroupUpgradeVos(groupId)
    for i, vo in ipairs(vos) do
        if vo.level <= level then
            local attrIds = vo.attrIds
            local attrNums = vo.attrNums
            local colors = vo.colors
            local count = #attrIds
            for i = 1, count, 1 do
                local attrId = attrIds[i]
                local color = colors[i] or 0
                local num = attrNums[i]
                if isNull(attrAdd[color]) then
                    attrAdd[color] = {}
                end
                if isNull(attrAdd[color][attrId]) then
                    attrAdd[color][attrId] = 0
                end
                attrAdd[color][attrId] = attrAdd[color][attrId] + num
            end
        end
    end
    self.groupTotalUpgradeAttr[groupId][level] = attrAdd
    return attrAdd
end

--- 检查小组是否已经解锁
---@param groupId any
function HomelandCheckInComponent:IsGroupUnlocked(groupId)
    return isNotNull(self:GetCheckInActiveInfo(groupId))
end

---------------- 读取配置信息

--- 获取加成vo
---@param id any
---@return CheckInBonusVo
function HomelandCheckInComponent:GetBonusVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting6292, "CheckInBonusVo", id)
end

--- 获取组里的加成表idList
---@param groupId any
---@param typeId any
function HomelandCheckInComponent:GetBonusGroupIdList(groupId, typeId)
    local cid = groupId..'_'..typeId
    local ids = CfUtils.GetIdGroupValue(AutoIds.IdSetting6292, cid, 'ids')
    local idList = parse_strings(ids, ',')
    return idList
end

--- 获取组里的全部加成vo
---@param groupId any
---@param typeId any
function HomelandCheckInComponent:GetBonusVos(groupId, typeId)
    local vos = {}
    local ids = self:GetBonusGroupIdList(groupId, typeId)
    for i, id in ipairs(ids) do
        local vo = self:GetBonusVo(checkNumber(id))
        table.insert(vos, vo)
    end
    return vos
end

--- 获取分组表vo
---@param groupId number
---@return CheckInGroupVo
function HomelandCheckInComponent:GetGroupVo(groupId)
    return CfUtils.GetCfVo(AutoIds.IdSetting6291, "CheckInGroupVo", groupId)
end

--- 获取全部分组表vo
---@return CheckInGroupVo[]
function HomelandCheckInComponent:GetAllGroupVo()
    if isNotNull(self.allGroupVos) then
        return self.allGroupVos
    end

    local vos = CfUtils.GetWholeVo(AutoIds.IdSetting6291, "CheckInGroupVo")

    local openVos = {}
    for i, vo in ipairs(vos) do
        if vo.status == 1 then
            table.insert(openVos, vo)
        end
    end

    table.sort(openVos, function(a, b)
        return checkNumber(a.refId) < checkNumber(b.refId)
    end)

    self.allGroupVos = openVos

    return openVos
end

--- 获取信息录入参数表vo
---@param id any
---@return CheckInParamVo
function HomelandCheckInComponent:GetParamVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting6301, "CheckInParamVo", id) or {}
end

--- 获取小队解锁vo
---@param id any
---@return CheckInGroupUnlockConditionVo
function HomelandCheckInComponent:GetGroupUnlockVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting6302, "CheckInGroupUnlockConditionVo", id)
end

--- 获取解锁第n个小组的解锁vo
---@param n integer 第n个小组
function HomelandCheckInComponent:GetGroupUnlockVoByUnlockNum(n)
    local cid = n
    local ids = CfUtils.GetIdGroupValue(AutoIds.IdSetting6302, cid, 'ids')
    if isNull(ids) then
        return
    end
    local idList = parse_strings(ids, ',')
    local voId = checkNumber(idList[1])
    local vo = self:GetGroupUnlockVo(voId)
    return vo
end

--- 获取小队升级vo
---@param id any
---@return CheckInGroupUpgradeVo
function HomelandCheckInComponent:GetGroupUpgradeVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting6303, "CheckInGroupUpgradeVo", id)
end

--- 获取小组升级的最大等级
---@param groupId any
function HomelandCheckInComponent:GetGroupUpgradeLevelMax(groupId)
    local cid = groupId
    local ids = CfUtils.GetIdGroupValue(AutoIds.IdSetting6303, cid, 'ids', 'IDGroup')
    if isNull(ids) then
        return 1
    end
    local idList = parse_strings(ids, ',')
    local max = #idList
    return max
end

--- 获取指定小组的全部升级表vo
---@param groupId integer 小组id
function HomelandCheckInComponent:GetGroupUpgradeVos(groupId)
    local cid = groupId
    local ids = CfUtils.GetIdGroupValue(AutoIds.IdSetting6303, cid, 'ids', 'IDGroup')
    local idList = parse_strings(ids, ',')
    local vos = {}
    for i, id in ipairs(idList) do
        local vo = self:GetGroupUpgradeVo(checkNumber(id))
        if isNotNull(vo) then
            table.insert(vos, vo)
        end
    end
    return vos
end

--- 获取指定小组的指定等级的升级表vo
---@param groupId integer 小组id
---@param level integer 小组等级
function HomelandCheckInComponent:GetGroupUpgradeVoByLevel(groupId, level)
    local cid = groupId..'_'..level
    local ids = CfUtils.GetIdGroupValue(AutoIds.IdSetting6303, cid, 'ids', 'IDGroup2')
    if isNull(ids) then
        return
    end
    local idList = parse_strings(ids, ',')
    local voId = checkNumber(idList[1])
    local vo = self:GetGroupUpgradeVo(voId)
    return vo
end

return HomelandCheckInComponent