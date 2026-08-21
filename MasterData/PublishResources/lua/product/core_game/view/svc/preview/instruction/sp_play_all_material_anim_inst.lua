require("sp_base_inst")
_class("SkillPreviewPlayAllMaterialAnimInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayAllMaterialAnimInstruction = SkillPreviewPlayAllMaterialAnimInstruction

function SkillPreviewPlayAllMaterialAnimInstruction:Constructor(params)
  self._anim = params.Anim
end

function SkillPreviewPlayAllMaterialAnimInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local flashEnemyEntities = world:GetGroup(world.BW_WEMatchers.MonsterID):GetEntities()
  if world:MatchType() == MatchType.MT_BlackFist and casterEntity:HasPet() then
    local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
    local enemyEntity = teamEntity:Team():GetEnemyTeamEntity()
    flashEnemyEntities = {
      enemyEntity:GetTeamLeaderPetEntity()
    }
  end
  for _, v in ipairs(flashEnemyEntities) do
    local entity = v
    if entity then
      if self._anim == "Flash" then
        entity:NewEnableFlash()
      elseif self._anim == "Transparent" then
        entity:NewEnableTransparent()
      elseif self._anim == "Ghost" then
        entity:NewEnableGhost()
      elseif self._anim == "FlashAlpha" then
        entity:NewEnableFlashAlpha()
      end
    end
  end
end
