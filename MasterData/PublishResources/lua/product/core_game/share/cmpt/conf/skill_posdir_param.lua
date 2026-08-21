_class("SkillPosDirParam", Object)
SkillPosDirParam = SkillPosDirParam

function SkillPosDirParam:Constructor(pos, dir)
  if pos ~= nil and pos.x ~= nil and pos.y ~= nil then
    self._pos = pos
  end
  if dir ~= nil and dir.x ~= nil and dir.y ~= nil then
    self._dir = dir
  end
end

function SkillPosDirParam:GetPos()
  return self._pos
end

function SkillPosDirParam:GetDir()
  return self._dir
end

_class("SkillPhaseData", Object)
SkillPhaseData = SkillPhaseData

function SkillPhaseData:Constructor(posdirParam, delaytype, delayphase, delayms, skillPhaseParam)
  self._posdirParam = posdirParam
  self._skillPhaseParam = skillPhaseParam
  self._delayType = delaytype
  self._delayMS = delayms
  self._delayFromPhase = delayphase
end

function SkillPhaseData:GetPhaseParam()
  return self._skillPhaseParam
end

function SkillPhaseData:GetPosDirParam()
  return self._posdirParam
end

function SkillPhaseData:GetDelayType()
  return self._delayType
end

function SkillPhaseData:GetDelayMS()
  return self._delayMS
end

function SkillPhaseData:GetDelayFromPhase()
  return self._delayFromPhase
end

_class("SkillPhaseTaskRunData", Object)
SkillPhaseTaskRunData = SkillPhaseTaskRunData

function SkillPhaseTaskRunData:Constructor()
  self.StartTick = GameGlobal:GetInstance():GetCurrentTime()
  self.EndTick = 0
end
