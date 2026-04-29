_class("UISummerActivityTwoEntryLevelItem", UICustomWidget)
UISummerActivityTwoEntryLevelItem = UISummerActivityTwoEntryLevelItem

function UISummerActivityTwoEntryLevelItem:OnShow()
  self._selectedBgGo = self:GetGameObject("SelectedBg")
  self._unSelctedGo = self:GetGameObject("UnSelcted")
  self._selectedGo = self:GetGameObject("Selected")
  self._selectedBtnGo = self:GetGameObject("SelectedBtn")
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._levelLabel = self:GetUIComponent("UILocalizationText", "Level")
  self._scoreLabel = self:GetUIComponent("UILocalizationText", "Score")
  self._iconImg = self:GetUIComponent("RawImageLoader", "Icon")
  self._desLabel = self:GetUIComponent("UILocalizationText", "Des")
end

function UISummerActivityTwoEntryLevelItem:Refresh(entryLevelData, canSelected, clickCallback)
  if not entryLevelData then
    return
  end
  self._entryLevelData = entryLevelData
  self._canSelected = canSelected
  self._isSelected = false
  self._iconImg:LoadImage(UISummerActivityTwoConst.EntryIcon)
  if self._canSelected then
    self._unSelctedGo:SetActive(true)
    self._selectedBtnGo:SetActive(true)
    self:RefreshSelectStatus()
  else
    self._selectedBgGo:SetActive(false)
    self._unSelctedGo:SetActive(false)
    self._selectedGo:SetActive(false)
    self._selectedBtnGo:SetActive(false)
    self._scoreLabel.color = Color(0.9921568627450981, 0.9921568627450981, 0.9921568627450981, 1)
    self._nameLabel.color = Color(0.9921568627450981, 0.9921568627450981, 0.9921568627450981, 1)
    self._levelLabel.color = Color(0.9921568627450981, 0.9921568627450981, 0.9921568627450981, 1)
    self._desLabel.color = Color(0.9921568627450981, 0.9921568627450981, 0.9921568627450981, 1)
  end
  self._levelLabel.text = self._entryLevelData:GetLevelStr()
  self._nameLabel:SetText(self._entryLevelData:GetLevelName())
  self._desLabel:SetText(StringTable.Get("str_summer_activity_two_suggest_level_and_awake", self._entryLevelData:GetSuggestAwake(), self._entryLevelData:GetSuggestLevel()))
  self._scoreLabel.text = self._entryLevelData:GetLevelScore()
  self._clickCallback = clickCallback
end

function UISummerActivityTwoEntryLevelItem:RefreshSelectStatus()
  self._selectedBgGo:SetActive(self._isSelected)
  self._selectedGo:SetActive(self._isSelected)
  if self._isSelected then
    self._scoreLabel.color = Color(0, 0, 0, 1)
    self._nameLabel.color = Color(0, 0, 0, 1)
    self._levelLabel.color = Color(0, 0, 0, 1)
    self._desLabel.color = Color(0.8549019607843137, 0.2, 0.2, 1)
  else
    self._scoreLabel.color = Color(0.5607843137254902, 0.5607843137254902, 0.5607843137254902, 1)
    self._nameLabel.color = Color(0.5607843137254902, 0.5607843137254902, 0.5607843137254902, 1)
    self._levelLabel.color = Color(0.5607843137254902, 0.5607843137254902, 0.5607843137254902, 1)
    self._desLabel.color = Color(0.5607843137254902, 0.5607843137254902, 0.5607843137254902, 1)
  end
end

function UISummerActivityTwoEntryLevelItem:SetSelectStatus(isSelected)
  self._isSelected = isSelected
  self._entryLevelData:SetSelectedStatus(self._isSelected)
  self:RefreshSelectStatus()
end

function UISummerActivityTwoEntryLevelItem:GetEntryLevelData()
  return self._entryLevelData
end

function UISummerActivityTwoEntryLevelItem:SelectedBtnOnClick()
  if not self._canSelected then
    return
  end
  if self._isSelected then
    return
  end
  if self._clickCallback then
    self._clickCallback()
  end
end
