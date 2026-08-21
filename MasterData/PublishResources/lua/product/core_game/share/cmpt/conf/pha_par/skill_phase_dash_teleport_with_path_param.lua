require("skill_phase_param_base")
_class("SkillPhaseDashTeleportWithPathParam", SkillPhaseParamBase)
SkillPhaseDashTeleportWithPathParam = SkillPhaseDashTeleportWithPathParam

function SkillPhaseDashTeleportWithPathParam:Constructor(t)
  self.startAction = t.startAction
  self.startDashDelay = t.startDashDelay
  self.startEffectID = t.startEffectID
  self.middleStartAction = t.middleStartAction
  self.middleStartDashDelay = t.middleStartDashDelay
  self.stopAction = t.stopAction
  self.stopDealy = t.stopDealy
  self.dashAction = t.dashAction
  self.eachDashDuration = t.eachDashDuration
  self.pathPointEffectID = t.pathPointEffectID
  self.eachDashFinishEffectID = t.eachDashFinishEffectID
  self.dashEffectID = t.dashEffectID
  self.dashAudioID = t.dashAudioID
end

function SkillPhaseDashTeleportWithPathParam:GetPhaseType()
  return SkillViewPhaseType.DashTeleportWithPath
end

function SkillPhaseDashTeleportWithPathParam:GetCacheTable()
  local t = {}
  if self.startEffectID and self.startEffectID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[self.startEffectID].ResPath,
      1
    })
  end
  if self.pathPointEffectID and self.pathPointEffectID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[self.pathPointEffectID].ResPath,
      1
    })
  end
  if self.eachDashFinishEffectID and self.eachDashFinishEffectID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[self.eachDashFinishEffectID].ResPath,
      1
    })
  end
  if self.dashEffectID and self.dashEffectID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[self.dashEffectID].ResPath,
      1
    })
  end
  return t
end

function SkillPhaseDashTeleportWithPathParam:GetStartAction()
  return self.startAction
end

function SkillPhaseDashTeleportWithPathParam:GetStartDashDelay()
  return self.startDashDelay
end

function SkillPhaseDashTeleportWithPathParam:GetStartEffectID()
  return self.startEffectID
end

function SkillPhaseDashTeleportWithPathParam:GetMiddleStartAction()
  return self.middleStartAction
end

function SkillPhaseDashTeleportWithPathParam:GetMiddleStartDashDelay()
  return self.middleStartDashDelay
end

function SkillPhaseDashTeleportWithPathParam:GetStopAction()
  return self.stopAction
end

function SkillPhaseDashTeleportWithPathParam:GetStopDelay()
  return self.stopDealy
end

function SkillPhaseDashTeleportWithPathParam:GetDashAction()
  return self.dashAction
end

function SkillPhaseDashTeleportWithPathParam:GetEachDashDuration()
  return self.eachDashDuration
end

function SkillPhaseDashTeleportWithPathParam:GetPathPointEffectID()
  return self.pathPointEffectID
end

function SkillPhaseDashTeleportWithPathParam:GetEachDashFinishEffectID()
  return self.eachDashFinishEffectID
end

function SkillPhaseDashTeleportWithPathParam:GetDashEffectID()
  return self.dashEffectID
end

function SkillPhaseDashTeleportWithPathParam:GetDashAudioID()
  return self.dashAudioID
end
