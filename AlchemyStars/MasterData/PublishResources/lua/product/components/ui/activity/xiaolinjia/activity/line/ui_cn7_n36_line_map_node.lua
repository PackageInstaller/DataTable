require("ui_activity_line_level_node_base")
_class("UICN7N36LineMapNode", UIActivityLineLevelNodeBase)
UICN7N36LineMapNode = UICN7N36LineMapNode

function UICN7N36LineMapNode:OnInit()
  self._anim = self:GetUIComponent("Animation", "Anim")
end

function UICN7N36LineMapNode:PlayAnimation()
  if self._anim then
    if self._rectTransform.anchoredPosition.y > 0 then
      self._anim:Play("uieff_UICN7N36MapNode_in01")
    elseif self._rectTransform.anchoredPosition.y <= 0 then
      self._anim:Play("uieff_UICN7N36MapNode_in")
    end
  end
end
