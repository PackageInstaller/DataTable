_class("UIN29DetectiveSuspectClueItem", UICustomWidget)
UIN29DetectiveSuspectClueItem = UIN29DetectiveSuspectClueItem

function UIN29DetectiveSuspectClueItem:OnShow(uiParams)
  self:InitWidget()
end

function UIN29DetectiveSuspectClueItem:InitWidget()
  self._tip = self:GetGameObject("tip")
  self._haveClicked = self:GetGameObject("haveClicked")
  self._clue = self:GetUIComponent("Image", "Clue")
  self._rectTransform = self:GetUIComponent("RectTransform", "rectTransform")
  self._clueSize = self:GetUIComponent("RectTransform", "Clue")
end

function UIN29DetectiveSuspectClueItem:SetData(suspiciousId, severList, psdId, playStory, time)
  self.suspiciousId = suspiciousId
  self._severList = severList
  self._psdId = psdId
  self.playStory = playStory
  self.checkTime = time
  if self.checkTime then
    self.checkTime()
  end
  local cfg = Cfg.cfg_component_detective_suspicious[self.suspiciousId]
  self.clue = cfg.ClueId
end

function UIN29DetectiveSuspectClueItem:SetPivos()
  self._rectTransform.anchorMax = Vector2(0.5, 0.5)
  self._rectTransform.anchorMin = Vector2(0.5, 0.5)
end

function UIN29DetectiveSuspectClueItem:SetPosition(position, size)
  self._rectTransform.anchoredPosition = Vector2(position[1], position[2])
  self._clueSize.sizeDelta = Vector2(size[1], size[2])
end

function UIN29DetectiveSuspectClueItem:ClueOnClick()
  if self.checkTime then
    local isOpen = self.checkTime()
    if not isOpen then
      return
    end
  end
  local cfg = Cfg.cfg_component_detective_suspicious[self.suspiciousId]
  local storyId = cfg.StoryId
  local hasClick = UIN29DetectiveHelper.IsInList(self.clue, self._severList)
  if hasClick then
    ToastManager.ShowToast(StringTable.Get("str_n29_detective_have_clicked_suspicious_item"))
  elseif self.playStory then
    Log.fatal("点击可疑点" .. self.suspiciousId)
    self.playStory(storyId, self.suspiciousId)
  end
end

function UIN29DetectiveSuspectClueItem:GetClue()
  return self.suspiciousId
end

function UIN29DetectiveSuspectClueItem:SetTips(bool)
  if self.checkTime then
    self.checkTime()
  end
  if bool then
    if UIN29DetectiveHelper.IsInList(self.clue, self._severList) then
      self._haveClicked:SetActive(true)
      self._tip:SetActive(false)
    else
      self._haveClicked:SetActive(false)
      self._tip:SetActive(true)
    end
  else
    self._haveClicked:SetActive(false)
    self._tip:SetActive(false)
  end
end
