require("skill_effect_result_base")
_class("SkillEffectSwitchBodyAreaByTargetPosResult", SkillEffectResultBase)
SkillEffectSwitchBodyAreaByTargetPosResult = SkillEffectSwitchBodyAreaByTargetPosResult

function SkillEffectSwitchBodyAreaByTargetPosResult:GetEffectType()
  return SkillEffectType.SwitchBodyAreaByTargetPos
end

function SkillEffectSwitchBodyAreaByTargetPosResult:Constructor(newDir, newBodyArea, switchDirType, oldBodyAreaPos, oldBodyArea)
  self._newDir = newDir
  self._newBodyArea = newBodyArea
  self._switchDirType = switchDirType
  self._oldBodyAreaPos = oldBodyAreaPos
  self._oldBodyArea = oldBodyArea
end

function SkillEffectSwitchBodyAreaByTargetPosResult:GetOldBodyAreaPos()
  return self._oldBodyAreaPos
end

function SkillEffectSwitchBodyAreaByTargetPosResult:GetSwitchDirType()
  return self._switchDirType
end

function SkillEffectSwitchBodyAreaByTargetPosResult:GetNewDir()
  return self._newDir
end

function SkillEffectSwitchBodyAreaByTargetPosResult:GetNewBodyArea()
  return self._newBodyArea
end

function SkillEffectSwitchBodyAreaByTargetPosResult:GetOldBodyArea()
  return self._oldBodyArea
end
