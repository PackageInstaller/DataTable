require("skill_effect_result_base")
_class("SkillEffectKillPlayerResult", SkillEffectResultBase)
SkillEffectKillPlayerResult = SkillEffectKillPlayerResult

function SkillEffectKillPlayerResult:GetEffectType()
  return SkillEffectType.KillPlayer
end

function SkillEffectKillPlayerResult:Constructor(pathList, newGridList)
  self._pathList = pathList
  self._newGridList = newGridList
end

function SkillEffectKillPlayerResult:GetPathList()
  return self._pathList
end

function SkillEffectKillPlayerResult:GetNewGridList()
  return self._newGridList
end
