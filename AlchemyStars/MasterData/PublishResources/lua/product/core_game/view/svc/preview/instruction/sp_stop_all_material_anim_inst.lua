require("sp_base_inst")
_class("SkillPreviewStopAllMaterialAnimInstruction", SkillPreviewBaseInstruction)
SkillPreviewStopAllMaterialAnimInstruction = SkillPreviewStopAllMaterialAnimInstruction

function SkillPreviewStopAllMaterialAnimInstruction:Constructor(params)
  self._exceptCaster = params.ExceptCaster
end

function SkillPreviewStopAllMaterialAnimInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local flashEnemyEntities = world:GetGroup(world.BW_WEMatchers.MonsterID):GetEntities()
  if world:MatchType() == MatchType.MT_BlackFist then
    flashEnemyEntities = world:GetGroup(world.BW_WEMatchers.Pet):GetEntities()
  end
  for _, v in ipairs(flashEnemyEntities) do
    if self._exceptCaster and self._exceptCaster == "true" then
      if v:GetID() ~= casterEntity:GetID() then
        v:StopMaterialAnimLayer(MaterialAnimLayer.SkillPreview)
      end
    else
      v:StopMaterialAnimLayer(MaterialAnimLayer.SkillPreview)
    end
  end
  local targetIDList = previewContext:GetTargetEntityIDList()
  targetIDList = table.unique(targetIDList)
  for _, id in pairs(targetIDList) do
    local entity = world:GetEntityByID(id)
    if entity then
      if entity:HasTeam() then
        entity = entity:GetTeamLeaderPetEntity()
      end
      entity:StopMaterialAnimLayer(MaterialAnimLayer.SkillPreview)
    end
  end
end
