_class("UISeasonStoryReviewItemS3", UICustomWidget)
UISeasonStoryReviewItemS3 = UISeasonStoryReviewItemS3

function UISeasonStoryReviewItemS3:Constructor()
  self._splitChar = "|"
  self._maxWidth = 1100
end

function UISeasonStoryReviewItemS3:OnShow(uiParams)
  self:_GetComponents()
end

function UISeasonStoryReviewItemS3:_GetComponents()
  self._lHead = self:GetUIComponent("RawImageLoader", "lHead")
  self._lSpeekerName = self:GetUIComponent("UILocalizationText", "lSpeakerName")
  self._lTalkTxt = self:GetUIComponent("UILocalizationText", "lTalkTxt")
  self._rHead = self:GetUIComponent("RawImageLoader", "rHead")
  self._rSpeekerName = self:GetUIComponent("UILocalizationText", "rSpeakerName")
  self._rTalkTxt = self:GetUIComponent("UILocalizationText", "rTalkTxt")
  self._rect = self:GetUIComponent("RectTransform", "rect")
  self._layout = self:GetUIComponent("HorizontalLayoutGroup", "rect")
  self._lTalkBgRect = self:GetUIComponent("RectTransform", "lTalkBg")
  self._rTalkBgRect = self:GetUIComponent("RectTransform", "rTalkBg")
  self._lTalkBgFitter = self:GetUIComponent("ContentSizeFitter", "lTalkBg")
  self._rTalkBgFitter = self:GetUIComponent("ContentSizeFitter", "rTalkBg")
  self._leftAreaObj = self:GetGameObject("LeftArea")
  self._rightAreaObj = self:GetGameObject("RightArea")
end

function UISeasonStoryReviewItemS3:SetData(storyID)
  self._storyID = storyID
  self:_InitComponents()
end

function UISeasonStoryReviewItemS3:_InitComponents()
  local cfg = Cfg.cfg_season_story_talk[self._storyID]
  local content = SeasonStoryHelper.GetContentInfo(StringTable.Get(cfg.ChatWord))
  if cfg.IsMainActorWord == 1 then
    self._layout.childAlignment = UnityEngine.TextAnchor.UpperLeft
    self._rect.pivot = Vector2(0, 0.5)
    self._leftAreaObj:SetActive(true)
    self._rightAreaObj:SetActive(false)
    self._lHead:LoadImage(cfg.SpeakerHead)
    self._lSpeekerName:SetText(SeasonStoryHelper.DoEscape(StringTable.Get(cfg.SpeakerName)))
    self._lTalkTxt:SetText(content)
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._lTalkBgRect)
    if self._lTalkBgRect.sizeDelta.x > self._maxWidth then
      self._lTalkBgFitter.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.Unconstrained
      local v2 = Vector2(self._maxWidth, self._lTalkBgRect.sizeDelta.y)
      self._lTalkBgRect.sizeDelta = v2
    else
      self._lTalkBgFitter.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.PreferredSize
    end
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._lTalkBgRect)
  else
    self._layout.childAlignment = UnityEngine.TextAnchor.UpperRight
    self._rect.pivot = Vector2(1, 0.5)
    self._leftAreaObj:SetActive(false)
    self._rightAreaObj:SetActive(true)
    self._rHead:LoadImage(cfg.SpeakerHead)
    self._rSpeekerName:SetText(SeasonStoryHelper.DoEscape(StringTable.Get(cfg.SpeakerName)))
    self._rTalkTxt:SetText(content)
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._rTalkBgRect)
    if self._rTalkBgRect.sizeDelta.x > self._maxWidth then
      self._rTalkBgFitter.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.Unconstrained
      local v2 = Vector2(self._maxWidth, self._rTalkBgRect.sizeDelta.y)
      self._rTalkBgRect.sizeDelta = v2
    else
      self._rTalkBgFitter.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.PreferredSize
    end
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._rTalkBgRect)
  end
end
