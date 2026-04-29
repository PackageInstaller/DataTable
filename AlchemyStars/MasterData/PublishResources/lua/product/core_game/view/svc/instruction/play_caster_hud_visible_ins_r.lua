require("base_ins_r")
_class("PlayCasterHUDVisibleInstruction", BaseInstruction)
PlayCasterHUDVisibleInstruction = PlayCasterHUDVisibleInstruction

function PlayCasterHUDVisibleInstruction:Constructor(paramList)
  self._visible = tonumber(paramList.visible)
end

function PlayCasterHUDVisibleInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  if casterEntity:HasSuperEntity() and casterEntity:EntityType():IsSkillHolder() then
    local cSuperEntity = casterEntity:SuperEntityComponent()
    casterEntity = cSuperEntity:GetSuperEntity()
  end
  local hpComponent = casterEntity:HP()
  if not hpComponent then
    return
  end
  local sliderEntityId = hpComponent:GetHPSliderEntityID()
  local sliderEntity = world:GetEntityByID(sliderEntityId)
  if not sliderEntity then
    return
  end
  local isHide = self._visible == 0
  hpComponent:SetHPBarTempHide(isHide)
  hpComponent:SetHPPosDirty(true)
  if not isHide then
    casterEntity:ReplaceHPComponent()
  end
end
