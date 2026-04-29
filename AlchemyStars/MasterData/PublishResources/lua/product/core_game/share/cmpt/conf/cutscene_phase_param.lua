local CutsceneDelayType = {AfterStart = 1, AfterEnd = 2}
_enum("CutsceneDelayType", CutsceneDelayType)
_class("CutscenePhaseTime", Object)
CutscenePhaseTime = CutscenePhaseTime

function CutscenePhaseTime:Constructor()
  self.StartTick = GameGlobal:GetInstance():GetCurrentTime()
  self.EndTick = 0
end

_class("CutscenePhaseParam", Object)
CutscenePhaseParam = CutscenePhaseParam

function CutscenePhaseParam:Constructor(delaytype, delayphase, delayms, phaseParam)
  self._phaseParam = phaseParam
  self._delayType = delaytype
  self._delayMS = delayms
  self._delayFromPhase = delayphase
end

function CutscenePhaseParam:GetPhaseParam()
  return self._phaseParam
end

function CutscenePhaseParam:GetDelayType()
  return self._delayType
end

function CutscenePhaseParam:GetDelayMS()
  return self._delayMS
end

function CutscenePhaseParam:GetDelayFromPhase()
  return self._delayFromPhase
end
