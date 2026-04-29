require("ui_activity_diff_level_node")
_class("UIActivityCN6N35DiffLevelNode", UIActivityDiffLevelNode)
UIActivityCN6N35DiffLevelNode = UIActivityCN6N35DiffLevelNode

function UIActivityCN6N35DiffLevelNode:OnInit()
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._nameGo = self:GetGameObject("Name")
  self._iconLockLoader = self:GetUIComponent("RawImageLoader", "IconLock")
end

function UIActivityCN6N35DiffLevelNode:OnRefresh()
  if self._data:IsOpen() then
    self._nameGo:SetActive(true)
  else
    self._nameGo:SetActive(false)
    self._iconLockLoader:LoadImage(self._data:GetUnOpenIcon())
  end
end

function UIActivityCN6N35DiffLevelNode:PlayAnimation()
end
