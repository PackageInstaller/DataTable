require("sp_base_inst")
_class("SkillPreviewPlayJocelyneCreateCasterGhostInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayJocelyneCreateCasterGhostInstruction = SkillPreviewPlayJocelyneCreateCasterGhostInstruction

function SkillPreviewPlayJocelyneCreateCasterGhostInstruction:Constructor(params)
  self._type = params.Type
  self._prefab = params.Prefab
  self._anim = params.Anim or "AtkUltPreview"
end

function SkillPreviewPlayJocelyneCreateCasterGhostInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = casterEntity:GetOwnerWorld()
  local entitySvc = world:GetService("RenderEntity")
  local SkillEffectCalc_Teleport = SkillEffectCalc_Teleport:New(world)
  local posNew = SkillEffectCalc_Teleport:_FindTeleportPos_Comparer(nil, casterEntity, nil, nil, previewContext:GetScopeResult(), AiSortByDistance._ComparerByFar)
  posNew = posNew or casterEntity:GetGridPosition()
  local entitySvc = world:GetService("RenderEntity")
  entitySvc:CreateGhost(posNew, casterEntity, self._anim, self._prefab)
end
