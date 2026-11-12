local DormMainMenuCtrl = class("DormMainMenuCtrl", BaseCtrl)
DormMainMenuCtrl._mapNodeConfig = {
  btnFurnitureReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_FurnitureReward"
  },
  btnRecord = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Record"
  },
  btnQuest = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Quest"
  },
  btnSwitch = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_SwitchBtn"
  },
  btnEscape = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Escape"
  },
  btnEncyclopedia = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Encyclopedia"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  snapshot = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  imgPlayerHead = {sComponentName = "Image"},
  txtWorldClass = {sComponentName = "TMP_Text"},
  txtRankCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_RANK"
  },
  goHonorTitle = {
    sCtrlName = "Game.UI.FriendEx.HonorTitleCtrl"
  },
  txtName = {sComponentName = "TMP_Text"},
  btnName = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Rename"
  },
  txtMusicOnTitle1 = {sComponentName = "TMP_Text"},
  txtLikeTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_MainMenu_LikeTitle"
  },
  txtLikeCount = {sComponentName = "TMP_Text"},
  txtVisitorTitleDay = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_MainMenu_VisitorToday"
  },
  txtVisitorCountDay = {sComponentName = "TMP_Text"},
  txtVisitorTitleTotal = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_MainMenu_Visitor"
  },
  txtVisitorCountTotal = {sComponentName = "TMP_Text"},
  txtBtnRecord = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_MainMenu_Record"
  },
  txtBtnFurnitureReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_MainMenu_FurnitureReward"
  },
  txtBtnQuest = {
    sComponentName = "TMP_Text",
    sLanguageId = "DormQuest_Title"
  },
  txtBtnEscape = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_MainMenu_Escape"
  },
  txtDefaultModeSwitch = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_MainMenu_DefaultMode"
  },
  txtClickToContinue1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Close_Tip"
  },
  txtBtnEncyclopedia = {
    sComponentName = "TMP_Text",
    sLanguageId = "DormMainMenu_Knowledge"
  },
  Content = {sComponentName = "Animator"},
  goRedRecord = {},
  goRedQuest = {}
}
DormMainMenuCtrl._mapEventConfig = {
  DormNameUpdate = "OnEvent_DormNameUpdate",
  DormBGMSetSuccess = "OnEvent_BGMUpdate"
}
DormMainMenuCtrl._mapRedDotConfig = {
  [RedDotDefine.DormQuest] = {sNodeName = "goRedQuest"},
  [RedDotDefine.DormRecord] = {
    sNodeName = "goRedRecord"
  }
}

function DormMainMenuCtrl:Awake()
end

function DormMainMenuCtrl:FadeIn()
end

function DormMainMenuCtrl:FadeOut()
end

function DormMainMenuCtrl:OnEnable()
  NovaAPI.DispatchEventWithData("DORM_LUA_SET_UI_HIDDEN", nil, {61})
  local tbParam = self:GetPanelParam()
  self.nCurRoom = tbParam[1]
  self:Refresh()
  
  local function wait()
    self._mapNode.Content.gameObject:SetActive(false)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    NovaAPI.UIEffectSnapShotCapture(self._mapNode.snapshot.gameObject)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.Content.gameObject:SetActive(true)
  end
  
  cs_coroutine.start(wait)
end

function DormMainMenuCtrl:OnDisable()
  NovaAPI.DispatchEventWithData("DORM_LUA_SET_UI_HIDDEN", nil, {0})
end

function DormMainMenuCtrl:OnDestroy()
end

function DormMainMenuCtrl:OnRelease()
end

function DormMainMenuCtrl:Refresh()
  local mapPlayerDormInfo = PlayerData.PlayerDormData:GetPlayerBaseInfo()
  local nWorldClass = PlayerData.Base:GetWorldClass()
  local sPlayerName = PlayerData.Base:GetPlayerNickName()
  local nHeadId = PlayerData.Base:GetPlayerHeadId()
  local mapCfg = ConfigTable.GetData("PlayerHead", nHeadId)
  if mapCfg ~= nil then
    self:SetPngSprite(self._mapNode.imgPlayerHead, mapCfg.Icon)
  end
  local sDormName
  local nLike = 0
  local nVisitNumDay = 0
  local nVisitNumTotal = 0
  if mapPlayerDormInfo ~= nil then
    sDormName = mapPlayerDormInfo.DormName
    nLike = mapPlayerDormInfo.LikeNum
    nVisitNumDay = mapPlayerDormInfo.DayVisitNum
    nVisitNumTotal = mapPlayerDormInfo.VisitTotalNum
  end
  if sDormName == nil or sDormName == "" then
    sDormName = ConfigTable.GetUIText("Dorm_DefaultName")
  end
  NovaAPI.SetTMPText(self._mapNode.txtName, sDormName)
  NovaAPI.SetTMPText(self._mapNode.txtLikeCount, nLike)
  NovaAPI.SetTMPText(self._mapNode.txtVisitorCountDay, nVisitNumDay)
  NovaAPI.SetTMPText(self._mapNode.txtVisitorCountTotal, nVisitNumTotal)
  NovaAPI.SetTMPText(self._mapNode.txtWorldClass, nWorldClass)
  self:SetHornorTitle()
  local nDefaultMode = PlayerData.PlayerDormData:GetPanelDefaultMode()
  self._mapNode.btnSwitch[1].gameObject:SetActive(nDefaultMode == 1)
  self._mapNode.btnSwitch[2].gameObject:SetActive(nDefaultMode ~= 1)
  
  local function callback(mapInfo)
    if mapInfo[self.nCurRoom] ~= nil then
      local nDiscId = mapInfo[self.nCurRoom].DiscId
      if 0 < nDiscId then
        local mapIPCfg = ConfigTable.GetData_Item(nDiscId)
        if mapIPCfg ~= nil then
          NovaAPI.SetTMPText(self._mapNode.txtMusicOnTitle1, mapIPCfg.Title)
        end
      else
        NovaAPI.SetTMPText(self._mapNode.txtMusicOnTitle1, ConfigTable.GetUIText("Dorm_Default_MusicName"))
      end
    end
  end
  
  PlayerData.PlayerDormData:GetRoomInfo(callback)
  
  local function LikeInfoCallback(nLike, nVisitNumDay, nVisitNumTotal)
    NovaAPI.SetTMPText(self._mapNode.txtLikeCount, nLike)
    NovaAPI.SetTMPText(self._mapNode.txtVisitorCountDay, nVisitNumDay)
    NovaAPI.SetTMPText(self._mapNode.txtVisitorCountTotal, nVisitNumTotal)
  end
  
  PlayerData.PlayerDormData:UpdateLikeInfo(LikeInfoCallback)
end

function DormMainMenuCtrl:SetHornorTitle()
  local tbCurHonorTitle = PlayerData.Base:GetPlayerHonorTitle()
  local tbOwnHonorData = PlayerData.Base:GetPlayerHonorTitleList() or {}
  local nLevel = PlayerData.PlayerDormData:GetHonorTitleLevel()
  self._mapNode.goHonorTitle:SetHonotTitle(140001, true, nLevel)
  self._mapNode.goHonorTitle.gameObject:SetActive(true)
end

function DormMainMenuCtrl:OnBtnClick_Close()
  local function waitAnim()
    EventManager.Hit(EventId.ClosePanel, PanelId.DormMainMenuPanel)
  end
  
  self._mapNode.Content:Play("MenuSidePanel_out")
  self:AddTimer(1, 0.4, waitAnim, true, true, true)
end

function DormMainMenuCtrl:OnBtnClick_SwitchBtn(btn, nIdx)
  if nIdx == 1 then
    self._mapNode.btnSwitch[1].gameObject:SetActive(false)
    self._mapNode.btnSwitch[2].gameObject:SetActive(true)
    PlayerData.PlayerDormData:SetPanelDefaultMode(2)
  else
    self._mapNode.btnSwitch[1].gameObject:SetActive(true)
    self._mapNode.btnSwitch[2].gameObject:SetActive(false)
    PlayerData.PlayerDormData:SetPanelDefaultMode(1)
  end
end

function DormMainMenuCtrl:OnBtnClick_Escape()
  NovaAPI.DispatchEventWithData("DORM_LUA_REFRESH_SCENE")
  self:OnBtnClick_Close()
end

function DormMainMenuCtrl:OnBtnClick_Rename()
  if not PlayerData.PlayerDormData:CheckCanRenameDorm() then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.DormRenamePanel, 0)
end

function DormMainMenuCtrl:OnBtnClick_Quest()
  EventManager.Hit(EventId.OpenPanel, PanelId.DormQuestPanel)
end

function DormMainMenuCtrl:OnEvent_DormNameUpdate()
  local mapPlayerDormInfo = PlayerData.PlayerDormData:GetPlayerBaseInfo()
  local sDormName
  if mapPlayerDormInfo ~= nil then
    sDormName = mapPlayerDormInfo.DormName
  end
  if sDormName == nil or sDormName == "" then
    sDormName = ConfigTable.GetUIText("Dorm_DefaultName")
  end
  NovaAPI.SetTMPText(self._mapNode.txtName, sDormName)
end

function DormMainMenuCtrl:OnBtnClick_Record()
  local function GetInfoCallback(mapDormInfo)
    local tbDormInfo = {}
    
    for _, mapDormInfo in pairs(mapDormInfo) do
      table.insert(tbDormInfo, mapDormInfo)
    end
    
    local function sort(a, b)
      return a.DormRoomId < b.DormRoomId
    end
    
    table.sort(tbDormInfo, sort)
    local nCurRoom = self.nCurRoom
    local nIdx = 1
    for index, mapRoomInfo in ipairs(tbDormInfo) do
      if nCurRoom == mapRoomInfo.DormRoomId then
        nIdx = index
      end
    end
    EventManager.Hit(EventId.OpenPanel, PanelId.DormMusicSelectPanel, nIdx, tbDormInfo)
  end
  
  PlayerData.PlayerDormData:GetRoomInfo(GetInfoCallback)
end

function DormMainMenuCtrl:OnBtnClick_FurnitureReward()
  EventManager.Hit(EventId.OpenPanel, PanelId.DormHandbookPanel, self.nCurRoom)
end

function DormMainMenuCtrl:OnBtnClick_Encyclopedia()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    EventManager.Hit(EventId.OpenPanel, PanelId.Dictionary)
  end
  
  cs_coroutine.start(wait)
  EventManager.Hit(EventId.ClosePanel, PanelId.DormMainMenuPanel)
end

function DormMainMenuCtrl:OnEvent_BGMUpdate()
  local function callback(mapInfo)
    if mapInfo[self.nCurRoom] ~= nil then
      local nDiscId = mapInfo[self.nCurRoom].DiscId
      
      if 0 < nDiscId then
        local mapIPCfg = ConfigTable.GetData_Item(nDiscId)
        if mapIPCfg ~= nil then
          NovaAPI.SetTMPText(self._mapNode.txtMusicOnTitle1, mapIPCfg.Title)
        end
      else
        NovaAPI.SetTMPText(self._mapNode.txtMusicOnTitle1, ConfigTable.GetUIText("Dorm_Default_MusicName"))
      end
    end
  end
  
  PlayerData.PlayerDormData:GetRoomInfo(callback)
end

return DormMainMenuCtrl
