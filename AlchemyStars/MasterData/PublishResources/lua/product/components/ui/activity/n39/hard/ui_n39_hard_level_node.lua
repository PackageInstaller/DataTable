require("ui_activity_hard_level_node")
_class("UIN39HardLevelNode", UIActivityNHardLevelNode)
UIN39HardLevelNode = UIN39HardLevelNode

function UIN39HardLevelNode:OnInit()
  self._open = self:GetGameObject("Open")
  self._lockIconLoader = self:GetUIComponent("RawImageLoader", "LockIcon")
  self._completeIconLoader = self:GetUIComponent("RawImageLoader", "CompleteIcon")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self.name = self:GetUIComponent("UILocalizedTMP", "Name")
  self._lockTips = self:GetUIComponent("UILocalizedTMP", "LockTips")
end

function UIN39HardLevelNode:GetLockTipsString()
  return "str_cn6&n35_hard_level_lock_tips"
end

function UIN39HardLevelNode:PlayAnimation()
end

function UIN39HardLevelNode:OnLevelOpen(clientCfg)
  self._open:SetActive(true)
  self._lock:SetActive(false)
  self._complete:SetActive(false)
  if clientCfg then
    self._iconLoader:LoadImage(clientCfg.Icon)
  end
end

function UIN39HardLevelNode:OnLevelLock(clientCfg)
  self._open:SetActive(false)
  self._lock:SetActive(true)
  self._complete:SetActive(false)
  if clientCfg then
    self._iconLoader:LoadImage(clientCfg.Icon)
    self._lockIconLoader:LoadImage(clientCfg.CloseIcon)
  end
end

function UIN39HardLevelNode:OnLevelComplete(clientCfg)
  self._open:SetActive(true)
  self._lock:SetActive(false)
  self._complete:SetActive(true)
  if clientCfg then
    self._iconLoader:LoadImage(clientCfg.Icon)
    self._completeIconLoader:LoadImage(clientCfg.CompleteIcon)
  end
end
