require("sp_base_inst")
_class("SkillPreviewPlayCreateCasterGhostInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayCreateCasterGhostInstruction = SkillPreviewPlayCreateCasterGhostInstruction

function SkillPreviewPlayCreateCasterGhostInstruction:Constructor(params)
  self._type = params.Type
  self._prefab = params.Prefab
  self._anim = params.Anim or "AtkUltPreview"
end

function SkillPreviewPlayCreateCasterGhostInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = casterEntity:GetOwnerWorld()
  local entitySvc = world:GetService("RenderEntity")
  if self._type == "Scope" then
    local scopeList = previewContext:GetScopeResult()
    for _, pos in pairs(scopeList) do
      entitySvc:CreateGhost(pos, casterEntity, self._anim, self._prefab)
    end
  elseif self._type == "PickUp" then
    local pickUpPos = previewContext:GetPickUpPos()
    local ghostEntity = entitySvc:CreateGhost(pickUpPos, casterEntity, self._anim, self._prefab)
  elseif self._type == "PickUpRotate" then
    local pickUpPos = previewContext:GetPickUpPos()
    local ghostEntity = entitySvc:CreateGhost(pickUpPos, casterEntity, self._anim, self._prefab)
    local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
    if previewPickUpComponent then
      previewPickUpComponent:SetRotateGhost(ghostEntity)
      local reflectPos = previewPickUpComponent:GetReflectPos()
      if reflectPos then
        ghostEntity:SetDirection(reflectPos - pickUpPos)
      end
    end
  elseif self._type == "TeleportTargetAroundNearestCaster" then
    self:_CalcTeleportTargetAroundNearestCaster(casterEntity, previewContext)
  end
end

function SkillPreviewPlayCreateCasterGhostInstruction:_CalcTeleportTargetAroundNearestCaster(casterEntity, previewContext)
  local world = casterEntity:GetOwnerWorld()
  local pickUpPos = previewContext:GetPickUpPos()
  local targetEntity
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local monsterList, monsterPosList = utilScopeSvc:SelectAllMonster(casterEntity)
  for _, monster in ipairs(monsterList) do
    local monsterGridPos = monster:GetGridPosition()
    local bodyArea = monster:BodyArea():GetArea()
    for i, area in ipairs(bodyArea) do
      local posWork = monsterGridPos + area
      if posWork == pickUpPos then
        targetEntity = monster
        break
      end
    end
  end
  if not targetEntity then
    return
  end
  local SkillEffectCalc_Teleport = SkillEffectCalc_Teleport:New(world)
  local posNew = SkillEffectCalc_Teleport:_CalcTargetAroundNearestCaster(casterEntity, targetEntity:GetID())
  local entitySvc = world:GetService("RenderEntity")
  local ghostEntity = entitySvc:CreateGhost(posNew, casterEntity, self._anim, self._prefab)
end
