_class("UIChaptersItem", UICustomWidget)
UIChaptersItem = UIChaptersItem

function UIChaptersItem:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.grassData = self.mCampaign:GetGraveRobberData()
end

function UIChaptersItem:OnShow()
  self._rect = self:GetUIComponent("RectTransform", "rect")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._imgBGMask = self:GetGameObject("imgBGMask")
  self._imgRed = self:GetGameObject("imgRed")
  self.imgGrass = self:GetGameObject("imgGrass")
  self:AttachEvent(GameEventType.GrassClose, self.FlushGrass)
end

function UIChaptersItem:OnHide()
  self:DetachEvent(GameEventType.GrassClose, self.FlushGrass)
end

function UIChaptersItem:Flush(chapter, curChapter)
  self._chapter = chapter
  self._curChapter = curChapter
  self._txtName:SetText(chapter.index_name .. StringTable.Get("str_common_colon") .. chapter.name)
  self._imgBGMask:SetActive(chapter.id ~= curChapter.id)
  if chapter.id == curChapter.id then
    local color = Color(0.5529411764705883, 0.5215686274509804, 0.47843137254901963)
    self._txtName.color = color
  else
    self._txtName.color = Color.white
  end
  local module = self:GetModule(MissionModule)
  local data = module:GetDiscoveryData()
  local chapterAwardData = data.chapterAwardData
  local chapterAward = chapterAwardData:GetChapterAwardChapterByChapterId(chapter.id)
  self._imgRed:SetActive(chapterAward and chapterAward:CanCollect() or false)
  self:FlushGrass()
end

function UIChaptersItem:FlushGrass()
  local canPlay = self.grassData:IsChapterCanPlay(self._chapter.id)
  self.imgGrass:SetActive(false)
end

function UIChaptersItem:imgBGOnClick(go)
  if self._chapter.id ~= self._curChapter.id then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryFlushChapter, self._chapter.id)
  end
  GameGlobal.UIStateManager():CloseDialog("UIChapters")
end
