require("ui_activity_diff_level_node")
_class("UIN39DiffLevelNode", UIActivityDiffLevelNode)
UIN39DiffLevelNode = UIN39DiffLevelNode

function UIN39DiffLevelNode:OnInit()
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._nameGo = self:GetGameObject("Name")
  self._iconLockLoader = self:GetUIComponent("RawImageLoader", "IconLock")
  self.name = self:GetUIComponent("UILocalizedTMP", "Name")
  self._unLockTips = self:GetUIComponent("UILocalizedTMP", "LockTips")
end

function UIN39DiffLevelNode:OnRefresh()
  if self._data:IsOpen() then
    self._nameGo:SetActive(true)
  else
    self._nameGo:SetActive(false)
    self._iconLockLoader:LoadImage(self._data:GetUnOpenIcon())
  end
end

function UIN39DiffLevelNode:PlayAnimation()
end
