require("base_ins_r")
_class("PlayTriggerTrapInstruction", BaseInstruction)
PlayTriggerTrapInstruction = PlayTriggerTrapInstruction

function PlayTriggerTrapInstruction:Constructor(paramList)
end

function PlayTriggerTrapInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local routineCmpt = casterEntity:SkillRoutine():GetResultContainer()
  if not routineCmpt then
    return
  end
  local resultArray = routineCmpt:GetEffectResultsAsArray(SkillEffectType.TriggerTrap)
  if not resultArray then
    return
  end
  local eTrap = {}
  for _, result in ipairs(resultArray) do
    local entity = world:GetEntityByID(result:GetEntityID())
    if entity then
      table.insert(eTrap, entity)
    end
  end
  if table.count(eTrap) == 0 then
    return
  end
  local trapServiceRender = world:GetService("TrapRender")
  if casterEntity and casterEntity:EntityType():IsAutoBeadSkillHolder() then
    local teamEntity = world:Player():GetCurrentTeamEntity()
    casterEntity = teamEntity
  end
  trapServiceRender:PlayTrapTriggerSkillTasks(TT, eTrap, false, casterEntity)
  trapServiceRender:DestroyTrapList(TT, eTrap)
end
