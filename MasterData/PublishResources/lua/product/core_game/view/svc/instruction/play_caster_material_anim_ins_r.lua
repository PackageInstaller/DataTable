require("base_ins_r")
_class("PlayCasterMaterialAnimInstruction", BaseInstruction)
PlayCasterMaterialAnimInstruction = PlayCasterMaterialAnimInstruction

function PlayCasterMaterialAnimInstruction:Constructor(paramList)
  self._animName = paramList.animName
  self._forcePlayOnSkillHolder = tonumber(paramList.forcePlayOnSkillHolder) == 1
end

function PlayCasterMaterialAnimInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local e = casterEntity
  if casterEntity:HasSuperEntity() and casterEntity:EntityType():IsSkillHolder() and not self._forcePlayOnSkillHolder then
    local cSuperEntity = casterEntity:SuperEntityComponent()
    e = cSuperEntity:GetSuperEntity()
  end
  e:PlayMaterialAnim(self._animName)
end
