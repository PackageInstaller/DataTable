require("sp_base_inst")

local function getSimplifiedV2Direction(v2)
  local v = v2:Clone()
  if v.x > 0 then
    v.x = 1
  elseif v.x < 0 then
    v.x = -1
  end
  if 0 < v.y then
    v.y = 1
  elseif 0 > v.y then
    v.y = -1
  end
  return v
end

_class("SkillPreviewPlayTeleportScopeArrowInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayTeleportScopeArrowInstruction = SkillPreviewPlayTeleportScopeArrowInstruction

function SkillPreviewPlayTeleportScopeArrowInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = casterEntity:GetOwnerWorld()
  local arrowEntities = world:GetGroup(world.BW_WEMatchers.PickUpArrow):GetEntities()
  for _, e in ipairs(arrowEntities) do
    world:DestroyEntity(e)
  end
  world = previewContext:GetWorld()
  local renderEntityService = world:GetService("RenderEntity")
  local pieceService = world:GetService("Piece")
  local scopeGridList = previewContext:GetScopeResult()
  local v2CasterPos = casterEntity:GetGridPosition()
  for _, v2Scope in ipairs(scopeGridList) do
    local dir = getSimplifiedV2Direction(v2Scope - v2CasterPos)
    local eArrow = renderEntityService:CreateRenderEntity(EntityConfigIDRender.PickUpArrow)
    eArrow:SetLocation(v2Scope, dir)
    pieceService:SetEffectEntityParentWithPiecePos(eArrow, v2Scope)
  end
end

_class("SkillPreviewRemoveTeleportScopeArrowInstruction", SkillPreviewBaseInstruction)
SkillPreviewRemoveTeleportScopeArrowInstruction = SkillPreviewRemoveTeleportScopeArrowInstruction

function SkillPreviewRemoveTeleportScopeArrowInstruction:DoInstruction(TT, casterEntity, previewContext)
  local arrowEntities = self._world:GetGroup(self._world.BW_WEMatchers.PickUpArrow):GetEntities()
  for _, e in ipairs(arrowEntities) do
    self._world:DestroyEntity(e)
  end
end
