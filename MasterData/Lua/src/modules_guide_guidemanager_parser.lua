local this = {}
local guideConditionTpl = L_GameTpl:getGuideConditionTpl()
local guideGroupTpl = L_GameTpl:getGuideGroupTpl()
local guideConditionTypeTpl = L_GameTpl:getGuideConditionTypeTpl()
local homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local journeyTaskTpl = L_GameTpl:getJourneyTaskTpl()
local guideScourceType = {
  guide = 0,
  fight = 1,
  task = 2,
  bingWorld = 3
}

function this:parseGuideParams(params)
  if not L_PlayerStore:isPlayerLogin() then
    return
  end
  if L_LoadingManager:isLoading() then
    return
  end
  local triggerConditions = {}
  local guideParams = params.guideParams
  guideParams = guideParams or {}
  for _, param in ipairs(guideParams) do
    if param.type then
      local conditions = guideConditionTpl:getConditionsByType(param.type)
      if not conditions then
        C_MJLog.LogInfo("guideCondition表没有condition类型： " .. param.type, C_ELogModule.Guide)
        return
      end
      local funcName = string.concat("parse", param.type)
      for _, condition in ipairs(conditions) do
        local conditionValue = self:convertType(guideConditionTpl:getParam(condition), guideConditionTpl:getParamType(condition))
        if self[funcName] then
          if self[funcName](conditionValue) then
            table.insert(triggerConditions, guideConditionTpl:getId(condition))
          end
        else
          local paramValue = self:convertType(param.param, guideConditionTpl:getParamType(condition))
          if conditionValue == paramValue or self:checkIsSpecialCondition(param.type, conditionValue, paramValue) then
            table.insert(triggerConditions, guideConditionTpl:getId(condition))
          end
        end
      end
    end
  end
  return self:checkAllGudieGroup(triggerConditions, params.callBack)
end

function this:checkAllGudieGroup(triggerConditions, callback)
  CS.UnityEngine.Profiling.Profiler.BeginSample("guide checkAllGudieGroup")
  local triggerGroupIds = {}
  local guideGroups = guideGroupTpl:getData()
  for _, group in pairs(guideGroups) do
    local sourcetType = guideGroupTpl:getTriggerSource(group)
    if sourcetType == guideScourceType.guide then
      local guideId = guideGroupTpl:getId(group)
      local isGuideContitionSatisfy = false
      local isGuideNeedCb = false
      isGuideContitionSatisfy, isGuideNeedCb = self:checkConditionsByGuideId(guideId, triggerConditions)
      if isGuideContitionSatisfy then
        if isGuideNeedCb then
          self._guideFinishedCallback[guideId] = callback
        end
        table.insert(triggerGroupIds, guideId)
      end
    end
  end
  table.sort(triggerGroupIds)
  CS.UnityEngine.Profiling.Profiler.EndSample()
  return triggerGroupIds
end

function this:checkConditionsByGuideId(guideId, triggerConditions)
  local groupTd = guideGroupTpl:getTplById(guideId)
  if triggerConditions == nil then
    triggerConditions = {}
  end
  local isGuideContitionSatisfy = false
  local isGuideNeedCb = false
  if not guideGroupTpl:getIsWorking(groupTd) or L_GuideStore:isGuideComplete(guideId) and guideGroupTpl:getIsRepeat(groupTd) == false then
    return isGuideContitionSatisfy, isGuideNeedCb
  end
  local andList = guideGroupTpl:getGuideAndCondition(groupTd) or {}
  local orList = guideGroupTpl:getGuideOrCondition(groupTd) or {}
  isGuideContitionSatisfy, isGuideNeedCb = self:evalGuideAndOrBranch(andList, orList, triggerConditions)
  if isGuideContitionSatisfy then
    local andDisable = guideGroupTpl:getGuideAndDisableCondition(groupTd) or {}
    local orDisable = guideGroupTpl:getGuideOrDisableCondition(groupTd) or {}
    if 0 < #andDisable or 0 < #orDisable then
      local disableHit, disableCb = self:evalGuideAndOrBranch(andDisable, orDisable, triggerConditions)
      if disableHit then
        isGuideContitionSatisfy = false
      end
      isGuideNeedCb = isGuideNeedCb or disableCb
    end
  end
  return isGuideContitionSatisfy, isGuideNeedCb
end

function this:evalGuideAndOrBranch(andList, orList, triggerConditions)
  local andRes, addAndCb = true, false
  local orRes, addOrCb = true, false
  local hasAnd = 0 < #andList
  local hasOr = 0 < #orList
  if hasAnd or hasOr then
    andRes, addAndCb = self:getAndBranchResult(andList, triggerConditions)
  end
  if hasOr then
    orRes, addOrCb = self:getOrBranchResult(orList, triggerConditions)
  end
  return andRes and orRes, addAndCb or addOrCb
end

function this:getAndBranchResult(conditions, triggerConditions)
  if #conditions == 0 then
    return true, false
  end
  local conditionRes, addCallback = self:checkConditions(conditions, triggerConditions)
  return not table.containsValue(conditionRes, false), addCallback
end

function this:getOrBranchResult(conditions, triggerConditions)
  if #conditions == 0 then
    return true, false
  end
  local conditionRes, addCallback = self:checkConditions(conditions, triggerConditions)
  return table.containsValue(conditionRes, true), addCallback
end

function this:getAndConditionResult(tpl, triggerConditions)
  return self:getAndBranchResult(guideGroupTpl:getGuideAndCondition(tpl) or {}, triggerConditions)
end

function this:getOrConditionResult(tpl, triggerConditions)
  return self:getOrBranchResult(guideGroupTpl:getGuideOrCondition(tpl) or {}, triggerConditions)
end

function this:checkConditions(conditions, triggerConditions)
  local conditionRes = {}
  local addCallback = false
  for _, condition in ipairs(conditions) do
    if table.containsValue(triggerConditions, condition) then
      table.insert(conditionRes, true)
      addCallback = true
    else
      local conditionTpl = guideConditionTpl:getTplById(condition)
      if conditionTpl == nil then
        C_MJLog.LogInfo("guideCondition表没有id： " .. condition, C_ELogModule.Guide)
      else
        local conditionValue = self:convertType(guideConditionTpl:getParam(conditionTpl), guideConditionTpl:getParamType(conditionTpl))
        local cType = guideConditionTpl:getType(conditionTpl)
        local funcName = string.concat("parse", cType)
        if self:checkIsSpecialConditionForMoment(cType, conditionValue) then
          table.insert(conditionRes, true)
        elseif self[funcName] then
          table.insert(conditionRes, self[funcName](conditionValue))
        else
          table.insert(conditionRes, false)
        end
      end
    end
  end
  return conditionRes, addCallback
end

function this:convertType(value, targetType)
  if value == nil then
    return 0
  end
  if targetType == "string" then
    return tostring(value)
  elseif targetType == "int" then
    local converted = tonumber(value)
    if converted == nil then
      return 0
    end
    return converted
  elseif targetType == "list<int>" then
    local splitList = string.split(value, "|")
    local converted = {}
    for _, v in ipairs(splitList) do
      if not string.isEmpty(v) then
        table.insert(converted, tonumber(v))
      end
    end
    return converted
  elseif targetType == "condition" then
    local splitList = string.split(value, "|")
    local converted = {}
    for _, v in ipairs(splitList) do
      if not string.isEmpty(v) then
        table.insert(converted, tonumber(v))
      end
    end
    return converted
  else
    errorf("Unsupported target type: " .. tostring(targetType), 2)
  end
end

function this:checkIsSpecialCondition(type, conditionValue, paramValue)
  if type == L_Const.specialGuideCondition.range then
    if math.isEmpty(conditionValue) then
      return self.isCloseToSpecial
    end
    return false
  elseif type == L_Const.specialGuideCondition.catchPet then
    if math.isEmpty(conditionValue) then
      return true
    end
    return false
  end
  return math.isEmpty(conditionValue)
end

function this:checkIsSpecialConditionForMoment(type, value)
  local tpl = guideConditionTypeTpl:getTplById(type)
  if guideConditionTypeTpl:getIsMoment(tpl) then
    return false
  end
  if type == L_Const.specialGuideCondition.range then
    if math.isEmpty(value) then
      return self.isCloseToSpecial
    end
    return false
  end
  return math.isEmpty(value)
end

function this.parse1001(param)
  return AzurWorld.TaskMgr:IsFinishTask(param)
end

function this.parse1004(param)
  return AzurWorld.TaskMgr:CheckTaskNodeIsFinished(param[1], param[2])
end

function this.parse2015(param)
  return true
end

function this.parse3001(param)
  if not L_PlayerStore:isPlayerLogin() then
    return false
  end
  return C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(param)
end

function this.parse3002(param)
  if param == "pageMainCity" and (c_UIRestore.HasRestoreUI() or c_UIRestore.IsRestoring()) then
    return false
  end
  return L_UI:checkPageOpen(param)
end

function this.parse3003(param)
  local pageName = "pageProduct"
  if not L_UI:checkPageOpen(pageName) then
    return false
  end
  local isTargetPage = false
  local page = L_UI:getPage(pageName)
  if page ~= nil and page.options and page.options.buildingGuid then
    local serverData = L_HomeStore:getHomeBuildingByGuid(page.options.buildingGuid)
    local homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
    local tpl_building = homeBuildingTpl:getTplById(serverData.build_id)
    local groupId = homeBuildingTpl:getGroupId(tpl_building)
    isTargetPage = groupId == param
  end
  return isTargetPage
end

function this.parse3004(param)
  local playerLevel = L_PlayerStore:getLv()
  return param <= playerLevel
end

function this.parse3005(param)
  if not L_CommonUtil.isValid(AzurWorldInstance) or AzurWorld.proxyCenter == nil then
    return false
  end
  local currentSceneId = AzurWorldInstance.CurWorldId
  if currentSceneId == nil then
    return false
  end
  return table.containsValue(param, currentSceneId)
end

function this.parse3006(param)
  local isHome = C_HomeUtil.IsInHome() and 1 or 0
  if L_WorldManager:getCurModule() == nil then
    return false
  end
  return param == isHome
end

function this.parse3008(param)
  return L_GuideStore:isGuideComplete(param)
end

function this.parse3007(param)
  if param == 0 then
    return true
  end
  return 0 < L_TechnologyStore:getCurTechnologyLevelById(param)
end

function this.parse3009(param)
  local vaildHeros = L_FormationStore:getCurTeamValidHeroes(L_FormationConst.FormationType.world)
  return table.count(vaildHeros) == param
end

function this.parse3010(param)
  if 0 < param then
    return L_PlayerStore:playerInMountStatus()
  end
  return not L_PlayerStore:playerInMountStatus()
end

function this.parse3011(param)
  local buildGroupId = param
  local csHomeStore = AzurWorld.HomeMgr:GetHomeStore()
  for _, homeBuildData in pairs(csHomeStore:GetBuildDatas()) do
    local tpl = homeBuildingTpl:getTplById(homeBuildData.buildId)
    if homeBuildingTpl:getGroupId(tpl) == buildGroupId then
      return true
    end
  end
  return false
end

function this.parse3012(param)
  if not L_CommonUtil.isValid(AzurWorldInstance) or AzurWorld.proxyCenter == nil then
    return false
  end
  local currentSceneId = AzurWorldInstance.CurWorldId
  if currentSceneId == nil then
    return false
  end
  return not table.containsValue(param, currentSceneId)
end

function this.parse3013(param)
  local journeyTaskId = param
  local tpl = journeyTaskTpl:getTplById(journeyTaskId)
  local taskId = tpl and tpl.taskId
  local state = AzurWorld.TaskMgr.m_Module:GetJourneyTaskState(taskId)
  local JourneyTaskState = CS.Azur.Gameplay.Task.JourneyTaskState
  return state.value__ & (JourneyTaskState.COMPLETED.value__ | JourneyTaskState.GAINED.value__) > 0
end

function this.parse3014(param)
  if L_UI:checkPageOpen("pagePetDuelMain") == false then
    return false
  end
  local pagePetDuelMainObj = L_UI:getPage("pagePetDuelMain")
  return pagePetDuelMainObj.levelId == param
end

function this.parse3017(param)
  local condId = AzurWorld.ConditionMgr:CreateCond(param, nil)
  local m = AzurWorld.ConditionMgr:CheckCond(condId)
  if m then
    C_MJLog.LogInfo("通用Condition判定通过 ", C_ELogModule.Guide)
  end
  return m
end

function this.parse3018(param)
  local id = AzurWorld.mountMgr:GetRideMountId()
  if id == 0 then
    return false
  end
  local stamina = L_SatietyStore:getPetSatiety(id)
  local max_stamina = L_SatietyStore:getPetMaxSatiety(id)
  local p = stamina / max_stamina
  local t = param / 100.0
  local value = p <= t
  return value
end

function this.parse3023(param)
  local homeLevel = C_HomeUtil.GetHomeLevel()
  return param <= homeLevel
end

function this.parse3025(param)
  local result = L_GuideManager.cacheJourneyTaskRewards[param] ~= nil
  return result
end

function this.parse3026(param)
  local result = L_GuideManager.cacheJourneyTaskCompletes[param] ~= nil
  return result
end

function this.parse3027(param)
  local result = L_GuideManager.cacheDungeonFirstWin[param] ~= nil
  return result
end

function this.parse3029(param)
  return AzurWorld.scenarioManager.StateMachine.curStateType.value__ == param
end

function this.parse3030(param)
  local stamina = AzurWorld.scenarioManager.RuntimeData.Stamina
  local compareType = param[1] or 1
  local threshold = param[2]
  if compareType == 1 then
    return stamina == threshold
  elseif compareType == 2 then
    return stamina > threshold
  elseif compareType == 3 then
    return stamina < threshold
  elseif compareType == 4 then
    return stamina >= threshold
  elseif compareType == 5 then
    return stamina <= threshold
  end
  return false
end

function this.parse3032(param)
  local isOpen = AzurWorld.scenarioManager.GlobalData.ActivitySave.IsEndlessOpen and 1 or 0
  return isOpen == param
end

function this.parse3031(param)
  local num = AzurWorld.scenarioManager.GlobalData:GetEndBookEnableNum()
  local isEnabled = 0 < num and 1 or 0
  return isEnabled == param
end

function this.parse3034(param)
  local result = true
  if CS.Lens.Gameplay.Managers.GuideManager.CheckInRealTimePetCatchState() then
    result = false
  end
  if result and CS.Lens.Gameplay.Managers.GuideManager.CheckInShowQuickItemBarState() then
    result = false
  end
  local checkItem = 0 < param
  return result == checkItem
end

return this
