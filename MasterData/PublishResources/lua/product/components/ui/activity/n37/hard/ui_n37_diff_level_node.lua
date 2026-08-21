require("ui_activity_diff_level_node")
_class("UIN37DiffLevelNode", UIActivityDiffLevelNode)
UIN37DiffLevelNode = UIN37DiffLevelNode

function UIN37DiffLevelNode:OnInit()
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._nameGo = self:GetGameObject("Name")
  self._iconLockLoader = self:GetUIComponent("RawImageLoader", "IconLock")
  self.name = self:GetUIComponent("UILocalizedTMP", "Name")
end

function UIN37DiffLevelNode:OnRefresh()
  if self._data:IsOpen() then
    self._nameGo:SetActive(true)
  else
    self._nameGo:SetActive(false)
    self._iconLockLoader:LoadImage(self._data:GetUnOpenIcon())
  end
end

function UIN37DiffLevelNode:PlayAnimation()
  if self._anim then
    if self._rectTransform.anchoredPosition.y > 0 then
      self._anim:Play("uieff_UIN37HardLevelNode_UP")
    elseif self._rectTransform.anchoredPosition.y <= 0 then
      self._anim:Play("uieff_UIN37HardLevelNode_down")
    end
  end
end
