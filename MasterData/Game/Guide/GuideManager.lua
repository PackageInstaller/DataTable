local GuideManager = {}
local GuideEnum = require("Game.Guide.GuideEnum")
local GuideConditionChecker = require("Game.Guide.GuideConditionChecker")
local GuideType_Normal = require("Game.Guide.GuideType.GuideType_Normal")
local GuideType_NormalTrigger = require("Game.Guide.GuideType.GuideType_NormalTrigger")
local GuideType_Tips = require("Game.Guide.GuideType.GuideType_Tips")
local FirstBattleGuideCtrl = require("Game.Guide.FristBattleGuideCtrl")

function GuideManager:Init()
  self.__skipGuide = false
  self:__SetInGuide(false)
  self.resloader = CS.ResLoader.Create()
  self.firstBattleGuideCtrl = FirstBattleGuideCtrl
  self.__normalGuideCtrl = GuideType_Normal.New()
  self.__triggerGuideCtrl = GuideType_NormalTrigger.New()
  self.__triggerGuideComplete = nil
  self.__allTriggerGuideComplete = false
  self:__InitTriggerEvent()
  self.__curGuideCtrl = nil
  self.extendArg = nil
end

function GuideManager:__SetInGuide(active)
  self.inGuide = active
  GR.InGuide = active
end

function GuideManager:SetGMSkipGuide(skipGuide)
  self.__skipGuide = skipGuide
end

function GuideManager:InitCompleteTriggerGuide(completeDic)
  self.__triggerGuideUnfinished = {}
  local isAllCompelete = true
  for _, guideId in pairs(ConfigData.guide.trigger_guide_list) do
    if not completeDic[guideId] then
      local guideCfg = ConfigData.guide[guideId]
      if guideCfg == nil then
        error("guide cfg is null,id:" .. tostring(guideCfg.id))
        return false
      end
      if GuideConditionChecker.CheckTriggerGuideCondition(guideCfg.guide_condition, guideCfg.guide_arg) then
        local cfgCondition, cfgConditionArg = guideCfg:GetFirstCondition()
        self.__triggerGuideUnfinished[cfgCondition] = self.__triggerGuideUnfinished[cfgCondition] or {}
        self.__triggerGuideUnfinished[cfgCondition][guideId] = guideCfg
      end
      isAllCompelete = false
    end
  end
  self.__triggerGuideComplete = completeDic
  if not isAllCompelete then
    MsgCenter:AddListener(eMsgEventId.OnSectorStageStateChange, self.__onSectorStageStateChange)
    MsgCenter:AddListener(eMsgEventId.UnlockFunc, self.__onUnlockFunc)
  end
  self.__allTriggerGuideComplete = isAllCompelete
end

function GuideManager:__InitTriggerEvent()
  function self.__onSectorStageStateChange(data)
    for stageId, _ in pairs(data) do
      if PlayerDataCenter.sectorStage:IsStageComplete(stageId) then
        self:HandleTriggerGuide(GuideEnum.TriggerGuideCondition.SectorStage, stageId)
      end
    end
  end
  
  function self.__onUnlockFunc(fid)
    self:HandleTriggerGuide(GuideEnum.TriggerGuideCondition.FuncUnlock, fid)
  end
end

function GuideManager:AddCompleteTriggerGuide(guideId)
  self.__triggerGuideComplete[guideId] = true
  local guideCfg = ConfigData.guide[guideId]
  local cfgCondition, cfgConditionArg = guideCfg:GetFirstCondition()
  if self.__triggerGuideUnfinished[cfgCondition] ~= nil then
    self.__triggerGuideUnfinished[cfgCondition][guideId] = nil
  end
end

function GuideManager:HandleTriggerGuide(conditionType, conditionArg)
  if self.__allTriggerGuideComplete then
    return
  end
  local guideTypeGroup = ConfigData.guide.trigger_guide_group[conditionType]
  if guideTypeGroup == nil then
    return
  end
  local guideGroup = guideTypeGroup[conditionArg]
  if guideGroup == nil then
    return
  end
  local completeDic = self.__triggerGuideComplete
  for _, guideId in pairs(guideGroup) do
    if not completeDic[guideId] then
      local guideCfg = ConfigData.guide[guideId]
      if GuideConditionChecker.CheckTriggerGuideCondition(guideCfg.guide_condition, guideCfg.guide_arg) then
        local cfgCondition, cfgConditionArg = guideCfg:GetFirstCondition()
        self.__triggerGuideUnfinished[cfgCondition] = self.__triggerGuideUnfinished[cfgCondition] or {}
        self.__triggerGuideUnfinished[cfgCondition][guideId] = guideCfg
      end
    end
  end
end

function GuideManager:IsTipsGuideConditionType(condition_Type)
  return 100 < condition_Type
end

function GuideManager:TryTriggerGuide(condition_Type, taskList, lastGuideId, extendArg)
  if condition_Type ~= nil and not GuideManager:IsTipsGuideConditionType(condition_Type) then
    self.__last_condition_Type = condition_Type
  end
  if self.__skipGuide or self.inGuide then
    return false
  end
  local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment)
  if aftertTeatmentCtrl ~= nil and aftertTeatmentCtrl:IsStartShowReward() then
    aftertTeatmentCtrl:BindResultAfterAction(function()
      GuideManager:TryTriggerGuide(condition_Type, taskList, lastGuideId)
    end)
    return
  end
  local taskList = taskList or PlayerDataCenter.allTaskData.guideTaskDatas
  local guideList = {}
  local guideDic = {}
  local guideTaskDic = {}
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  for _, taskData in pairs(taskList) do
    if lastGuideId ~= nil and table.contain(taskData.stcData.guide_id, lastGuideId) then
    elseif saveUserData:ContainSkipGuideTask(taskData.id) then
    else
      for _, guideId in pairs(taskData.stcData.guide_id) do
        if not guideDic[guideId] then
          local guideCfg = ConfigData.guide[guideId]
          if guideCfg == nil then
            error("guide cfg is null,id:" .. tostring(guideCfg.id))
            return false
          end
          if guideCfg.guide_type == GuideEnum.GuideType.TipsGuide then
            if condition_Type == nil or GuideManager:IsTipsGuideConditionType(condition_Type) then
              for _, tipsGuideId in pairs(guideCfg.step_list) do
                self:StartNewTipsGuide(tipsGuideId, condition_Type, extendArg)
              end
            end
          else
            local cfgCondition, cfgConditionArg = guideCfg:GetFirstCondition()
            if (condition_Type == nil or cfgCondition == condition_Type) and GuideConditionChecker.CheckGuideCondition(cfgCondition, cfgConditionArg, extendArg) and GuideConditionChecker.CheckTriggerGuideCondition(guideCfg.guide_condition, guideCfg.guide_arg) then
              guideDic[guideId] = guideCfg.priority
              guideTaskDic[guideId] = taskData.id
              table.insert(guideList, guideId)
            end
          end
        end
      end
    end
  end
  if #guideList == 0 then
    return self:TryStartTriggerTypeGuide(condition_Type, lastGuideId, extendArg)
  end
  table.sort(guideList, function(x1, x2)
    return guideDic[x1] > guideDic[x2]
  end)
  local guideId = guideList[1]
  self.extendArg = extendArg
  GuideManager:StartNewGuide(guideId, nil, guideTaskDic[guideId])
  return true
end

function GuideManager:TryStartTriggerTypeGuide(condition_Type, lastGuideId, extendArg)
  if self.__allTriggerGuideComplete then
    return
  end
  if condition_Type == nil then
    condition_Type = self.__last_condition_Type
  end
  local triggerGuideDic = self.__triggerGuideUnfinished[condition_Type]
  if triggerGuideDic == nil or table.count(triggerGuideDic) <= 0 then
    return false
  end
  local guideList = {}
  local guideDic = {}
  for guideId, guideCfg in pairs(triggerGuideDic) do
    if GuideConditionChecker.CheckTriggerGuideCondition(guideCfg.extra_condition, guideCfg.extra_arg) then
      local cfgCondition, cfgConditionArg = guideCfg:GetFirstCondition()
      if GuideConditionChecker.CheckGuideCondition(cfgCondition, cfgConditionArg, extendArg) then
        guideDic[guideId] = guideCfg.priority
        table.insert(guideList, guideId)
      end
    end
  end
  if #guideList == 0 then
    return false
  end
  table.sort(guideList, function(x1, x2)
    return guideDic[x1] > guideDic[x2]
  end)
  local guideId = guideList[1]
  self.extendArg = extendArg
  self:StartNewTriggerGuide(guideId)
  return true
end

function GuideManager:__CheckTriggerGuideCondition(condition_type, condition_arg)
end

function GuideManager:StartNewTriggerGuide(id, endAction)
  if self.inGuide then
    return
  end
  if self.__triggerGuideComplete ~= nil and self.__triggerGuideComplete[id] then
    return
  end
  local guideCfg = ConfigData.guide[id]
  self:__SetInGuide(true)
  self.endAction = endAction
  self.guideid = id
  self.guideCfg = guideCfg
  self.__curGuideCtrl = self.__triggerGuideCtrl
  self.__curGuideCtrl:StartGuide(self.guideCfg)
end

function GuideManager:StartNewTipsGuide(id, condition_Type, extendArg)
  local tipsGuideCfg = ConfigData.tips_guide[id]
  if tipsGuideCfg == nil then
    error("tips_guide Cfg is null,id:" .. tostring(id))
    return
  end
  if condition_Type ~= nil and condition_Type ~= tipsGuideCfg.condition then
    return
  end
  if not GuideConditionChecker.CheckGuideCondition(tipsGuideCfg.condition, tipsGuideCfg.condition_arg, extendArg) then
    return
  end
  local tipsGuideCtrl = GuideType_Tips.New()
  tipsGuideCtrl:StartGuide(tipsGuideCfg)
end

function GuideManager:StartNewGuide(id, endAction, taskId)
  if self.inGuide then
    return
  end
  local guideCfg = ConfigData.guide[id]
  if guideCfg == nil then
    error("guide Cfg is null,id:" .. tostring(id))
    return
  end
  self:__SetInGuide(true)
  self.endAction = endAction
  self.guideid = id
  self.guideCfg = guideCfg
  self.__curGuideCtrl = self.__normalGuideCtrl
  self.__curGuideCtrl:StartGuide(self.guideCfg, taskId)
end

function GuideManager:SetEndAction(endAction)
  if not self.inGuide then
    return
  end
  self.endAction = endAction
end

function GuideManager:SkipGuide()
  if not self.inGuide then
    return
  end
  self.__curGuideCtrl:EndGuide(false)
end

function GuideManager:BreakSkipGuide()
  if not self.inGuide then
    return
  end
  self.__curGuideCtrl:BreakEndGuide()
end

function GuideManager:OnEndGuide(success)
  local lastGuideId = self.guideid
  self.__curGuideCtrl = nil
  self.extendArg = nil
  GuideUtil:ClearData()
  self:__SetInGuide(false)
  if self.endAction ~= nil then
    self.endAction(success)
    self.endAction = nil
  end
  if success then
    self:TryTriggerGuide(nil, nil, lastGuideId)
  end
end

function GuideManager:GetCurGuideCtrl()
  return self.__curGuideCtrl
end

function GuideManager:OnGuideTaskDelete(taskList)
  local isInGuideFirstStep = GuideManager.inGuide and GuideManager:GetCurGuideCtrl():IsFirstIndexAndNoLast()
  for _, taskData in pairs(taskList) do
    for _, guideId in pairs(taskData.stcData.guide_id) do
      if isInGuideFirstStep and guideId == GuideManager.guideid then
        GuideManager:SkipGuide()
        break
      end
      local guideCfg = ConfigData.guide[guideId]
      if guideCfg == nil then
        error("guide cfg is null,id:" .. tostring(guideCfg.id))
        return
      end
      if guideCfg.guide_type == GuideEnum.GuideType.TipsGuide then
        for _, tipsGuideId in pairs(guideCfg.step_list) do
          GuideType_Tips.TryClearTipsGuide(tipsGuideId)
        end
      end
    end
  end
end

function GuideManager:AddGuideFeature(feature)
  if self.__curGuideCtrl ~= nil then
    self.__curGuideCtrl:AddGuideFeature(feature)
  end
end

function GuideManager:RemoveGuideFeature(feature)
  if self.__curGuideCtrl ~= nil then
    self.__curGuideCtrl:RemoveGuideFeature(feature)
  end
end

function GuideManager:HasGuideFeature(feature)
  if self.__curGuideCtrl ~= nil then
    return self.__curGuideCtrl:HasGuideFeature(feature)
  end
  return false
end

function GuideManager:UncompleteCollectResGuide(uncomplete)
  self.collectResGuideUnComplete = uncomplete
end

function GuideManager:OnQuitAndClear()
  self.firstBattleGuideCtrl:ResetData()
  self:BreakSkipGuide()
  GuideUtil.ClearOnNetReset()
  MsgCenter:RemoveListener(eMsgEventId.OnSectorStageStateChange, self.__onSectorStageStateChange)
  MsgCenter:RemoveListener(eMsgEventId.UnlockFunc, self.__onUnlockFunc)
end

GuideManager:Init()
return GuideManager
