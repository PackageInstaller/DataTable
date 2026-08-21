_class("UIActivityN32NHardLevelNode", UIActivityNHardLevelNode)
UIActivityN32NHardLevelNode = UIActivityN32NHardLevelNode

function UIActivityN32NHardLevelNode:OnInit()
  self._open = self:GetGameObject("Open")
  self._lockIconLoader = self:GetUIComponent("RawImageLoader", "LockIcon")
  self._completeIconLoader = self:GetUIComponent("RawImageLoader", "CompleteIcon")
  self._anim = self:GetUIComponent("Animation", "Anim")
end

function UIActivityN32NHardLevelNode:GetLockTipsString()
  return "str_n32_hard_level_lock_tips"
end

function UIActivityN32NHardLevelNode:PlayAnimation()
  if self._anim then
    if self._rectTransform.anchoredPosition.y > 0 then
      self._anim:Play("uieff_UIActivityN32NHardLevelNode_in01")
    elseif self._rectTransform.anchoredPosition.y <= 0 then
      self._anim:Play("uieff_UIActivityN32NHardLevelNode_in02")
    end
  end
end

function UIActivityN32NHardLevelNode:OnLevelOpen(clientCfg)
  self._open:SetActive(true)
  self._lock:SetActive(false)
  self._complete:SetActive(false)
  if clientCfg then
    self._iconLoader:LoadImage(clientCfg.Icon)
  end
end

function UIActivityN32NHardLevelNode:OnLevelLock(clientCfg)
  self._open:SetActive(false)
  self._lock:SetActive(true)
  self._complete:SetActive(false)
  if clientCfg then
    self._iconLoader:LoadImage(clientCfg.Icon)
    self._lockIconLoader:LoadImage(clientCfg.CloseIcon)
  end
end

function UIActivityN32NHardLevelNode:OnLevelComplete(clientCfg)
  self._open:SetActive(true)
  self._lock:SetActive(false)
  self._complete:SetActive(true)
  if clientCfg then
    self._iconLoader:LoadImage(clientCfg.Icon)
    self._completeIconLoader:LoadImage(clientCfg.CompleteIcon)
  end
end
