local StorySetCtrl = class("StorySetCtrl", BaseCtrl)
StorySetCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  imgBgPanel = {},
  imgBgChapter = {sComponentName = "Image"},
  goList = {sNodeName = "---List---"},
  chapterLsv = {
    sComponentName = "LoopScrollView"
  },
  goInfo = {sNodeName = "---Info---"},
  imgChapterIcon = {sComponentName = "Image"},
  txtTitle = {sComponentName = "TMP_Text"},
  txtChapter = {sComponentName = "TMP_Text"},
  sectionLsv = {
    sComponentName = "LoopScrollView"
  },
  goTab = {sNodeName = "---Tab---"},
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
  tabLsv = {
    sComponentName = "LoopScrollView"
  }
}
StorySetCtrl._mapEventConfig = {
  [EventId.UIBackConfirm] = "OnEvent_Back",
  [EventId.UIHomeConfirm] = "OnEvent_BackHome",
  [EventId.TransAnimOutClear] = "OnEvent_TransAnimOutClear",
  ReceiveStorySetRewardSuc = "OnEvent_ReceiveStorySetRewardSuc",
  StorySetChapterRefresh = "OnEvent_StorySetChapterRefresh"
}
StorySetCtrl._mapRedDotConfig = {}
local panelType_chapter = 1
local panelType_Section = 2

function StorySetCtrl:Refresh()
  if self.nPanelType == panelType_chapter then
    self.animRoot:Play("StorySetPanel_Switch_List", 0, 0)
    self:RefreshTab()
    self:RefreshChapter()
  elseif self.nPanelType == panelType_Section then
    self.animRoot:Play("StorySetPanel_Switch_Info", 0, 0)
    self:RefreshSection()
  end
end

function StorySetCtrl:RefreshChapter()
  self._mapNode.goList.gameObject:SetActive(true)
  self._mapNode.goTab.gameObject:SetActive(true)
  self._mapNode.goInfo.gameObject:SetActive(false)
  self._mapNode.btnShowUnRead.gameObject:SetActive(true)
  self._mapNode.txtShowUnReadDesc.gameObject:SetActive(true)
  for nInstanceId, v in pairs(self.tbChapterGrid) do
    self:UnbindCtrlByNode(v)
    self.tbChapterGrid[nInstanceId] = nil
  end
  if #self.tbChapter == 0 then
    self._mapNode.txtEmpty.gameObject:SetActive(true)
    self._mapNode.chapterLsv.gameObject:SetActive(false)
  else
    self._mapNode.txtEmpty.gameObject:SetActive(false)
    self._mapNode.chapterLsv.gameObject:SetActive(true)
    self._mapNode.chapterLsv:Init(#self.tbChapter, self, self.OnRefreshChapterGrid, self.OnChapterGridClick, true)
    if self.bLocation then
      self.bLocation = false
      local nNewIndex = 0
      for k, v in ipairs(self.tbChapter) do
        if v ~= nil and v.bUnlock then
          local nChapterId = v.nId
          local mapCfg = ConfigTable.GetData("StorySetChapter", nChapterId)
          if mapCfg ~= nil and mapCfg.IsShow then
            nNewIndex = k
          end
        end
      end
      if 1 < nNewIndex then
        do
          local function wait()
            coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
            
            self._mapNode.chapterLsv:SetScrollGridPos(nNewIndex - 1, 0.5, 0)
          end
          
          cs_coroutine.start(wait)
        end
      end
    else
      local nRecentChapterId = PlayerData.StorySet:GetRecentChapterId()
      local nNewIndex = 0
      if 0 < self.nChapterId and self.nLocationIndex ~= nil and 0 < self.nLocationIndex then
        nNewIndex = self.nLocationIndex
      else
        for k, v in ipairs(self.tbChapter) do
          if v ~= nil and v.bUnlock then
            local nChapterId = v.nId
            local mapCfg = ConfigTable.GetData("StorySetChapter", nChapterId)
            if mapCfg ~= nil and mapCfg.Id == nRecentChapterId then
              nNewIndex = k
            end
          end
        end
      end
      if nNewIndex <= 0 and PlayerData.StorySet:IsChapterAllRead(nRecentChapterId) and #self.tbChapter > 0 then
        for _, v in ipairs(self.tbChapter) do
          if v.nId == nRecentChapterId then
            nNewIndex = 1
            break
          end
        end
      end
      if 0 < nNewIndex then
        local function wait()
          coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
          
          self._mapNode.chapterLsv:SetScrollGridPos(nNewIndex - 1, 0)
        end
        
        cs_coroutine.start(wait)
      else
        do
          local function wait()
            coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
            
            self._mapNode.chapterLsv:SetScrollGridPos(#self.tbChapter, 0)
          end
          
          cs_coroutine.start(wait)
        end
      end
    end
  end
end

function StorySetCtrl:OnRefreshChapterGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local data = self.tbChapter[nIndex]
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbChapterGrid[nInstanceId] then
    self.tbChapterGrid[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.StorySet.StorySetChapterItemCtrl")
  end
  self.tbChapterGrid[nInstanceId]:RefreshItem(data)
end

function StorySetCtrl:OnChapterGridClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  local data = self.tbChapter[nIndex]
  if data == nil then
    return
  end
  local mapCfg = ConfigTable.GetData("StorySetChapter", data.nId)
  if mapCfg ~= nil then
    if not mapCfg.IsShow then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("StorySet_Chapter_Empty"))
      return
    end
    if not data.bUnlock then
      if mapCfg.LockText ~= "" then
        EventManager.Hit(EventId.OpenMessageBox, mapCfg.LockText)
      else
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("StorySet_Chapter_Lock"))
      end
      return
    end
  end
  local nAnimLen = 0
  if self.tbChapterGrid[nInstanceId] ~= nil then
    nAnimLen = self.tbChapterGrid[nInstanceId]:PlayAnim(false)
  end
  self.nSelectIndex = nIndex
  self.bResetLsvPos = true
  self.nPanelType = panelType_Section
  CS.WwiseAudioManager.Instance:PlaySound("ui_mainline_story_menu")
  if 0 < nAnimLen then
    self:AddTimer(1, nAnimLen, function()
      self:Refresh()
    end, true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen)
  else
    self:Refresh()
  end
end

function StorySetCtrl:RefreshSection()
  self._mapNode.goList.gameObject:SetActive(false)
  self._mapNode.goTab.gameObject:SetActive(false)
  self._mapNode.goInfo.gameObject:SetActive(true)
  self._mapNode.btnShowUnRead.gameObject:SetActive(false)
  self._mapNode.txtShowUnReadDesc.gameObject:SetActive(false)
  for nInstanceId, v in pairs(self.tbSectionGrid) do
    self:UnbindCtrlByNode(v)
    self.tbSectionGrid[nInstanceId] = nil
  end
  local data = self.tbChapter[self.nSelectIndex]
  if nil ~= data then
    self.tbSectionList = data.tbSectionList
    self._mapNode.sectionLsv:Init(#self.tbSectionList, self, self.OnRefreshSectionGrid, self.OnSectionGridClick, not self.bResetLsvPos)
    local mapChapterCfg = ConfigTable.GetData("StorySetChapter", data.nId)
    if mapChapterCfg ~= nil then
      self:SetPngSprite(self._mapNode.imgChapterIcon, "Icon/MapEpisode/" .. mapChapterCfg.Image)
      self:SetPngSprite(self._mapNode.imgBgChapter, "Icon/MapEpisode/" .. mapChapterCfg.Bg)
      NovaAPI.SetTMPText(self._mapNode.txtTitle, ConfigTable.GetUIText("StorySet_Title") .. mapChapterCfg.Title)
      NovaAPI.SetTMPText(self._mapNode.txtChapter, mapChapterCfg.Name)
    end
  end
  self.bResetLsvPos = false
end

function StorySetCtrl:OnRefreshSectionGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local data = self.tbSectionList[nIndex]
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbSectionGrid[nInstanceId] then
    self.tbSectionGrid[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.StorySet.StorySetSectionItemCtrl")
  end
  self.tbSectionGrid[nInstanceId]:RefreshItem(data)
end

function StorySetCtrl:OnSectionGridClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local data = self.tbSectionList[nIndex]
  if data.nStatus == AllEnum.StorySetStatus.Lock then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("StorySet_Section_Lock_Tip"))
    return
  end
  local mapCfg = ConfigTable.GetData("StorySetSection", data.nId)
  if mapCfg ~= nil then
    local function avgEndCallback()
      EventManager.Hit(EventId.ClosePanel, PanelId.PureAvgStory)
      
      self.bGetReward = false
      self.bTransitionEnd = false
      if data.nStatus == AllEnum.StorySetStatus.UnLock then
        PlayerData.StorySet:ReceiveStorySetReward(mapCfg.ChapterId, data.nId, function(netMsg)
          self.bGetReward = true
          self.tbReward = netMsg
        end)
        PlayerData.Story:SetRecentStoryInfo(GameEnum.StoryPreviewType.StorySet, mapCfg.ChapterId, mapCfg.Id)
      end
    end
    
    local mapData = {
      nType = AllEnum.StoryAvgType.Plot,
      sAvgId = mapCfg.AVGId,
      nNodeId = nil,
      callback = avgEndCallback
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.PureAvgStory, mapData)
  end
end

function StorySetCtrl:RefreshTab()
  self.tbTabData = PlayerData.StorySet:GetAllTabList()
  self._mapNode.tabLsv:Init(#self.tbTabData, self, self.OnRefreshTabGrid, self.OnTabGridClick)
end

function StorySetCtrl:OnRefreshTabGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local cfg = self.tbTabData[nIndex]
  local root = goGrid.transform:Find("btnGrid/AnimRoot")
  local imgOn = root:Find("imgOn"):GetComponent("Image")
  if nIndex == 1 then
    self:SetAtlasSprite(imgOn, "07_tab", "tab_storyset_1")
  elseif nIndex == #self.tbTabData then
    self:SetAtlasSprite(imgOn, "07_tab", "tab_storyset_3")
  else
    self:SetAtlasSprite(imgOn, "07_tab", "tab_storyset_2")
  end
  imgOn.gameObject:SetActive(nIndex == self.nCurrentTabIndex)
  local txtOn = root:Find("txtOn"):GetComponent("TMP_Text")
  local txtOff = root:Find("txtOff"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtOn, cfg.TabName)
  NovaAPI.SetTMPText(txtOff, cfg.TabName)
  txtOn.gameObject:SetActive(nIndex == self.nCurrentTabIndex)
  txtOff.gameObject:SetActive(nIndex ~= self.nCurrentTabIndex)
  local tabLine = root.transform:Find("tabLine").gameObject
  tabLine:SetActive(nIndex < #self.tbTabData)
  if self.nCurrentTabIndex == nIndex then
    self.goCurrentTabGrid = goGrid
  end
  local redDot = root:Find("RedDot").gameObject
  RedDotManager.RegisterNode(RedDotDefine.Story_Set_Tab, cfg.Id, redDot, nil, nil, true)
end

function StorySetCtrl:OnTabGridClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  if self.nCurrentTabIndex == nIndex then
    return
  end
  self.nCurrentTabIndex = nIndex
  local root = goGrid.transform:Find("btnGrid/AnimRoot")
  local imgOn = root:Find("imgOn"):GetComponent("Image")
  imgOn.gameObject:SetActive(true)
  local txtOn = root:Find("txtOn"):GetComponent("TMP_Text")
  local txtOff = root:Find("txtOff"):GetComponent("TMP_Text")
  txtOn.gameObject:SetActive(true)
  txtOff.gameObject:SetActive(false)
  if self.goCurrentTabGrid ~= nil then
    local lastRoot = self.goCurrentTabGrid.transform:Find("btnGrid/AnimRoot")
    local lastImgOn = lastRoot:Find("imgOn"):GetComponent("Image")
    lastImgOn.gameObject:SetActive(false)
    local lastTxtOn = lastRoot:Find("txtOn"):GetComponent("TMP_Text")
    local lastTxtOff = lastRoot:Find("txtOff"):GetComponent("TMP_Text")
    lastTxtOn.gameObject:SetActive(false)
    lastTxtOff.gameObject:SetActive(true)
  end
  self.goCurrentTabGrid = goGrid
  local nAnimLen = 0
  for _, v in pairs(self.tbChapterGrid) do
    nAnimLen = v:PlayOutAnim()
  end
  if 0 < nAnimLen then
    self:AddTimer(1, nAnimLen, function()
      self:UpdateChapterList()
      self:RefreshChapter()
    end, true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen)
  else
    self:UpdateChapterList()
    self:RefreshChapter()
  end
end

function StorySetCtrl:ShowGetReward()
  if self.bGetReward and self.tbReward ~= nil and self.bTransitionEnd then
    UTILS.OpenReceiveByChangeInfo(self.tbReward, function()
      self:UpdateChapterList()
      if self.nPanelType == panelType_Section then
        self:RefreshSection()
      end
    end)
    self.bGetReward = false
    self.tbReward = nil
    self.bTransitionEnd = false
  end
end

function StorySetCtrl:UpdateChapterList()
  if self.tbTabData == nil then
    self.tbChapter = PlayerData.StorySet:GetAllChapterList(self.nCurrentTabIndex, self.bOnlyShowUnRead)
  else
    local cfg = self.tbTabData[self.nCurrentTabIndex]
    self.tbChapter = PlayerData.StorySet:GetAllChapterList(cfg.Id, self.bOnlyShowUnRead)
  end
end

function StorySetCtrl:Awake()
  self.nSelectIndex = 0
  self.nCurrentTabIndex = 1
  self.nPanelType = panelType_chapter
  self.bResetLsvPos = true
  self.nChapterId = 0
  self.bOnlyShowUnRead = false
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.bLocation = tbParam[1]
    self.nChapterId = tbParam[2] ~= nil and tbParam[2] or 0
  end
end

function StorySetCtrl:OnEnable()
  self.tbChapterGrid = {}
  self.tbSectionGrid = {}
  self:UpdateChapterList()
  self.animRoot = self.gameObject:GetComponent("Animator")
  if self.nChapterId > 0 then
    for k, v in ipairs(self.tbChapter) do
      if v.nId == self.nChapterId then
        if v.bUnlock then
          self.nSelectIndex = k
          self.nPanelType = panelType_Section
          break
        end
        self.nLocationIndex = k
        break
      end
    end
  end
  self:Refresh()
  self.animRoot:Play("StorySetPanel_in", 0, 0)
end

function StorySetCtrl:OnDisable()
  for _, v in pairs(self.tbChapterGrid) do
    self:UnbindCtrlByNode(v)
  end
  self.tbChapterGrid = {}
  for _, v in pairs(self.tbSectionGrid) do
    self:UnbindCtrlByNode(v)
  end
  self.tbSectionGrid = {}
end

function StorySetCtrl:OnDestroy()
end

function StorySetCtrl:OnRelease()
end

function StorySetCtrl:OnEvent_Back(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if self.nPanelType == panelType_Section then
    self.bResetLsvPos = true
    self.nPanelType = panelType_chapter
    self:Refresh()
  else
    EventManager.Hit(EventId.CloesCurPanel)
  end
  self.nChapterId = 0
  self.nLocationIndex = nil
end

function StorySetCtrl:OnEvent_BackHome(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  PanelManager.Home()
end

function StorySetCtrl:OnEvent_TransAnimOutClear()
  self.bTransitionEnd = true
  self:ShowGetReward()
end

function StorySetCtrl:OnEvent_ReceiveStorySetRewardSuc()
  self:ShowGetReward()
end

function StorySetCtrl:OnEvent_StorySetChapterRefresh()
  if self.bSendMsg then
    return
  end
  self.bSendMsg = true
  
  local function serverCallback()
    self:UpdateChapterList()
    self.bSendMsg = false
    if self.nPanelType == panelType_chapter then
      self:RefreshChapter()
    end
  end
  
  PlayerData.StorySet:SendGetStorySetData(serverCallback)
end

function StorySetCtrl:OnClick_ShowUnRead()
  self._mapNode.imgShowUnReadOn.gameObject:SetActive(not self.bOnlyShowUnRead)
  self.bOnlyShowUnRead = not self.bOnlyShowUnRead
  self:UpdateChapterList()
  self:RefreshChapter()
end

return StorySetCtrl
