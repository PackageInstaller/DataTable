_class("UISummerActivityTwoLevelItem", UICustomWidget)
UISummerActivityTwoLevelItem = UISummerActivityTwoLevelItem

function UISummerActivityTwoLevelItem:OnShow()
  self._normalPanel = self:GetGameObject("NormalPanel")
  self._normalIcon = self:GetUIComponent("RawImageLoader", "NormalIcon")
  self._normalRed = self:GetGameObject("NormalRed")
  self._normalComplete = self:GetGameObject("NormalComplete")
  self._normalIndex = self:GetUIComponent("UILocalizationText", "NormalIndex")
  self._affixPanel = self:GetGameObject("AffixPanel")
  self._affixIcon = self:GetUIComponent("RawImageLoader", "AffixIcon")
  self._scoreIcon = self:GetUIComponent("RawImageLoader", "ScoreIcon")
  self._score = self:GetUIComponent("UILocalizationText", "Score")
  self._affixName = self:GetUIComponent("UILocalizationText", "AffixName")
  self._affixRed = self:GetGameObject("AffixRed")
  self._scoreIconGo = self:GetGameObject("ScoreIcon")
  self._scoreGo = self:GetGameObject("Score")
  self._tipsGo = self:GetGameObject("Tips")
  self._tipsLabel = self:GetUIComponent("UILocalizationText", "Tips")
end

function UISummerActivityTwoLevelItem:Refresh(levelData)
  self._levelData = levelData
  self._levelType = self._levelData:GetLevelType()
  local status = self._levelData:GetStatus()
  if self._levelType == UISummerActivity2LevelType.Normal then
    self._normalPanel:SetActive(true)
    self._affixPanel:SetActive(false)
    self._normalIcon:LoadImage(self:GetIconName(status))
    if status == UISummerActivityTwoLevelStatus.UnComplete then
      self._normalRed:SetActive(true)
    else
      self._normalRed:SetActive(false)
    end
    if status == UISummerActivityTwoLevelStatus.Complete then
      self._normalComplete:SetActive(true)
    else
      self._normalComplete:SetActive(false)
    end
    self._normalIndex.text = self:GetLevelName()
  elseif self._levelType == UISummerActivity2LevelType.Affix then
    self._normalPanel:SetActive(false)
    self._affixPanel:SetActive(true)
    self._scoreIcon:LoadImage(UISummerActivityTwoConst.EntryIcon)
    self._score.text = self._levelData:GetMaxScore()
    if status == UISummerActivityTwoLevelStatus.UnComplete then
      self._affixRed:SetActive(true)
    else
      self._affixRed:SetActive(false)
    end
    self._affixIcon:LoadImage(self:GetIconName(status))
    self._affixName:SetText(self:GetLevelName())
    if status == UISummerActivityTwoLevelStatus.UnOpen then
      self._scoreIconGo:SetActive(false)
      self._scoreGo:SetActive(false)
      self._tipsGo:SetActive(true)
      self._tipsLabel.text = StringTable.Get("str_summer_activity_two_level_un_open_tips")
    elseif status == UISummerActivityTwoLevelStatus.Complete then
      self._scoreIconGo:SetActive(true)
      self._scoreGo:SetActive(true)
      self._tipsGo:SetActive(false)
    elseif status == UISummerActivityTwoLevelStatus.UnComplete then
      self._scoreIconGo:SetActive(false)
      self._scoreGo:SetActive(false)
      self._tipsGo:SetActive(true)
      self._tipsLabel.text = StringTable.Get("str_summer_activity_two_level_unstart")
    end
  else
    self._normalPanel:SetActive(false)
    self._affixPanel:SetActive(false)
  end
end

function UISummerActivityTwoLevelItem:RefreshRemainTime()
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = timeModule:GetServerTime() / 1000
  local seconds = math.floor(self._levelData:GetTimes() - nowTime)
  if seconds < 0 then
    seconds = 0
    self._levelData:CalStatus()
    self:Refresh(self._levelData)
    return
  end
  local timeStr = ""
  local day = math.floor(seconds / 3600 / 24)
  if 0 < day then
    seconds = seconds - day * 3600 * 24
    local hour = math.floor(seconds / 3600)
    timeStr = StringTable.Get("str_summer_activity_two_day", day)
    if 0 < hour then
      timeStr = timeStr .. StringTable.Get("str_summer_activity_two_hour", hour)
    end
  elseif 60 <= seconds then
    local hour = math.floor(seconds / 3600)
    seconds = seconds - hour * 3600
    if 0 < hour then
      timeStr = StringTable.Get("str_summer_activity_two_hour", hour)
    end
    local minus = math.floor(seconds / 60)
    if minus then
      timeStr = timeStr .. StringTable.Get("str_summer_activity_two_minus", minus)
    end
  else
    timeStr = StringTable.Get("str_summer_activity_two_less_minus")
  end
  return timeStr
end

function UISummerActivityTwoLevelItem:BtnOnClick()
  if self._levelData:GetStatus() == UISummerActivityTwoLevelStatus.UnOpen then
    if self._levelData:IsPreLevelCondition() then
      ToastManager.ShowToast(StringTable.Get("str_summer_activity_two_level_unlock_tips"))
    else
      local remainTimeStr = self:RefreshRemainTime()
      ToastManager.ShowToast(StringTable.Get("str_summer_activity_two_normal_level_unopen_tips", remainTimeStr))
    end
    return
  end
  if self._levelData:GetLevelType() == UISummerActivity2LevelType.Normal then
    self:ShowDialog("UISummerActivityTwoNormalLevelDetail", self._levelData)
  elseif self._levelData:GetLevelType() == UISummerActivity2LevelType.Affix then
    self:ShowDialog("UISummerActivityTwoLevelDetail", self._levelData)
  end
end

function UISummerActivityTwoLevelItem:NormalBtnOnClick()
  self:BtnOnClick()
end

function UISummerActivityTwoLevelItem:AffixBtnOnClick()
  self:BtnOnClick()
end

function UISummerActivityTwoLevelItem:GetIconName(status)
  if status == UISummerActivityTwoLevelStatus.UnOpen then
    return self._levelData:GetLevelIconUnOpen()
  elseif status == UISummerActivityTwoLevelStatus.Complete then
    return self._levelData:GetLevelIconComplete()
  elseif status == UISummerActivityTwoLevelStatus.UnComplete then
    return self._levelData:GetLevelIconUnComplete()
  end
  return ""
end

function UISummerActivityTwoLevelItem:GetLevelName()
  if self._levelType == UISummerActivity2LevelType.Normal then
    return self._levelData:GetLevelGroup() .. "-" .. self._levelData:GetSortIndex()
  elseif self._levelType == UISummerActivity2LevelType.Affix then
    return self._levelData:GetName() .. " " .. self._levelData:GetLevelGroup() .. "-" .. self._levelData:GetSortIndex()
  else
    return self._levelData:GetName()
  end
end
