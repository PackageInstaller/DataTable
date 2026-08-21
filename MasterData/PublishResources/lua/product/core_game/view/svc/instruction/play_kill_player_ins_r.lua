_class("PlayKillPlayerInstruction", BaseInstruction)
PlayKillPlayerInstruction = PlayKillPlayerInstruction

function PlayKillPlayerInstruction:Constructor(paramList)
end

function PlayKillPlayerInstruction:GetCacheResource()
  local t = {}
  return t
end

function PlayKillPlayerInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.KillPlayer)
end
