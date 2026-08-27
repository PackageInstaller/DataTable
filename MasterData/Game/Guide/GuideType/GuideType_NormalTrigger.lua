local GuideType_Normal = require("Game.Guide.GuideType.GuideType_Normal")
local GuideType_NormalTrigger = class("GuideType_NormalTrigger", GuideType_Normal)

function GuideType_NormalTrigger:ctor()
  self.__sendGuideMsg = false
end

function GuideType_NormalTrigger:EndGuide(success, isBreak)
  if self.guideCfg ~= nil and not self.__sendGuideMsg then
    self:__ReqTriggerGuideComplete()
  end
  self.__sendGuideMsg = false
  GuideType_Normal.EndGuide(self, success, isBreak)
end

function GuideType_NormalTrigger:__ReqTriggerGuideComplete(action)
  if self.guideCfg.trigger_repeat then
    if action then
      action()
    end
    return
  end
  local guideId = self.guideCfg.id
  NetworkManager:GetNetwork(NetworkTypeID.Object):CS_GUIDE_TriggerComplete(guideId, action)
  GuideManager:AddCompleteTriggerGuide(guideId)
end

function GuideType_NormalTrigger:OnStepFinishAction(stepIndex, action)
  if self.guideCfg == nil then
    return
  end
  if self.guideCfg.step_finish == stepIndex and self.guideCfg.step_finish < #self.guideCfg.step_list then
    self.__sendGuideMsg = true
    self:__ReqTriggerGuideComplete(action)
    return
  end
  if action ~= nil then
    action()
  end
end

function GuideType_NormalTrigger:BreakEndGuide()
  self.__sendGuideMsg = false
  GuideType_Normal.EndGuide(self, false)
end

return GuideType_NormalTrigger
