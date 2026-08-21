_class("UIActivityDiffLevelNode", UICustomWidget)
UIActivityDiffLevelNode = UIActivityDiffLevelNode

function UIActivityDiffLevelNode:OnShow(uiParams)
  self:InitWidget()
  self:OnInit()
end

function UIActivityDiffLevelNode:InitWidget()
  self._go = self:GetGameObject()
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self.name = self:GetUIComponent("UILocalizationText", "Name")
  self._lock = self:GetGameObject("Lock")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._unLockTips = self:GetUIComponent("UILocalizationText", "LockTips")
  self._unLockTips1 = self:GetUIComponent("UILocalizationText", "LockTips1")
  self._cup = self:GetGameObject("Cup")
  self._cupNum = self:GetUIComponent("UILocalizedTMP", "CupNum")
  if self._cupNum == nil then
    self._cupNum = self:GetUIComponent("UILocalizationText", "CupNum")
  end
end

function UIActivityDiffLevelNode:SetData(data, cb)
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
    if self._cup then
      self._cup:SetActive(true)
    end
    self:RefreshCupInfo()
    self._iconLoader:LoadImage(self._data:GetOpenIcon())
  else
    self._lock:SetActive(true)
    if self._cup then
      self._cup:SetActive(false)
    end
    self._iconLoader:LoadImage(self._data:GetOpenIcon())
    self._unLockTips:SetText(self._data:GetLockTips())
    if self._unLockTips1 then
      self._unLockTips1:SetText(self._data:GetLockTips())
    end
  end
  self:OnRefresh()
  self:PlayAnimation()
end

function UIActivityDiffLevelNode:BtnOnClick(go)
  if not self._data:IsOpen() then
    ToastManager.ShowToast(self._data:GetLockTips())
    return
  end
  self._onClick(self._data)
end

function UIActivityDiffLevelNode:SetVisible(status)
  self._go:SetActive(status)
end

function UIActivityDiffLevelNode:OnInit()
end

function UIActivityDiffLevelNode:RefreshCupInfo()
  local cupDatas = self._data:GetCupDatas()
  local completCount = self._data:GetCompleteCupCount()
  if self._cupNum then
    self._cupNum:SetText(completCount .. "/" .. #cupDatas)
  end
end

function UIActivityDiffLevelNode:OnRefresh()
end

function UIActivityDiffLevelNode:PlayAnimation()
end
