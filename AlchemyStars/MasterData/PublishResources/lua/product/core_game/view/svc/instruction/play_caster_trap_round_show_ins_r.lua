require("base_ins_r")
_class("PlayCasterTrapRoundShowInstruction", BaseInstruction)
PlayCasterTrapRoundShowInstruction = PlayCasterTrapRoundShowInstruction

function PlayCasterTrapRoundShowInstruction:Constructor(paramList)
  local param = tonumber(paramList.visible)
  if param == 1 then
    self._visible = true
  else
    self._visible = false
  end
  self._text = paramList.text
end

function PlayCasterTrapRoundShowInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local roundRender = casterEntity:TrapRoundInfoRender()
  if not roundRender then
    return
  end
  roundRender:SetIsShow(self._visible)
  local round_entity_id = roundRender:GetRoundInfoEntityID()
  local round_entity = world:GetEntityByID(round_entity_id)
  if not round_entity then
    return
  end
  round_entity:SetViewVisible(self._visible)
  if self._visible then
    local go = round_entity:View().ViewWrapper.GameObject
    local uiview = go:GetComponent("UIView")
    if uiview then
      local text = uiview:GetUIComponent("UILocalizationText", "CurRoundText")
      if self._text then
        text:SetText(self._text)
      else
        text:SetText("!")
      end
    end
    local renderEntityService = world:GetService("RenderEntity")
    renderEntityService:SetHudPosition(casterEntity, round_entity, roundRender:GetOffset())
  end
end
