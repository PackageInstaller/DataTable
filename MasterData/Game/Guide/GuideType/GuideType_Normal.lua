local GuideType_Base = require("Game.Guide.GuideType.GuideType_Base")
local GuideType_Normal = class("GuideType_Normal", GuideType_Base)
local GuideEnum = require("Game.Guide.GuideEnum")
local GuideConditionChecker = require("Game.Guide.GuideConditionChecker")
local CS_EventTriggerListener = CS.EventTriggerListener
local Type_RectTransform = typeof(CS.UnityEngine.RectTransform)
local CS_RenderManager = CS.RenderManager
local slipWaitTime = 20

function GuideType_Normal:ctor()
  self.__onCurStepFinish = BindCallback(self, self.OnCurStepFinish)
  self.__callTryNextGuide = BindCallback(self, self.__TryNextGuide)
  self.__guideFeature = 0
  self.__onScreenSizeChangedEvent = BindCallback(self, self.__OnScreenSizeChanged)
  MsgCenter:AddListener(eMsgEventId.OnScreenSizeChanged, self.__onScreenSizeChangedEvent)
end

function GuideType_Normal:StartGuide(guideCfg, taskId)
  self.guideCfg = guideCfg
  if #guideCfg.step_list == 0 then
    self:EndGuide(false)
    return
  end
  self.guideIndex = 1
  self.taskId = taskId
  UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(guideWindow)
    if guideWindow == nil then
      self:BreakEndGuide()
      return
    end
    self.guideWindow = guideWindow
    self.guideWindow:BindGuideSkipEvent(BindCallback(self, function()
      CS.MessageCommon.ShowMessageBox(ConfigData:GetTipContent(144), function()
        self:SkipGuide(true)
      end, nil)
    end))
    self:NextStep()
  end)
end

function GuideType_Normal:IsFirstIndexAndNoLast()
  return self.guideIndex == 1 and 1 < #self.guideCfg.step_list
end

function GuideType_Normal:AddGuideFeature(feature)
  self.__guideFeature = self.__guideFeature | feature
end

function GuideType_Normal:RemoveGuideFeature(feature)
  self.__guideFeature = self.__guideFeature & ~feature
end

function GuideType_Normal:HasGuideFeature(feature)
  return self.__guideFeature & feature > 0
end

function GuideType_Normal:SkipGuide(skipTask)
  if skipTask and self.taskId ~= nil and self.taskId > 0 then
    PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SaveSkipGuideTask(self.taskId)
    PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
  end
  self:EndGuide(false)
end

function GuideType_Normal:BreakEndGuide()
  self:EndGuide(false, true)
end

function GuideType_Normal:EndGuide(success, isBreak)
  self:ClearOperatorGuide()
  if not isBreak and self.guideCfg ~= nil and self.guideCfg.finish_task then
    local taskNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Task)
    if taskNetworkCtrl ~= nil then
      taskNetworkCtrl:CS_QUEST_ClientAddSchedule(function()
        self:__RealEndGuide(success)
      end)
      return
    end
  end
  self:__RealEndGuide(success)
end

function GuideType_Normal:__RealEndGuide(success)
  if not success and self.guideCfg ~= nil then
    for i = self.guideIndex, #self.guideCfg.step_list do
      self:__CallClearCode(i)
    end
  end
  self.__containEventTrigger = false
  self.guideCfg = nil
  self.guideStepCfg = nil
  self.guideWindow = nil
  self.curTargetTransform = nil
  if self.waitTimerId ~= nil then
    TimerManager:StopTimer(self.waitTimerId)
    self.waitTimerId = nil
  end
  UIManager:DeleteWindow(UIWindowTypeID.Guide)
  GuideManager:OnEndGuide(success)
  if not GuideManager.inGuide then
    NoticeManager:ContinueShowNotice("guide")
  end
end

function GuideType_Normal:NextStep()
  if self.guideCfg == nil then
    self:BreakEndGuide()
    return
  end
  local stepId = self.guideCfg.step_list[self.guideIndex]
  local guideStepCfg = ConfigData.guide_step[stepId]
  if guideStepCfg == nil then
    error("guide step cfg is null,id:" .. tostring(stepId))
    self:EndGuide(false)
    return
  end
  if not GuideConditionChecker.CheckGuideCondition(guideStepCfg.condition, guideStepCfg.condition_arg, GuideManager.extendArg) then
    self:EndGuide(false)
    return
  end
  if self.guideIndex == 1 then
    if #self.guideCfg.guide_condition > 0 and not GuideConditionChecker.CheckTriggerGuideCondition(self.guideCfg.guide_condition, self.guideCfg.guide_arg) then
      self:EndGuide(false)
      return
    end
    NoticeManager:PuaseShowNotice("guide")
  end
  self.guideWindow:SetWaitMaskActive(true)
  self.guideStepCfg = guideStepCfg
  self.guideWindow:SetSkipButtonActive(false)
  if not string.IsNullOrEmpty(self.guideStepCfg.first_code) then
    local firstExeCode = load(self.guideStepCfg.first_code)
    if firstExeCode == nil then
      warn(string.format("guide error id[%d],index[%d],stepId[%d],fisrt code error,interrupt", self.guideCfg.id, self.guideIndex, self.guideStepCfg.id))
      self:EndGuide(false)
      return
    end
    local status, current = xpcall(firstExeCode, debug.traceback)
    if not status then
      error(current)
      return
    end
  end
  if self.guideStepCfg.target_type == 0 then
    self:RunNextInternal(guideStepCfg)
  elseif self.guideStepCfg.target_type == 1 then
    self:NextWaitUIWindow(self.guideStepCfg)
  elseif self.guideStepCfg.target_type == 2 then
    self:NextWaitScene(self.guideStepCfg, BindCallback(self, self.NextWaitSceneTarget, self.guideStepCfg))
  elseif self.guideStepCfg.target_type == 3 then
    self:NextWaitScriptTarget(self.guideStepCfg)
  else
    error("guideStepCfg is target_type error,id:" .. tostring(self.guideStepCfg.id))
    self:EndGuide(false)
  end
end

function GuideType_Normal:RunCurStep()
  GuideType_Base.RunCurStep(self)
  self.guideWindow:SetWaitMaskActive(false)
  local step_type = self.guideStepCfg.step_type
  if step_type == GuideEnum.StepType.LargeDialog then
    self.guideWindow:ShowGuideLargeDialog(LanguageUtil.GetLocaleText(self.guideStepCfg.info), self.guideStepCfg.info_type, self.guideStepCfg.info_pos, self.__onCurStepFinish)
  elseif step_type == GuideEnum.StepType.Operate then
    self:__RunCurStepOperator()
    if self.skipTimerId ~= nil then
      TimerManager:StopTimer(self.skipTimerId)
      self.skipTimerId = nil
    end
    if self.guideStepCfg ~= nil and self.guideStepCfg.guide_skip then
      self.skipTimerId = TimerManager:StartTimer(slipWaitTime, function()
        if self.guideWindow ~= nil then
          self.guideWindow:SetSkipButtonActive(true)
        end
        TimerManager:StopTimer(self.skipTimerId)
        self.skipTimerId = nil
      end, nil, false, false, self:IsTimerUnScale())
    end
  elseif step_type == GuideEnum.StepType.Avg then
    local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
    if self.guideStepCfg.avg_skip then
      avgCtrl:ShowAvg(self.guideStepCfg.avg_name, self.__onCurStepFinish)
    else
      avgCtrl:ShowAvg(self.guideStepCfg.avg_name, self.__onCurStepFinish, true, true)
    end
  elseif step_type == GuideEnum.StepType.Code then
    local guideCode = load(self.guideStepCfg.custom_code)
    if guideCode == nil then
      warn(string.format("guide error id[%d],index[%d],stepId[%d],load script is null,interrupt", self.guideCfg.id, self.guideIndex, self.guideStepCfg.id))
      self:EndGuide(false)
      return
    end
    local status, current = xpcall(guideCode, debug.traceback)
    if not status then
      error(current)
    end
  elseif step_type == GuideEnum.StepType.HeroSmallTalk then
    self.guideWindow:ShowGuideHeroSmallTalk(LanguageUtil.GetLocaleText(self.guideStepCfg.info), self.guideStepCfg.info_type, self.guideStepCfg.info_pos, self.__onCurStepFinish)
  elseif step_type == GuideEnum.StepType.Highlight then
    self:__RunCurStepOperator()
  elseif step_type == GuideEnum.StepType.AvgStory then
    local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
    if self.guideStepCfg.avg_skip then
      avgCtrl:StartAvg(nil, tonumber(self.guideStepCfg.avg_name), self.__onCurStepFinish, false, true, false)
    else
      avgCtrl:StartAvg(nil, tonumber(self.guideStepCfg.avg_name), self.__onCurStepFinish, true, true, true)
    end
  elseif step_type == GuideEnum.StepType.MultiPicture then
    if self.guideCfg == nil then
      return
    end
    local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
    GuidePicture.OpenGuidePicture(self.guideStepCfg.pic_id, self.__onCurStepFinish, true)
  else
    self:EndGuide(false)
    return
  end
end

function GuideType_Normal:__RunCurStepOperator()
  if self.guideStepCfg.target_type == 1 then
    local targetWindow = UIManager:GetWindow(self.guideStepCfg.target_parent)
    if targetWindow == nil then
      warn(string.format("guide error id[%d],index[%d],stepId[%d],targetWindow is null", self.guideCfg.id, self.guideIndex, self.guideStepCfg.id))
      self:EndGuide(false)
      return
    end
    local targetTrans = targetWindow.transform:Find(self.guideStepCfg.target_name)
    if IsNull(targetTrans) then
      warn(string.format("guide error id[%d],index[%d],stepId[%d],target Transform is null", self.guideCfg.id, self.guideIndex, self.guideStepCfg.id))
      self:EndGuide(false)
      return
    end
    self.curTargetTransform = targetTrans
  end
  self:__PlayOperatorGuide()
end

function GuideType_Normal:__PlayOperatorGuide()
  if IsNull(self.curTargetTransform) then
    warn(string.format("guide error id[%d],index[%d],stepId[%d],play target Transform is null", self.guideCfg.id, self.guideIndex, self.guideStepCfg.id))
    self:EndGuide(false)
    return
  end
  if not self.curTargetTransform.gameObject.activeInHierarchy then
    warn(string.format("guide error id[%d],index[%d],stepId[%d],target is Hide", self.guideCfg.id, self.guideIndex, self.guideStepCfg.id))
    self:EndGuide(false)
    return
  end
  local isRectTrasform = true
  if self.guideStepCfg.target_type > 1 then
    isRectTrasform = GR.IsType(self.curTargetTransform, Type_RectTransform)
  end
  self.__opIsRectTrasform = isRectTrasform
  if not self:__RefreshOperatorGuidePos(isRectTrasform, true) then
    return
  end
  self.__inOpGuide = true
  if self.guideStepCfg.op_refresh then
    self.__opRefreshTimerId = TimerManager:StartTimer(1, BindCallback(self, self.__RefreshOperatorGuidePos, isRectTrasform), nil, false, true, self:IsTimerUnScale())
  end
  self.__containEventTrigger = false
  if self.guideStepCfg.step_type == GuideEnum.StepType.Operate then
    self.__containEventTrigger = not IsNull(self.curTargetTransform:FindComponent(eUnityComponentID.EventTriggerListener))
    local eventTigger = CS_EventTriggerListener.Get(self.curTargetTransform)
    eventTigger:onClick("+", self.__onCurStepFinish)
    local exButtonPlus = self.curTargetTransform:FindComponent(eUnityComponentID.ExButtonPlus)
    if not IsNull(exButtonPlus) then
      self.__oldButtonClosePress = exButtonPlus.closePressAction
      exButtonPlus.closePressAction = true
    end
  elseif self.guideStepCfg.step_type == GuideEnum.StepType.Highlight then
    self.guideWindow:BindContinueBtnEvent(self.__onCurStepFinish, self.guideStepCfg.step_type)
  end
end

function GuideType_Normal:__RefreshOperatorGuidePos(isRectTrasform, isFirst)
  local success = false
  if IsNull(self.curTargetTransform) then
    return false
  end
  if isRectTrasform then
    if self.curTargetTransform.gameObject.layer == LayerMask.UI then
      success = self.guideWindow:PlayGuide(self.curTargetTransform, UIManager.UICamera, self.guideStepCfg.custom_size)
    else
      success = self.guideWindow:PlayGuide(self.curTargetTransform, UIManager:GetMainCamera(), self.guideStepCfg.custom_size)
    end
  else
    local boxCollider = self.curTargetTransform:FindComponent(eUnityComponentID.Collider)
    if IsNull(boxCollider) then
      if #self.guideStepCfg.custom_size == 2 and self.guideStepCfg.step_type == GuideEnum.StepType.Highlight then
        local ratio = CS_RenderManager.SceneCameraResolutionRatio
        local screenPos = UIManager:GetMainCamera():WorldToScreenPoint(self.curTargetTransform.position)
        success = self.guideWindow:PlayGuideCustome(screenPos / ratio, Vector2.New(self.guideStepCfg.custom_size[1], self.guideStepCfg.custom_size[2]))
      else
        warn(string.format("guide error id[%d],index[%d],stepId[%d],target Collider is null", self.guideCfg.id, self.guideIndex, self.guideStepCfg.id))
        self:EndGuide(false)
        return
      end
    else
      success = self.guideWindow:PlayGuideCollider(boxCollider, UIManager:GetMainCamera(), self.guideStepCfg.custom_size)
    end
  end
  if not success then
    warn(string.format("guide error id[%d],index[%d],stepId[%d],target is not in screen", self.guideCfg.id, self.guideIndex, self.guideStepCfg.id))
    self:EndGuide(false)
    return false
  end
  self.guideWindow:ShowGuideAniInfo(LanguageUtil.GetLocaleText(self.guideStepCfg.info), self.guideStepCfg.info_type, self.guideStepCfg.info_pos, isFirst, self.guideStepCfg.step_type, self.guideStepCfg.arrow_offset)
  return true
end

function GuideType_Normal:__OnScreenSizeChanged()
  if not self.__inOpGuide or self.guideStepCfg == nil then
    return
  end
  if self.guideStepCfg.op_refresh then
    return
  end
  TimerManager:StopTimer(self.__opRefreshTimerId)
  self.__opRefreshTimerId = TimerManager:StartTimer(1, BindCallback(self, self.__RefreshOperatorGuidePos, self.__opIsRectTrasform), nil, false, true, self:IsTimerUnScale())
end

function GuideType_Normal:OnCurStepFinish()
  if self.guideStepCfg == nil then
    return
  end
  local step_type = self.guideStepCfg.step_type
  if step_type == GuideEnum.StepType.LargeDialog then
  elseif step_type == GuideEnum.StepType.Operate then
    self:ClearOperatorGuide()
  elseif step_type == GuideEnum.StepType.Avg then
  elseif step_type == GuideEnum.StepType.Code then
  elseif step_type == GuideEnum.StepType.HeroSmallTalk then
  elseif step_type == GuideEnum.StepType.Highlight then
    self:ClearOperatorGuide()
  elseif step_type == GuideEnum.StepType.AvgStory then
  elseif step_type == GuideEnum.StepType.MultiPicture then
  else
    self:EndGuide(false)
    return
  end
  self.curTargetTransform = nil
  self.guideWindow:CloseGuide(self.guideStepCfg.step_type)
  self:__CallClearCode(self.guideIndex)
  self:OnStepFinishAction(self.guideIndex, self.__callTryNextGuide)
end

function GuideType_Normal:__TryNextGuide()
  self:__CallCompleteCode(self.guideIndex)
  if self.guideIndex < #self.guideCfg.step_list then
    self.guideIndex = self.guideIndex + 1
    self:NextStep()
  else
    self:EndGuide(true)
  end
end

function GuideType_Normal:__CallClearCode(guideIndex)
  if self.guideCfg == nil then
    return
  end
  local stepId = self.guideCfg.step_list[guideIndex]
  if stepId == nil then
    return
  end
  local guideStepCfg = ConfigData.guide_step[stepId]
  if not string.IsNullOrEmpty(guideStepCfg.clear_code) then
    local afterExeCode = load(guideStepCfg.clear_code)
    if afterExeCode == nil then
      warn(string.format("guide error id[%d],index[%d],stepId[%d],clear code error,interrupt", self.guideCfg.id, guideIndex, stepId))
      self:EndGuide(false)
      return
    end
    local status, current = xpcall(afterExeCode, debug.traceback)
    if not status then
      error(current)
      return
    end
  end
end

function GuideType_Normal:__CallCompleteCode(guideIndex)
  if self.guideCfg == nil then
    return
  end
  local stepId = self.guideCfg.step_list[guideIndex]
  if stepId == nil then
    return
  end
  local guideStepCfg = ConfigData.guide_step[stepId]
  if not string.IsNullOrEmpty(guideStepCfg.complete_code) then
    local afterExeCode = load(guideStepCfg.complete_code)
    if afterExeCode == nil then
      warn(string.format("guide error id[%d],index[%d],stepId[%d],complete code error,interrupt", self.guideCfg.id, guideIndex, stepId))
      self:EndGuide(false)
      return
    end
    local status, current = xpcall(afterExeCode, debug.traceback)
    if not status then
      error(current)
      return
    end
  end
end

function GuideType_Normal:ClearOperatorGuide()
  self.__inOpGuide = false
  TimerManager:StopTimer(self.__opRefreshTimerId)
  self.__opRefreshTimerId = nil
  TimerManager:StopTimer(self.skipTimerId)
  self.skipTimerId = nil
  if self.guideStepCfg == nil or self.guideStepCfg.step_type == GuideEnum.StepType.Highlight then
    return
  end
  if not IsNull(self.curTargetTransform) then
    local eventTigger = CS_EventTriggerListener.Get(self.curTargetTransform)
    if not IsNull(eventTigger) then
      eventTigger:onClick("-", self.__onCurStepFinish)
      if not self.__containEventTrigger then
        DestroyUnityObject(eventTigger)
      end
    end
    local exButtonPlus = self.curTargetTransform:FindComponent(eUnityComponentID.ExButtonPlus)
    if not IsNull(exButtonPlus) and self.__oldButtonClosePress ~= nil then
      exButtonPlus.closePressAction = self.__oldButtonClosePress
    end
    self.__oldButtonClosePress = nil
  end
end

return GuideType_Normal
