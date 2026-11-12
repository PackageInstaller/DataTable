local BaseCtrl = require("GameCore.UI.BaseCtrl")
local AvgData = PlayerData.Avg
local StoryEntranceCtrl = class("StoryEntranceCtrl", BaseCtrl)
StoryEntranceCtrl._mapNodeConfig = {
  btnMainline = {
    sNodeName = "btnMainline",
    sComponentName = "UIButton",
    callback = "OnBtn_ClickMainline"
  },
  btnNovaStory = {
    sNodeName = "btnNovaStory",
    sComponentName = "UIButton",
    callback = "OnBtn_ClickNovaStory"
  },
  btnActivity = {
    sNodeName = "btnActivity",
    sComponentName = "UIButton",
    callback = "OnBtn_ClickActivity"
  },
  txtMainlineTilte = {
    sNodeName = "txtMainlineTilte",
    sComponentName = "TMP_Text",
    sLanguageId = "WorldMap_MainLine_Avg"
  },
  txtCurMainline = {
    sNodeName = "txtCurMainline",
    sComponentName = "TMP_Text",
    sLanguageId = "Continue_MainlineStory"
  },
  txtNovaStoryTilte = {
    sNodeName = "txtNovaStoryTilte",
    sComponentName = "TMP_Text",
    sLanguageId = "Nova_Story"
  },
  txtCurNovaStory = {
    sNodeName = "txtCurNovaStory",
    sComponentName = "TMP_Text",
    sLanguageId = "Nova_Story_Desc"
  },
  txtActivityTilte = {
    sNodeName = "txtActivityTilte",
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Review"
  },
  txtActivity = {
    sNodeName = "txtActivity",
    sComponentName = "TMP_Text",
    sLanguageId = "Previous_Activity_Plot"
  },
  btnMainlineQuickEntrance = {
    sNodeName = "btnMainlineQuickEntrance",
    sComponentName = "UIButton",
    callback = "OnBtn_ClickMainlineQuickEntrance"
  },
  txtMainlineQuickTitle = {
    sNodeName = "txtMainlineQuickTitle",
    sComponentName = "TMP_Text",
    sLanguageId = "MainLine_Progress"
  },
  imgMainlinceChapterBg = {
    sNodeName = "imgMainlinceChapterBg",
    sComponentName = "Image"
  },
  txtMainlineChapter = {
    sNodeName = "txtMainlineChapter",
    sComponentName = "TMP_Text"
  },
  txtRecentStoryQuickTitle = {
    sNodeName = "txtRecentStoryQuickTitle",
    sComponentName = "TMP_Text",
    sLanguageId = "Continue_Reading"
  },
  btnRecentStoryQuickEntrance = {
    sNodeName = "btnRecentStoryQuickEntrance",
    sComponentName = "UIButton",
    callback = "OnBtn_ClickRecentStoryQuickEntrance"
  },
  goRecentStory = {
    sNodeName = "goRecentStory",
    sComponentName = "GameObject"
  },
  goNoStory = {sNodeName = "goNoStory", sComponentName = "GameObject"},
  imgRecentStoryBg = {
    sNodeName = "imgRecentStoryBg",
    sComponentName = "Image"
  },
  txtRecentStoryTitle = {
    sNodeName = "txtRecentStoryTitle",
    sComponentName = "TMP_Text"
  },
  txtNoProgress = {
    sNodeName = "txtNoProgress",
    sComponentName = "TMP_Text",
    sLanguageId = "No_Progress_Yet"
  },
  txtActivityQuickTitle = {
    sNodeName = "txtActivityQuickTitle",
    sComponentName = "TMP_Text",
    sLanguageId = "Latest_Release"
  },
  btnActivityQuickEntrance = {
    sNodeName = "btnActivityQuickEntrance",
    sComponentName = "UIButton",
    callback = "OnBtn_ClickActivityQuickEntrance"
  },
  goActivityStory = {
    sNodeName = "goActivityStory",
    sComponentName = "GameObject"
  },
  goNoActivity = {
    sNodeName = "goNoActivity",
    sComponentName = "GameObject"
  },
  imgActivityStoryBg = {
    sNodeName = "imgActivityStoryBg",
    sComponentName = "Image"
  },
  txtActivityStoryTitle = {
    sNodeName = "txtActivityStoryTitle",
    sComponentName = "TMP_Text"
  },
  txtComingSoon = {
    sNodeName = "txtComingSoon",
    sComponentName = "TMP_Text",
    sLanguageId = "RegusBoss_NotOpenItem"
  },
  btnBack = {
    sComponentName = "UIButton",
    callback = "OnBtn_ClickBack"
  },
  btnHome = {
    sComponentName = "UIButton",
    callback = "OnBtn_ClickHome"
  },
  imgActivityLockBg = {},
  goActivityOn = {},
  txtActivityLock = {
    sNodeName = "txtActivityLock",
    sComponentName = "TMP_Text"
  },
  imgPreviewDb = {},
  redDotNovaStory = {},
  redDotMainline = {}
}
StoryEntranceCtrl._mapEventConfig = {}
StoryEntranceCtrl._mapRedDotConfig = {
  [RedDotDefine.Story_Set] = {
    sNodeName = "redDotNovaStory"
  },
  [RedDotDefine.Map_MainLine_Entrance] = {
    sNodeName = "redDotMainline"
  }
}

function StoryEntranceCtrl:Awake()
  local function callback()
    self.bHasAchievementData = true
  end
  
  PlayerData.Achievement:SendAchievementInfoReq(callback)
end

function StoryEntranceCtrl:FadeIn()
  EventManager.Hit(EventId.SetTransition)
end

function StoryEntranceCtrl:OnEnable()
  self.bHasActivityStorys = false
  self.bHasNovaStorys = false
  self:RefreshMainlineQuickEntranceState()
  self:RefreshRecentStoryQuickEntranceState()
  self:RefreshComingSoonState()
  self:RefreshActivityLockState()
end

function StoryEntranceCtrl:OnDisable()
end

function StoryEntranceCtrl:RefreshMainlineQuickEntranceState()
  local curStoryId = PlayerData.Story:GetLastMainlineStoryId()
  local storConfig = ConfigTable.GetData_Story(curStoryId)
  local curChapter = storConfig.Chapter
  if storConfig.IsLast == true and AvgData:IsStoryReaded(curStoryId) == true then
    curChapter = curChapter + 1
    local nextChapterConfig = ConfigTable.GetData("StoryChapter", curChapter, "")
    if nextChapterConfig ~= nil then
      if AvgData:IsStoryChapterShow(curChapter) == true then
        curStoryId = AvgData:GetRecentStoryId(curChapter)
      else
        curChapter = curChapter - 1
      end
    else
      curChapter = curChapter - 1
    end
  end
  local chapterConfig = ConfigTable.GetData("StoryChapter", curChapter, "")
  local storyConfig = ConfigTable.GetData_Story(curStoryId)
  local title = chapterConfig.Name .. " " .. storyConfig.Index
  NovaAPI.SetTMPText(self._mapNode.txtMainlineChapter, title)
  self:SetPngSprite(self._mapNode.imgMainlinceChapterBg, chapterConfig.BannerIcon)
  self.curChapter = curChapter
  self.curStoryId = curStoryId
end

function StoryEntranceCtrl:RefreshRecentStoryQuickEntranceState()
  local bHasRecentStory, recentData, title, bannerPath = PlayerData.Story:GetRecentStoryInfo()
  self._mapNode.goRecentStory:SetActive(bHasRecentStory)
  self._mapNode.goNoStory:SetActive(not bHasRecentStory)
  self.tbRecentStory = recentData
  if bHasRecentStory then
    NovaAPI.SetTMPText(self._mapNode.txtRecentStoryTitle, title)
    if bannerPath ~= nil then
      self:SetPngSprite(self._mapNode.imgRecentStoryBg, bannerPath)
    end
  end
end

function StoryEntranceCtrl:RefreshComingSoonState()
  local recentTime = 0
  local previewDataList = {}
  
  local function GetPreviewStory(mapData)
    local curTime = CS.ClientManager.Instance.serverTimeStamp
    local showData = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapData.ShowTime)
    if curTime >= showData then
      if showData > recentTime then
        recentTime = showData
        previewDataList = {mapData}
      elseif showData == recentTime then
        table.insert(previewDataList, mapData)
      end
    end
  end
  
  ForEachTableLine(ConfigTable.Get("StoryPreview"), GetPreviewStory)
  local previewData
  if 0 < #previewDataList then
    table.sort(previewDataList, function(a, b)
      local aHasUnread = false
      if a.Type == GameEnum.StoryPreviewType.MainlineStory then
        aHasUnread = not PlayerData.Avg:IsChapterAllRead(a.StoryId)
      elseif a.Type == GameEnum.StoryPreviewType.StorySet then
        aHasUnread = not PlayerData.StorySet:IsChapterAllRead(a.StoryId)
      end
      local bHasUnread = false
      if b.Type == GameEnum.StoryPreviewType.MainlineStory then
        bHasUnread = not PlayerData.Avg:IsChapterAllRead(b.StoryId)
      elseif b.Type == GameEnum.StoryPreviewType.StorySet then
        bHasUnread = not PlayerData.StorySet:IsChapterAllRead(b.StoryId)
      end
      if aHasUnread ~= bHasUnread then
        return aHasUnread
      else
        return a.Id < b.Id
      end
    end)
    previewData = previewDataList[1]
    self.nPreviewStoryId = previewData.Id
  end
  self.bHasActivityStorys = previewData ~= nil and previewData.Type ~= nil and previewData.Type ~= GameEnum.StoryPreviewType.None
  self._mapNode.goActivityStory:SetActive(self.bHasActivityStorys)
  self._mapNode.goNoActivity:SetActive(not self.bHasActivityStorys)
  if self.bHasActivityStorys then
    self._mapNode.txtActivityStoryTitle.gameObject:SetActive(previewData.Title ~= "")
    self._mapNode.imgPreviewDb.gameObject:SetActive(previewData.Title ~= "")
    NovaAPI.SetTMPText(self._mapNode.txtActivityStoryTitle, previewData.Title)
    self:SetPngSprite(self._mapNode.imgActivityStoryBg, previewData.Icon)
  end
end

function StoryEntranceCtrl:RefreshActivityLockState()
  local bUnlock = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.ActivityReview)
  self._mapNode.imgActivityLockBg.gameObject:SetActive(not bUnlock)
  self._mapNode.goActivityOn.gameObject:SetActive(bUnlock)
  if not bUnlock then
    local mapFuncCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.ActivityReview)
    local sTips = mapFuncCfgData ~= nil and UTILS.ParseParamDesc(mapFuncCfgData.Tips, mapFuncCfgData) or ""
    NovaAPI.SetTMPText(self._mapNode.txtActivityLock, sTips)
  end
end

function StoryEntranceCtrl:OnBtn_ClickMainline()
  EventManager.Hit(EventId.OpenPanel, PanelId.StoryChapter)
end

function StoryEntranceCtrl:OnBtn_ClickNovaStory()
  PlayerData.StorySet:TryOpenStorySetPanel(function()
    EventManager.Hit(EventId.OpenPanel, PanelId.StorySet)
  end)
end

function StoryEntranceCtrl:OnBtn_ClickActivity()
  if not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.ActivityReview, true) then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.ActivityStoryReview)
end

function StoryEntranceCtrl:OnBtn_ClickMainlineQuickEntrance()
  local chapterData = ConfigTable.GetData("StoryChapter", self.curChapter, "")
  if chapterData.Type == GameEnum.chapterType.Mainline then
    EventManager.Hit(EventId.OpenPanel, PanelId.MainlineEx, self.curChapter)
  else
    EventManager.Hit(EventId.OpenPanel, chapterData.StoryPanelId, self.curChapter)
  end
end

function StoryEntranceCtrl:OnBtn_ClickRecentStoryQuickEntrance()
  if self.tbRecentStory == nil then
    return
  end
  if self.tbRecentStory.Type == GameEnum.StoryPreviewType.ActivityStory then
    PlayerData.StoryReview:TryOpenStoryChapter(self.tbRecentStory.ChapterId)
  elseif self.tbRecentStory.Type == GameEnum.StoryPreviewType.StorySet then
    PlayerData.StorySet:TryOpenStorySetPanel(function()
      EventManager.Hit(EventId.OpenPanel, PanelId.StorySet, false, self.tbRecentStory.ChapterId)
    end)
  end
end

function StoryEntranceCtrl:OnBtn_ClickActivityQuickEntrance()
  if not self.bHasActivityStorys then
    return
  end
  local previewConfig = ConfigTable.GetData("StoryPreview", self.nPreviewStoryId, "")
  if previewConfig.Type == GameEnum.StoryPreviewType.ActivityStory then
  elseif previewConfig.Type == GameEnum.StoryPreviewType.MainlineStory then
    local chapterId = previewConfig.StoryId
    local isUnlock = AvgData:IsStoryChapterUnlock(chapterId)
    if isUnlock then
      local chapterData = ConfigTable.GetData("StoryChapter", chapterId, "")
      if chapterData.Type == GameEnum.chapterType.Mainline then
        EventManager.Hit(EventId.OpenPanel, PanelId.MainlineEx, chapterId)
      else
        EventManager.Hit(EventId.OpenPanel, chapterData.StoryPanelId, chapterId)
      end
    else
      EventManager.Hit(EventId.OpenPanel, PanelId.StoryChapter)
    end
  elseif previewConfig.Type == GameEnum.StoryPreviewType.StorySet then
    PlayerData.StorySet:TryOpenStorySetPanel(function()
      EventManager.Hit(EventId.OpenPanel, PanelId.StorySet, false, previewConfig.StoryId)
    end)
  end
end

function StoryEntranceCtrl:OnBtn_ClickHome()
  PanelManager.Home()
end

function StoryEntranceCtrl:OnBtn_ClickBack()
  EventManager.Hit(EventId.ClosePanel, PanelId.StoryEntrance)
end

return StoryEntranceCtrl
