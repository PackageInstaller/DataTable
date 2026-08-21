require("base_ins_r")
_class("PlayDestroyMonsterInstruction", BaseInstruction)
PlayDestroyMonsterInstruction = PlayDestroyMonsterInstruction

function PlayDestroyMonsterInstruction:Constructor(paramList)
end

function PlayDestroyMonsterInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local playDamageService = world:GetService("PlayDamage")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.DestroyMonster)
  if not resultArray then
    return
  end
  local index = phaseContext:GetCurResultIndexByType(SkillEffectType.DestroyMonster)
  local result = resultArray[index]
  if not result then
    return
  end
  local eID = result:GetEntityID()
  local eMonster = world:GetEntityByID(eID)
  if not eMonster then
    return
  end
  local svc = world:GetService("MonsterShowRender")
  TaskManager:GetInstance():CoreGameStartTask(function(TT)
    svc:_DoOneMonsterDead(TT, eMonster)
  end)
end
