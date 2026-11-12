local DormCtrl = class("DormCtrl", BaseCtrl)
local ModuleManager = require("GameCore.Module.ModuleManager")
local DormGuideUI = require("Game.UI.Dorm.DormGuideUI")
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
DormCtrl._mapNodeConfig = {
  rtEditorRoot = {
    sCtrlName = "Game.UI.Dorm.DormEditor.DormEditorCtrl"
  },
  rtInteractiveRoot = {
    sCtrlName = "Game.UI.Dorm.DormInteractive.DormInteractiveCtrl"
  },
  rtFriendRoot = {
    sCtrlName = "Game.UI.Dorm.DormFriend.DormFriendRootCtrl"
  },
  CharListRoot = {
    sCtrlName = "Game.UI.Dorm.DormCharSelect.DormSelectCharCtrl"
  },
  btnHomeMain = {
    sComponentName = "UIButton",
    callback = "BtnClick_Home"
  },
  btnBackMain = {
    sComponentName = "UIButton",
    callback = "BtnClick_Back"
  },
  btnShowMenu = {
    sComponentName = "UIButton",
    callback = "BtnClick_ShowMenu"
  },
  btnHideAllUI2 = {
    sComponentName = "UIButton",
    callback = "BtnClick_HideAllUI2"
  },
  txt_ShowUI = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_ShowUI"
  },
  rtMenu = {}
}
DormCtrl._mapEventConfig = {
  [EventId.UIBackConfirm] = "OnEvent_Back",
  [EventId.UIHomeConfirm] = "OnEvent_Home",
  Dorm_HideUI = "OnEvent_DormHideUI",
  DormPanel_BtnClickEdit = "OnEvent_EditMode",
  DormPanel_BtnInteractive = "OnEvent_InteractiveMode",
  DormPanel_BtnClickObserve = "OnEvent_ObserveMode",
  DormPanel_BtnClickOperate = "OnEvent_OperateMode",
  DormPanel_NextRoom = "OnEvent_NextRoom",
  OnEvent_DormLevelLoadComplete = "OnEvent_DormLevelLoadComplete",
  DORM_LEVEL_FINISH = "OnEvent_DormLevelFinish",
  DORM_CS2LUA_SHOW_SELECT_ROME_UI = "OnEvent_SelectRoom",
  DORM_CS2LUA_SWITCH_NEW_ROOM = "OnEvent_SwitchRoom",
  DormRoomSelect_ChangeRoomResult = "OnEvent_ChangeRoomResult",
  DormCharSelectResult = "OnEvent_DormCharSelectResult",
  DormPanel_OpenSelectChar = "OnEvent_OpenSelectChar",
  DormUpdatePresetNameSuc = "OnEvent_DormUpdatePresetNameSuc",
  DormBGMSetSuccess = "OnEvent_DormBGMSetSuccess",
  ResetDormMusic = "OnEvent_ResetDormMusic",
  DormVisitFriendRoom = "OnEvent_VisitFriend",
  DormBackHome = "OnEvent_BackHome",
  DormNewRoomUnlock = "OnEvent_DormNewRoomUnlock",
  DormElevatorHideUI = "OnEvent_DormElevatorHideUI",
  [EventId.OpenPanel] = "OnEvent_DormGlobalOpenPanel",
  [EventId.ClosePanel] = "OnEvent_DormGlobalClosePanel"
}

function DormCtrl:Awake()
  self.animator = self.gameObject:GetComponent("Animator")
  self.bNeedWaitElevator = false
  self._nDormPopupCount = 0
end

function DormCtrl:RefreshVirtualMouseStick()
  local bPlayerControlMode = self._panel.nCurMode == 0 or self._panel.nCurMode == 3
  local bEnable = not bPlayerControlMode or not (0 >= self._nDormPopupCount)
  GamepadUIManager.SetVirtualMouseStickEnable(bEnable)
end

function DormCtrl:OnEvent_DormGlobalOpenPanel(nPanelId)
  if self._panel == nil then
    return
  end
  if nPanelId == self._panel._nPanelId then
    return
  end
  self._nDormPopupCount = self._nDormPopupCount + 1
  self:RefreshVirtualMouseStick()
end

function DormCtrl:OnEvent_DormGlobalClosePanel(nPanelId)
  if nPanelId == self._panel._nPanelId then
    return
  end
  if self._nDormPopupCount > 0 then
    self._nDormPopupCount = self._nDormPopupCount - 1
  end
  self:RefreshVirtualMouseStick()
end

function DormCtrl:OnEnable()
  self._nDormPopupCount = 0
  self.gameObject:SetActive(false)
  local bGetRoomInfo = false
  local bGetBagInfo = false
  
  local function ReopenWaitFrame()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    EventManager.Hit("OnEvent_DormLevelLoadComplete")
    self._panel:SetDormBGM()
  end
  
  local function SetDormData(nRoomId)
    local nCurRoom = nRoomId
    local roomData = {}
    if nCurRoom ~= 0 then
      local nFurnitureLen = 0
      if self._panel.mapDormRoomInfo[nCurRoom] ~= nil then
        local mapData = self._panel.mapDormRoomInfo[nCurRoom]
        nFurnitureLen = #mapData.FurnitureList
      end
      local tbRole = {}
      local bIsMale = PlayerData.Base:GetPlayerSex() == true
      if bIsMale then
        table.insert(tbRole, {
          9101,
          910101,
          true
        })
      else
        table.insert(tbRole, {
          9100,
          910001,
          true
        })
      end
      for index, value in ipairs(self._panel.mapDormRoomInfo[nCurRoom].RoleList) do
        local nSkinId = PlayerData.PlayerDormData:GetDormCharSkin(value.RoleId)
        table.insert(tbRole, {
          value.RoleId,
          nSkinId,
          value.IsVisit
        })
        if value.IsVisit == true then
          value.IsVisit = false
        end
      end
      local nSceneId = 0
      local bIsGuide = PlayerData.PlayerDormData:GetGuideState()
      table.insert(roomData, {
        1,
        nCurRoom,
        nFurnitureLen,
        tbRole,
        nSceneId,
        bIsGuide
      })
      for _, mapFurnitur in ipairs(self._panel.mapDormRoomInfo[nCurRoom].FurnitureList) do
        table.insert(roomData, {
          mapFurnitur.FurnitureId,
          mapFurnitur.X,
          mapFurnitur.Y,
          mapFurnitur.Z,
          mapFurnitur.Rotation
        })
      end
      safe_call_cs_func(CS.DormModuleHelper.SetDormData, roomData)
    else
      printError("NO ROOM CONFIG")
      return
    end
  end
  
  local function GetRoomInfoCallback(mapDormRoomInfo, mapDormBaseInfo)
    bGetRoomInfo = true
    local roomId = 0
    for nRoomId, _ in pairs(mapDormRoomInfo) do
      if roomId == 0 or roomId == nil then
        roomId = nRoomId
      else
        roomId = math.min(roomId, nRoomId)
      end
    end
    self._panel.nCurRoom = self._panel.nCurRoom == 0 and roomId or self._panel.nCurRoom
    self._panel.mapDormRoomInfo = mapDormRoomInfo
    self._panel.mapDormBaseData = mapDormBaseInfo
    if bGetBagInfo then
      local sCurModule = ModuleManager.GetCurModuleName()
      if sCurModule == "DormModuleScene" then
        cs_coroutine.start(ReopenWaitFrame)
      else
        SetDormData(roomId)
        NovaAPI.EnterModule("DormModuleScene", true)
      end
      self._mapNode.rtEditorRoot:Init(self._panel.nCurRoom)
      self._mapNode.rtInteractiveRoot:SetRoom(self._panel.nCurRoom)
      self._mapNode.rtInteractiveRoot:SetQuestInfo()
    else
      return
    end
  end
  
  local function GetBagInfoCallback(mapFurnitureBag)
    bGetBagInfo = true
    self._panel.mapFurnitureBag = mapFurnitureBag
    self._panel.mapFurnitureUsedCount = PlayerData.PlayerDormData:GetUsedCount()
    if bGetRoomInfo then
      local sCurModule = ModuleManager.GetCurModuleName()
      if sCurModule == "DormModuleScene" then
        cs_coroutine.start(ReopenWaitFrame)
      else
        SetDormData(self._panel.nCurRoom)
        NovaAPI.EnterModule("DormModuleScene", true)
      end
      self._mapNode.rtEditorRoot:Init(self._panel.nCurRoom)
      self._mapNode.rtInteractiveRoot:SetRoom(self._panel.nCurRoom)
      self._mapNode.rtInteractiveRoot:SetQuestInfo()
    else
      return
    end
  end
  
  PlayerData.PlayerDormData:GetRoomInfo(GetRoomInfoCallback)
  PlayerData.PlayerDormData:GetBagInfo(GetBagInfoCallback)
  if self._panel.nCurMode == -1 then
    local nCurCachedMode = PlayerData.PlayerDormData:GetPanelDefaultMode()
    if nCurCachedMode == 1 then
      self._mapNode.rtInteractiveRoot:SetMode(0)
      self._panel.nCurMode = 0
      self._panel.nCurInteractiveMode = 0
    else
      self._mapNode.rtInteractiveRoot:SetMode(1)
      self._panel.nCurMode = 1
      self._panel.nCurInteractiveMode = 1
    end
  elseif self._panel.nCurMode == 1 then
    self._mapNode.rtInteractiveRoot:SetMode(1)
    self._panel.nCurInteractiveMode = 1
  else
    self._mapNode.rtInteractiveRoot:SetMode(0)
    self._panel.nCurMode = 0
    self._panel.nCurInteractiveMode = 0
  end
  self:RefreshVirtualMouseStick()
  self.bNeedSwitchModeAfterLoad = true
  self.bHide = false
  self._mapNode.btnShowMenu.gameObject:SetActive(false)
  DormGuideUI.Bind(self)
end

function DormCtrl:OnDisable()
  DormGuideUI.Unbind(self)
  self._panel._tbParam[1] = self._panel.nCurRoom
  GamepadUIManager.SetVirtualMouseStickEnable(true)
end

function DormCtrl:SwitchRoom(nRoomId)
  local nNextRoom = nRoomId
  self._panel.nCurRoom = nNextRoom
  self._mapNode.rtEditorRoot:SwitchRoom(self._panel.nCurRoom)
  self._mapNode.rtInteractiveRoot:SetRoom(self._panel.nCurRoom)
  local tbRoleData = PlayerData.PlayerDormData:GetRoleInfo(nRoomId)
  PlayerData.PlayerDormData:SetRoleVisitState()
  local roomData = {}
  local nFurnitureLen = 0
  local tbRole = {}
  local bIsMale = PlayerData.Base:GetPlayerSex() == true
  if bIsMale then
    table.insert(tbRole, {
      9101,
      910101,
      true
    })
  else
    table.insert(tbRole, {
      9100,
      910001,
      true
    })
  end
  for index, value in ipairs(tbRoleData) do
    local nSkinId = PlayerData.PlayerDormData:GetDormCharSkin(value.RoleId)
    table.insert(tbRole, {
      value.RoleId,
      nSkinId,
      value.IsVisit
    })
    if value.IsVisit == false then
      value.IsVisit = true
    end
  end
  if self._panel.mapDormRoomInfo[nNextRoom] ~= nil then
    local mapData = self._panel.mapDormRoomInfo[nNextRoom]
    nFurnitureLen = #mapData.FurnitureList
  end
  table.insert(roomData, {
    1,
    self._panel.nCurRoom,
    nFurnitureLen,
    tbRole,
    0
  })
  for _, mapFurnitur in ipairs(self._panel.mapDormRoomInfo[self._panel.nCurRoom].FurnitureList) do
    table.insert(roomData, {
      mapFurnitur.FurnitureId,
      mapFurnitur.X,
      mapFurnitur.Y,
      mapFurnitur.Z,
      mapFurnitur.Rotation
    })
  end
  safe_call_cs_func(CS.DormModuleHelper.SetDormData, roomData)
  self._mapNode.rtInteractiveRoot:SetCharCount()
  local nStyle = 55
  local mapRoomConfigData = ConfigTable.GetData("DormRoom", self._panel.nCurRoom)
  if mapRoomConfigData ~= nil then
    nStyle = mapRoomConfigData.TransUIStyle
  end
  
  local function TransitionCallback()
    NovaAPI.DispatchEventWithData("DORM_LEVEL_STATE_CHANGED", nil, {false, 0})
  end
  
  EventManager.Hit(EventId.SetTransition, nStyle, TransitionCallback)
end

function DormCtrl:VisitFriendRoom(nUid, nRoomId)
  local function GetDataCallback(mapFriendInfo)
    local mapFriendDormInfo = mapFriendInfo.mapDormDetail[nRoomId]
    
    if mapFriendDormInfo == nil then
      return
    end
    self._panel.nCurRoom = nRoomId
    self._panel.nCurVisitFriendUid = nUid
    self._panel.nCustomBgm = mapFriendDormInfo.DiscId
    local tbRoleData = mapFriendDormInfo.RoleList
    local roomData = {}
    local nFurnitureLen = 0
    local tbRole = {}
    local bIsMale = PlayerData.Base:GetPlayerSex() == true
    if bIsMale then
      table.insert(tbRole, {
        9101,
        910101,
        true
      })
    else
      table.insert(tbRole, {
        9100,
        910001,
        true
      })
    end
    for index, value in ipairs(tbRoleData) do
      local nSkinId = PlayerData.PlayerDormData:GetDormCharSkin(value.RoleId)
      table.insert(tbRole, {
        value.RoleId,
        nSkinId,
        value.IsVisit
      })
      if value.IsVisit == false then
        value.IsVisit = true
      end
    end
    nFurnitureLen = #mapFriendDormInfo.FurnitureList
    table.insert(roomData, {
      1,
      nRoomId,
      nFurnitureLen,
      tbRole,
      0
    })
    for _, mapFurnitur in ipairs(mapFriendDormInfo.FurnitureList) do
      table.insert(roomData, {
        mapFurnitur.FurnitureId,
        mapFurnitur.X,
        mapFurnitur.Y,
        mapFurnitur.Z,
        mapFurnitur.Rotation
      })
    end
    safe_call_cs_func(CS.DormModuleHelper.SetDormData, roomData)
    self.bNeedSwitchModeAfterLoad = self._panel.nCurMode ~= 3
    self._panel.nCurMode = 3
    self:RefreshVirtualMouseStick()
    self._mapNode.rtInteractiveRoot:RecycleAllInteractiveHudCtrl()
    self._mapNode.rtEditorRoot.gameObject:SetActive(false)
    self._mapNode.rtInteractiveRoot.gameObject:SetActive(false)
    self._mapNode.rtFriendRoot.gameObject:SetActive(false)
    local mapDormFriendInfo = PlayerData.PlayerDormData:DormGetFriendInfoByUid(nUid)
    local mapFriendDetailData = PlayerData.Friend:GetFriendDetailData(nUid)
    self._mapNode.rtFriendRoot:Refresh(mapDormFriendInfo, mapFriendDetailData)
    local nStyle = 55
    local mapRoomConfigData = ConfigTable.GetData("DormRoom", self._panel.nCurRoom)
    if mapRoomConfigData ~= nil then
      nStyle = mapRoomConfigData.TransUIStyle
    end
    
    local function TransitionCallback()
      NovaAPI.DispatchEventWithData("DORM_LEVEL_STATE_CHANGED", nil, {false, 0})
    end
    
    EventManager.Hit(EventId.SetTransition, nStyle, TransitionCallback)
  end
  
  if self._panel.nCurMode ~= 3 then
    if self._panel.nCurMode == 2 then
      self._panel.nModeBeforeVisitFriend = self._panel.nCurInteractiveMode
    else
      self._panel.nModeBeforeVisitFriend = self._panel.nCurMode
    end
  end
  PlayerData.PlayerDormData:DormGetFriendVisitData(nUid, nRoomId, GetDataCallback)
end

function DormCtrl:ChangeVisitFriendRoom(nUid, nRoomId)
  local mapFriendInfo = PlayerData.PlayerDormData:DormGetCachedFriendVisitData(nUid)
  if mapFriendInfo == nil then
    return
  end
  self._panel.nCurRoom = nRoomId
  self._panel.nCurVisitFriendUid = nUid
  local mapFriendDormInfo = mapFriendInfo.mapDormDetail[nRoomId]
  local tbRoleData = mapFriendDormInfo.RoleList
  self._panel.nCustomBgm = mapFriendDormInfo.DiscId
  local roomData = {}
  local nFurnitureLen = 0
  local tbRole = {}
  local bIsMale = PlayerData.Base:GetPlayerSex() == true
  if bIsMale then
    table.insert(tbRole, {
      9101,
      910101,
      true
    })
  else
    table.insert(tbRole, {
      9100,
      910001,
      true
    })
  end
  for index, value in ipairs(tbRoleData) do
    local nSkinId = PlayerData.PlayerDormData:GetDormCharSkin(value.RoleId)
    table.insert(tbRole, {
      value.RoleId,
      nSkinId,
      value.IsVisit
    })
    if value.IsVisit == false then
      value.IsVisit = true
    end
  end
  nFurnitureLen = #mapFriendDormInfo.FurnitureList
  table.insert(roomData, {
    1,
    nRoomId,
    nFurnitureLen,
    tbRole,
    0
  })
  for _, mapFurnitur in ipairs(mapFriendDormInfo.FurnitureList) do
    table.insert(roomData, {
      mapFurnitur.FurnitureId,
      mapFurnitur.X,
      mapFurnitur.Y,
      mapFurnitur.Z,
      mapFurnitur.Rotation
    })
  end
  safe_call_cs_func(CS.DormModuleHelper.SetDormData, roomData)
  self.bNeedSwitchModeAfterLoad = self._panel.nCurMode ~= 3
  local nStyle = 55
  local mapRoomConfigData = ConfigTable.GetData("DormRoom", self._panel.nCurRoom)
  if mapRoomConfigData ~= nil then
    nStyle = mapRoomConfigData.TransUIStyle
  end
  
  local function TransitionCallback()
    NovaAPI.DispatchEventWithData("DORM_LEVEL_STATE_CHANGED", nil, {false, 0})
  end
  
  EventManager.Hit(EventId.SetTransition, nStyle, TransitionCallback)
  self._panel.nCurMode = 3
  self:RefreshVirtualMouseStick()
  self._mapNode.rtEditorRoot.gameObject:SetActive(false)
  self._mapNode.rtInteractiveRoot.gameObject:SetActive(false)
  self._mapNode.rtFriendRoot.gameObject:SetActive(false)
  local mapDormFriendInfo = PlayerData.PlayerDormData:DormGetFriendInfoByUid(nUid)
  local mapFriendDetailData = PlayerData.Friend:GetFriendDetailData(nUid)
  self._mapNode.rtFriendRoot:Refresh(mapDormFriendInfo, mapFriendDetailData)
end

function DormCtrl:DOSwitch2Interactive()
  self._mapNode.rtEditorRoot.gameObject:SetActive(false)
  self._mapNode.rtInteractiveRoot.gameObject:SetActive(true)
  self.animator:Play("DormPanel_in")
  self._mapNode.rtInteractiveRoot:SetMode(self._panel.nCurInteractiveMode)
  self._panel.nCurMode = self._panel.nCurInteractiveMode
  self:RefreshVirtualMouseStick()
  self._mapNode.rtEditorRoot:ExitEdiorMode()
  NovaAPI.DispatchEventWithData("DormSwicthMode", nil, {
    self._panel.nCurInteractiveMode
  })
end

function DormCtrl:OnEvent_Back(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  self:BtnClick_Back(nPanelId)
end

function DormCtrl:OnEvent_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  self:BtnClick_Home(nPanelId)
end

function DormCtrl:BtnClick_Back(nPanelId)
  if self._panel.nCurMode == 2 then
    self:OnEvent_InteractiveMode()
    return
  end
  if self._panel.nCurMode == 3 then
    self:OnEvent_BackHome()
    return
  end
  self.gameObject:SetActive(false)
  
  local function TransitionCallback()
    NovaAPI.DispatchEventWithData("DORM_LEVEL_STATE_CHANGED", nil, {true, 0})
  end
  
  EventManager.Hit(EventId.SetTransition, 6, TransitionCallback, AllEnum.MainViewCorner.Dorm)
end

function DormCtrl:BtnClick_Home(nPanelId)
  local function callback()
    self.gameObject:SetActive(false)
    
    local function TransitionCallback()
      NovaAPI.DispatchEventWithData("DORM_LEVEL_STATE_CHANGED", nil, {true, 0})
    end
    
    EventManager.Hit(EventId.SetTransition, 6, TransitionCallback, AllEnum.MainViewCorner.Dorm)
  end
  
  if self._panel.nCurMode == 2 then
    local sLanguage1 = ConfigTable.GetUIText("Dorm_SaveConfirmContent")
    local sLanguage2 = ConfigTable.GetUIText("DormBtn_SaveAndExit")
    local sLanguage3 = ConfigTable.GetUIText("DormBtn_Exit")
    self._panel:SaveRoom(callback, false, sLanguage1, sLanguage2, sLanguage3)
  else
    callback()
  end
end

function DormCtrl:BtnClick_ShowMenu()
  self._mapNode.btnHideAllUI2.gameObject:SetActive(true)
end

function DormCtrl:BtnClick_HideAllUI2()
  if self.bHide then
    self.bHide = false
    self._mapNode.rtMenu:SetActive(true)
    self._mapNode.btnShowMenu.gameObject:SetActive(false)
    self._mapNode.rtFriendRoot.gameObject:SetActive(self._panel.nCurMode == 3)
    self._mapNode.rtInteractiveRoot.gameObject:SetActive(self._panel.nCurMode ~= 3)
    local DormGuideUI = require("Game.UI.Dorm.DormGuideUI")
    DormGuideUI.SetOwnerCap("businessHide", nil)
    return
  end
end

function DormCtrl:OnEvent_EditMode()
  self._mapNode.rtEditorRoot.gameObject:SetActive(true)
  self._mapNode.rtEditorRoot.nCurMainTab = 1
  self._mapNode.rtEditorRoot.nCurFurniturTab1 = 1
  self._mapNode.rtEditorRoot.nCurFurniturTab2 = 1
  self._mapNode.rtEditorRoot.nCurPresetTab = 2
  self._mapNode.rtEditorRoot.nCurPresetIdx = 0
  self._mapNode.rtEditorRoot.nCurSuitId = 0
  self._mapNode.rtEditorRoot.nCurSelectPresetIdx = 0
  self._mapNode.rtEditorRoot:InitListToggle()
  self._mapNode.rtEditorRoot:OnBtnClick_FurnitureListOpen()
  self._mapNode.rtInteractiveRoot:RecycleAllInteractiveHudCtrl()
  self._mapNode.rtInteractiveRoot.gameObject:SetActive(false)
  WwiseAudioMgr:PostEvent("Home_UI_furniture")
  self._panel.nCurMode = 2
  self:RefreshVirtualMouseStick()
  NovaAPI.DispatchEventWithData("DormSwicthMode", nil, {2})
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if self._mapNode.rtEditorRoot ~= nil then
      self._mapNode.rtEditorRoot:SetRoomRatio()
    end
  end
  
  cs_coroutine.start(wait)
end

function DormCtrl:OnEvent_InteractiveMode(bNotNeedCheck)
  local function callback(bSaveSuc)
    if bSaveSuc then
      NovaAPI.DispatchEventWithData("DORM_LUA_SAVE_ROOM_SUCC")
    else
      NovaAPI.DispatchEventWithData("DORM_LUA_ABANDON_SAVE_ROOM")
    end
    self:DOSwitch2Interactive()
  end
  
  if bNotNeedCheck == true then
    self:DOSwitch2Interactive()
  else
    local sLanguage1 = ConfigTable.GetUIText("Dorm_SaveConfirmContent")
    local sLanguage2 = ConfigTable.GetUIText("DormBtn_SaveAndExit")
    local sLanguage3 = ConfigTable.GetUIText("DormBtn_Exit")
    self._panel:SaveRoom(callback, false, sLanguage1, sLanguage2, sLanguage3)
  end
end

function DormCtrl:OnEvent_ObserveMode()
  self._mapNode.rtInteractiveRoot:SetMode(1)
  self._panel.nCurMode = 1
  self._panel.nCurInteractiveMode = 1
  self:RefreshVirtualMouseStick()
  NovaAPI.DispatchEventWithData("DormSwicthMode", nil, {1})
end

function DormCtrl:OnEvent_OperateMode()
  self._mapNode.rtInteractiveRoot:SetMode(0)
  self._panel.nCurMode = 0
  self._panel.nCurInteractiveMode = 0
  self:RefreshVirtualMouseStick()
  NovaAPI.DispatchEventWithData("DormSwicthMode", nil, {0})
end

function DormCtrl:OnEvent_NextRoom(nUid)
  if self._panel.nCurMode == 3 then
    local mapFriendCachedDormData = PlayerData.PlayerDormData:DormGetCachedFriendVisitData(self._panel.nCurVisitFriendUid)
    local nCurRoom = self._panel.nCurRoom
    self.gameObject:SetActive(false)
    EventManager.Hit(EventId.OpenPanel, PanelId.DormRoomSelectPanel, mapFriendCachedDormData.mapDormDetail, nCurRoom, false, true)
  else
    local nCurRoom = self._panel.nCurRoom
    local mapRoomData = self._panel.mapDormRoomInfo
    self.gameObject:SetActive(false)
    EventManager.Hit(EventId.OpenPanel, PanelId.DormRoomSelectPanel, mapRoomData, nCurRoom, false, false)
  end
end

function DormCtrl:OnEvent_BackHome()
  self._panel.nCurMode = self._panel.nModeBeforeVisitFriend
  self:RefreshVirtualMouseStick()
  self._panel.nCurVisitFriendUid = 0
  self.bNeedSwitchModeAfterLoad = true
  self._panel.nCustomBgm = 0
  self:SwitchRoom(701001)
end

function DormCtrl:OnEvent_DormLevelLoadComplete()
  self._mapNode.rtEditorRoot.gameObject:SetActive(self._panel.nCurMode == 2)
  self._mapNode.rtInteractiveRoot.gameObject:SetActive(self._panel.nCurMode == 0 or self._panel.nCurMode == 1)
  local sAnim = "DormPanel_in"
  if self._panel.nCurMode == 0 or self._panel.nCurMode == 1 then
    self._panel.nCurInteractiveMode = self._panel.nCurMode
    self._mapNode.rtInteractiveRoot:SetMode(self._panel.nCurMode)
    self._mapNode.rtInteractiveRoot:RegisterVirtualJoystick()
  end
  self._mapNode.rtFriendRoot.gameObject:SetActive(self._panel.nCurMode == 3)
  if self._panel.nCurMode == 3 then
    self._mapNode.rtFriendRoot:RegisterVirtualJoystick()
    sAnim = "DormPanelFriend_in"
  end
  if self.bNeedSwitchModeAfterLoad then
    NovaAPI.DispatchEventWithData("DormSwicthMode", nil, {
      self._panel.nCurMode
    })
    self.bNeedSwitchModeAfterLoad = false
  end
  if not self.bNeedWaitElevator then
    self.gameObject:SetActive(true)
  end
  self.bNeedWaitElevator = false
  EventManager.Hit(EventId.SetTransition)
  self.animator:Play(sAnim)
  if DormGuideUI.IsLeaveLocked() then
    DormGuideUI._ApplyInterceptUI()
  end
  self._panel:SetDormBGM()
end

function DormCtrl:OnEvent_DormLevelFinish()
  NovaAPI.EnterModule("MainMenuModuleScene", true)
end

function DormCtrl:OnEvent_SelectRoom(nState)
  if nState == 2 then
    EventManager.Hit("DormElevatorHideUI", true)
    local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
    DormGuideAdapter.MarkWalkout()
    EventManager.Hit("DormGuide_ElevatorExit")
    return
  elseif nState == 1 then
    if self._panel.nCurMode == 3 then
      local mapFriendCachedDormData = PlayerData.PlayerDormData:DormGetCachedFriendVisitData(self._panel.nCurVisitFriendUid)
      local nCurRoom = self._panel.nCurRoom
      self.gameObject:SetActive(false)
      EventManager.Hit(EventId.OpenPanel, PanelId.DormRoomSelectPanel, mapFriendCachedDormData.mapDormDetail, nCurRoom, true, true)
    else
      local nCurRoom = self._panel.nCurRoom
      local mapRoomData = self._panel.mapDormRoomInfo
      self.gameObject:SetActive(false)
      EventManager.Hit(EventId.OpenPanel, PanelId.DormRoomSelectPanel, mapRoomData, nCurRoom, true, false)
    end
  else
    EventManager.Hit("DormElevatorHideUI", false)
  end
end

function DormCtrl:OnEvent_SwitchRoom()
  if self._panel.nCurMode == 3 then
    self:ChangeVisitFriendRoom(self._panel.nCurVisitFriendUid, self.nSelectedRoomId)
    self.nSelectedRoomId = 0
  else
    self:SwitchRoom(self.nSelectedRoomId)
    self.nSelectedRoomId = 0
  end
end

function DormCtrl:OnEvent_VisitFriend(nUid, nRoomId)
  if self._panel.nCurVisitFriendUid == nUid then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("DormTips_VisitSameFriend"))
    return
  end
  self:VisitFriendRoom(nUid, nRoomId)
end

function DormCtrl:OnEvent_ChangeRoomResult(bConfirm, nRoomId, bElevator)
  local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
  DormGuideAdapter.NoteRoomConfirm(bConfirm, nRoomId, bElevator)
  if bConfirm then
    self.nSelectedRoomId = nRoomId
  end
  if bElevator then
    NovaAPI.DispatchEventWithData("DORM_LUA_SELECT_SCENE_CALLBACK", nil, {bConfirm})
    self.bNeedWaitElevator = bElevator and bConfirm
  elseif bConfirm then
    self:OnEvent_SwitchRoom()
  else
    self.gameObject:SetActive(true)
    local sAnim = "DormPanel_in"
    if self._panel.nCurMode == 3 then
      sAnim = "DormPanelFriend_in"
    end
    if self._panel.nCurMode == 1 then
      self._mapNode.rtInteractiveRoot:InitFurnitureBtns()
    end
    self.animator:Play(sAnim)
  end
end

function DormCtrl:OnEvent_OpenSelectChar()
  local tbCurSelectChar = {}
  local tbCharInRoom = {}
  local mapDormRoomCfgData = ConfigTable.GetData("DormRoom", self._panel.nCurRoom)
  if mapDormRoomCfgData ~= nil then
    local nMaxCharCount = mapDormRoomCfgData.RoleNum
    for i = 1, nMaxCharCount do
      table.insert(tbCurSelectChar, 0)
    end
    local curRoomInfo = self._panel.mapDormRoomInfo[self._panel.nCurRoom]
    local tbRoleList = curRoomInfo.RoleList
    if tbRoleList ~= nil then
      for idx, mapRole in ipairs(tbRoleList) do
        tbCurSelectChar[idx] = mapRole.RoleId
      end
    end
    for nRoomId, mapRoomInfo in pairs(self._panel.mapDormRoomInfo) do
      if nRoomId ~= self._panel.nCurRoom then
        for _, mapRole in ipairs(mapRoomInfo.RoleList) do
          tbCharInRoom[mapRole.RoleId] = nRoomId
        end
      end
    end
    self._mapNode.CharListRoot:ShowList(tbCurSelectChar, false, 1, tbCharInRoom)
    self._nDormPopupCount = self._nDormPopupCount + 1
    self:RefreshVirtualMouseStick()
    NovaAPI.DispatchEventWithData("DormSwicthMode", nil, {4})
    self._mapNode.rtInteractiveRoot:SetShowBtns(false)
    self._mapNode.rtMenu:SetActive(false)
  end
end

function DormCtrl:OnEvent_DormCharSelectResult(tbCurChar, bConfirm)
  local function revertChar()
    local beforeChar = self._panel.mapDormRoomInfo[self._panel.nCurRoom].RoleList
    
    local tbBeforeCharId = {}
    for _, mapCharInfo in ipairs(beforeChar) do
      local nCharId = mapCharInfo.RoleId
      table.insert(tbBeforeCharId, mapCharInfo.RoleId)
      if table.indexof(tbCurChar, nCharId) < 1 then
        local nSkinId = 0
        local mapChar = ConfigTable.GetData_Character(nCharId)
        if mapChar ~= nil then
          nSkinId = mapChar.DefaultSkinId
        end
        NovaAPI.DispatchEventWithData("DORM_LUA_SWITCH_ACTOR_CALLBACK", nil, {
          true,
          nCharId,
          nSkinId
        })
      end
    end
    for _, nCharId in ipairs(tbCurChar) do
      if 0 < nCharId and table.indexof(tbBeforeCharId, nCharId) < 1 then
        NovaAPI.DispatchEventWithData("DORM_LUA_SWITCH_ACTOR_CALLBACK", nil, {false, nCharId})
      end
    end
    if not DormGuideUI._bHideChrome then
      self._mapNode.rtInteractiveRoot:SetShowBtns(true)
      self._mapNode.rtMenu:SetActive(true)
    end
    self._mapNode.rtInteractiveRoot:SetCharCount()
    self._mapNode.rtInteractiveRoot:SetFastInteractiveBtn()
  end
  
  if bConfirm then
    local tbChar = {}
    local bSame = true
    local beforeChar = self._panel.mapDormRoomInfo[self._panel.nCurRoom].RoleList
    for _, nCharId in ipairs(tbCurChar) do
      if nCharId ~= 0 then
        table.insert(tbChar, nCharId)
      end
    end
    if #beforeChar ~= #tbChar then
      bSame = false
    end
    for _, mapCharInfo in ipairs(beforeChar) do
      if table.indexof(tbCurChar, mapCharInfo.RoleId) < 1 then
        bSame = false
      end
    end
    
    local function callback(ret)
      local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
      DormGuideAdapter.NoteCharResult(true)
      self._panel.mapDormRoomInfo = ret
      self._mapNode.rtInteractiveRoot:SetCharCount()
      self._mapNode.rtInteractiveRoot:SetFastInteractiveBtn()
      self._mapNode.CharListRoot:CloseList()
      if not DormGuideUI._bHideChrome then
        self._mapNode.rtInteractiveRoot:SetShowBtns(true)
        self._mapNode.rtMenu:SetActive(true)
      end
      if self._nDormPopupCount > 0 then
        self._nDormPopupCount = self._nDormPopupCount - 1
      end
      self:RefreshVirtualMouseStick()
      NovaAPI.DispatchEventWithData("DormSwicthMode", nil, {
        self._panel.nCurInteractiveMode
      })
    end
    
    if bSame then
      callback(self._panel.mapDormRoomInfo)
    else
      PlayerData.PlayerDormData:UpdateInvitationRole(self._panel.nCurRoom, tbChar, callback)
    end
  else
    local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
    DormGuideAdapter.NoteCharResult(false)
    revertChar()
    self._mapNode.CharListRoot:CloseList()
    if not DormGuideUI._bHideChrome then
      self._mapNode.rtInteractiveRoot:SetShowBtns(true)
      self._mapNode.rtMenu:SetActive(true)
    end
    if self._nDormPopupCount > 0 then
      self._nDormPopupCount = self._nDormPopupCount - 1
    end
    self:RefreshVirtualMouseStick()
    NovaAPI.DispatchEventWithData("DormSwicthMode", nil, {
      self._panel.nCurInteractiveMode
    })
  end
end

function DormCtrl:OnEvent_DormUpdatePresetNameSuc(nBuildId, sName)
  self._panel.mapPresetInfo[nBuildId].BuildName = sName
end

function DormCtrl:OnEvent_DormBGMSetSuccess(tbInfo)
  for _, value in ipairs(tbInfo) do
    if self._panel.mapDormRoomInfo[value.DormRoomId] ~= nil then
      self._panel.mapDormRoomInfo[value.DormRoomId].DiscId = value.DiscId
    end
  end
end

function DormCtrl:OnEvent_ResetDormMusic()
  self._panel:SetDormBGM()
end

function DormCtrl:OnEvent_DormNewRoomUnlock()
  local function GetRoomInfoCallback(mapDormRoomInfo, mapDormBaseInfo)
    self._panel.mapDormRoomInfo = mapDormRoomInfo
    
    self._panel.mapDormBaseData = mapDormBaseInfo
  end
  
  local function GetDormBagInfo(mapFurnitureBag)
    self._panel.mapFurnitureBag = mapFurnitureBag
    self._panel.mapFurnitureUsedCount = PlayerData.PlayerDormData:GetUsedCount()
    self._mapNode.rtEditorRoot:Init(self._panel.nCurRoom)
    self._mapNode.rtInteractiveRoot:SetRoom(self._panel.nCurRoom)
  end
  
  PlayerData.PlayerDormData:GetRoomInfo(GetRoomInfoCallback)
  PlayerData.PlayerDormData:GetBagInfo(GetDormBagInfo)
end

function DormCtrl:OnEvent_DormHideUI()
  self._mapNode.rtMenu:SetActive(false)
  self._mapNode.rtInteractiveRoot.gameObject:SetActive(false)
  self._mapNode.rtFriendRoot.gameObject:SetActive(false)
  self._mapNode.btnShowMenu.gameObject:SetActive(true)
  self._mapNode.btnHideAllUI2.gameObject:SetActive(false)
  self.bHide = true
  local DormGuideUI = require("Game.UI.Dorm.DormGuideUI")
  DormGuideUI.SetOwnerCap("businessHide", 56)
end

function DormCtrl:OnEvent_DormElevatorHideUI(bHide)
  self.gameObject:SetActive(bHide)
end

return DormCtrl
