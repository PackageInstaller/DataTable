_class("UIActivityN29DiffLevelNode", UIActivityDiffLevelNode)
UIActivityN29DiffLevelNode = UIActivityN29DiffLevelNode

function UIActivityN29DiffLevelNode:OnInit()
  self._anim = self:GetUIComponent("Animation", "Anim")
end

function UIActivityN29DiffLevelNode:PlayAnimation()
  if self._anim then
    if self._rectTransform.anchoredPosition.x > -180 then
      self._anim:Play("uieff_UIActivityN29DiffLevelNode_in03")
    elseif self._rectTransform.anchoredPosition.x < -180 then
      self._anim:Play("uieff_UIActivityN29DiffLevelNode_in01")
    else
      self._anim:Play("uieff_UIActivityN29DiffLevelNode_in02")
    end
  end
end
