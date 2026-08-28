---TODO 重构Condition 分隔符模式太蠢了

------------ import ------------
local UIModule           = CS.Engine.UI.UIModule
local Time               = CS.UnityEngine.Time
local KTool              = CS.Engine.Lib.KTool
local blocker            = CS.Engine.UI.UIRaycastBlocker.Instance
local cs_coroutine       = require "XLua.cs_coroutine"
---@type GuideUtils
local GuideUtils = import('Game.UI.Guide.GuideUtils')
---@type ActionUtils
local ActionUtils = import('Game.UI.FightReady.UIMainChapter.ActionUtils')
------------ import ------------


------------ define ------------
local SafeUnpack         = SafeUnpack
local checkNumber        = checkNumber
local parse_strings      = parse_strings
local GuideConditionType = Constants.GuideConditionType
--- 退出重连条件类型
local GuideExitReconnectConditionType = Constants.GuideExitReconnectConditionType

local ParseStringByLevel = GuideUtils.ParseStringByLevel
local SplitFlagLevel     = GuideUtils.SplitFlagLevel

local IsEmpty = function(str)
    return string.isEmpty(str) or str == "0"
end
------------ define ------------

---@class GuideComponentConditionPartial
local GuideComponentConditionPartial = Class('GuideComponentConditionPartial')

function GuideComponentConditionPartial:__init()
    self._str2Cache = {}
end

function GuideComponentConditionPartial:__delete()
    self.context = nil
end



---------------------------------------------------
--- logic begin --
---------------------------------------------------

---CheckModuleConfig
---检查模块配置
---@param systemGuideModuleVo SystemGuideModuleVo 系统引导表 vo
---@param conditionGroups table 引导条件组
function GuideComponentConditionPartial:CheckModuleConfig(systemGuideModuleVo, conditionGroups)
    local vo = systemGuideModuleVo
    --- 如果该模块拥有 断线重连模块步骤id列表 并且该模块满足条件 则替换
    local moduleSteps = vo.exitAdd2
    if next(moduleSteps) and self:CheckConditionByGroups(conditionGroups) then
         local index = self:CheckExitAdd2Condition(vo.exitAdd2params)
        if index == 0 then return end
        local moduleStepStr = moduleSteps[index]
        return parse_strings(moduleStepStr, "#")
    end
end

---CheckCondition
---检查条件   warn: 条件类型为负数 是 自定义条件   通用条件为 Constants.CommonUnlockType
---@param condition string 条件字符串  (条件类型,条件参数;条件类型,条件参数)
function GuideComponentConditionPartial:CheckCondition(condition, splitFlag)
    --- 无条件 返回满足
    if IsEmpty(condition) then
        return true
    end
    local conditionGroups = parse_strings(condition)
    return self:CheckConditionByGroups(conditionGroups, splitFlag)
end


---CheckModuleCompleteCondition
---@param curModuleStep SystemGuideModuleStepVo
function GuideComponentConditionPartial:CheckCompleteCondition(curModuleStep)
    local completeCondition = curModuleStep.completeCondition
    if IsEmpty(completeCondition) then
        return false
    end
    -- print("completeCondition", completeCondition)
    -----17#-13^0:-14^MaidCoffee_IsPopPcTips^1;
    local completeConditionGroup = parse_strings(completeCondition, ";")
    local isComplete = true
    local skipStepCount = 0
    for i, oneCompleteCondition in ipairs(completeConditionGroup) do
        local res, count = self:CheckOneCompleteCondition(oneCompleteCondition)
        isComplete = isComplete and res
        if count then
            skipStepCount = math.max(skipStepCount, count)
        end
    end
    return isComplete, skipStepCount
end

function GuideComponentConditionPartial:CheckOneCompleteCondition(completeCondition)
    local conditionType, conditionParams = SafeUnpack(parse_strings(completeCondition, "#"))
    return self:CheckOneCondition(conditionType, conditionParams)
end

---CheckExitAdd2Condition
---检查断线退出条件
---@param exitAdd2params table
function GuideComponentConditionPartial:CheckExitAdd2Condition(exitAdd2params)
    if next(exitAdd2params) == nil then
        return 1
    end

    local conditionType, conditionParams = SafeUnpack(exitAdd2params)
    local res = self:CheckOneCondition(conditionType, conditionParams)
    return res and 2 or 1

    -- local exitReconnectType, exitReconnectParams = SafeUnpack(exitAdd2params)
    -- exitReconnectType = checkNumber(exitReconnectType)
    -- if exitReconnectType == GuideExitReconnectConditionType.TeamCardCount then
    --     local questId, cardCount = SafeUnpack(parse_strings(exitReconnectParams, ":"))
    --     local teamComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.TeamComponent)
    --     local teamTab       = teamComponent:GetTeamByQuestId(questId) or {}
    --     local teamCardCount = teamComponent:GetTeamMemberCount(teamTab)
    --     return teamCardCount >= checkNumber(cardCount) and 1 or 2

    -- elseif exitReconnectType ==  GuideExitReconnectConditionType.EquipUpLevel then
    --    ---@type EquipmentComponent
    --     local equipComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.EquipmentComponent)
    --     ---@type EquipDojo[]
    --     local equipDojos     = equipComponent:GetAllEquips()
    --     local equipId        = checkNumber(exitReconnectParams)
    --     for i, v in ipairs(equipDojos) do
    --         if checkNumber(v.equipmentId) == equipId then
    --             return checkNumber(v.level) <= 1 and 1 or 2
    --         end
    --     end
    --     return 1
    -- end

end

---CheckIsConfigCondition
---@param condition string
function GuideComponentConditionPartial:CheckIsConfigCondition(condition)
    return string.isEmpty(condition) or condition == "0"
end

---CheckConditionByGroups
---检查条件组合列表
---@param groups table {[1] = 条件类型,条件参数, [2] = 条件类型,条件参数}
function GuideComponentConditionPartial:CheckConditionByGroups(groups, splitFlag)
    local isSatisfy = true
    if next(groups) == nil then return isSatisfy end

    for i, group in pairs(groups) do
        isSatisfy = isSatisfy and self:CheckConditionByGroup(group, splitFlag)
    end
    return isSatisfy
end

function GuideComponentConditionPartial:CheckConditionGroupList(groupList, isSingle)
    local isSatisfy = true
    if next(groupList) == nil then return isSatisfy end
    for i, group in pairs(groupList) do
        isSatisfy = isSatisfy and self:CheckOneConditionByCondition(group, isSingle)
    end
    return isSatisfy
end

---CheckOneConditionByCondition
---通过条件配置检查一个条件
---@param condition table {conditionType, conditionParams}
function GuideComponentConditionPartial:CheckOneConditionByCondition(condition, isSingle)
    local conditionType, conditionParams = SafeUnpack(condition)
    return self:CheckOneCondition(conditionType, conditionParams, isSingle)
end

---CheckConditionByGroup
---检查条件组合
---@param group table {条件类型,条件参数}
function GuideComponentConditionPartial:CheckConditionByGroup(group, splitFlag, isSingle)
    splitFlag = splitFlag == nil and "#" or splitFlag
    local conditionType, conditionParams = SafeUnpack(parse_strings(group, splitFlag))
    return self:CheckOneCondition(conditionType, conditionParams, isSingle)
end

function GuideComponentConditionPartial:CheckOneCondition(conditionType, conditionParams, isSingle)
    
    conditionType = checkNumber(conditionType)

    if conditionType > 0 then
        if isSingle then
           return GameUtils.IsUnlockedSingle(conditionType, conditionParams)
        end
        return GameUtils.IsUnlocked(tostring(conditionType), conditionParams)

    elseif conditionType == GuideConditionType.SystemFunction then
        return GameUtils.IsUnlockedBySystemTogId(conditionParams)

    elseif conditionType == GuideConditionType.CheckIsUnlockChapter then
        return self.context:CheckIsCanActiveLoopModule(Constants.GuideModule.UnlockChapter)

    elseif conditionType == GuideConditionType.RegionEntry then
        ---@type RegionEntryVo
        local vo = ActionUtils.GetRegionEntryVo(conditionParams)
        if vo == nil then
            return false
        end
        local isUnlock = GameUtils.IsUnlockedSingle(vo.unlockType, vo.unlockNum, vo.unlockId)
        return isUnlock
        
    elseif conditionType == GuideConditionType.OwnCardCount then
        ---@type CardComponent
        local comp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
        return comp:GetCardOwnCount() >= checkNumber(conditionParams)

    elseif conditionType == GuideConditionType.CompletePreModule then
        ---@type GuideComponent
        local context  = self.context
        local moduleId = context:GetCompleteModuleId()

        --- 不是等待执行的模块 就说明 已通过前置模块
        return moduleId >= checkNumber(conditionParams)

    elseif conditionType == GuideConditionType.GachaponPool then
        local poolId  = conditionParams
        ---@type GachaponGuideVo
        local setting = CfUtils.GetCfVo(AutoIds.IdSetting383, "GachaponGuideVo", poolId)
        local goodsId = setting.singleProp
        local consume = setting.singleConsume
        local curOp   = QuestConfMgr:GetInstance():GetCurOpId()
        return curOp == 0 and GoodsUtils.GetThingNo(goodsId) < consume

    elseif conditionType == GuideConditionType.CardCultivate then
        ---@return GoodsConfMgr
        local goodsConfMgr     = GoodsConfMgr:GetInstance()
        local consumeGoodsList = goodsConfMgr:GetExpGoodsVoList()
        ---@type GoodsVo
        local goodsVo          = consumeGoodsList[1]
        local goodsId          = goodsVo.refId
        local effectNum        = goodsVo.effectNum
        local goldConsume      = GameUtils.GetConsumeAspect(Constants.UpGradeConsume.CardConsume) * effectNum
        --- 无基础猫球 或者 金币不足
        return GoodsUtils.GetThingNo(goodsId) < 1 or GoodsUtils.GetThingNo(Constants.Currency.GoldId) < goldConsume

    elseif conditionType == GuideConditionType.EquipCultivate then
        --- 如果以前装过 装备 直接判断模块完成
        ---@type EquipmentComponent
        local equipComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.EquipmentComponent)
        local equips = equipComponent:GetAllEquips()
        local isCompleteModule = false
        ---@param equipDojo EquipDojo
        for i, equipDojo in ipairs(equips) do
            isCompleteModule = checkNumber(equipDojo.playerCardId) > 0
            if isCompleteModule then
                break
            end
        end
        return isCompleteModule

    elseif conditionType == GuideConditionType.ResourcesQuest then
        ---@type DailyQuestComponent
        local dailyQuestComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.DailyQuestComponent)
        return dailyQuestComponent:GetOneCompleteAllConditionQuestIdByQuestType(1) > checkNumber(conditionParams)

    elseif conditionType == GuideConditionType.CompleteSpecifyModule then
        local moduleId = checkNumber(conditionParams)
        ---@type GuideComponent
        local context  = self.context
        if moduleId >= 1000 then
            local completeSpecialGuide = context:GetCompleteSpecialGuide()
            return completeSpecialGuide[tostring(moduleId)] ~= nil
        end
        return context:GetCompleteModuleId() >= moduleId

    elseif conditionType == GuideConditionType.BattleEndResult then
        if BattleInfo == nil or BattleEndMgr == nil then
            return false
        end
        local res = checkNumber(conditionParams)
        if BattleEndMgr.passType ~= res or BattleInfo.gameMode == Constants.GameMode.PVP then
            return false
        end
        local passType      = BattleEndMgr.passType
        local questType     = BattleEndMgr.questType
        local showData      = BattleEndMgr.showData
        local isShowRole    = BattleEndMgr:GetPanelShowType(passType, questType, showData.response)
        local isDirectional = questType == Constants.IDType.QuestDirectionalFight
        local showDefeat    = (not isShowRole) and (not isDirectional)
        local showCardDJ    = BattleEndMgr:GetJump2CultivateCardDJ()
        return showDefeat and showCardDJ ~= nil

    elseif conditionType == GuideConditionType.WaitSpecifyTimeInDialog then
        local res, lastDialog = self:CheckLastDialogIsExists()
        if not res then
            return res
        end
        local dialogId, waitTime = self:GetDialogIdAndWaitTime(conditionParams)
        if lastDialog.Argument.id ~= checkNumber(dialogId) then
            if self.dialogId2WaitTime and self.dialogId2WaitTime[dialogId] then
                self.dialogId2WaitTime[dialogId] = nil
            end
        else
            self.dialogId2WaitTime = self.dialogId2WaitTime or {}
            local startTime   = self.dialogId2WaitTime[dialogId]
            local elapsedTime = 0
            ---故意让他受暂停影响
            if startTime then
                elapsedTime = Time.unscaledTime - startTime
            else
                self.dialogId2WaitTime[dialogId] = Time.unscaledTime
            end
            local res = elapsedTime >= checkNumber(waitTime)
            if res then
                --- 在检查下blocker 如果这时候还有Blocker 则不触发循环引导
                --- 开启网络请求 必有blocker
                --- 由于是网络请求走协程开启的 还是可能会触发循环引导 
                res = blocker.ConditionsCount <= 0
                self.dialogId2WaitTime = nil
            end
            return res

        end

    elseif conditionType == GuideConditionType.CallDialogFunc then
        local res, lastDialog = self:CheckLastDialogIsExists()
        if not res then
            return res
        end
        local dialogId, funcName = SafeUnpack(parse_strings(conditionParams, ":"))

        if lastDialog.Argument.id ~= checkNumber(dialogId) or not lastDialog.IsShow or lastDialog.Env[funcName] == nil then
            return false
        end
        local Env = lastDialog.Env
        ---CatHouseInteractionDialog:IsChild()  funcName = IsChild
        return Env[funcName](Env)

    elseif conditionType == GuideConditionType.EditTeamIsOwnCard then
        local res, lastDialog = self:CheckLastDialogIsExists()
        if not res then
            return res
        end
        local dialogId = checkNumber(conditionParams)
        if lastDialog.Argument.id ~= dialogId or not lastDialog.IsShow then
            return false
        end
        ---@type UIFightTeamDialog
        local Env = lastDialog.Env
        if isNull(Env) then
            return false
        end

        local index = Env:GetPlayerCardIndex()
        return index ~= nil and index >= 1

    elseif conditionType == GuideConditionType.CheckLocalDataDate then
        local localDataName, res   = SafeUnpack(parse_strings(conditionParams, ":"))
        local lastDate             = checkNumber(CfUtils.GetLocalData(localDataName))
        local t                    = timestamp_to_time(os.time())
        return (checkNumber(t.day) == checkNumber(lastDate)) == (checkNumber(res) == 1)

    elseif conditionType == GuideConditionType.IsPCPlatform then
        local res = checkNumber(conditionParams) == 1
        return GameUtils.IsPCPlatform() == res

    elseif conditionType == GuideConditionType.CheckLocalData then
        local localDataName, res = SafeUnpack(parse_strings(conditionParams, ":"))
        return checkNumber(CfUtils.GetLocalData(localDataName)) == checkNumber(res or 1)

    elseif conditionType == GuideConditionType.CheckLadderSeason then
        --- 还未想好依赖于接口返回的数据 的条件怎么处理 先这样实现
        self._requestPath = Interfaces.LADDER_HOME
        local yield_return = cs_coroutine.yield_return
        while self._responseData == nil do
            yield_return()
        end
        local responseData = self._responseData.data
        self._responseData = nil
        local localSeasonKey = Constants.PlayerPrefsType.LadderCompetionSeasonId
        local localSeason  = checkInt(CfUtils.GetLocalData(localSeasonKey, '0'))
        if  localSeason == checkNumber(responseData.lastSeason) and
                (checkNumber(responseData.season) - checkNumber(responseData.lastSeason) == 1) then
            return false
        end
        return true

    elseif conditionType == GuideConditionType.CheckIsAdvanceLevelUp then
        local res, lastDialog = self:CheckLastDialogIsExists()
        if not res then
            return res
        end
        local dialogId = conditionParams
        if lastDialog.Argument.id ~= checkNumber(dialogId) or not lastDialog.IsShow then
            return false
        end
        
        ---@type CardProgressionConstants
        local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
        ---@type CardProgressionMainDialog
        local Env = lastDialog.Env
        ---@type CardProgressionConstants.MainViewType
        local mainViewType = Env:GetSelectTabViewType()
        if mainViewType == CardProgressionConstants.MainViewType.AdvanceLevel then
            ---@type CardProgressionAdvanceLevelUp
            local levelEnv   = Env:GetEnvByViewType(mainViewType)
            local uiIsAdLvUp = levelEnv:GetIsCanAdvanceLevelUp()
            return uiIsAdLvUp
        end
        return false

    elseif conditionType == GuideConditionType.ConditionOR then
        ---17#-13^0:-14^MaidCoffee_IsPopPcTips^1
        ---conditionParams->>  -13^0 : -14^MaidCoffee_IsPopPcTips^1
        local level3Group = ParseStringByLevel(SplitFlagLevel.Level3, conditionParams)
        local res = false
        for i, v in ipairs(level3Group) do
            res = res or self:CheckOneCondition(SafeUnpack(ParseStringByLevel(SplitFlagLevel.Level4, v)))
        end
        return res

    elseif conditionType == GuideConditionType.CheckIsCompleteCanPopMaidCoffReport then
        ---弹过 || (是PC && PC弹窗未弹过)
        local isPop = self:CheckOneCondition(GuideConditionType.CheckLocalDataDate, "MaidCoffeeReportEnterTime:1")
        return isPop or 
                (GameUtils.IsPCPlatform() and 
                        self:CheckOneCondition(GuideConditionType.CheckLocalData, "MaidCoffee_IsPopPcTips:0"))
        
    elseif conditionType == GuideConditionType.CheckIsCompleteCanPopMaidCoffPCTips then
        local isPop = self:CheckOneCondition(GuideConditionType.CheckLocalData, "MaidCoffee_IsPopPcTips:1")
        --- 是否弹过 || 不是PC
        return isPop or not GameUtils.IsPCPlatform() 

    elseif conditionType == GuideConditionType.CheckIsDrawChapterRewards then
        return QuestConfMgr:GetInstance():IsDrawChapterReward(conditionParams)

    elseif conditionType == GuideConditionType.CheckIsOwnManager then
        ---@type MaidCoffeeComponent
        local component = GameUtils.GetEntityCompByType(ECSComponentType.Constants.MaidCoffeeComponent)
        if component == nil then
            return false
        end
        local MaidCoffeeConstants = import("Game.MaidCoffee.MaidCoffeeConstants")
        local id = component:GetStaffInfoByType(MaidCoffeeConstants.SelectType.Manager, 1)
        return id > 0, checkNumber(conditionParams)
    elseif conditionType == GuideConditionType.CheckIsHaveMenuSell then
        ---@type MaidCoffeeComponent
        local component = GameUtils.GetEntityCompByType(ECSComponentType.Constants.MaidCoffeeComponent)
        if component == nil then
            return false
        end
        return component:IsHaveMenuSell(), checkNumber(conditionParams)
    elseif conditionType == GuideConditionType.CheckIsShowCatBall then
        local res, lastDialog = self:CheckLastDialogIsExists()
        if not res then
            return res
        end
        local dialogId = conditionParams
        if lastDialog.Argument.id ~= checkNumber(dialogId) or not lastDialog.IsInitialized then
            return false
        end

        ---@type UIFightTeamDialog
        local Env = lastDialog.Env
        if isNull(Env) then
            return false
        end
        ---依赖于界面数据 界面改 要跟着改
        local curLevelId = Env.curLevelId
        local curLevelType = Env.curLevelType
        return QuestConfMgr:GetInstance():IsShowCatBall(curLevelId, curLevelType)
    
    elseif conditionType == GuideConditionType.CheckIsSelectCoreStore then
        local res, lastDialog = self:CheckLastDialogIsExists()
        if not res then
            return res
        end
        local dialogId = Constants.UITypeIds.GroceryDialog
        if lastDialog.Argument.id ~= checkNumber(dialogId) or not lastDialog.IsShow then
            return false
        end

        ---@type GroceryDialog
        local Env = lastDialog.Env
        if isNull(Env) then
            return false
        end

        ---@type GroceryConstants
        local GroceryConstants = import('Game.Grocery.GroceryConstants')
        return Env:GetSelectedGroceryType() == GroceryConstants.GroceryType.Coin

    elseif conditionType == GuideConditionType.CheckIsUnlockFishMenu then
        local goodsRecords = self.context:GetGoodsRecords()
        local goodsIds     = goodsRecords[Constants.IDType.RestaurantRecipeGoods]
        if goodsIds == nil then
            return false
        end
        local res = false
        ---@type MaidCoffeeUtils
        local MaidCoffeeUtils     = import("Game.MaidCoffee.MaidCoffeeUtils")
        for goodsId, _ in pairs(goodsIds) do
            ---@type MaidCoffeeMenuMakeVo
            local vo = MaidCoffeeUtils.GetMaidCoffeeMenuMakeVo(goodsId)
            ---检查是否是鱼料理
            res = vo.type == 3
            if res then
                break
            end
        end
        
        return res
    elseif conditionType == GuideConditionType.CheckCombatEffTipsGuide then
        local res, lastDialog = self:CheckLastDialogIsExists()
        if not res then
            return res
        end
        local dialogId = Constants.UITypeIds.UIFightTeamChoose
        if lastDialog.Argument.id ~= checkNumber(dialogId) or not lastDialog.IsShow then
            return false
        end

        ---@type UIFightTeamDialog
        local Env = lastDialog.Env
        if isNull(Env) then
            return false
        end

        return Env.CheckCombatEffTipsGuideCondition ~= nil and Env:CheckCombatEffTipsGuideCondition(checkNumber(conditionParams))

    elseif conditionType == GuideConditionType.CheckTeamCardCount then
        local res, lastDialog = self:CheckLastDialogIsExists()
        if not res then
            return res
        end
        local dialogId = Constants.UITypeIds.UIFightTeamChoose
        if lastDialog.Argument.id ~= checkNumber(dialogId) or not lastDialog.IsShow then
            return false
        end

        ---@type UIFightTeamDialog
        local Env = lastDialog.Env
        if isNull(Env) then
            return false
        end
        return Env.CheckTeamCardCount ~= nil and Env:CheckTeamCardCount(checkNumber(conditionParams))
    elseif conditionType == GuideConditionType.CheckOnlineRewards then
        ---@type PlayerComponent
        local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
        if playerComponent == nil then
            return false
        end
        return playerComponent:IsOpenOnlineRewards()
    elseif conditionType == GuideConditionType.MainViewPragmatic then
        ---@type HotPointCollectionComponent
        local component = GameUtils.GetEntityCompByType(ECSComponentType.Constants.HotPointCollectionComponent)
        if component == nil then
            return true
        end
        return not component:GetIsPlaying()
    else
        printError("guide---------------->>>> error 未知条件类型类型 %s", conditionType)
    end

        return false
end

function GuideComponentConditionPartial:CheckLastDialogIsExists()
    local CurrentScreen = UIModule.CurrentScreen
    if isNull(CurrentScreen) then
        return false, nil
    end
    ---@type Engine.UI.UILuaDialog
    local lastDialog = CurrentScreen:LastDialog()
    if KTool.IsNull(lastDialog) or KTool.IsNull(lastDialog.Argument) then
        return false, nil
    end
    return true, lastDialog
end


function GuideComponentConditionPartial:Clear()
    self.dialogId2WaitTime = nil
end
---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function GuideComponentConditionPartial:SetContext(context)
    self.context = context
end

function GuideComponentConditionPartial:GetConditionGroups(condition)
    return IsEmpty(condition) and {} or parse_strings(condition)
end

function GuideComponentConditionPartial:GetConditionGroupList(conditionGroups)
    local t = {}
    local SystemFunction = GuideConditionType.SystemFunction
    for i, conditionStr in ipairs(conditionGroups) do
        local conditionGroup = parse_strings(conditionStr, "#")
        local conditionType  = checkNumber(conditionGroup[1])
        --- 如果是系统功能表 解锁条件表类型对应的条件
        if conditionType == SystemFunction then
            local systemFunctionId = conditionGroup[2]
            ---@type SystemToggleVo
            local vo = CfUtils.SystemToggleVo( systemFunctionId)
            local unlockTypeList = string.split2(vo.unlockType, ";")
            local unlockNumList = string.split2(vo.unlockNum, ";")
            local length = math.min(#unlockTypeList, #unlockNumList)
            local unlockType, unlockNum
            for i = 1, length do
                unlockType, unlockNum = checkNumber(unlockTypeList[i]), checkNumber(unlockNumList[i])
                table.insert(t, {unlockType, unlockNum})
            end
            
            print("%s systemFunctionId %s 转成 [%s --- %s]", vo.realName, systemFunctionId, table.toString(t))
        else
            table.insert(t, conditionGroup)
        end
    end
    return t
end

function GuideComponentConditionPartial:CheckInterfaceData(errorCode, path, data)
    if errorCode ~= 0 then
        return
    end

    if self._requestPath then
        self._requestPath = string.trim(self._requestPath)
        path = string.trim(path)
        if self._requestPath == path then
            self._requestPath = nil
            self._responseData = data
            
        end
    end
  
end

function GuideComponentConditionPartial:GetDialogIdAndWaitTime(conditionParams)
    if self._str2Cache[conditionParams] == nil then
        self._str2Cache[conditionParams] = parse_strings(conditionParams, ":")
    end
    return SafeUnpack(self._str2Cache[conditionParams])
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------


---------------------------------------------------
--- handler end ---
---------------------------------------------------


return GuideComponentConditionPartial
