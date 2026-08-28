-- 食契联动活动 歼灭战组件

local UIModule = CS.Engine.UI.UIModule
local cs_coroutine = require("XLua.cs_coroutine")
local ECSComponent = import("Frame.ECS.ECSComponent")

---@class ActivityLinkageBossComponent
local ActivityLinkageBossComponent = Class('ActivityLinkageBossComponent', ECSComponent)

function ActivityLinkageBossComponent:__init()
    self:CleanProperties()
    self:InitParams()
end

function ActivityLinkageBossComponent:__delete()
    if isNotNull(self.co_branchRankCountDown) then
        CoStop(self.co_branchRankCountDown)
    end
    self:CleanProperties()
end

function ActivityLinkageBossComponent:CleanProperties()
    self.activityType = nil
    self.activityContentId = nil
    self.activityUuid= nil

    self.rankInfo = nil
    self.allBossQuestData = nil
    self.playerRank = nil
    self.hurtDrawRewardId = nil
    self.historyMaxHurt = nil
    self.percentageRank = nil
    self.stagePlayerScore = nil
    self.superRareRewardIsGet = nil
    self.superRareRewardRemainTimes = nil
    self.splitRankConfig = nil
    self.splitRankCloseTime = nil
    self.branchRankScheduleId = nil
    self.branchRankInfo = nil
    self.branchPlayerRank = nil
    self.branchPercentageRank = nil

    self.co_branchRankCountDown = nil
    self.callbackOnBranchRankCountDown = nil
end

function ActivityLinkageBossComponent:InitParams()
    self.hpId = 9000037
    self.resources = { self.hpId }

    self.typeVoId = AutoIds.IdSetting6154
    self.typeVoName = "Activity.ContractOfFood.Annihilation.TypeVo"
    self.damageRewardVoId = AutoIds.IdSetting6151
    self.damageRewardVoName = "Activity.ContractOfFood.Annihilation.DamageRewardVo"
    self.rankRewardVoId = AutoIds.IdSetting6155
    self.rankRewardVoName = "Activity.ContractOfFood.Annihilation.RankRewardVo"
    self.paramVoId = AutoIds.IdSetting6150
    self.paramVoName = "Activity.ContractOfFood.Annihilation.ParamsVo"
    self.branchRankRewardVoId = AutoIds.IdSetting6719
    self.branchRankRewardVoName = "Activity.ContractOfFood.Annihilation.BranchRankRewardVo"

    self.interfaceHome = Interfaces.ActivityLinkageBossHome
    self.interfaceDrawDamageReward = Interfaces.ActivityLinkageDrawDamageReward
    self.interfaceDrawRankDailyReward = Interfaces.ActivityLinkageDrawRankDailyReward
    self.interfaceBranchRank = Interfaces.ActivityLinkageBranchRank
    self.interfaceDrawBranchRankDailyReward = Interfaces.ActivityLinkageDrawBranchRankDailyReward

    self.teamRoomDialogAnimPrefix = "ActivityDreamAdventures"
    self.selectQuestDialogAnimPrefix = "ActivityDreamAdventures"

    self.homeUITypeId = Constants.UITypeIds.UIActivityFoodAnnihilationEntryDialog
    self.teamUITypeId = Constants.UITypeIds.UIActivityFoodAnnihilationTeamDialog
    self.rankUITypeId = Constants.UITypeIds.UIActivityFoodAnnihilationRankDialog
    self.rewardPreviewUITypeId = Constants.UITypeIds.UIActivityFoodAnnihilationDamageRewardPopupDialog
    self.rankRewardPreviewUITypeId = Constants.UITypeIds.UIActivityFoodAnnihilationRankRewardPopupDialog
    self.rankDamagePreviewUITypeId = Constants.UITypeIds.UIActivityFoodAnnihilationRankDescPopupDialog
    self.branchRankUITypeId = Constants.UITypeIds.UIActivityFoodAnnihilationBranchRankDialog

    self.damageRewardCellLuaPath = "Game.UI.Common.CommonPreviewListNode"
    self.rankRewardPreviewCellLuaPath = "Game.UI.Common.CommonPreviewListNode"
    self.rankDamagePreviewCellLuaPath = "Game.UI.Common.CommonPreviewListNode"

    self.homeQuestBtnGroupLuaPath = "Game.Activity.LinkageBoss.QuestBtnGroup"
    self.homeDropItemGroupLuaPath = "Game.Activity.LinkageBoss.DropItemGroup"
end

function ActivityLinkageBossComponent:SetActivityData(activityType, activityContentId, activityUuid, activityPrefabId)
    self.activityType = activityType
    self.activityContentId = activityContentId
    self.activityUuid = activityUuid
    self.activityPrefabId = activityPrefabId
end

--- 歼灭战home页
function ActivityLinkageBossComponent:RequestHome(onEnd)
    return CoStart(function()
        local success = false
        GameUtils.Request(self.interfaceHome, {activityUuid = self.activityUuid}, function(request, response)
            success = true
            if checkNumber(response.errCode) ~= 0 then
                return
            end
            local jsonData = response.data
            self.rankInfo = jsonData.rankInfo
            self.allBossQuestData = jsonData.allBossQuestData
            self.playerRank = jsonData.playerRank
            self.hurtDrawRewardId = jsonData.hurtDrawRewardId
            self.historyMaxHurt = checkNumber(jsonData.historyMaxHurt)
            self.percentageRank = jsonData.percentageRank
            self.stagePlayerScore = jsonData.stagePlayerScore
            self.superRareRewardIsGet = checkNumber(jsonData.superRareRewardNum) <= 0 
            self.superRareRewardRemainTimes = checkNumber(jsonData.superRareRewardNum)
            self.splitRankConfig = checkTable(jsonData.splitRankConfig)
            self.splitRankCloseTime = checkNumber(jsonData.splitRankCloseTime)
            self.branchRankScheduleId = checkNumber(jsonData.scheduleId)

            -- 刷新分榜倒计时
            self:BranchRankCountDown()

            -- 更新hp（战斗现在没有地方扣体力，在这里更新体力）
            local curServerHp = jsonData.hpData.hp
            local curClientHp = GoodsUtils.GetThingNo(self.hpId)
            GoodsUtils.DrawRewards({{goodsId = self.hpId, num = curServerHp - curClientHp}}, true)

            if isNotNull(onEnd) then
                onEnd()
            end
        end)
        while not success do
            CoYield()
        end
    end)
end

--- 活动的home页数据
function ActivityLinkageBossComponent:RequestActivityHome()
    local activityDojo = {
        id = self.activityUuid,
        activityContentId = self.activityContentId,
    }
    local DreamAdventuresMgr = import("Game.Activity.DreamAdventures.DreamAdventuresMgr"):GetInstance()
    DreamAdventuresMgr:SetActivityDojo(activityDojo)
    DreamAdventuresMgr:UpdateHomeData(activityDojo)
end

--- 获取资源条内容
function ActivityLinkageBossComponent:GetResources()
    return self.resources
end

--- 购买体力
function ActivityLinkageBossComponent:BuyHP()
    local DreamAdventuresMgr = import("Game.Activity.DreamAdventures.DreamAdventuresMgr"):GetInstance()
    DreamAdventuresMgr:BuyActivityHp()
end

function ActivityLinkageBossComponent:GetBossQuestData(bossTypeId)
    return self.allBossQuestData[tostring(bossTypeId)]
end

--- 指定id的参数表数据
---@param id any
function ActivityLinkageBossComponent:GetParamVo(id)
    return CfUtils.GetCfVo(self.paramVoId, self.paramVoName, id)
end

--- 指定歼灭战类型表
---@return TypeVo
function ActivityLinkageBossComponent:GetTypeVo(bossTypeId)
    return CfUtils.GetCfVo(self.typeVoId, self.typeVoName, bossTypeId)
end

--- 获取伤害奖励表
function ActivityLinkageBossComponent:GetDamageRewardVos()
    return CfUtils.GetCf(self.damageRewardVoId, self.damageRewardVoName, true)
end

--- 获取排行榜奖励表
function ActivityLinkageBossComponent:GetRankRewardVos()
    return CfUtils.GetCf(self.rankRewardVoId, self.rankRewardVoName, true)
end

--- 获取分榜奖励表
function ActivityLinkageBossComponent:GetBranchRankRewardVos()
    return CfUtils.GetCf(self.branchRankRewardVoId, self.branchRankRewardVoName, true)
end

--- 获取组队界面的uiTypeId
function ActivityLinkageBossComponent:GetTeamUITypeId()
    return self.teamUITypeId
end

--- 获取选关界面的uiTypeId
function ActivityLinkageBossComponent:GetHomeUITypeId()
    return self.homeUITypeId
end

--- 选关界面动画名字的前缀
function ActivityLinkageBossComponent:GetSelectQuestDialogAnimationPrefix()
    return self.selectQuestDialogAnimPrefix
end

--- 组队界面动画名字的前缀
function ActivityLinkageBossComponent:GetTeamRoomDialogAnimationPrefix()
    return self.teamRoomDialogAnimPrefix
end

--- home页选关按钮组
function ActivityLinkageBossComponent:GetHomeQuestBtnGroupLuaPath()
    return self.homeQuestBtnGroupLuaPath
end

--- home页掉落物品组
function ActivityLinkageBossComponent:GetHomeDropItemGroupLuaPath()
    return self.homeDropItemGroupLuaPath
end

--- 获取超稀有奖励的获取状态
function ActivityLinkageBossComponent:GetSuperRareRewardIsGet()
    return self.superRareRewardIsGet
end

--- 获取超稀有奖励触发保底的剩余次数
function ActivityLinkageBossComponent:GetSuperRareRewardRemainTimes()
    return self.superRareRewardRemainTimes
end

--- 获取邀请助力分页控制
function ActivityLinkageBossComponent:GetInvitePages()
    return self:GetParamVo(3).num
end

--- 获取好友邀请次数上限
function ActivityLinkageBossComponent:GetFriendInviteLimit()
    return nil
end

--- 获取排行榜分榜的数量
function ActivityLinkageBossComponent:GetBranchRankNum()
    return table.count(self.splitRankConfig)
end

--- 获取当期分榜的剩余时间
function ActivityLinkageBossComponent:GetBranchRankRemainTime()
    return self.splitRankCloseTime
end

--- 是否开启语音聊天功能
function ActivityLinkageBossComponent:UseVoiceRoom()
    return checkNumber(self:GetParamVo(11).num) == 1
end

--- 获取活动的主线关卡进度
function ActivityLinkageBossComponent:GetActivityMainQuestId()
    local DreamAdventuresMgr = import("Game.Activity.DreamAdventures.DreamAdventuresMgr"):GetInstance()
    local curMainQuestId = DreamAdventuresMgr:GetMainQuestId()
    return curMainQuestId
end

--@region   伤害奖励
--- 奖励预览按钮
function ActivityLinkageBossComponent:OnRewardPreviewBtnClicked()
    local data = {
        funcRefreshDialogData = Bind(self, self.GetDamageRewardUIData),
        funcRequestGetOne = Bind(self, self.RequestGetDamageReward),
        funcRequestGetAll = Bind(self, self.RequestGetDamageReward),
        nodeDataList = self:GetDamageRewardUIData(),
        nodeLuaPath = self.damageRewardCellLuaPath,
    }
    UIModule.OpenDialog({ id = self.rewardPreviewUITypeId, parameters = {data = data}})
end

--- 请求获取伤害奖励
---@param rewardId any
---@param onSuccess any
function ActivityLinkageBossComponent:RequestGetDamageReward(rewardId, onSuccess)
    local canGetNum = self:GetDamageRewardRedPoint()
    if canGetNum == 0 then
        return
    end

    GameUtils.Request(self.interfaceDrawDamageReward, {activityUuid = self.activityUuid, rewardId = rewardId}, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end

        local jsonData = response.data
        local rewards = jsonData.rewards

        if isNull(rewards)
        or table.count(rewards) == 0 then
            return
        end

        -- 更新dojo里面的领取状态
        self:UpdateRewardGetState(rewardId)
        
        GoodsUtils.DrawRewards(rewards)
        UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = rewards } })

        if isNotNull(onSuccess) then
            onSuccess(rewards)
        end
    end)
end

--- 获取伤害奖励界面的数据
function ActivityLinkageBossComponent:GetDamageRewardUIData()
    local activityId = self.activityContentId
    local data = {}
    local vos = self:GetDamageRewardVos()
    for i, vo in ipairs(vos) do
        if vo.activityId == activityId and vo.status > 0 then
            local cellData = {
                id = vo.refId,
                name = vo.upperLimit,
                rewardsList = vo.rewardsList,
            }
            local getState = Constants.GetStatus.Not
            if self.historyMaxHurt > vo.upperLimit then
                if self.hurtDrawRewardId[tostring(vo.refId)] == 1 then
                    -- 已领取
                    getState = Constants.GetStatus.Has
                else
                    -- 可领取
                    getState = Constants.GetStatus.Can
                end
            else
                -- 未达成
                getState = Constants.GetStatus.Not
            end
            cellData.getState = getState
            table.insert(data, cellData)
        end
    end

    local order = Constants.GetStatusSortOrder
    table.sort(data, function(a, b)
        if a.getState == b.getState then
            return a.id < b.id
        else
            return order[a.getState] < order[b.getState]
        end
    end)
    -- print("[伤害奖励]", table.dump(data, nil, 5))
    return data
end

--- 更新伤害奖励领取状态
---@param rewardId any
function ActivityLinkageBossComponent:UpdateRewardGetState(rewardId)
    if isNotNull(rewardId) then
        -- 领取一个奖励
        self.hurtDrawRewardId[tostring(rewardId)] = 1
    else
        -- 一键领取所有可领取的奖励
        local data = self:GetDamageRewardUIData()
        for i, cellData in ipairs(data) do
            if cellData.getState == Constants.GetStatus.Can then
                self.hurtDrawRewardId[tostring(cellData.id)] = 1
            end
        end
    end
end

--- 获取伤害奖励的红点数量
function ActivityLinkageBossComponent:GetDamageRewardRedPoint()
    local value = 0
    local data = self:GetDamageRewardUIData()
    for i, cellData in ipairs(data) do
        if cellData.getState == Constants.GetStatus.Can then
            value = value + 1
        end
    end
    return value
end
--@endregion

--@region   排行榜

--- 排行榜按钮
function ActivityLinkageBossComponent:OnRankBtnClicked()
    UIModule.OpenDialog({ id = self.rankUITypeId, parameters = {comp = self}})
end

function ActivityLinkageBossComponent:GetRankData()
    return self.rankInfo
end

function ActivityLinkageBossComponent:GetMyRankData()
    local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
    ---@type PlayerDojo
    local playerDojo = playerComponent:GetPlayerDojo()

    local data = {}
    data.playerId = playerDojo.playerId
    data.name = playerDojo.playerName
    data.avatar = playerDojo.playerAvatar
    data.avatarFrame = playerDojo.playerAvatarFrame
    data.level = playerDojo.level
    data.ranking = self.playerRank.ranking
    data.score = self.playerRank.hurt

    return data
end

--- 排行榜排名伤害一览
function ActivityLinkageBossComponent:OnRankDamageBtnClicked()
    local data = {
        nodeDataList = self:GetRankDamagePreviewUIData(),
        nodeLuaPath = self.rankDamagePreviewCellLuaPath,
    }
    UIModule.OpenDialog({ id = self.rankDamagePreviewUITypeId, parameters = {data = data}})
end

--- 获取排名档位最低玩家的伤害值
---@param lowerLimit any
function ActivityLinkageBossComponent:GetCurrentRankDamageValue(lowerLimit)
    for i, data in ipairs(self.stagePlayerScore) do
        if checkNumber(data.rank) == lowerLimit then
            return data.score
        end
    end
end

--- 获取伤害奖励界面的数据
function ActivityLinkageBossComponent:GetRankDamagePreviewUIData()
    local activityId = self.activityContentId
    local data = {}
    local vos = self:GetRankRewardVos()
    for i, vo in ipairs(vos) do
        if vo.activityId == activityId and vo.status > 0 then
            local value = self:GetCurrentRankDamageValue(vo.lowerLimit)
            if isNull(value) then
                value = 0
            end
            local cellData = {
                id = vo.refId,
                name = vo.name,
                value = value,
            }
            table.insert(data, cellData)
        end
    end
    -- print("[伤害奖励]", table.dump(data, nil, 5))
    return data
end

--- 排行榜奖励一览
function ActivityLinkageBossComponent:OnRankRewardPreviewBtnClicked()
    local data = {
        nodeDataList = self:GetRankRewardPreviewUIData(),
        nodeLuaPath = self.rankRewardPreviewCellLuaPath,
    }
    UIModule.OpenDialog({ id = self.rankRewardPreviewUITypeId, parameters = {data = data}})
end

--- 获取伤害奖励界面的数据
function ActivityLinkageBossComponent:GetRankRewardPreviewUIData()
    local activityId = self.activityContentId
    local data = {}
    local vos = self:GetRankRewardVos()
    for i, vo in ipairs(vos) do
        if vo.activityId == activityId and vo.status > 0 then
            local cellData = {
                id = vo.refId,
                name = vo.name,
                rewardsList = vo.rewardsList,
            }
            table.insert(data, cellData)
        end
    end
    -- print("[伤害奖励]", table.dump(data, nil, 5))
    return data
end

--- 获取排行榜每日奖励红点
function ActivityLinkageBossComponent:GetRankDailyRedPoint()
    ---@type DreamAdventuresMgr
    local DreamAdventuresMgr = import("Game.Activity.DreamAdventures.DreamAdventuresMgr"):GetInstance()
    return DreamAdventuresMgr:GetFoodRankDailyReceiveTips()
end

--- 设置排行榜每日奖励红点
---@param tips any
function ActivityLinkageBossComponent:SetRankDailyRedPoint(tips)
    ---@type DreamAdventuresMgr
    local DreamAdventuresMgr = import("Game.Activity.DreamAdventures.DreamAdventuresMgr"):GetInstance()
    DreamAdventuresMgr:SetFoodRankDailyReceiveTips(tips)
end

--- 领取排行榜每日奖励
function ActivityLinkageBossComponent:GetRankDailyReward()
    self:SetRankDailyRedPoint(-1)
    GameUtils.CommonDrawRewards(self.interfaceDrawRankDailyReward, {activityUuid = self.activityUuid})
end
--@endregion

--@region   排行榜分榜

--- 请求分榜数据
---@param branchId any
---@param onScuccess any
function ActivityLinkageBossComponent:RequestBranchRank(branchId, onScuccess)
    GameUtils.Request(self.interfaceBranchRank, {activityUuid = self.activityUuid, scheduleId = branchId}, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end

        local jsonData = response.data
        self.branchRankInfo = jsonData.rankInfo
        self.branchPlayerRank = jsonData.playerRank
        self.branchPercentageRank = jsonData.percentageRank
        self.branchStagePlayerScore = jsonData.stagePlayerScore

        if isNotNull(onScuccess) then
            onScuccess()
        end
    end)
end

function ActivityLinkageBossComponent:OnBranchRankBtnClicked()
    local branchId = self.branchRankScheduleId  -- 默认打开当前的一期
    if branchId == 0 then
        -- 0表示最后一期已经结束
        branchId = self:GetTheLastBranchRankScheduleId()
    end
    self:RequestBranchRank(branchId, function()
        UIModule.OpenDialog({ id = self.branchRankUITypeId, parameters = {comp = self}})
    end)
end

--- 获取分榜每日奖励红点
function ActivityLinkageBossComponent:GetBranchRankDailyRedPoint()
    ---@type DreamAdventuresMgr
    local DreamAdventuresMgr = import("Game.Activity.DreamAdventures.DreamAdventuresMgr"):GetInstance()
    return DreamAdventuresMgr:GetFoodBranchRankDailyReceiveTips()
end

--- 设置分榜每日奖励红点
---@param tips any
function ActivityLinkageBossComponent:SetBranchRankDailyRedPoint(tips)
    ---@type DreamAdventuresMgr
    local DreamAdventuresMgr = import("Game.Activity.DreamAdventures.DreamAdventuresMgr"):GetInstance()
    DreamAdventuresMgr:SetFoodBranchRankDailyReceiveTips(tips)
end

--- 领取分榜每日奖励
function ActivityLinkageBossComponent:GetBranchRankDailyReward()
    self:SetBranchRankDailyRedPoint(-1)
    GameUtils.CommonDrawRewards(self.interfaceDrawBranchRankDailyReward, {activityUuid = self.activityUuid})
end

function ActivityLinkageBossComponent:GetBranchRankData()
    return self.branchRankInfo
end

function ActivityLinkageBossComponent:GetMyBranchRankData()
    local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
    ---@type PlayerDojo
    local playerDojo = playerComponent:GetPlayerDojo()

    local data = {}
    data.playerId = playerDojo.playerId
    data.name = playerDojo.playerName
    data.avatar = playerDojo.playerAvatar
    data.avatarFrame = playerDojo.playerAvatarFrame
    data.level = playerDojo.level
    data.ranking = self.branchPlayerRank.ranking
    data.score = self.branchPlayerRank.hurt

    return data
end

--- 分榜排名伤害一览
function ActivityLinkageBossComponent:OnBranchRankDamageBtnClicked()
    local data = {
        nodeDataList = self:GetBranchRankDamagePreviewUIData(),
        nodeLuaPath = self.rankDamagePreviewCellLuaPath,
    }
    UIModule.OpenDialog({ id = self.rankDamagePreviewUITypeId, parameters = {data = data}})
end

--- 获取排名档位最低玩家的伤害值
---@param lowerLimit any
function ActivityLinkageBossComponent:GetCurrentBranchRankDamageValue(lowerLimit)
    for i, data in ipairs(self.branchStagePlayerScore) do
        if checkNumber(data.rank) == lowerLimit then
            return data.score
        end
    end
end

--- 获取伤害奖励界面的数据
function ActivityLinkageBossComponent:GetBranchRankDamagePreviewUIData()
    local activityId = self.activityContentId
    local data = {}
    local vos = self:GetBranchRankRewardVos()
    for i, vo in ipairs(vos) do
        if vo.activityId == activityId and vo.status > 0 then
            local value = self:GetCurrentBranchRankDamageValue(vo.lowerLimit)
            if isNull(value) then
                value = 0
            end
            local cellData = {
                id = vo.refId,
                name = vo.name,
                value = value,
            }
            table.insert(data, cellData)
        end
    end
    -- print("[伤害奖励]", table.dump(data, nil, 5))
    return data
end

--- 排行榜奖励一览
function ActivityLinkageBossComponent:OnBranchRankRewardPreviewBtnClicked()
    local data = {
        nodeDataList = self:GetBranchRankRewardPreviewUIData(),
        nodeLuaPath = self.rankRewardPreviewCellLuaPath,
    }
    UIModule.OpenDialog({ id = self.rankRewardPreviewUITypeId, parameters = {data = data}})
end

--- 获取伤害奖励界面的数据
function ActivityLinkageBossComponent:GetBranchRankRewardPreviewUIData()
    local activityId = self.activityContentId
    local data = {}
    local vos = self:GetBranchRankRewardVos()
    for i, vo in ipairs(vos) do
        if vo.activityId == activityId and vo.status > 0 then
            local cellData = {
                id = vo.refId,
                name = vo.name,
                rewardsList = vo.rewardsList,
            }
            table.insert(data, cellData)
        end
    end
    print("[伤害奖励]", table.dump(data, nil, 5))
    return data
end

--- 获取分榜的排期数据
function ActivityLinkageBossComponent:GetBranchRankScheduleData()
    local data = {}
    local config = self.splitRankConfig
    for k, v in pairs(config) do
        table.insert(data, v)
    end
    table.inPlaceBubbleSort(data, function(a, b)
        return a.order < b.order
    end)

    local isUnlock = true
    local curUnlockId = self.branchRankScheduleId
    for i, v in ipairs(data) do
        v.isUnlock = isUnlock

        -- 当前排期之前的都是解锁的，之后的都是未解锁的
        local isCurrentSchedule = checkNumber(v.id) == checkNumber(curUnlockId)
        if isCurrentSchedule then
            isUnlock = false
        end
    end
    return data
end

--- 获取下一期分榜的id，如果没有下一期，返回-1
function ActivityLinkageBossComponent:GetNextBranchRankScheduleId()
    local data = {}
    local config = self.splitRankConfig
    for k, v in pairs(config) do
        table.insert(data, v)
    end
    table.inPlaceBubbleSort(data, function(a, b)
        return a.order < b.order
    end)

    local curUnlockIndex = -1
    local curUnlockId = self.branchRankScheduleId
    for i, v in ipairs(data) do
        local find = checkNumber(v.id) == checkNumber(curUnlockId)
        if find then
            curUnlockIndex = i
            break
        end
    end
    if curUnlockIndex > 0 and curUnlockIndex < #data then
        return data[curUnlockIndex + 1].id
    else
        return -1
    end
end

--- 获取最后一期分榜的id
function ActivityLinkageBossComponent:GetTheLastBranchRankScheduleId()
    local data = {}
    local config = self.splitRankConfig
    for k, v in pairs(config) do
        table.insert(data, v)
    end
    table.inPlaceBubbleSort(data, function(a, b)
        return a.order < b.order
    end)

    return data[#data].id
end

function ActivityLinkageBossComponent:BranchRankCountDown()
    -- self.splitRankCloseTime
    if isNotNull(self.co_branchRankCountDown) then
        CoStop(self.co_branchRankCountDown)
    end
    self.co_branchRankCountDown = CoStart(function()
        while true do
            if self.splitRankCloseTime <= 0 then
                break
            end
            self.splitRankCloseTime = self.splitRankCloseTime - 1
            if isNotNull(self.callbackOnBranchRankCountDown) then
                self.callbackOnBranchRankCountDown(self.splitRankCloseTime)
            end
            CoYield(1)
        end
        self:OnBranchRankCountDownEnd()
        self.co_branchRankCountDown = nil
    end)
end

--- 分榜倒计时结束，切换下一期分榜
function ActivityLinkageBossComponent:OnBranchRankCountDownEnd()
    local nextScheduleId = self:GetNextBranchRankScheduleId()
    if nextScheduleId < 0 then
        -- 已经没有下一期了
        return
    end

    self:RequestHome(function()
        Events.Broadcast(Constants.EventNames.ActivityLinkageBossBranchRankEnd)
    end)
end

--@endregion

return ActivityLinkageBossComponent