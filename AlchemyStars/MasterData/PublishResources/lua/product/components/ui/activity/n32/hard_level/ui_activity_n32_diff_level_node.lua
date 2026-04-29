_class("UIActivityN32DiffLevelNode", UIActivityDiffLevelNode)
UIActivityN32DiffLevelNode = UIActivityN32DiffLevelNode

function UIActivityN32DiffLevelNode:OnInit()
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._nameGo = self:GetGameObject("Name")
  self._iconLockLoader = self:GetUIComponent("RawImageLoader", "IconLock")
end

function UIActivityN32DiffLevelNode:OnRefresh()
  if self._data:IsOpen() then
    self._nameGo:SetActive(true)
  else
    self._nameGo:SetActive(false)
    self._iconLockLoader:LoadImage(self._data:GetUnOpenIcon())
  end
end

function UIActivityN32DiffLevelNode:PlayAnimation()
  if self._anim then
    if self._rectTransform.anchoredPosition.y > 0 then
      self._anim:Play("uieff_UIActivityN32NHardLevelNode_in01")
    elseif self._rectTransform.anchoredPosition.y <= 0 then
      self._anim:Play("uieff_UIActivityN32NHardLevelNode_in02")
    end
  end
end
