_class("UIN29DetectiveTalkItem", UICustomWidget)
UIN29DetectiveTalkItem = UIN29DetectiveTalkItem

function UIN29DetectiveTalkItem:OnShow(uiParams)
  self:InitWidget()
end

function UIN29DetectiveTalkItem:InitWidget()
  self._lock = self:GetGameObject("Lock")
  self._unlock = self:GetGameObject("Unlock")
  self._show = self:GetGameObject("Show")
  self._clueUISelect = self:GetUIComponent("UISelectObjectPath", "Clue")
  self._showBtn = self:GetGameObject("ShowBtn")
  self._clicked = self:GetGameObject("Clicked")
  self._notClick = self:GetGameObject("NotClick")
  self._showTitle = self:GetUIComponent("UILocalizationText", "ShowTitle")
  self._unlockTitle = self:GetUIComponent("UILocalizationText", "UnlockTitle")
  self._lockTitle = self:GetUIComponent("UILocalizationText", "LockTitle")
end

function UIN29DetectiveTalkItem:SetData(talkId, severList, psdId, playStory, right, wrong, time)
  self.talkId = talkId
  self.severLsit = severList
  self._psdId = psdId
  self.playStory = playStory
  self.rightShow = right
  self.wrongShow = wrong
  self.checkTime = time
  if self.checkTime then
    self.checkTime()
  end
  local cfg = Cfg.cfg_component_detective_talk[self.talkId]
  self._clueID = cfg.ClueId
  self._storyID = cfg.StoryID
  self._title = cfg.Title
  self._show:SetActive(false)
  self._lock:SetActive(false)
  self._unlock:SetActive(false)
  self.haveGetClue = UIN29DetectiveHelper.IsInList(self._clueID, self.severLsit)
  if UIN29DetectiveHelper.IsLock(self.talkId, self.severLsit) and not self.haveGetClue then
    if UIN29DetectiveHelper.IsShow(self.talkId, self.severLsit) then
      if UIN29DetectiveHelper.CheckOpenIdKey(self._psdId, "UIN29DetectiveTalkItemShow" .. self.talkId) then
        self:InitUnlockData()
      else
        self:InitShowData()
      end
    else
      self:InitLockData()
    end
  else
    self:InitUnlockData()
  end
end

function UIN29DetectiveTalkItem:InitShowData()
  self._show:SetActive(true)
  self._showTitle:SetText(StringTable.Get(self._title))
  local clues = Cfg.cfg_component_detective_talk[self.talkId].NeedClue
  self._clueUISelect:SpawnObjects("UIN29DetectiveTalkClueItem", #clues)
  self._clues = self._clueUISelect:GetAllSpawnList()
  for i = 1, #self._clues do
    self._clues[i]:SetData(clues[i], function(item)
      self:OnClueClicked(item)
    end)
    if i == 1 then
      self:OnClueClicked(self._clues[i])
    end
  end
end

function UIN29DetectiveTalkItem:InitLockData()
  self._lock:SetActive(true)
  self._lockTitle:SetText(StringTable.Get(self._title))
end

function UIN29DetectiveTalkItem:InitUnlockData()
  self._unlock:SetActive(true)
  self._unlockTitle:SetText(StringTable.Get(self._title))
  if self.haveGetClue then
    self._clicked:SetActive(true)
    self._notClick:SetActive(false)
  else
    self._clicked:SetActive(false)
    self._notClick:SetActive(true)
  end
end

function UIN29DetectiveTalkItem:OnClueClicked(item)
  if self.checkTime then
    self.checkTime()
  end
  if self._clueWidget then
    self._clueWidget:SetSelected(false)
  end
  self._clueWidget = item
  self._clueWidget:SetSelected(true)
  self._clueId = self._clueWidget:GetClue()
end

function UIN29DetectiveTalkItem:ShowBtnOnClick()
  if self.checkTime then
    self.checkTime()
  end
  local RightClueId = Cfg.cfg_component_detective_talk[self.talkId].Evidence
  if self._clueId and RightClueId == self._clueId then
    self._show:SetActive(false)
    self._unlock:SetActive(true)
    self._notClick:SetActive(true)
    self._unlockTitle:SetText(StringTable.Get(self._title))
    if self.rightShow then
      self.rightShow()
    end
    UIN29DetectiveHelper.SetOpenIdKey(self._psdId, "UIN29DetectiveTalkItemShow" .. self.talkId)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N20StrategyAdd)
  elseif self.wrongShow then
    self.wrongShow()
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N20StrategyReduce)
  end
end

function UIN29DetectiveTalkItem:UnlockOnClick()
  if self.checkTime then
    local isOpen = self.checkTime()
    if not isOpen then
      return
    end
  end
  local hasGetClue = UIN29DetectiveHelper.IsInList(self._clueID, self.severLsit)
  if hasGetClue then
    ToastManager.ShowToast(StringTable.Get("str_n29_detective_had_clue"))
  elseif self.playStory then
    self.playStory(self._storyID, self.talkId)
  end
end

function UIN29DetectiveTalkItem:LockOnClick()
  if self.checkTime then
    self.checkTime()
  end
  ToastManager.ShowToast(StringTable.Get("str_n29_detective_not_had_clue"))
end

function UIN29DetectiveTalkItem:GetItemBtnGo()
  return self._unlock
end
