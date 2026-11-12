local DormCtrl = class("DormCtrl", BaseCtrl)
DormCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  rtEditorRoot = {
    sCtrlName = "Game.UI.Dorm.Legacy.DormEditorCtrl"
  },
  rtInteractiveRoot = {
    sCtrlName = "Game.UI.Dorm.Legacy.DormInteractiveCtrl"
  },
  TestHotFix = {sComponentName = "Text"},
  btnTestHotFix = {
    sComponentName = "UIButton",
    nCount = 3,
    callback = "HotFixTestBtn"
  },
  CharListRoot = {
    sCtrlName = "Game.UI.Dorm.DormCharSelect.DormSelectCharCtrl"
  }
}
DormCtrl._mapEventConfig = {
  [EventId.UIBackConfirm] = "OnEvent_Back",
  [EventId.UIHomeConfirm] = "OnEvent_Home",
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
  DormCharInteractive = "OnEvent_DormCharInteractive",
  DormCharGiftSend = "OnEvent_DormCharGift"
}

function DormCtrl:Awake()
end

function DormCtrl:OnEnable()
  self.nSelectedRoomId = 0
  local tbParam = self:GetPanelParam()
  local roomId = tbParam[1]
  self.gameObject:SetActive(false)
  local bGetRoomInfo = false
  local bGetBagInfo = false
  
  local function GetRoomInfoCallback(mapDormRoomInfo)
    bGetRoomInfo = true
    if roomId == nil or roomId <= 0 then
      for nRoomId, _ in pairs(mapDormRoomInfo) do
        if roomId == 0 or roomId == nil then
          roomId = nRoomId
        else
          roomId = math.min(roomId, nRoomId)
        end
      end
    end
    self._panel.nCurRoom = roomId
    self._panel.mapDormRoomInfo = mapDormRoomInfo
    if bGetBagInfo then
      NovaAPI.EnterModule("DormModuleScene", true)
      self._mapNode.rtEditorRoot:Init(self._panel.nCurRoom)
    else
      return
    end
  end
  
  PlayerData.PlayerDormData:GetRoomInfo(GetRoomInfoCallback)
  
  local function GetBagInfoCallback(mapFurnitureBag)
    bGetBagInfo = true
    self._panel.mapFurnitureBag = mapFurnitureBag
    self._panel.mapFurnitureUsedCount = PlayerData.PlayerDormData:GetUsedCount()
    if bGetRoomInfo then
      NovaAPI.EnterModule("DormModuleScene", true)
      self._mapNode.rtEditorRoot:Init(self._panel.nCurRoom)
    else
      return
    end
  end
  
  PlayerData.PlayerDormData:GetBagInfo(GetBagInfoCallback)
end

function DormCtrl:SwitchRoom(nRoomId)
  local nNextRoom = nRoomId
  self._panel.nCurRoom = nNextRoom
  self._mapNode.rtEditorRoot:Init(self._panel.nCurRoom)
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
    local nSkinId = PlayerData.Char:GetCharSkinId(value.RoleId)
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
  NovaAPI.DispatchEventWithData("DORM_LEVEL_STATE_CHANGED", nil, {false, 0})
end

function DormCtrl:OnEvent_Back(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if self._panel.nCurMode == 2 then
    self:OnEvent_InteractiveMode()
    return
  end
  NovaAPI.DispatchEventWithData("DORM_LEVEL_STATE_CHANGED", nil, {true, 0})
  self.gameObject:SetActive(false)
end

function DormCtrl:OnEvent_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  NovaAPI.DispatchEventWithData("DORM_LEVEL_STATE_CHANGED", nil, {true, 0})
  self.gameObject:SetActive(false)
end

function DormCtrl:OnEvent_EditMode()
  self._mapNode.rtEditorRoot.gameObject:SetActive(true)
  self._mapNode.rtInteractiveRoot:RecycleAllInteractiveHudCtrl()
  self._mapNode.rtInteractiveRoot.gameObject:SetActive(false)
  self._panel.nCurMode = 2
  NovaAPI.DispatchEventWithData("DormSwicthMode", nil, {2})
end

function DormCtrl:OnEvent_InteractiveMode()
  local function callback(bSaveSuc)
    self._panel.tempEditCount = {}
    
    self._mapNode.rtEditorRoot.gameObject:SetActive(false)
    self._mapNode.rtInteractiveRoot.gameObject:SetActive(true)
    self._mapNode.rtInteractiveRoot:SetMode(self._panel.nCurInteractiveMode)
    self._panel.nCurMode = self._panel.nCurInteractiveMode
    if bSaveSuc then
      NovaAPI.DispatchEventWithData("DORM_LUA_SAVE_ROOM_SUCC")
    else
      NovaAPI.DispatchEventWithData("DORM_LUA_ABANDON_SAVE_ROOM")
    end
    NovaAPI.DispatchEventWithData("DormSwicthMode", nil, {
      self._panel.nCurInteractiveMode
    })
  end
  
  self._panel:SaveRoom(callback, false)
end

function DormCtrl:OnEvent_ObserveMode()
  self._mapNode.rtInteractiveRoot:SetMode(1)
  self._panel.nCurMode = 1
  self._panel.nCurInteractiveMode = 1
  NovaAPI.DispatchEventWithData("DormSwicthMode", nil, {1})
end

function DormCtrl:OnEvent_OperateMode()
  self._mapNode.rtInteractiveRoot:SetMode(0)
  self._panel.nCurMode = 0
  self._panel.nCurInteractiveMode = 0
  NovaAPI.DispatchEventWithData("DormSwicthMode", nil, {0})
end

function DormCtrl:OnEvent_NextRoom()
  local nCurRoom = self._panel.nCurRoom
  local mapRoomData = self._panel.mapDormRoomInfo
  self.gameObject:SetActive(false)
  EventManager.Hit(EventId.OpenPanel, PanelId.DormRoomSelectPanel, mapRoomData, nCurRoom, false)
end

function DormCtrl:OnEvent_DormLevelLoadComplete()
  self._mapNode.rtEditorRoot.gameObject:SetActive(self._panel.nCurMode == 2)
  self._mapNode.rtInteractiveRoot.gameObject:SetActive(self._panel.nCurMode == 0 or self._panel.nCurMode == 1)
  if self._panel.nCurMode == 0 or self._panel.nCurMode == 1 then
    self._panel.nCurInteractiveMode = self._panel.nCurMode
    self._mapNode.rtInteractiveRoot:SetMode(self._panel.nCurMode)
  end
  self.gameObject:SetActive(true)
  EventManager.Hit(EventId.SetTransition)
end

function DormCtrl:OnEvent_DormLevelFinish()
  NovaAPI.EnterModule("MainMenuModuleScene", true)
end

function DormCtrl:HotFixTestBtn(btn, idx)
  if idx == 1 then
    local tbTestRet = safe_call_cs_func(CS.DormModuleHelper_HotFix.TestGetDormData, 1)
    local str = ""
    for i = 0, 2 do
      str = str .. tbTestRet[i]
    end
    self._mapNode.TestHotFix.text = str
  elseif idx == 2 then
    local str = safe_call_cs_func(CS.DormModuleHelper_HotFix.TestGetDormData1, "test2")
    self._mapNode.TestHotFix.text = str
  else
    safe_call_cs_func(CS.DormModuleHelper_HotFix.TestGetDormData2, self._mapNode.TestHotFix.gameObject)
  end
end

function DormCtrl:OnEvent_SelectRoom()
  local nCurRoom = self._panel.nCurRoom
  local mapRoomData = self._panel.mapDormRoomInfo
  self.gameObject:SetActive(false)
  EventManager.Hit(EventId.OpenPanel, PanelId.DormRoomSelectPanel, mapRoomData, nCurRoom, true)
end

function DormCtrl:OnEvent_SwitchRoom()
  self:SwitchRoom(self.nSelectedRoomId)
  self.nSelectedRoomId = 0
end

function DormCtrl:OnEvent_ChangeRoomResult(bConfirm, nRoomId, bElevator)
  if bConfirm then
    self.nSelectedRoomId = nRoomId
  else
    self.gameObject:SetActive(true)
  end
  if bElevator then
    NovaAPI.DispatchEventWithData("DORM_LUA_SELECT_SCENE_CALLBACK", nil, {bConfirm})
  elseif bConfirm then
    self:OnEvent_SwitchRoom()
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
          table.insert(tbCharInRoom, mapRole.RoleId)
        end
      end
    end
    self._mapNode.CharListRoot:ShowList(tbCurSelectChar, false, 1, tbCharInRoom)
    self._mapNode.rtInteractiveRoot:RecycleAllInteractiveHudCtrl()
    NovaAPI.DispatchEventWithData("DormSwicthMode", nil, {4})
    self._mapNode.rtInteractiveRoot:SetShowBtns(false)
  end
end

function DormCtrl:OnEvent_DormCharSelectResult(tbCurChar, bConfirm)
  local function revertChar()
    local beforeChar = self._panel.mapDormRoomInfo[self._panel.nCurRoom].RoleList
    
    local tbBeforeCharId = {}
    for _, mapCharInfo in ipairs(beforeChar) do
      local nCharId = mapCharInfo.RoleId
      table.insert(tbBeforeCharId, tbBeforeCharId)
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
      self._panel.mapDormRoomInfo = ret
      self._mapNode.CharListRoot:CloseList()
      self._mapNode.rtInteractiveRoot:SetShowBtns(true)
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
    revertChar()
    self._mapNode.CharListRoot:CloseList()
    self._mapNode.rtInteractiveRoot:SetShowBtns(true)
    NovaAPI.DispatchEventWithData("DormSwicthMode", nil, {
      self._panel.nCurInteractiveMode
    })
  end
end

function DormCtrl:OnEvent_DormCharInteractive(tbCharId, callback)
  local tbCheck = {}
  for _, mapRoleInfo in ipairs(tbCharId) do
    if not PlayerData.PlayerDormData:CheckRoleInteraction(mapRoleInfo.RoleId) then
      table.insert(tbCheck, mapRoleInfo)
    end
  end
  if #tbCheck < 1 then
    if callback ~= nil and type(callback == "function") then
      callback()
    end
    return
  end
  
  local function netCallback(InfoList)
    local charStr = ""
    for _, mapInfo in ipairs(InfoList) do
      charStr = charStr .. string.format("角色进行了交互:%d,当前好感度经验为:%d 当前好感度等级为:%d\n", mapInfo.AffinityInfo.CharId, mapInfo.AffinityInfo.AffinityExp, mapInfo.AffinityInfo.AffinityLevel)
      if mapInfo.ItemInfo.Tid ~= 0 then
        charStr = charStr .. string.format("角色赠送了礼物:%d,数量为:%d\n", mapInfo.ItemInfo.Tid, mapInfo.ItemInfo.Qty)
      end
    end
    print(charStr)
    if callback ~= nil and type(callback == "function") then
      callback()
    end
  end
  
  PlayerData.PlayerDormData:DormRoleInteraction(tbCheck, netCallback)
end

function DormCtrl:OnEvent_DormCharGift(nRoomId, nCharId, tbGift, callback)
  if PlayerData.PlayerDormData:CheckRoleSendGift(nCharId) then
    print("该角色今天已被赠送过礼物")
    callback()
    return
  end
  
  local function netCallback(Info)
    local giftStr = ""
    for _, itemTpl in ipairs(tbGift) do
      giftStr = giftStr .. " " .. itemTpl.Tid
    end
    print(string.format("赠送了礼物:%s 当前好感度为：%d 当前好感度等级为:%d", giftStr, Info.AffinityExp, Info.AffinityLevel))
    if callback ~= nil and type(callback == "function") then
      callback()
    end
  end
  
  PlayerData.PlayerDormData:DormAffinityGiftSend(nRoomId, nCharId, tbGift, netCallback)
end

return DormCtrl
