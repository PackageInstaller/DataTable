_class("UIActivityN21CCLevelHardItem", UICustomWidget)
UIActivityN21CCLevelHardItem = UIActivityN21CCLevelHardItem

function UIActivityN21CCLevelHardItem:OnShow()
  self._scoreGo = self:GetGameObject("Score")
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._scoreLabel = self:GetUIComponent("UILocalizationText", "Score")
  self._lock = self:GetGameObject("Lock")
end

function UIActivityN21CCLevelHardItem:OnHide()
end

function UIActivityN21CCLevelHardItem:Refresh(levelData, isSelected, callback)
  self._levelData = levelData
  self._callback = callback
  if levelData:IsLevelOpen() then
    self._lock:SetActive(false)
    self._scoreGo:SetActive(true)
    self._scoreLabel.color = Color(0.996078431372549, 0.9882352941176471, 0.9803921568627451, 1)
    self._nameLabel.color = Color(0.996078431372549, 0.9882352941176471, 0.9803921568627451, 1)
  else
    self._lock:SetActive(true)
    self._scoreGo:SetActive(false)
    self._scoreLabel.color = Color(0.6666666666666666, 0.6666666666666666, 0.6666666666666666, 1)
    self._nameLabel.color = Color(0.6666666666666666, 0.6666666666666666, 0.6666666666666666, 1)
  end
  if isSelected then
    self._scoreLabel.color = Color(1.0, 0.7098039215686275, 0.1607843137254902, 1)
    self._nameLabel.color = Color(1.0, 0.7098039215686275, 0.1607843137254902, 1)
  end
  self._nameLabel:SetText(StringTable.Get("str_n20_crisis_contract_hard_title" .. levelData:GetHardId()))
  self._scoreLabel:SetText(levelData:GetBaseScore())
end

function UIActivityN21CCLevelHardItem:BtnOnClick()
  if not self._levelData:IsLevelOpen() then
    if self._callback then
      self._callback(false, self._levelData:GetHardId())
    end
    ToastManager.ShowToast(StringTable.Get("str_n20_crisis_contract_hard_lock_tips", self._levelData:GetUnLockScore()))
    return
  end
  if self._callback then
    self._callback(true, self._levelData:GetHardId())
  end
end
