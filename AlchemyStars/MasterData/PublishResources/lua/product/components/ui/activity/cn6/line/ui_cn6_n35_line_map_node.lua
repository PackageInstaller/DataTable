require("ui_activity_line_level_node_base")
_class("UICN6N35LineMapNode", UIActivityLineLevelNodeBase)
UICN6N35LineMapNode = UICN6N35LineMapNode

function UICN6N35LineMapNode:OnInit()
  self._anim = self:GetUIComponent("Animation", "Anim")
end

function UICN6N35LineMapNode:PlayAnimation()
  if not self._anim or self._rectTransform.anchoredPosition.y > 0 then
  elseif self._rectTransform.anchoredPosition.y <= 0 then
  end
end
