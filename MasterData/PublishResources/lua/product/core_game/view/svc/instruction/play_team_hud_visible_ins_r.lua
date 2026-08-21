require("base_ins_r")
_class("PlayTeamHUDVisibleInstruction", BaseInstruction)
PlayTeamHUDVisibleInstruction = PlayTeamHUDVisibleInstruction

function PlayTeamHUDVisibleInstruction:Constructor(paramList)
  self._visible = tonumber(paramList.visible)
end

function PlayTeamHUDVisibleInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local teamEntity = world:Player():GetCurrentTeamEntity()
  local hpComponent = teamEntity:HP()
  if not hpComponent then
    return
  end
  local sliderEntityId = hpComponent:GetHPSliderEntityID()
  local sliderEntity = world:GetEntityByID(sliderEntityId)
  if not sliderEntity then
    return
  end
  hpComponent:SetHPBarTempHide(self._visible == 0)
  hpComponent:SetHPPosDirty(true)
end
