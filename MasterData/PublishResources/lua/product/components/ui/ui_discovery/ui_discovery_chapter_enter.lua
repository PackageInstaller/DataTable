local ChapterType = {
  ChapterOne = 1,
  ChapterTwo = 2,
  ChapterThree = 3
}
_enum("ChapterType", ChapterType)
_class("UIDiscoveryChapterEnter", UICustomWidget)
UIDiscoveryChapterEnter = UIDiscoveryChapterEnter

function UIDiscoveryChapterEnter:Constructor()
  self._module = self:GetModule(MissionModule)
  self.data = self._module:GetDiscoveryData()
  self.mCampaign = self:GetModule(CampaignModule)
  self.grassData = self.mCampaign:GetGraveRobberData()
  self.quaternion = Quaternion.identity
end

function UIDiscoveryChapterEnter:OnShow()
  self.root = self:GetGameObject("root")
  self.imgGrass = self:GetGameObject("imgGrass")
  self._chapterName = self:GetUIComponent("UILocalizationText", "txtChapterName")
  self.btnChapterArrow = self:GetUIComponent("RectTransform", "btnChapterArrow")
  self.btnChapterArrowObj = self:GetGameObject("btnChapterArrow")
  self.btnChapterClick = self:GetUIComponent("Image", "btnChapter")
  self._imgRedChapter = self:GetGameObject("imgRedChapter")
  self._imgRedChapter:SetActive(false)
  self._sectionRed = self:GetGameObject("sectionRed")
  self._sectionRed:SetActive(false)
  self.txtPartName = self:GetUIComponent("UILocalizationText", "txtPartName")
  self:AttachEvent(GameEventType.DiscoveryShowHideChapter, self.ShowHideChapter)
  self:AttachEvent(GameEventType.GrassClose, self.FlushGrass)
  self:AttachEvent(GameEventType.UpdateChapterAwardData, self.FlushRed)
  self:AttachEvent(GameEventType.CheckPartUnlock, self.CheckPartUnlock)
  if EngineGameHelper.EnableAppleVerifyBulletin() then
    self._btnPart = GameObjectHelper.FindChild(self.root.transform, "btnPart")
    if self._btnPart then
      self._btnPart.gameObject:SetActive(false)
    end
  end
  self:CheckPartUnlock()
end

function UIDiscoveryChapterEnter:OnHide()
  self:DetachEvent(GameEventType.DiscoveryShowHideChapter, self.ShowHideChapter)
  self:DetachEvent(GameEventType.GrassClose, self.FlushGrass)
  self:DetachEvent(GameEventType.UpdateChapterAwardData, self.FlushRed)
  self:DetachEvent(GameEventType.CheckPartUnlock, self.CheckPartUnlock)
end

function UIDiscoveryChapterEnter:Init(isFromUIChapters)
  self.isFromUIChapters = isFromUIChapters
  if isFromUIChapters then
    self.quaternion:SetEuler(0, 0, 180)
  else
    self.quaternion:SetEuler(0, 0, 0)
  end
  self.btnChapterArrow.localRotation = self.quaternion
end

function UIDiscoveryChapterEnter:Flush(chapterId)
  self.chapterId = chapterId
  self:FlushGrass()
  self:FlushPart()
  self:FlushChapter()
  self:FlushArrow()
  self:FlushRed()
end

function UIDiscoveryChapterEnter:FlushGrass()
  local canPlay = self.grassData:HasCanPlayNode()
  self.imgGrass:SetActive(false)
end

function UIDiscoveryChapterEnter:FlushPart()
  local section = self.data:GetDiscoverySectionByChapterId(self.chapterId)
  if section then
    self.txtPartName:SetText(section.index_name)
  else
    Log.fatal("### not section. chapterId=", self.chapterId)
  end
end

function UIDiscoveryChapterEnter:FlushChapter()
  if not self.data then
    return
  end
  local chapter = self.data:GetChapterByChapterId(self.chapterId)
  if not chapter then
    return
  end
  self._chapterName:SetText(chapter.index_name .. StringTable.Get("str_common_colon") .. chapter.name)
end

function UIDiscoveryChapterEnter:FlushArrow()
  local chapter = self.data:GetChapterByChapterId(self.chapterId)
  local section = chapter:GetSectionId()
  local missionModule = self:GetModule(MissionModule)
  self.btnChapterArrowObj:SetActive(true)
  if section == ChapterType.ChapterOne then
    local missionId = Cfg.cfg_global.ui_discovery_chapter1_enter_level.IntValue
    local passStage = missionModule:GetPassMissionById(missionId)
    if not passStage then
      self.btnChapterArrowObj:SetActive(false)
    end
  elseif section == ChapterType.ChapterTwo then
    self.btnChapterArrowObj:SetActive(false)
  elseif section == ChapterType.ChapterThree then
    local missionId = Cfg.cfg_global.ui_discovery_chapter3_enter_level.IntValue
    local passStage = missionModule:GetPassMissionById(missionId)
    if not passStage then
      self.btnChapterArrowObj:SetActive(false)
    end
  end
end

function UIDiscoveryChapterEnter:FlushRed()
  if not self.data then
    return
  end
  local section = self.data:GetDiscoverySectionByChapterId(self.chapterId)
  if not section then
    Log.fatal("### not section. chapterId=", self.chapterId)
  end
  if not section.chapterIds then
    Log.fatal("### not chapter unlock in this section. chapterId=", self.chapterId)
  end
  local chapterAwardData = self.data.chapterAwardData
  local red = chapterAwardData:CanCollectWithoutChapter(self.data, self.chapterId)
  self._imgRedChapter:SetActive(red)
  self:FlushSectionRed()
end

function UIDiscoveryChapterEnter:FlushSectionRed()
  local red = false
  local thisSection = self.data:GetDiscoverySectionByChapterId(self.chapterId)
  local sections = self.data.sections
  for key, section in pairs(sections) do
    if section.id ~= thisSection.id and section:CanCollect() then
      red = true
      break
    end
  end
  self._sectionRed:SetActive(red)
end

function UIDiscoveryChapterEnter:ShowHideChapter(isShow)
  self.root:SetActive(isShow)
end

function UIDiscoveryChapterEnter:btnChapterOnClick(go)
  self:btnChapterArrowOnClick(go)
end

function UIDiscoveryChapterEnter:btnChapterArrowOnClick(go)
  if self.isFromUIChapters then
    GameGlobal.UIStateManager():CloseDialog("UIChapters")
  else
    GameGlobal.UAReportForceGuideEvent("UIDiscoveryClick", {
      "ArrowOnClick"
    }, true)
    self:ShowDialog("UIChapters", self.chapterId, function()
      self.root:SetActive(false)
    end, function()
      self.root:SetActive(true)
    end)
  end
end

function UIDiscoveryChapterEnter:btnPartOnClick(go)
  self:ShowDialog("UIDiscoveryPart", self.chapterId)
end

function UIDiscoveryChapterEnter:CheckPartUnlock()
  if self.isFromUIChapters then
    return
  end
  local mRole = GameGlobal.GetModule(RoleModule)
  local roleId = mRole:GetPstId()
  local key = roleId .. "UIDiscoveryChapterEnter_CheckPartUnlock"
  local chapter, node = self.data:GetCanPlayChapterNode()
  if chapter then
    local section = self.data:GetDiscoverySectionByChapterId(chapter.id)
    if section.id == 1 then
      return
    end
    local saveSectionId = UnityEngine.PlayerPrefs.GetInt(key, 0)
    if saveSectionId ~= section.id then
      self:ShowDialog("UIDiscoveryPartUnlock", section.id)
      UnityEngine.PlayerPrefs.SetInt(key, section.id)
    end
  end
end
