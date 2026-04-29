require("base_ins_r")
_class("PlayAllGridPurifyInstruction", BaseInstruction)
PlayAllGridPurifyInstruction = PlayAllGridPurifyInstruction

function PlayAllGridPurifyInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local container = casterEntity:SkillRoutine():GetResultContainer()
  local results = container:GetEffectResultsAsArray(SkillEffectType.GridPurify)
  if not results or #results == 0 then
    return
  end
  local traps = {}
  for _, result in ipairs(results) do
    local ids = result:GetPurifiedTrapIDs()
    for __, id in ipairs(ids) do
      local e = world:GetEntityByID(id)
      if e then
        table.insert(traps, e)
      end
    end
  end
  local trapServiceRender = world:GetService("TrapRender")
  trapServiceRender:PlayTrapDieSkill(TT, traps, true)
end
