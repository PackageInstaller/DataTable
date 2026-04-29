require("base_ins_r")
_class("PlayRemoveLineRendererInstruction", BaseInstruction)
PlayRemoveLineRendererInstruction = PlayRemoveLineRendererInstruction

function PlayRemoveLineRendererInstruction:Constructor(paramList)
end

function PlayRemoveLineRendererInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local effectLineRenderer = casterEntity:EffectLineRenderer()
  if effectLineRenderer then
    casterEntity:RemoveEffectLineRenderer()
  end
  local monsterGroup = world:GetGroup(world.BW_WEMatchers.MonsterID)
  for i, entity in ipairs(monsterGroup:GetEntities()) do
    local effectLineRenderer = entity:EffectLineRenderer()
    if effectLineRenderer then
      entity:RemoveEffectLineRenderer()
    end
  end
end
