_class("UIN28GronruGameAdventureForum", UICustomWidget)
UIN28GronruGameAdventureForum = UIN28GronruGameAdventureForum

function UIN28GronruGameAdventureForum:Constructor()
  self._parent = nil
  self._cfg = nil
end

function UIN28GronruGameAdventureForum:OnShow(uiParams)
  self._uiShort = self:GetUIComponent("RectTransform", "uiShort")
  self._uiLong = self:GetUIComponent("RectTransform", "uiLong")
  self._uiAgree = self:GetUIComponent("RectTransform", "uiAgree")
  self._uiDisagreee = self:GetUIComponent("RectTransform", "uiDisagreee")
  self._txtHour = self:GetUIComponent("UILocalizationText", "txtHour")
  self._txtPublisher = self:GetUIComponent("UILocalizationText", "txtPublisher")
  self._txtPublisherThumb = self:GetUIComponent("UILocalizationText", "txtPublisherThumb")
end

function UIN28GronruGameAdventureForum:OnHide()
end

function UIN28GronruGameAdventureForum:BtnPreviewOnClick(go)
  self._parent:OnForumPreview(self._cfg)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BounceTabExpand)
end

function UIN28GronruGameAdventureForum:Flush(parent, cfg)
  self._parent = parent
  self._cfg = cfg
  if self._cfg.LayoutType == UIN28GronruPlatformType.Forum_Layout_Short then
    self:ResetCellSize(self._uiShort.sizeDelta)
  elseif self._cfg.LayoutType == UIN28GronruPlatformType.Forum_Layout_Long then
    self:ResetCellSize(self._uiLong.sizeDelta)
  end
  self._uiAgree.gameObject:SetActive(self._cfg.CommentType == UIN28GronruPlatformType.Forum_Comment_Agree)
  self._uiDisagreee.gameObject:SetActive(self._cfg.CommentType == UIN28GronruPlatformType.Forum_Comment_Disagree)
  self._txtHour:SetText(StringTable.Get(self._cfg.GameDuration))
  self._txtPublisher:SetText(StringTable.Get(self._cfg.Publisher))
  self._txtPublisherThumb:SetText(StringTable.Get(self._cfg.Name))
end

function UIN28GronruGameAdventureForum:ResetCellSize(cellSize)
  local view = self:View()
  local rt = view.transform
  rt.pivot = Vector2.one * 0.5
  rt.localScale = Vector3.one
  rt.anchorMin = Vector2(0, 1)
  rt.anchorMax = Vector2(0, 1)
  rt.sizeDelta = cellSize
  rt.anchoredPosition = Vector2.zero
end

function UIN28GronruGameAdventureForum:Size()
  if self._cfg.LayoutType == UIN28GronruPlatformType.Forum_Layout_Short then
    return self._uiShort.sizeDelta
  elseif self._cfg.LayoutType == UIN28GronruPlatformType.Forum_Layout_Long then
    return self._uiLong.sizeDelta
  end
  local rt = self:View().transform
  return rt.sizeDelta
end

function UIN28GronruGameAdventureForum:SetPos(x, y)
  local rt = self:View().transform
  rt.anchoredPosition = Vector2(x, y)
end
