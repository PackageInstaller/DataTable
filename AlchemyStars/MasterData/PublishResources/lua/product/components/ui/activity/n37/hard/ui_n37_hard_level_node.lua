require("ui_activity_hard_level_node")
_class("UIN37HardLevelNode", UIActivityNHardLevelNode)
UIN37HardLevelNode = UIN37HardLevelNode

function UIN37HardLevelNode:OnInit()
  self._open = self:GetGameObject("Open")
  self._lockIconLoader = self:GetUIComponent("RawImageLoader", "LockIcon")
  self._completeIconLoader = self:GetUIComponent("RawImageLoader", "CompleteIcon")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self.name = self:GetUIComponent("UILocalizedTMP", "Name")
end

function UIN37HardLevelNode:GetLockTipsString()
  return "str_cn6&n35_hard_level_lock_tips"
end

function UIN37HardLevelNode:PlayAnimation()
  self:StartTask(function(TT)
    self._anim:Play("uieff_UIN37DiffLevelNode_in")
  end)
end

function UIN37HardLevelNode:OnLevelOpen(clientCfg)
  self._open:SetActive(true)
  self._lock:SetActive(false)
  self._complete:SetActive(false)
  if clientCfg then
    self._iconLoader:LoadImage(clientCfg.Icon)
  end
end

function UIN37HardLevelNode:OnLevelLock(clientCfg)
  self._open:SetActive(false)
  self._lock:SetActive(true)
  self._complete:SetActive(false)
  if clientCfg then
    self._iconLoader:LoadImage(clientCfg.Icon)
    self._lockIconLoader:LoadImage(clientCfg.CloseIcon)
  end
end

function UIN37HardLevelNode:OnLevelComplete(clientCfg)
  self._open:SetActive(true)
  self._lock:SetActive(false)
  self._complete:SetActive(true)
  if clientCfg then
    self._iconLoader:LoadImage(clientCfg.Icon)
    self._completeIconLoader:LoadImage(clientCfg.CompleteIcon)
  end
end
