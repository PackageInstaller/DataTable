require("ui_activity_hard_level_node")
_class("UIActivityCN6N35NHardLevelNode", UIActivityNHardLevelNode)
UIActivityCN6N35NHardLevelNode = UIActivityCN6N35NHardLevelNode

function UIActivityCN6N35NHardLevelNode:OnInit()
  self._open = self:GetGameObject("Open")
  self._lockIconLoader = self:GetUIComponent("RawImageLoader", "LockIcon")
  self._completeIconLoader = self:GetUIComponent("RawImageLoader", "CompleteIcon")
  self._anim = self:GetUIComponent("Animation", "Anim")
end

function UIActivityCN6N35NHardLevelNode:GetLockTipsString()
  return "str_cn6&n35_hard_level_lock_tips"
end

function UIActivityCN6N35NHardLevelNode:PlayAnimation()
end

function UIActivityCN6N35NHardLevelNode:OnLevelOpen(clientCfg)
  self._open:SetActive(true)
  self._lock:SetActive(false)
  self._complete:SetActive(false)
  if clientCfg then
    self._iconLoader:LoadImage(clientCfg.Icon)
  end
end

function UIActivityCN6N35NHardLevelNode:OnLevelLock(clientCfg)
  self._open:SetActive(false)
  self._lock:SetActive(true)
  self._complete:SetActive(false)
  if clientCfg then
    self._iconLoader:LoadImage(clientCfg.Icon)
    self._lockIconLoader:LoadImage(clientCfg.CloseIcon)
  end
end

function UIActivityCN6N35NHardLevelNode:OnLevelComplete(clientCfg)
  self._open:SetActive(true)
  self._lock:SetActive(false)
  self._complete:SetActive(true)
  if clientCfg then
    self._iconLoader:LoadImage(clientCfg.Icon)
    self._completeIconLoader:LoadImage(clientCfg.CompleteIcon)
  end
end
