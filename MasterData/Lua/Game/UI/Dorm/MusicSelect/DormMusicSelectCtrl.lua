local DormMusicSelectCtrl = class("DormMusicSelectCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
DormMusicSelectCtrl._mapNodeConfig = {
  TMPRoomName = {sComponentName = "TMP_Text"},
  TMPCurMusicName = {sComponentName = "TMP_Text"},
  TMPDiscListTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_MusicSelect_ListTitle"
  },
  imgRoomIcon = {sComponentName = "Image"},
  svDiscList = {
    sComponentName = "LoopScrollView"
  },
  btnNextRoom = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Next"
  },
  btnPrevRoom = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Prev"
  },
  btnHomeMain = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Home"
  },
  btnBackMain = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnSaveRoom = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Save"
  },
  btnSaveRoomGray = {},
  btnApplyAllRoom = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ApplyAll"
  },
  btnApplyAllRoomGray = {},
  txtBtnSaveRoom = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_MusicSelect_Save"
  },
  txtBtnSaveRoomGray = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_MusicSelect_Save"
  },
  txtBtnApplyAllRoom = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_MusicSelect_ApplyAll"
  },
  txtBtnApplyAllRoomGray = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_MusicSelect_ApplyAll"
  },
  imgPointBg = {nCount = 6},
  imgPoint = {nCount = 6}
}
DormMusicSelectCtrl._mapEventConfig = {}
DormMusicSelectCtrl._mapRedDotConfig = {}

function DormMusicSelectCtrl:Awake()
  self.tbGridCtrl = {}
  self.nMusicStartTime = 0
  self.Animator = self.gameObject:GetComponent("Animator")
end

function DormMusicSelectCtrl:FadeIn()
end

function DormMusicSelectCtrl:FadeOut()
end

function DormMusicSelectCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  self.nCurRoomIdx = tbParam[1]
  self.tbRoomInfo = tbParam[2]
  self.nCurDiscMusic = self.tbRoomInfo[self.nCurRoomIdx].DiscId
  self.nCurSelectMusic = -1
  for i = 1, 6 do
    self._mapNode.imgPointBg[i]:SetActive(self.tbRoomInfo[i] ~= nil)
    self._mapNode.imgPoint[i]:SetActive(self.nCurRoomIdx == i)
  end
  self:SetDormInfo(self.tbRoomInfo[self.nCurRoomIdx])
  self:SetSaveBtn()
  self._mapNode.btnNextRoom.gameObject:SetActive(1 < #self.tbRoomInfo)
  self._mapNode.btnPrevRoom.gameObject:SetActive(1 < #self.tbRoomInfo)
  self.tbSortCfg = {
    nSortType = PlayerData.Filter.nFormationDiscSrotType,
    bOrder = PlayerData.Filter.bFormationDiscOrder
  }
  self.tbAllDisc = PlayerData.Disc:GetAllDisc()
  self:FilterDisc()
  self:SortDisc()
  self._mapNode.svDiscList:SetAnim(0.08)
  self._mapNode.svDiscList:Init(#self.tbDiscId, self, self.OnGridRefreshDiscMusic, self.OnGridBtnClickDiscMusic, true)
end

function DormMusicSelectCtrl:FilterDisc()
  self.tbSortedDisc = {}
  for _, data in pairs(self.tbAllDisc) do
    local mapCfg = ConfigTable.GetData("Disc", data.nId)
    if mapCfg.Visible then
      local isFilter = PlayerData.Filter:CheckFilterByDisc(data.nId)
      if isFilter then
        table.insert(self.tbSortedDisc, data)
      end
    end
  end
end

function DormMusicSelectCtrl:SortDisc()
  self.tbDiscId = {}
  UTILS.SortByPriority(self.tbSortedDisc, {
    AllEnum.DiscSortField[self.tbSortCfg.nSortType]
  }, PlayerData.Disc:GetDiscSortField(), self.tbSortCfg.bOrder)
  for i = 1, #self.tbSortedDisc do
    table.insert(self.tbDiscId, self.tbSortedDisc[i].nId)
  end
  table.insert(self.tbDiscId, 1, 0)
end

function DormMusicSelectCtrl:SetSaveBtn()
  self._mapNode.btnSaveRoom.gameObject:SetActive(self.nCurSelectMusic >= 0 and self.nCurDiscMusic ~= self.nCurSelectMusic)
  self._mapNode.btnSaveRoomGray.gameObject:SetActive(self.nCurSelectMusic < 0 or self.nCurDiscMusic == self.nCurSelectMusic)
  self._mapNode.btnApplyAllRoom.gameObject:SetActive(self.nCurSelectMusic >= 0)
  self._mapNode.btnApplyAllRoomGray.gameObject:SetActive(self.nCurSelectMusic < 0)
end

function DormMusicSelectCtrl:OnGridRefreshDiscMusic(goGrid, nIdx)
  nIdx = nIdx + 1
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceId] then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.Dorm.MusicSelect.DormMusicSelectDiscGridCtrl")
  end
  local nDiscId = self.tbDiscId[nIdx]
  if nDiscId == nil then
    return
  end
  local bCur = self.nCurDiscMusic == nDiscId
  local bPlay = self.nMusicStartTime > 0 and self.nCurSelectMusic == nDiscId
  local nMusicTime = self.nMusicStartTime > 0 and CS.ClientManager.Instance.serverTimeStamp - self.nMusicStartTime or 0
  self.tbGridCtrl[nInstanceId]:Refresh(nDiscId, bCur, bPlay, nMusicTime)
  self.tbGridCtrl[nInstanceId]:SetSelect(nDiscId == self.nCurSelectMusic)
end

function DormMusicSelectCtrl:OnGridBtnClickDiscMusic(goGrid, nIdx)
  nIdx = nIdx + 1
  local nDiscId = self.tbDiscId[nIdx]
  if nDiscId == nil then
    return
  end
  if self.nCurSelectMusic == nDiscId then
    return
  end
  local nInstanceId = goGrid:GetInstanceID()
  self.nMusicStartTime = CS.ClientManager.Instance.serverTimeStamp
  self.tbGridCtrl[nInstanceId]:PlayMusic()
  self.tbGridCtrl[nInstanceId]:SetSelect(true)
  if nDiscId == 0 then
    WwiseAudioMgr:SetDormMusic("system", "houZhai")
  else
    local mapIPCfg = ConfigTable.GetData("DiscIP", nDiscId)
    if mapIPCfg ~= nil then
      local sVoFile = mapIPCfg.VoFile
      WwiseAudioMgr:SetDormMusic("outfit", sVoFile)
      WwiseAudioMgr:SeekOnEvent("music_outfit", 0)
    end
  end
  for nInstanceIdGrid, ctrl in pairs(self.tbGridCtrl) do
    if nInstanceIdGrid ~= nInstanceId then
      ctrl:StopPlay()
      ctrl:SetSelect(false)
    end
  end
  self.nCurSelectMusic = nDiscId
  self:SetSaveBtn()
end

function DormMusicSelectCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
  end
  self.tbGridCtrl = {}
  EventManager.Hit("ResetDormMusic")
end

function DormMusicSelectCtrl:OnDestroy()
end

function DormMusicSelectCtrl:OnRelease()
end

function DormMusicSelectCtrl:SetDormInfo(mapDormInfo)
  local mapRoomCfgData = ConfigTable.GetData("DormRoom", mapDormInfo.DormRoomId)
  if mapRoomCfgData == nil then
    return
  end
  local sName = mapDormInfo.RoomName == nil or mapDormInfo.RoomName == "" and mapRoomCfgData.DefaultName or mapDormInfo.RoomName
  NovaAPI.SetTMPText(self._mapNode.TMPRoomName, sName)
  local sMusicTitle = ""
  if self.nCurDiscMusic == 0 then
    sMusicTitle = orderedFormat(ConfigTable.GetUIText("Dorm_MusicSelect_CurMusicTitle"), ConfigTable.GetUIText("Dorm_Default_MusicName"))
  else
    local mapIPCfg = ConfigTable.GetData_Item(self.nCurDiscMusic)
    if mapIPCfg ~= nil then
      sMusicTitle = orderedFormat(ConfigTable.GetUIText("Dorm_MusicSelect_CurMusicTitle"), mapIPCfg.Title)
    end
  end
  NovaAPI.SetTMPText(self._mapNode.TMPCurMusicName, sMusicTitle)
  local nRoomScene = mapDormInfo.RoomScene == 0 and mapRoomCfgData.SceneRes
  local mapSceneConfig = ConfigTable.GetData("DormRoomScene", nRoomScene)
  if mapSceneConfig ~= nil then
    self:SetPngSprite(self._mapNode.imgRoomIcon, mapSceneConfig.IconRes .. "_big")
  end
end

function DormMusicSelectCtrl:OnBtnClick_Close()
  EventManager.Hit(EventId.ClosePanel, PanelId.DormMusicSelectPanel)
end

function DormMusicSelectCtrl:OnBtnClick_Home()
  self:OnBtnClick_Close()
  EventManager.Hit(EventId.ClosePanel, PanelId.DormMainMenuPanel)
  
  local function transitionOpenCallback()
    local function OnEventAfterEnterMain()
      EventManager.Remove(EventId.AfterEnterMain, PanelManager, OnEventAfterEnterMain)
      
      PanelManager.IGNORE_CS_TRANS_EVENT = false
      
      local function wait()
        PanelManager.Home()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        EventManager.Hit(EventId.SetTransition)
      end
      
      cs_coroutine.start(wait)
    end
    
    local function OnEventDormLevelFinish()
      EventManager.Remove("DORM_LEVEL_FINISH", PanelManager, OnEventDormLevelFinish)
      PanelManager.IGNORE_CS_TRANS_EVENT = true
      NovaAPI.EnterModule("MainMenuModuleScene", true)
    end
    
    EventManager.Add("DORM_LEVEL_FINISH", PanelManager, OnEventDormLevelFinish)
    EventManager.Add(EventId.AfterEnterMain, PanelManager, OnEventAfterEnterMain)
    NovaAPI.DispatchEventWithData("DORM_LEVEL_STATE_CHANGED", nil, {true, 0})
  end
  
  EventManager.Hit(EventId.SetTransition, 6, transitionOpenCallback, AllEnum.MainViewCorner.Dorm)
end

function DormMusicSelectCtrl:OnBtnClick_Next()
  local nTotalCount = #self.tbRoomInfo
  self.nCurRoomIdx = self.nCurRoomIdx + 1
  if nTotalCount < self.nCurRoomIdx then
    self.nCurRoomIdx = 1
  end
  for i = 1, 6 do
    self._mapNode.imgPoint[i]:SetActive(self.nCurRoomIdx == i)
  end
  self.nCurDiscMusic = self.tbRoomInfo[self.nCurRoomIdx].DiscId
  self.nCurSelectMusic = -1
  if self.nCurDiscMusic == 0 then
    WwiseAudioMgr:SetDormMusic("system", "houZhai")
  else
    local mapIPCfg = ConfigTable.GetData("DiscIP", self.nCurDiscMusic)
    if mapIPCfg ~= nil then
      local sVoFile = mapIPCfg.VoFile
      WwiseAudioMgr:SetDormMusic("outfit", sVoFile)
      WwiseAudioMgr:SeekOnEvent("music_outfit", 0)
    end
  end
  self.nMusicStartTime = 0
  self:SetDormInfo(self.tbRoomInfo[self.nCurRoomIdx])
  self._mapNode.svDiscList:Init(#self.tbDiscId, self, self.OnGridRefreshDiscMusic, self.OnGridBtnClickDiscMusic, true)
  self:SetSaveBtn()
end

function DormMusicSelectCtrl:OnBtnClick_Prev()
  local nTotalCount = #self.tbRoomInfo
  self.nCurRoomIdx = self.nCurRoomIdx - 1
  if self.nCurRoomIdx < 1 then
    self.nCurRoomIdx = nTotalCount
  end
  for i = 1, 6 do
    self._mapNode.imgPoint[i]:SetActive(self.nCurRoomIdx == i)
  end
  self.nCurDiscMusic = self.tbRoomInfo[self.nCurRoomIdx].DiscId
  self.nCurSelectMusic = -1
  if self.nCurDiscMusic == 0 then
    WwiseAudioMgr:SetDormMusic("system", "houZhai")
  else
    local mapIPCfg = ConfigTable.GetData("DiscIP", self.nCurDiscMusic)
    if mapIPCfg ~= nil then
      local sVoFile = mapIPCfg.VoFile
      WwiseAudioMgr:SetDormMusic("outfit", sVoFile)
      WwiseAudioMgr:SeekOnEvent("music_outfit", 0)
    end
  end
  self.nMusicStartTime = 0
  self:SetDormInfo(self.tbRoomInfo[self.nCurRoomIdx])
  self._mapNode.svDiscList:Init(#self.tbDiscId, self, self.OnGridRefreshDiscMusic, self.OnGridBtnClickDiscMusic, true)
  self:SetSaveBtn()
end

function DormMusicSelectCtrl:OnBtnClick_Save()
  if self.nCurSelectMusic == -1 then
    return
  end
  
  local function callback()
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Dorm_MusicSelect_SaveSuccess"))
    self.nCurDiscMusic = self.nCurSelectMusic
    self.tbRoomInfo[self.nCurRoomIdx].DiscId = self.nCurSelectMusic
    self.nCurSelectMusic = -1
    self._mapNode.svDiscList:Init(#self.tbDiscId, self, self.OnGridRefreshDiscMusic, self.OnGridBtnClickDiscMusic, true)
    self:SetSaveBtn()
    self:SetDormInfo(self.tbRoomInfo[self.nCurRoomIdx])
  end
  
  local nCurDisc = self.tbRoomInfo[self.nCurRoomIdx].DiscId
  if nCurDisc == self.nCurSelectMusic then
    callback()
  else
    PlayerData.PlayerDormData:DormSetRoomBgm({
      {
        DormRoomId = self.tbRoomInfo[self.nCurRoomIdx].DormRoomId,
        DiscId = self.nCurSelectMusic
      }
    }, callback)
  end
end

function DormMusicSelectCtrl:OnBtnClick_ApplyAll()
  if self.nCurSelectMusic == -1 then
    return
  end
  
  local function confirmCallback()
    local bNeedMessage = false
    local tbRoomId = {}
    for _, mapRoomInfo in ipairs(self.tbRoomInfo) do
      if self.nCurSelectMusic ~= mapRoomInfo.DiscId then
        bNeedMessage = true
        table.insert(tbRoomId, mapRoomInfo.DormRoomId)
      end
    end
    if bNeedMessage then
      local function callback()
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Dorm_MusicSelect_SaveSuccess"))
        
        self.nCurDiscMusic = self.nCurSelectMusic
        for _, mapRoomInfo in ipairs(self.tbRoomInfo) do
          mapRoomInfo.DiscId = self.nCurSelectMusic
        end
        self.nCurSelectMusic = -1
        self._mapNode.svDiscList:Init(#self.tbDiscId, self, self.OnGridRefreshDiscMusic, self.OnGridBtnClickDiscMusic, true)
        self:SetSaveBtn()
        self:SetDormInfo(self.tbRoomInfo[self.nCurRoomIdx])
      end
      
      local tbMsg = {}
      for _, nRoomId in ipairs(tbRoomId) do
        table.insert(tbMsg, {
          DormRoomId = nRoomId,
          DiscId = self.nCurSelectMusic
        })
      end
      PlayerData.PlayerDormData:DormSetRoomBgm(tbMsg, callback)
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Dorm_MusicSelect_SaveSuccess"))
    end
  end
  
  local sContent = ""
  if self.nCurSelectMusic == 0 then
    sContent = orderedFormat(ConfigTable.GetUIText("Dorm_MusicSelect_ApplyAllHint"), ConfigTable.GetUIText("Dorm_Default_MusicName"))
  else
    local mapIPCfg = ConfigTable.GetData_Item(self.nCurSelectMusic)
    if mapIPCfg ~= nil then
      sContent = orderedFormat(ConfigTable.GetUIText("Dorm_MusicSelect_ApplyAllHint"), mapIPCfg.Title)
    end
  end
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = sContent,
    callbackConfirmAfterClose = confirmCallback
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

return DormMusicSelectCtrl
