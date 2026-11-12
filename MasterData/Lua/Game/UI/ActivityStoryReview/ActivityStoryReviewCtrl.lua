local ActivityStoryReviewCtrl = class("ActivityStoryReviewCtrl", BaseCtrl)
local LocalData = require("GameCore.Data.LocalData")
local newDayTime = UTILS.GetDayRefreshTimeOffset()
ActivityStoryReviewCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  imgBgChapterLower = {sComponentName = "Image"},
  imgBgChapterHigher = {sComponentName = "Image"},
  goList = {sNodeName = "---List---"},
  chapterLsv = {
    sComponentName = "LoopScrollView"
  },
  snapChapter = {
    sNodeName = "chapterLsv",
    sComponentName = "LoopScrollSnap",
    callback = "OnGridSelect_Chapter"
  },
  goItem = {},
  rtList = {
    sComponentName = "RectTransform"
  },
  btnTitle = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Title"
  },
  reddotStoryLineList = {},
  imgTitle = {sComponentName = "Image"},
  txtTitle = {sComponentName = "TMP_Text"},
  goStoryLine = {
    sNodeName = "---StoryLineList---"
  },
  aniStoryLine = {
    sNodeName = "---StoryLineList---",
    sComponentName = "Animator"
  },
  tabLsv = {
    sComponentName = "LoopScrollView"
  },
  btnArrow = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Arrow"
  },
  btnCloseStoryLine = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Arrow"
  },
  txtEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "StorySet_Chapter_Empty_Tip"
  },
  btnShowUnRead = {
    sNodeName = "btnShowUnRead",
    sComponentName = "UIButton",
    callback = "OnClick_ShowUnRead"
  },
  imgShowUnReadOn = {},
  txtShowUnReadDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "StorySet_Only_Show_Unread"
  },
  goPopUp = {
    sNodeName = "---PopUp---"
  },
  goBlur = {
    sNodeName = "t_fullscreen_blur_black"
  },
  goWindow = {},
  animWindow = {sNodeName = "rtWindow", sComponentName = "Animator"},
  txtStoryTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StoryReview_PreStory_Window_Title"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseWindow"
  },
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_CloseWindow"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StoryReview_PreStory_Tips"
  },
  txtStoryType = {sComponentName = "TMP_Text"},
  txtMainlineStoryTitle = {sComponentName = "TMP_Text"},
  txtStory = {sComponentName = "TMP_Text"},
  btnGoto = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Goto"
  },
  txtBtnGoto = {
    sComponentName = "TMP_Text",
    sLanguageId = "StoryReview_PreStory_Btn_Goto"
  },
  btnDontShow = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_DontShow"
  },
  imgDontShow2 = {},
  txtDontShow = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_TodayWarning"
  },
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  txtCancelBtn = {
    sComponentName = "TMP_Text",
    sLanguageId = "StoryReview_Read_Cancel"
  },
  btnContinue = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Continue"
  },
  txtBtnContinue = {
    sComponentName = "TMP_Text",
    sLanguageId = "StoryReview_Read_Continue"
  }
}
ActivityStoryReviewCtrl._mapEventConfig = {
  LoopScrollGridAnimUpdate = "OnEvent_GridAnimUpdate"
}
ActivityStoryReviewCtrl._mapRedDotConfig = {
  [RedDotDefine.StoryReview] = {
    sNodeName = "reddotStoryLineList"
  }
}

function ActivityStoryReviewCtrl:UpdateAllChapters()
  self.tbLineChapters = PlayerData.StoryReview:GetAllStoryReview()
  self.tbAllLineIds = PlayerData.StoryReview:GetSortedStoryLineIds()
end

function ActivityStoryReviewCtrl:RefreshStoryLineList()
  self.tbStoryLineGrid = {}
  self._mapNode.tabLsv:Init(#self.tbAllLineIds, self, self.OnGridLineRefresh, self.OnGridLineBtnClick, true)
end

function ActivityStoryReviewCtrl:OnGridLineRefresh(goGrid, nGridIndex)
  local nLineId = self.tbAllLineIds[nGridIndex + 1]
  if nLineId ~= nil then
    self.tbStoryLineGrid[nLineId] = goGrid
    local goRedDot = goGrid.transform:Find("btnGrid/AnimRoot/reddotStoryLine")
    RedDotManager.RegisterNode(RedDotDefine.StoryReview_StoryLine, nLineId, goRedDot, nil, nil, true)
    local mapCfg = ConfigTable.GetData("ActivityStoryLine", nLineId)
    if mapCfg ~= nil then
      local txtStoryLine = goGrid.transform:Find("btnGrid/AnimRoot/goDeselect/txtStoryLine"):GetComponent("TMP_Text")
      local txtStoryLineSelect = goGrid.transform:Find("btnGrid/AnimRoot/goSelect/txtStoryLineSelect"):GetComponent("TMP_Text")
      local goSelect = goGrid.transform:Find("btnGrid/AnimRoot/goSelect")
      local goDeselect = goGrid.transform:Find("btnGrid/AnimRoot/goDeselect")
      goSelect.gameObject:SetActive(nLineId == self.nSelectLineId)
      goDeselect.gameObject:SetActive(nLineId ~= self.nSelectLineId)
      NovaAPI.SetTMPText(txtStoryLine, mapCfg.Title)
      NovaAPI.SetTMPText(txtStoryLineSelect, mapCfg.Title)
    end
  end
end

function ActivityStoryReviewCtrl:OnGridLineBtnClick(goGrid, nGridIndex)
  local nSelectLine = self.tbAllLineIds[nGridIndex + 1] or 0
  if self.nSelectLineId == nSelectLine then
    return
  end
  local goLastGrid = self.tbStoryLineGrid[self.nSelectLineId]
  if goLastGrid ~= nil then
    local imgLastSelect = goLastGrid.transform:Find("btnGrid/AnimRoot/goSelect")
    local imgLastUnSelect = goLastGrid.transform:Find("btnGrid/AnimRoot/goDeselect")
    imgLastSelect.gameObject:SetActive(false)
    imgLastUnSelect.gameObject:SetActive(true)
  end
  local goSelect = goGrid.transform:Find("btnGrid/AnimRoot/goSelect")
  local goDeselect = goGrid.transform:Find("btnGrid/AnimRoot/goDeselect")
  local ani = goGrid.transform:Find("btnGrid/AnimRoot"):GetComponent("Animator")
  goSelect.gameObject:SetActive(true)
  goDeselect.gameObject:SetActive(false)
  ani:Play("rtLineList_in", 0, 0)
  self.ani:Play("ActivityStoryReview_switch", 0, 0)
  self.nSelectLineId = nSelectLine
  self.nScrollPos = nil
  self:RefreshChapterList()
end

function ActivityStoryReviewCtrl:UpdateSelectChapters()
  self.tbSelectChapters = self.tbLineChapters[self.nSelectLineId] or {}
  if not PlayerData.StoryReview:GetOnlyShowUnRead() then
    return
  end
  local tbUnRead = {}
  for _, nChapterId in ipairs(self.tbSelectChapters) do
    if not PlayerData.StoryReview:IsChapterReadByHandbook(nChapterId) then
      table.insert(tbUnRead, nChapterId)
    end
  end
  self.tbSelectChapters = tbUnRead
end

function ActivityStoryReviewCtrl:RefreshChapterList()
  self.nSelectChapterId = 0
  self.nPreChapterType = 0
  self.nPreChapterId = 0
  self:UpdateSelectChapters()
  self.nBgLowerIndex = nil
  local mapLineCfg = ConfigTable.GetData("ActivityStoryLine", self.nSelectLineId)
  if mapLineCfg ~= nil then
    NovaAPI.SetTMPText(self._mapNode.txtTitle, mapLineCfg.Title)
  end
  for nInstanceId, objCtrl in pairs(self.tbChaptersGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbChaptersGridCtrl[nInstanceId] = nil
  end
  local bEmpty = #self.tbSelectChapters == 0
  self._mapNode.txtEmpty.gameObject:SetActive(bEmpty)
  self._mapNode.chapterLsv.gameObject:SetActive(not bEmpty)
  if bEmpty then
    self.nBgIndex = nil
    self:SetChapterBgSprite(self._mapNode.imgBgChapterLower, nil)
    self:SetChapterBgSprite(self._mapNode.imgBgChapterHigher, nil)
  else
    self._mapNode.chapterLsv:Init(#self.tbSelectChapters, self, self.OnGridChaptersRefresh, self.OnGridChaptersBtnClick, self.nScrollPos ~= nil)
    EventManager.Hit("ActivityStoryReviewListIn")
  end
end

function ActivityStoryReviewCtrl:OnGridChaptersRefresh(goGrid, nGridIndex)
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbChaptersGridCtrl[nInstanceId] then
    self.tbChaptersGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.ActivityStoryReview.ActivityStoryReviewItemCtrl")
  end
  local nChapterId = self.tbSelectChapters[nGridIndex + 1]
  if nChapterId ~= nil then
    self.tbChaptersGridCtrl[nInstanceId]:SetItem(nChapterId)
  end
end

function ActivityStoryReviewCtrl:OnGridChaptersBtnClick(goGrid, nGridIndex)
  local nChapterId = self.tbSelectChapters[nGridIndex + 1]
  if nChapterId == nil then
    return
  end
  local mapCfg = CacheTable.GetData("_ActivityStoryChapter", nChapterId)
  if mapCfg == nil then
    return
  end
  self.nSelectChapterId = nChapterId
  self.bSelectChapterRead = PlayerData.StoryReview:IsChapterReadByHandbook(nChapterId)
  self.nPreChapterType = mapCfg.PrevChapterType
  self.nPreChapterId = mapCfg.PrevChapterId
  local bMove = self.nBgIndex ~= nGridIndex + 1
  if bMove then
    self._mapNode.chapterLsv:SetScrollGridPos(nGridIndex, 0.2, 0)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
    self:AddTimer(1, 0.2, function()
      self:OpenStoryChapter(nChapterId)
    end, true, true, true)
  else
    self:OpenStoryChapter(nChapterId)
  end
end

function ActivityStoryReviewCtrl:OpenStoryChapter(nChapterId)
  local function open()
    if self.bOpenStoryLine then
      self.ani:Play("ActivityStoryReview_out2", 0, 0)
    else
      self.ani:Play("ActivityStoryReview_out1", 0, 0)
    end
    EventManager.Hit("ActivityStoryReviewListOut")
    self._mapNode.btnCloseStoryLine.gameObject:SetActive(false)
    self._mapNode.btnTitle.gameObject:SetActive(false)
    self._mapNode.goStoryLine.gameObject:SetActive(false)
    self._mapNode.TopBar.gameObject:SetActive(false)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
    self:AddTimer(1, 0.5, function()
      PlayerData.StoryReview:TryOpenStoryChapter(nChapterId)
    end, true, true, true)
  end
  
  local function checkOpenWindow(bPass)
    if not bPass and not self.dontShowAgain then
      self:ShowPreStoryWindow()
    else
      open()
    end
  end
  
  if self.nPreChapterType == GameEnum.ActivityStoryPreviewType.MainlineStory then
    local bPass = PlayerData.Avg:IsChapterLastStoryRead(self.nPreChapterId)
    checkOpenWindow(bPass)
  elseif self.nPreChapterType == GameEnum.ActivityStoryPreviewType.StorySet then
    local bPass = PlayerData.StorySet:IsChapterAllRead(self.nPreChapterId)
    checkOpenWindow(bPass)
  elseif self.nPreChapterType == GameEnum.ActivityStoryPreviewType.ActivityStory then
    if PlayerData.StoryReview:IsChapterLoaded(self.nPreChapterId) then
      local bPass = PlayerData.StoryReview:IsChapterRead(self.nPreChapterId)
      checkOpenWindow(bPass)
    else
      local function netCallback()
        local bPass = PlayerData.StoryReview:IsChapterRead(self.nPreChapterId)
        
        checkOpenWindow(bPass)
      end
      
      PlayerData.StoryReview:SendGetChapterInfo(self.nPreChapterId, netCallback)
    end
  else
    open()
  end
end

function ActivityStoryReviewCtrl:MoveChapterList(bImmediate)
  local fOpenOffsetX = 277
  local fMoveTime = 0.2
  local rtList = self._mapNode.rtList
  local nTargetX = self.bOpenStoryLine and fOpenOffsetX or 0
  rtList:DOKill()
  if bImmediate then
    rtList.anchoredPosition = Vector2(nTargetX, -40)
  else
    rtList:DOAnchorPosX(nTargetX, fMoveTime):SetUpdate(true):SetEase(Ease.InOutQuad)
  end
end

function ActivityStoryReviewCtrl:ShowStoryLine(bImmediate)
  self._mapNode.btnCloseStoryLine.gameObject:SetActive(self.bOpenStoryLine)
  self._mapNode.btnTitle.gameObject:SetActive(not self.bOpenStoryLine)
  self:MoveChapterList(bImmediate)
  if self.bOpenStoryLine then
    self._mapNode.tabLsv:SetScrollGridPos(self.nSelectLineId - 1, 0, 1)
    self._mapNode.goStoryLine.gameObject:SetActive(true)
    self._mapNode.aniStoryLine:Play("StoryLineList_in", 0, 0)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.26)
  elseif bImmediate then
    self._mapNode.goStoryLine.gameObject:SetActive(false)
  else
    self._mapNode.aniStoryLine:Play("StoryLineList_out", 0, 0)
    self.ani:Play("ActivityStoryReview_out", 0, 0)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
    self:AddTimer(1, 0.2, function()
      self._mapNode.goStoryLine.gameObject:SetActive(false)
    end, true, true, true)
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.TopBar.gameObject:SetActive(not self.bOpenStoryLine)
  end
  
  cs_coroutine.start(wait)
end

function ActivityStoryReviewCtrl:ShowPreStoryWindow()
  self._mapNode.goPopUp.gameObject:SetActive(true)
  self._mapNode.goWindow.gameObject:SetActive(false)
  self._mapNode.goBlur.gameObject:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goWindow:SetActive(true)
    self._mapNode.animWindow:Play("t_window_04_t_in")
    EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  end
  
  cs_coroutine.start(wait)
  local sName = ""
  if self.nPreChapterType == GameEnum.ActivityStoryPreviewType.MainlineStory then
    NovaAPI.SetTMPText(self._mapNode.txtStoryType, ConfigTable.GetUIText("StoryReview_PreType_Mainline"))
    self._mapNode.txtMainlineStoryTitle.gameObject:SetActive(true)
    local chapterConfig = ConfigTable.GetData("StoryChapter", self.nPreChapterId, "")
    NovaAPI.SetTMPText(self._mapNode.txtMainlineStoryTitle, chapterConfig.Name)
    sName = chapterConfig.Desc
  elseif self.nPreChapterType == GameEnum.ActivityStoryPreviewType.StorySet then
    NovaAPI.SetTMPText(self._mapNode.txtStoryType, ConfigTable.GetUIText("StoryReview_PreType_StorySet"))
    self._mapNode.txtMainlineStoryTitle.gameObject:SetActive(false)
    local chapterConfig = ConfigTable.GetData("StorySetChapter", self.nPreChapterId, "")
    sName = chapterConfig.Name
  elseif self.nPreChapterType == GameEnum.ActivityStoryPreviewType.ActivityStory then
    NovaAPI.SetTMPText(self._mapNode.txtStoryType, ConfigTable.GetUIText("StoryReview_PreType_ActivityStory"))
    self._mapNode.txtMainlineStoryTitle.gameObject:SetActive(false)
    local chapterConfig = CacheTable.GetData("_ActivityStoryChapter", self.nPreChapterId, "")
    sName = chapterConfig.Title
  end
  NovaAPI.SetTMPText(self._mapNode.txtStory, sName)
end

function ActivityStoryReviewCtrl:GetChapterBg(nIndex)
  local nChapterId = self.tbSelectChapters[nIndex]
  if nChapterId == nil then
    return nil
  end
  local mapCfgData = CacheTable.GetData("_ActivityStoryChapter", nChapterId)
  if mapCfgData == nil or mapCfgData.IconRes3 == "" then
    return nil
  end
  return mapCfgData.IconRes3
end

function ActivityStoryReviewCtrl:SetChapterBgSprite(imgBg, sBg)
  local bHasBg = sBg ~= nil and sBg ~= ""
  imgBg.gameObject:SetActive(bHasBg)
  if bHasBg then
    self:SetPngSprite(imgBg, sBg)
  end
end

function ActivityStoryReviewCtrl:RefreshChapterBgPair(nLowerIndex)
  if self.nBgLowerIndex == nLowerIndex then
    return
  end
  self.nBgLowerIndex = nLowerIndex
  self:SetChapterBgSprite(self._mapNode.imgBgChapterLower, self:GetChapterBg(nLowerIndex))
  self:SetChapterBgSprite(self._mapNode.imgBgChapterHigher, self:GetChapterBg(nLowerIndex + 1))
end

function ActivityStoryReviewCtrl:UpdateChapterBgFade(ratio)
  if self.nBgIndex == nil then
    return
  end
  local nBgAnimRange = 2
  local fBgFadeHold = 0.2
  local fOffset = (0.5 - ratio) * 2 * nBgAnimRange
  fOffset = math.min(math.max(fOffset, -0.5), 0.5)
  local bBack = fOffset < 0
  local nLowerIndex = bBack and self.nBgIndex - 1 or self.nBgIndex
  local fT = bBack and fOffset + 1 or fOffset
  self:RefreshChapterBgPair(nLowerIndex)
  local fProgress = math.min(math.max(fT - fBgFadeHold, 0) / (1 - 2 * fBgFadeHold), 1)
  if nLowerIndex < 1 then
    fProgress = 1
  elseif nLowerIndex + 1 > #self.tbSelectChapters then
    fProgress = 0
  end
  NovaAPI.SetImageColor(self._mapNode.imgBgChapterLower, Color(1, 1, 1, 1 - fProgress))
  NovaAPI.SetImageColor(self._mapNode.imgBgChapterHigher, Color(1, 1, 1, fProgress))
end

function ActivityStoryReviewCtrl:ClosePreStoryWindow()
  if self.dontShowAgain then
    local _curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
    local _fixedTimeStamp = _curTimeStamp + newDayTime * 3600
    local _nYear = tonumber(os.date("!%Y", _fixedTimeStamp))
    local _nMonth = tonumber(os.date("!%m", _fixedTimeStamp))
    local _nDay = tonumber(os.date("!%d", _fixedTimeStamp))
    local _nowD = _nYear * 366 + _nMonth * 31 + _nDay
    LocalData.SetPlayerLocalData("ActStoryReview_Tips_Time", tostring(_nowD))
  end
  self._mapNode.goBlur.gameObject:SetActive(false)
  self._mapNode.goWindow.gameObject:SetActive(false)
end

function ActivityStoryReviewCtrl:PlayWindowCloseAnim()
  self._mapNode.animWindow:Play("t_window_04_t_out")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  self:AddTimer(1, 0.3, function()
    self:ClosePreStoryWindow()
  end, true, true, true)
end

function ActivityStoryReviewCtrl:Awake()
  self.nSelectLineId = 0
  self.nSelectChapterId = 0
  self.tbAllChapters = {}
  self.tbSelectChapters = {}
  self.bOpenStoryLine = false
  self.tbStoryLineGrid = {}
  self.tbChaptersGridCtrl = {}
  self.ani = self.gameObject.transform:GetComponent("Animator")
  self.bSelectChapterRead = false
  self._mapNode.imgShowUnReadOn:SetActive(PlayerData.StoryReview:GetOnlyShowUnRead())
end

function ActivityStoryReviewCtrl:OnEnable()
  local TipsTime = LocalData.GetPlayerLocalData("ActStoryReview_Tips_Time")
  local _tipDay = 0
  if TipsTime ~= nil then
    _tipDay = tonumber(TipsTime)
  end
  local curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  local fixedTimeStamp = curTimeStamp + newDayTime * 3600
  local nYear = tonumber(os.date("!%Y", fixedTimeStamp))
  local nMonth = tonumber(os.date("!%m", fixedTimeStamp))
  local nDay = tonumber(os.date("!%d", fixedTimeStamp))
  local nowD = nYear * 366 + nMonth * 31 + nDay
  self.dontShowAgain = nowD == _tipDay
  self._mapNode.imgDontShow2:SetActive(self.dontShowAgain)
  self:UpdateAllChapters()
  PlayerData.StoryReview:RefreshAvgRedDot()
  if PlayerData.StoryReview:GetOnlyShowUnRead() and self.nSelectChapterId ~= 0 and not self.bSelectChapterRead and PlayerData.StoryReview:IsChapterReadByHandbook(self.nSelectChapterId) then
    self.nScrollPos = nil
  end
  self.nLastReadChapterId = PlayerData.StoryReview:GetLastReadChapterId() or 0
  local tbParam = self:GetPanelParam()
  local nTargetChapterId = 0
  if type(tbParam) == "table" then
    nTargetChapterId = tonumber(tbParam[1]) or 0
  end
  local nEffectiveChapterId = 0
  if nTargetChapterId ~= nil and nTargetChapterId ~= 0 then
    nEffectiveChapterId = nTargetChapterId
  elseif self.nLastReadChapterId ~= 0 then
    nEffectiveChapterId = self.nLastReadChapterId
  end
  if self.nSelectLineId == 0 then
    if nEffectiveChapterId ~= 0 then
      for _, nLineId in ipairs(self.tbAllLineIds) do
        local tbChapters = self.tbLineChapters[nLineId]
        if tbChapters ~= nil then
          for _, nChapterId in ipairs(tbChapters) do
            if nChapterId == nEffectiveChapterId then
              self.nSelectLineId = nLineId
              break
            end
          end
        end
        if self.nSelectLineId ~= 0 then
          break
        end
      end
    end
    if self.nSelectLineId == 0 then
      self.nSelectLineId = self.tbAllLineIds[1] or 0
    end
  end
  self:RefreshStoryLineList()
  self:RefreshChapterList()
  self:ShowStoryLine(true)
end

function ActivityStoryReviewCtrl:OnDisable()
  self._mapNode.rtList:DOKill()
  for nInstanceId, objCtrl in pairs(self.tbChaptersGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbChaptersGridCtrl[nInstanceId] = nil
  end
  self.nScrollPos = self._mapNode.chapterLsv:GetScrollPos()
end

function ActivityStoryReviewCtrl:OnDestroy()
end

function ActivityStoryReviewCtrl:OnRelease()
end

function ActivityStoryReviewCtrl:OnBtnClick_Title()
  self.bOpenStoryLine = true
  self:ShowStoryLine()
end

function ActivityStoryReviewCtrl:OnBtnClick_Arrow()
  self.bOpenStoryLine = false
  self:ShowStoryLine()
end

function ActivityStoryReviewCtrl:OnClick_ShowUnRead()
  local bOnlyShowUnRead = not PlayerData.StoryReview:GetOnlyShowUnRead()
  PlayerData.StoryReview:SetOnlyShowUnRead(bOnlyShowUnRead)
  self._mapNode.imgShowUnReadOn:SetActive(bOnlyShowUnRead)
  if self.bOpenStoryLine then
    self.ani:Play("ActivityStoryReview_switch", 0, 0)
  else
    self.ani:Play("ActivityStoryReview_in", 0, 0)
  end
  self.nScrollPos = nil
  self:RefreshChapterList()
end

function ActivityStoryReviewCtrl:OnBtnClick_CloseWindow()
  self:PlayWindowCloseAnim()
end

function ActivityStoryReviewCtrl:OnBtnClick_Goto()
  local nChapterId = self.nPreChapterId or 0
  if nChapterId == 0 then
    self:ClosePreStoryWindow()
    return
  end
  
  local function lockTips(sTip)
    if sTip ~= nil and sTip ~= "" then
      EventManager.Hit(EventId.OpenMessageBox, sTip)
    else
      printError("前置剧情锁着但没取到锁定原因，章节 id：" .. tostring(nChapterId))
    end
  end
  
  if self.nPreChapterType == GameEnum.ActivityStoryPreviewType.MainlineStory then
    local bUnlock, sTip = PlayerData.Avg:IsStoryChapterUnlock(nChapterId)
    if not bUnlock then
      lockTips(sTip)
      return
    end
    self:ClosePreStoryWindow()
    local chapterCfg = ConfigTable.GetData("StoryChapter", nChapterId)
    local nPanelId = chapterCfg ~= nil and chapterCfg.StoryPanelId or 0
    if nPanelId == 0 then
      nPanelId = PanelId.MainlineEx
    end
    EventManager.Hit(EventId.OpenPanel, nPanelId, nChapterId)
  elseif self.nPreChapterType == GameEnum.ActivityStoryPreviewType.StorySet then
    PlayerData.StorySet:TryOpenStorySetPanel(function()
      local bUnlock, sTip = PlayerData.StorySet:IsChapterUnlock(nChapterId)
      if not bUnlock then
        lockTips(sTip)
        return
      end
      self:ClosePreStoryWindow()
      EventManager.Hit(EventId.OpenPanel, PanelId.StorySet, true, nChapterId)
    end)
  elseif self.nPreChapterType == GameEnum.ActivityStoryPreviewType.ActivityStory then
    if not PlayerData.StoryReview:CheckStoryInReview(nChapterId) then
      lockTips(ConfigTable.GetUIText("Activity_Not_Open"))
      return
    end
    self:ClosePreStoryWindow()
    PlayerData.StoryReview:TryOpenStoryChapter(nChapterId)
  else
    self:ClosePreStoryWindow()
  end
end

function ActivityStoryReviewCtrl:OnBtnClick_DontShow()
  self.dontShowAgain = not self.dontShowAgain
  self._mapNode.imgDontShow2:SetActive(self.dontShowAgain)
end

function ActivityStoryReviewCtrl:OnBtnClick_Cancel()
  self:PlayWindowCloseAnim()
end

function ActivityStoryReviewCtrl:OnBtnClick_Continue()
  self:ClosePreStoryWindow()
  PlayerData.StoryReview:TryOpenStoryChapter(self.nSelectChapterId)
end

function ActivityStoryReviewCtrl:OnGridSelect_Chapter(_, goGrid)
  self.nBgIndex = tonumber(goGrid.name) + 1
end

function ActivityStoryReviewCtrl:OnEvent_GridAnimUpdate(ratio, index)
  self.nBgIndex = index + 1
  self:UpdateChapterBgFade(ratio)
end

return ActivityStoryReviewCtrl
