_class("PlayAllHitBackInstruction", BaseInstruction)
PlayAllHitBackInstruction = PlayAllHitBackInstruction

function PlayAllHitBackInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local tResults = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.HitBack)
  if not tResults or #tResults == 0 then
    return
  end
  local playSkillService = world:GetService("PlaySkill")
  local taskArray = {}
  for _, result in ipairs(tResults) do
    if not result:GetHadPlay() then
      local beHitbackEntityID = result:GetTargetID()
      local targetEntity = world:GetEntityByID(beHitbackEntityID)
      local resvc = world:GetService("RenderEntity")
      resvc:TurnToTarget(targetEntity, casterEntity, nil, nil, 1)
      local processHitTaskID = playSkillService:ProcessHit(casterEntity, targetEntity, result)
      if processHitTaskID then
        table.insert(taskArray, processHitTaskID)
      end
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskArray) do
    YIELD(TT)
  end
end
