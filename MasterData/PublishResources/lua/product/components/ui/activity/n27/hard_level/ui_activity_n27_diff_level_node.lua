_class("UIActivityN27DiffLevelNode", UICustomWidget)
UIActivityN27DiffLevelNode = UIActivityN27DiffLevelNode

function UIActivityN27DiffLevelNode:OnShow(uiParams)
  self:InitWidget()
end

function UIActivityN27DiffLevelNode:InitWidget()
  self._go = self:GetGameObject()
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self._lock = self:GetGameObject("Lock")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._unLockTips = self:GetUIComponent("UILocalizationText", "UnLockTips")
  self._cup = self:GetGameObject("Cup")
  self._cupNum = self:GetUIComponent("UILocalizedTMP", "CupNum")
  self._anim = self:GetUIComponent("Animation", "Anim")
end

function UIActivityN27DiffLevelNode:SetData(data, cb)
  self._data = data
  self._onClick = cb
  self._go:SetActive(true)
  self._rectTransform.anchorMax = Vector2(0.5, 0.5)
  self._rectTransform.anchorMin = Vector2(0.5, 0.5)
  self._rectTransform.sizeDelta = Vector2.zero
  self._rectTransform.anchoredPosition = self._data:GetPosition()
  self.name:SetText(self._data:GetNodeName())
  if self._data:IsOpen() then
    self._lock:SetActive(false)
    self._cup:SetActive(true)
    local cupDatas = self._data:GetCupDatas()
    local completCount = self._data:GetCompleteCupCount()
    self._cupNum:SetText(completCount .. "/" .. #cupDatas)
    self._iconLoader:LoadImage(self._data:GetOpenIcon())
  else
    self._lock:SetActive(true)
    self._cup:SetActive(false)
    self._iconLoader:LoadImage(self._data:GetUnOpenIcon())
    self._unLockTips:SetText(self._data:GetLockTips())
  end
  if self._rectTransform.anchoredPosition.y >= 67 then
    self._anim:Play("uieff_UIActivityN27DiffLevelNode_up")
  else
    self._anim:Play("uieff_UIActivityN27DiffLevelNode_down")
  end
end

function UIActivityN27DiffLevelNode:BtnOnClick(go)
  if not self._data:IsOpen() then
    ToastManager.ShowToast(self._data:GetLockTips())
    return
  end
  self._onClick(self._data)
end

function UIActivityN27DiffLevelNode:SetVisible(status)
  self._go:SetActive(status)
end
