require("base_ins_r")
_class("PlayCasterAnimationByTrapStateInstruction", BaseInstruction)
PlayCasterAnimationByTrapStateInstruction = PlayCasterAnimationByTrapStateInstruction

function PlayCasterAnimationByTrapStateInstruction:Constructor(paramList)
  self._openAnimName = paramList.openAnimName
  self._closeAnimName = paramList.closeAnimName
end

function PlayCasterAnimationByTrapStateInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local e = casterEntity
  if casterEntity:HasSuperEntity() and casterEntity:EntityType():IsSkillHolder() then
    local cSuperEntity = casterEntity:SuperEntityComponent()
    e = cSuperEntity:GetSuperEntity()
  end
  local renderAttrCmpt = e:RenderAttributes()
  if renderAttrCmpt:GetAttribute("OpenState") and renderAttrCmpt:GetAttribute("OpenState") == 1 then
    e:SetAnimatorControllerTriggers({
      self._openAnimName
    })
  else
    e:SetAnimatorControllerTriggers({
      self._closeAnimName
    })
  end
end
