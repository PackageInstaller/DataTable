require("base_ins_r")
_class("PlayCasterTrapRoundInstruction", BaseInstruction)
PlayCasterTrapRoundInstruction = PlayCasterTrapRoundInstruction

function PlayCasterTrapRoundInstruction:Constructor(paramList)
end

function PlayCasterTrapRoundInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local roundRender = casterEntity:TrapRoundInfoRender()
  if not roundRender then
    return
  end
  local round_entity_id = roundRender:GetRoundInfoEntityID()
  local round_entity = world:GetEntityByID(round_entity_id)
  if not round_entity then
    return
  end
  local attrCmpt = casterEntity:RenderAttributes()
  local curRound = attrCmpt:GetAttribute("CurrentRound") or 1
  local totalRound = attrCmpt:GetAttribute("TotalRound")
  local go = round_entity:View().ViewWrapper.GameObject
  local uiview = go:GetComponent("UIView")
  if uiview then
    local text = uiview:GetUIComponent("UILocalizationText", "CurRoundText")
    local left = totalRound - curRound + 1
    if left == 1 then
      text:SetText("!")
    else
      text:SetText(left)
    end
  end
end
