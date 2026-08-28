-------------------------------------------------------------------------------
-- Pass卡模块
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-11-29 15:25:15
-------------------------------------------------------------------------------

local PassCardUtils = import('Game.UI.PassCard.PassCardUtils')
local ECSComponent  = import('Frame.ECS.ECSComponent')

---@class PassCardComponent : ECSComponent
local PassCardComponent = Class('PassCardComponent', ECSComponent)


function PassCardComponent:__init()
    self.name = 'PassCardComponent'

    ---@type integer @ 当前赛季的id
    self.scheduleId_ = 0

    ---@type table @ 缓存数据
    self.cacheDataMap_ = {}

    ---@type table[] @ 领取数据列表
    self.drawDataList_ = {}

    ---@type PassCardHomeDojo
    self.passHomeDojo_ = import('Game.Dojo.PassCard.PassCardHomeDojo').New()

    ---@type PassCardTaskDojo
    self.passTaskDojo_ = import('Game.Dojo.PassCard.PassCardTaskDojo').New()
end


function PassCardComponent:__delete()
    self.scheduleId_    = nil
    self.cacheDataMap_  = nil
    self.drawDataList_  = nil
    self.passHomeDojo_  = nil
    self.passTaskDojo_  = nil
end


-------------------------------------------------
-- get / set

---@return PassCardHomeDojo
function PassCardComponent:GetHomeDojo()
    return self.passHomeDojo_
end


---@return PassCardTaskDojo
function PassCardComponent:GetTaskDojo()
    return self.passTaskDojo_
end


---@return table[]
function PassCardComponent:GetDrawDataList()
    return self.drawDataList_
end


--- 是否解锁了 普通Pass卡
---@return boolean
function PassCardComponent:IsUnlockNormalPass()
    return self:GetHomeDojo().passCardType >= PassCardUtils.PassType.NORMAL
end


--- 是否解锁了 豪华Pass卡
---@return boolean
function PassCardComponent:IsUnlockDeluxePass()
    return self:GetHomeDojo().passCardType >= PassCardUtils.PassType.DELUXE
end


--- Pass卡经验道具id
---@return integer
function PassCardComponent:GetPassExpGoodsId()
    if not self.cacheDataMap_.passExpGoodsId then
        local scheduleId = self:GetHomeDojo().scheduleId
        local passPlanVo = PassCardUtils.GetPassCardPlanVo(scheduleId)
        self.cacheDataMap_.passExpGoodsId = checkInt(passPlanVo.passExpGoodsId)
    end
    return self.cacheDataMap_.passExpGoodsId
end


--- Pass卡展示是否为卡牌
---@return boolean
function PassCardComponent:IsPassLobbyIsCard()
    local lobbyType = GoodsUtils.GetIdType(self:GetPassLobbyCardId())
    return lobbyType == Constants.IDType.CharacterCard
end


--- Pass卡展示卡牌id
---@return integer
function PassCardComponent:GetPassLobbyCardId()
    if not self.cacheDataMap_.passLobbyCardId then
        local scheduleId = self:GetHomeDojo().scheduleId
        local passPlanVo = PassCardUtils.GetPassCardPlanVo(scheduleId)
        self.cacheDataMap_.passLobbyCardId = checkInt(passPlanVo.lobbyModeId)
    end
    return self.cacheDataMap_.passLobbyCardId
end


--- Pass卡最大等级
---@return integer
function PassCardComponent:GetPassLevelMax()
    if not self.cacheDataMap_.passLevelMax then
        local scheduleId = self:GetHomeDojo().scheduleId
        local passPlanVo = PassCardUtils.GetPassCardPlanVo(scheduleId)
        self.cacheDataMap_.passLevelMax = checkInt(passPlanVo.passLevelMax)
    end
    return self.cacheDataMap_.passLevelMax
end


--- Pass卡是否满级
---@return boolean
function PassCardComponent:IsPassLevelMax()
    local passCardLevel = self:GetHomeDojo().passCardLevel
    return passCardLevel >= self:GetPassLevelMax()
end


--- 获取 普通Pass卡 商品dojo
---@return PassCardHomeProductDojo
function PassCardComponent:GetNormalProductDojo()
    local productId = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.NORMAL_PARSS_PRODUCT)
    return self:GetHomeDojo():GetProductDojo(productId)
end


--- 获取 豪华Pass卡 商品dojo
---@return PassCardHomeProductDojo
function PassCardComponent:GetDeluxeProductDojo()
    local productId = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.DELUXE_PARSS_PRODUCT)
    return self:GetHomeDojo():GetProductDojo(productId)
end


--- 获取 豪华Pass卡 查价商品dojo
---@return PassCardHomeProductDojo
function PassCardComponent:GetDeluxeDiffProductDojo()
    local productId = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.DELUXE_DIFF_PRODUCT)
    return self:GetHomeDojo():GetProductDojo(productId)
end


--- 获取 普通Pass卡 所有奖励数据字典（合并过后的）
---@return table<string, table>
function PassCardComponent:GetAllNormalRewardDataMap()
    if not self.cacheDataMap_.allNormalRewardDataMap then
        local scheduleId = self:GetHomeDojo().scheduleId
        local passPlanVo = PassCardUtils.GetPassCardPlanVo(scheduleId)
        self.cacheDataMap_.allNormalRewardDataMap = PassCardUtils.GetAllRewardDataMap(passPlanVo.scheduleId, {PassCardUtils.PassType.NORMAL})
    end
    return self.cacheDataMap_.allNormalRewardDataMap
end


--- 获取 普通Pass卡 所有奖励数据列表（合并过后的）
---@return table[]
function PassCardComponent:GetAllNormalRewardDataList()
    if not self.cacheDataMap_.allNormalRewardDataList then
        local rewardDataMap  = self:GetAllNormalRewardDataMap()
        local rewardDataList = PassCardUtils.ConvertRewardDataMapToList(rewardDataMap)
        self.cacheDataMap_.allNormalRewardDataList = rewardDataList
    end
    return self.cacheDataMap_.allNormalRewardDataList
end


--- 获取 豪华Pass卡 所有奖励数据字典（合并过后的）
---@return table<string, table>
function PassCardComponent:GetAllDeluxeRewardDataMap()
    if not self.cacheDataMap_.allDiffDeluxeRewardDataMap then
        local scheduleId = self:GetHomeDojo().scheduleId
        local passPlanVo = PassCardUtils.GetPassCardPlanVo(scheduleId)
        self.cacheDataMap_.allDiffDeluxeRewardDataMap = PassCardUtils.GetAllRewardDataMap(passPlanVo.scheduleId, {PassCardUtils.PassType.DELUXE})
    end
    return self.cacheDataMap_.allDiffDeluxeRewardDataMap
end


--- 获取 豪华Pass卡 所有奖励数据列表（合并过后的）
---@return table[]
function PassCardComponent:GetAllDeluxeRewardDataList()
    if not self.cacheDataMap_.allDeluxeRewardDataList then
        local rewardDataMap  = self:GetAllDeluxeRewardDataMap()
        local rewardDataList = PassCardUtils.ConvertRewardDataMapToList(rewardDataMap)
        self.cacheDataMap_.allDeluxeRewardDataList = rewardDataList
    end
    return self.cacheDataMap_.allDeluxeRewardDataList
end


--- 获取 普通+豪华Pass卡 所有奖励数据字典（合并过后的）
---@return table<string, table>
function PassCardComponent:GetAllNormalAndDeluxeRewardDataMap()
    if not self.cacheDataMap_.allNormalAndDeluxeRewardDataMap then
        local scheduleId = self:GetHomeDojo().scheduleId
        local passPlanVo = PassCardUtils.GetPassCardPlanVo(scheduleId)
        self.cacheDataMap_.allNormalAndDeluxeRewardDataMap = PassCardUtils.GetAllRewardDataMap(passPlanVo.scheduleId, {PassCardUtils.PassType.NORMAL, PassCardUtils.PassType.DELUXE})
    end
    return self.cacheDataMap_.allNormalAndDeluxeRewardDataMap
end


--- 获取 普通+豪华Pass卡 所有奖励数据列表（合并过后的）
---@return table[]
function PassCardComponent:GetAllNormalAndDeluxeRewardDataList()
    if not self.cacheDataMap_.allNormalAndDeluxeRewardDataList then
        local rewardDataMap  = self:GetAllNormalAndDeluxeRewardDataMap()
        local rewardDataList = PassCardUtils.ConvertRewardDataMapToList(rewardDataMap)
        self.cacheDataMap_.allNormalAndDeluxeRewardDataList = rewardDataList
    end
    return self.cacheDataMap_.allNormalAndDeluxeRewardDataList
end


--- 获取 循环宝箱 道具数据
---@return table
function PassCardComponent:GetLoopChestData()
    if not self.cacheDataMap_.loopChestData then
        local scheduleId = self:GetHomeDojo().scheduleId
        local passPlanVo = PassCardUtils.GetPassCardPlanVo(scheduleId)
        local chestData  = {
            icon    = passPlanVo.loopChestIcon,
            rewards = {
                {goodsId = passPlanVo.loopChestId, num = passPlanVo.loopChestNum}
            }
        }
        self.cacheDataMap_.loopChestData = chestData
    end
    return self.cacheDataMap_.loopChestData
end


--- 获取 循环宝箱 每个领取经验
---@return integer
function PassCardComponent:GetLoopChestEachExp()
    if not self.cacheDataMap_.loopChestEachExp then
        local scheduleId = self:GetHomeDojo().scheduleId
        local passPlanVo = PassCardUtils.GetPassCardPlanVo(scheduleId)
        self.cacheDataMap_.loopChestEachExp = checkInt(passPlanVo.loopExpNum)
    end
    return self.cacheDataMap_.loopChestEachExp
end


-------------------------------------------------
-- public

--- 请求最新 Pass卡主页数据
---@param callback fun():void
function PassCardComponent:SyncPassHomeData(callback)
    GameUtils.Request(Interfaces.OverseaPassCardHome, {}, function(request, response)
        if checkInt(response.errCode) == 0 then

            -- update homeDojo
            local responseData = checkTable(response.data)
            self:GetHomeDojo():Fill(responseData)

            -- check update cache
            local oldScheduleId = self.scheduleId_
            local newScheduleId = self:GetHomeDojo().scheduleId
            if oldScheduleId ~= newScheduleId then

                -- update scheduleId
                self.scheduleId_ = newScheduleId

                -- clear cacheDataMap
                self.cacheDataMap_ = {}

                -- rebuild allDrawDataList
                self:RebuildDrawDataList_()
            end

            -- update passLevel
            self:UpdatePassCardExp(self:GetHomeDojo().passCardTotalExp)

            -- sync playerDojo passScheduleId
            GameUtils.GetPlayerDojo().passScheduleId = newScheduleId

            -- done callback
            if callback then
                callback()
            end
        end
    end)
end


--- 请求最新 Pass卡任务数据
---@param callback fun():void
function PassCardComponent:SyncPassTaskData(callback)
    GameUtils.Request(Interfaces.OverseaPassCardTask, {}, function(request, response)
        if checkInt(response.errCode) == 0 then

            -- update taskDojo
            local responseData = checkTable(response.data)
            self:GetTaskDojo():Fill(responseData)

            -- done callback
            if callback then
                callback()
            end
        end
    end)
end


-------------------------------------------------------------------------------
-- about level
-------------------------------------------------------------------------------

--- 更新 Pass卡经验
---@param newExp integer @ 最新Pass卡经验
function PassCardComponent:UpdatePassCardExp(newPassExp)
    local newTotalExp   = checkInt(newPassExp)
    local passLevelData = PassCardUtils.ConvertPassExpToLevel(newTotalExp, self:GetPassLevelMax())
    self:GetHomeDojo().passCardTotalExp = newTotalExp
    self:GetHomeDojo().passCardLevel    = passLevelData.level
    
    if self:IsPassLevelMax() then
        self:GetHomeDojo().passCardOverExp = passLevelData.exp
        self:UpdateDrawnCircleTimes(self:GetHomeDojo().drawnCircleTimes)
    else
        self:GetHomeDojo().passCardOverExp = 0
        self:UpdateDrawnCircleTimes(0)
        self:GetHomeDojo().passCardShowExp = passLevelData.exp
    end

    Events.Broadcast(PassCardUtils.EventName.PASS_CARD_EXP_CHANGE)
end


--- 更新 循环宝箱次数
---@param drawnTimes integer @ 最新已经领取次数
function PassCardComponent:UpdateDrawnCircleTimes(drawnTimes)
    local loopChestEachExp   = self:GetLoopChestEachExp()
    local passCardOverExp    = self:GetHomeDojo().passCardOverExp
    local drawnCircleTimes   = checkInt(drawnTimes)
    local canDrawPassCardExp = passCardOverExp - (drawnCircleTimes * loopChestEachExp)
    local canDrawCircleTimes = loopChestEachExp > 0 and math.floor(canDrawPassCardExp / loopChestEachExp) or 0

    self:GetHomeDojo().drawnCircleTimes   = drawnCircleTimes
    self:GetHomeDojo().canDrawCircleTimes = canDrawCircleTimes
    self:GetHomeDojo().passCardShowExp    = canDrawPassCardExp

    Events.Broadcast(PassCardUtils.EventName.PASS_CARD_LOOP_TIMES)
end


--- 更新 Pass卡类型
---@param passCardType PassCardUtils.PassType
function PassCardComponent:UpdatePassCardType(passCardType)
    self:GetHomeDojo().passCardType = passCardType
    Events.Broadcast(PassCardUtils.EventName.PASS_CARD_TYPE_CHANGE)
end


-------------------------------------------------------------------------------
-- about rewards
-------------------------------------------------------------------------------

--- 生成领取奖励数据列表
function PassCardComponent:RebuildDrawDataList_()
    self.drawDataList_ = {}
    local lastStageId  = 0
    local scheduleId   = self:GetHomeDojo().scheduleId
    local allRewardIds = PassCardUtils.GetAllRewardIds(scheduleId)
    for rewardIndex = #allRewardIds, 1, -1 do
        local rewardId = checkInt(allRewardIds[rewardIndex])
        local rewardVo = PassCardUtils.GetPassCardRewardVo(rewardId)
        if rewardVo:IsStageReward() then
            lastStageId = rewardIndex
        end
        self.drawDataList_[rewardIndex] = {
            rewardId        = checkInt(rewardId),
            rewardVo        = rewardVo,
            passLevel       = checkInt(rewardVo.passLevel),
            freeGoodsData   = {goodsId = rewardVo.freeGoodsId,   num = rewardVo.freeGoodsNum,   text = 'x'..rewardVo.freeGoodsNum,   isShowNo = true},
            normalGoodsData = {goodsId = rewardVo.normalGoodsId, num = rewardVo.normalGoodsNum, text = 'x'..rewardVo.normalGoodsNum, isShowNo = true},
            deluxeGoodsData = {goodsId = rewardVo.deluxeGoodsId, num = rewardVo.deluxeGoodsNum, text = 'x'..rewardVo.deluxeGoodsNum, isShowNo = true},
            stageDrawIndex  = lastStageId,  -- 所属的阶段奖励
        }
    end
end


--- 是否 领取了指定位置的 免费奖励
---@param drawIndex integer
---@return boolean
function PassCardComponent:IsDrawnFreeRewardsAt(drawIndex)
    ---@type PassCardRewardVo
    local rewardVo = self:GetDrawDataList()[drawIndex].rewardVo
    return self:GetHomeDojo():IsDrawnRewardsId(rewardVo.freeDrawId)
end


--- 是否 领取了指定位置的 普通奖励
---@param drawIndex integer
---@return boolean
function PassCardComponent:IsDrawnNormalRewardsAt(drawIndex)
    ---@type PassCardRewardVo
    local rewardVo = self:GetDrawDataList()[drawIndex].rewardVo
    return self:GetHomeDojo():IsDrawnRewardsId(rewardVo.normalDrawId)
end


--- 是否 领取了指定位置的 豪华奖励
---@param drawIndex integer
---@return boolean
function PassCardComponent:IsDrawnDeluxeRewardsAt(drawIndex)
    ---@type PassCardRewardVo
    local rewardVo = self:GetDrawDataList()[drawIndex].rewardVo
    return self:GetHomeDojo():IsDrawnRewardsId(rewardVo.deluxeDrawId)
end


--- 是否 领取了指定位置的 全部奖励
---@param drawIndex integer
---@return boolean
function PassCardComponent:IsDrawnAllRewardsAt(drawIndex)
    return self:IsDrawnFreeRewardsAt(drawIndex) and self:IsDrawnNormalRewardsAt(drawIndex) and self:IsDrawnDeluxeRewardsAt(drawIndex)
end


--- 是否 解锁了指定位置的 免费奖励
---@param drawIndex integer
---@return boolean
function PassCardComponent:IsUnlockFreeRewardsAt(drawIndex)
    local passLevel = self:GetDrawDataList()[drawIndex].passLevel
    return self:GetHomeDojo().passCardLevel >= passLevel
end


--- 是否 解锁了指定位置的 普通奖励
---@param drawIndex integer
---@return boolean
function PassCardComponent:IsUnlockNormalRewardsAt(drawIndex)
    return self:IsUnlockFreeRewardsAt(drawIndex) and self:IsUnlockNormalPass()
end


--- 是否 解锁了指定位置的 豪华奖励
---@param drawIndex integer
---@return boolean
function PassCardComponent:IsUnlockDeluxeRewardsAt(drawIndex)
    return self:IsUnlockFreeRewardsAt(drawIndex) and self:IsUnlockDeluxePass()
end


--- 是否 解锁了指定位置的 全部奖励
---@param drawIndex integer
---@return boolean
function PassCardComponent:IsUnlockAllRewardsAt(drawIndex)
    return self:IsUnlockFreeRewardsAt(drawIndex) and self:IsUnlockNormalPass() and self:IsUnlockDeluxePass()
end


--- 获取 全部奖励中可领取的id列表
---@return integer[]
function PassCardComponent:GetAllCanDrawIdList()
    local drawIdList = {}
    for drawIndex, drawData in ipairs(self:GetDrawDataList()) do
        ---@type PassCardRewardVo
        local rewardVo = drawData.rewardVo
        -- check freeReward
        if self:IsUnlockFreeRewardsAt(drawIndex) and not self:IsDrawnFreeRewardsAt(drawIndex) then
            table.insert(drawIdList, rewardVo.freeDrawId)
        end
        -- check normalReward
        if self:IsUnlockNormalRewardsAt(drawIndex) and not self:IsDrawnNormalRewardsAt(drawIndex) then
            table.insert(drawIdList, rewardVo.normalDrawId)
        end
        -- check normalReward
        if self:IsUnlockDeluxeRewardsAt(drawIndex) and not self:IsDrawnDeluxeRewardsAt(drawIndex) then
            table.insert(drawIdList, rewardVo.deluxeDrawId)
        end
    end
    return drawIdList
end


--- 是否 指定位置 有可领取的奖励
---@param drawIndex integer
---@return boolean
function PassCardComponent:HasCanDrawRewardsAt(drawIndex)
    -- check freeReward
    if self:IsUnlockFreeRewardsAt(drawIndex) and not self:IsDrawnFreeRewardsAt(drawIndex) then
        return true
    end
    -- check normalReward
    if self:IsUnlockNormalRewardsAt(drawIndex) and not self:IsDrawnNormalRewardsAt(drawIndex) then
        return true
    end
    -- check normalReward
    if self:IsUnlockDeluxeRewardsAt(drawIndex) and not self:IsDrawnDeluxeRewardsAt(drawIndex) then
        return true
    end
    return false
end


--- 是否 有可领取的奖励
function PassCardComponent:HasCanDrawRewards()
    for drawIndex, _ in ipairs(self:GetDrawDataList()) do
        if self:HasCanDrawRewardsAt(drawIndex) then
            return true
        end
    end
    return false
end


-------------------------------------------------------------------------------
-- about redPoint
-------------------------------------------------------------------------------

--- 检测Pass卡日常任务红点
---@return boolean
function PassCardComponent:CheckDailyTaskRedPoint()
    local hasRedPoint = false

    for _, taskDojo in ipairs(self:GetTaskDojo().dailyTaskList) do
        if taskDojo:CanDraw() then
            hasRedPoint = true
            break
        end
    end

    GameUtils.SetRedPointNum(Constants.RedPointConst.BattlePassTaskCommon , hasRedPoint and 1 or 0)
    return hasRedPoint
end


--- 检测Pass卡精英任务红点
---@return boolean
function PassCardComponent:CheckEliteTaskRedPoint()
    local hasRedPoint = false

    for _, taskDojo in ipairs(self:GetTaskDojo().eliteTaskList) do
        if taskDojo:CanDraw() then
            hasRedPoint = true
            break
        end
    end

    GameUtils.SetRedPointNum(Constants.RedPointConst.BattlePassTaskElite , hasRedPoint and 1 or 0)
    return hasRedPoint
end


--- 检测Pass卡全部任务红点
---@return boolean
function PassCardComponent:CheckPassTaskRedPoint()
    local hasDailyRed = self:CheckDailyTaskRedPoint()
    local hasEliteRed = self:CheckEliteTaskRedPoint()
    local hasRedPoint = hasDailyRed or hasEliteRed

    GameUtils.SetRedPointNum(Constants.RedPointConst.BattlePassTask , hasRedPoint and 1 or 0)
    return hasRedPoint
end


--- 检测Pass卡领取奖励红点
---@return boolean
function PassCardComponent:CheckPassRewardsRedPoint()
    local hasRedPoint = false

    -- check chest rewards
    if self:GetHomeDojo().canDrawCircleTimes > 0 then 
        hasRedPoint = true
    end

    -- check has rewards
    if hasRedPoint == false then
        hasRedPoint = self:HasCanDrawRewards()
    end

    GameUtils.SetRedPointNum(Constants.RedPointConst.BattlePassRewards, hasRedPoint and 1 or 0)
    return hasRedPoint
end


return PassCardComponent
