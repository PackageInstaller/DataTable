_class("UISummerActivityTwoEntryItem", UICustomWidget)
UISummerActivityTwoEntryItem = UISummerActivityTwoEntryItem

function UISummerActivityTwoEntryItem:OnShow()
  self._levelToName = {
    [1] = "I.",
    [2] = "II.",
    [3] = "III.",
    [4] = "IV.",
    [5] = "V.",
    [6] = "VI.",
    [7] = "VII."
  }
  self._selectedBgGo = self:GetGameObject("SelectedBg")
  self._unSelctedGo = self:GetGameObject("UnSelcted")
  self._selectedGo = self:GetGameObject("Selected")
  self._selectedBtnGo = self:GetGameObject("SelectedBtn")
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._levelGo = self:GetGameObject("Level")
  self._levelLabel = self:GetUIComponent("UILocalizationText", "Level")
  self._scoreLabel = self:GetUIComponent("UILocalizationText", "Score")
  self._iconImg = self:GetUIComponent("RawImageLoader", "Icon")
  self._levelIcon = self:GetGameObject("LevelIcon")
  self._icon = self:GetUIComponent("Image", "LevelIcon")
end

function UISummerActivityTwoEntryItem:Refresh(entryData, canSelected, clickCallback, isSingle)
  self._isSingle = isSingle
  self._entryData = entryData
  self._canSelected = canSelected
  self._isSelected = false
  self._groupIsSelected = false
  self._iconImg:LoadImage(UISummerActivityTwoConst.EntryIcon)
  self._levelIcon:SetActive(self._isSingle)
  self._levelGo:SetActive(not self._isSingle)
  if self._canSelected then
    self._unSelctedGo:SetActive(true)
    self._selectedBtnGo:SetActive(true)
    self:RefreshSelectStatus()
  else
    self._selectedBgGo:SetActive(false)
    self._unSelctedGo:SetActive(false)
    self._selectedGo:SetActive(false)
    self._selectedBtnGo:SetActive(false)
    if self._isSingle then
      self._scoreLabel.color = Color(1.0, 0.8156862745098039, 0.1803921568627451, 1)
      self._nameLabel.color = Color(1.0, 0.8156862745098039, 0.1803921568627451, 1)
      self._icon.color = Color(1, 1, 1, 1)
    else
      self._scoreLabel.color = Color(0.9921568627450981, 0.9921568627450981, 0.9921568627450981, 1)
      self._nameLabel.color = Color(0.9921568627450981, 0.9921568627450981, 0.9921568627450981, 1)
      self._levelLabel.color = Color(0.9921568627450981, 0.9921568627450981, 0.9921568627450981, 1)
    end
  end
  self._nameLabel:SetText(self._entryData:GetDes())
  local levelText = ""
  if self._levelToName[self._entryData:GetLevel()] then
    levelText = self._levelToName[self._entryData:GetLevel()]
  end
  self._levelLabel.text = levelText
  self._scoreLabel.text = self._entryData:GetScroeRatioStr()
  self._clickCallback = clickCallback
end

function UISummerActivityTwoEntryItem:RefreshSelectStatus()
  self._selectedBgGo:SetActive(self._isSelected)
  self._selectedGo:SetActive(self._isSelected)
  if self._isSingle then
    if self._isSelected then
      self._scoreLabel.color = Color(0, 0, 0, 1)
      self._nameLabel.color = Color(0, 0, 0, 1)
      self._icon.color = Color(0, 0, 0, 1)
    else
      self._scoreLabel.color = Color(1.0, 0.8156862745098039, 0.1803921568627451, 1)
      self._nameLabel.color = Color(1.0, 0.8156862745098039, 0.1803921568627451, 1)
      self._icon.color = Color(1, 1, 1, 1)
    end
  elseif self._isSelected then
    self._scoreLabel.color = Color(0, 0, 0, 1)
    self._nameLabel.color = Color(0, 0, 0, 1)
    self._levelLabel.color = Color(0, 0, 0, 1)
  elseif self._groupIsSelected then
    self._scoreLabel.color = Color(0.5019607843137255, 0.4980392156862745, 0.4980392156862745, 1)
    self._nameLabel.color = Color(0.5019607843137255, 0.4980392156862745, 0.4980392156862745, 1)
    self._levelLabel.color = Color(0.5019607843137255, 0.4980392156862745, 0.4980392156862745, 1)
  else
    self._scoreLabel.color = Color(0.9921568627450981, 0.9921568627450981, 0.9921568627450981, 1)
    self._nameLabel.color = Color(0.9921568627450981, 0.9921568627450981, 0.9921568627450981, 1)
    self._levelLabel.color = Color(0.9921568627450981, 0.9921568627450981, 0.9921568627450981, 1)
  end
end

function UISummerActivityTwoEntryItem:SetSelectStatus(isSelected, groupIsSelected)
  self._isSelected = isSelected
  self._groupIsSelected = groupIsSelected
  self._entryData:SetSelectedStatus(self._isSelected)
  self:RefreshSelectStatus()
end

function UISummerActivityTwoEntryItem:GetEntryData()
  return self._entryData
end

function UISummerActivityTwoEntryItem:SelectedBtnOnClick()
  if not self._canSelected then
    return
  end
  if self._clickCallback then
    self._clickCallback()
  end
end
