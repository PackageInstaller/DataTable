local DormInteractiveCtrl = class("DormInteractiveCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local totalLength = 292
local totalHeight = 37
DormInteractiveCtrl._mapNodeConfig = {
  rtObserve = {},
  rtOperate = {},
  rtInteractiveBtn = {},
  rtListHideRoot = {},
  rtInteractiveHide = {},
  rtDormName = {},
  rtGiftHint = {},
  btnRewardHint = {
    sComponentName = "UIButton",
    sNodeName = "rtGiftHint",
    callback = "OnBtnClick_ReceiveDormReward"
  },
  btnHideUI = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_HideUI"
  },
  btnPrintScreen = {sComponentName = "UIButton"},
  btnPhone = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Phone"
  },
  btnInteractive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_FastInteractive"
  },
  btnEditor = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_EditMode"
  },
  btnOperate = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Operate"
  },
  btnObserve = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Observe"
  },
  btnCharacter = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Character"
  },
  btnVisit = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Visit"
  },
  btnElevator = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Elevator"
  },
  txtnum = {
    sComponentName = "TMP_Text",
    sLanguage = "DormBtn_InteractiveMode"
  },
  TMPDormName = {sComponentName = "TMP_Text"},
  rtHudPool = {},
  rtHud = {},
  goCharHud = {
    sNodeName = "goFurnitureHud"
  },
  goCharHudRoot = {},
  txtBtnOperate = {
    sComponentName = "TMP_Text",
    sLanguageId = "DormBtn_ViewMode"
  },
  txtBtnObserve = {
    sComponentName = "TMP_Text",
    sLanguageId = "DormBtn_BossMode"
  },
  txtBtnEditor = {
    sComponentName = "TMP_Text",
    sLanguageId = "DormBtn_Edior"
  },
  txtBtnCharacter = {
    sComponentName = "TMP_Text",
    sLanguageId = "DormBtn_Role"
  },
  txtBtnVisit = {
    sComponentName = "TMP_Text",
    sLanguageId = "DormBtn_Visit"
  },
  txtBtnElevator = {
    sComponentName = "TMP_Text",
    sLanguageId = "DormBtn_Elevator"
  },
  txtGiftHint = {
    sComponentName = "TMP_Text",
    sLanguageId = "DormReward_FastReceive"
  },
  rtCharHint = {},
  goJoystick = {
    sNodeName = "--joystick--"
  },
  rtContact = {
    sCtrlName = "Game.UI.Dorm.DormContact.DormContactBtnListCtrl"
  },
  cgBtnInteractive = {
    sComponentName = "CanvasGroup"
  },
  rtQuest = {},
  TMPTitleQuest = {
    sComponentName = "TMP_Text",
    sLanguageId = "DormQuest_Title"
  },
  TMPDescQuest = {sComponentName = "TMP_Text"},
  TMPProcess = {sComponentName = "TMP_Text"},
  rtBarFill = {
    sComponentName = "RectTransform"
  },
  goRedDotQuest = {},
  btnQuestInteractiveSide = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Quest"
  },
  goRedDotElevator = {},
  goRedDotMainMenu = {}
}
DormInteractiveCtrl._mapEventConfig = {
  ACTIVE_DORM_INTERACTIVE_HUD = "OnEvent_ActiveHud",
  DEACTIVE_DORM_INTERACTIVE_HUD = "OnEvent_DeactiveHud",
  DORM_CS2LUA_CLOSE_INTERACTIVE_ICON = "OnEvent_CloseContactHud",
  DormShowInteractiveBtns = "OnEvent_DormShowInteractiveBtns",
  DORM_CS2LUA_ENTER_CHAR_ACTIVE = "OnEvent_DormEnterActive",
  FurnitureFunctionBtnClick = "OnEvent_FurnitureFunctionBtnClick",
  [EventId.QuestDataRefresh] = "OnEvent_QuestRefresh",
  DormNameUpdate = "OnEvent_DormNameUpdate",
  DormRoleInteraction = "OnEvent_DormRoleInteraction"
}
DormInteractiveCtrl._mapRedDotConfig = {
  [RedDotDefine.DormElevator] = {
    sNodeName = "goRedDotElevator"
  },
  [RedDotDefine.DormMainMenu] = {
    sNodeName = "goRedDotMainMenu"
  }
}

function DormInteractiveCtrl:Awake()
  self.mapHudCtrls = {}
  self.tbHudPool = {}
end

function DormInteractiveCtrl:FadeIn()
end

function DormInteractiveCtrl:FadeOut()
end

function DormInteractiveCtrl:OnEnable()
  self.gameObject:SetActive(true)
  self._mapNode.rtCharHint:SetActive(false)
  if NovaAPI.GetCurrentModuleName() == "DormModuleScene" then
    NovaAPI.DispatchEventWithData("DormJoystickPrefabLoadComplete")
  end
  self:SetCharCount()
  local tbRewardIds = self._panel:GetDormRewardId()
  local DormGuideUI = require("Game.UI.Dorm.DormGuideUI")
  local bGift = false
  if self._panel ~= nil and type(self._panel.GetDormRewardId) == "function" then
    local tbIds = self._panel:GetDormRewardId()
    bGift = tbIds ~= nil and 0 < #tbIds
  end
  local bExcept = DormGuideUI._mapShowExcept ~= nil and DormGuideUI._mapShowExcept.rtGiftHint == true
  if DormGuideUI.IsLeaveLocked() and not bExcept then
    self._mapNode.rtGiftHint:SetActive(false)
    if self._mapNode.rtGiftNumHint ~= nil then
      self._mapNode.rtGiftNumHint:SetActive(false)
    end
    if self._mapNode.rtDormName ~= nil then
      self._mapNode.rtDormName:SetActive(false)
    end
  else
    self._mapNode.rtGiftHint:SetActive(0 < #tbRewardIds)
  end
end

function DormInteractiveCtrl:OnDisable()
  self:ClearAllInteractiveHudCtrl()
end

function DormInteractiveCtrl:OnDestroy()
  self:RemoveAllHUD()
end

function DormInteractiveCtrl:OnRelease()
end

function DormInteractiveCtrl:RemoveAllHUD()
  for _, mapCtrl in pairs(self.mapHudCtrls) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self.mapHudCtrls = {}
  for _, mapCtrl in ipairs(self.tbHudPool) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self.tbHudPool = {}
end

function DormInteractiveCtrl:SetRoom(nRoomId)
  local mapRoomConfig = ConfigTable.GetData("DormRoom", nRoomId)
  if mapRoomConfig == nil then
    return
  end
  local sDormName = self._panel.mapDormRoomInfo[self._panel.nCurRoom].RoomName
  if sDormName == nil or sDormName == "" then
    sDormName = mapRoomConfig.DefaultName
  end
  NovaAPI.SetTMPText(self._mapNode.TMPDormName, sDormName)
  self:SetFastInteractiveBtn()
end

function DormInteractiveCtrl:SetMode(nState)
  self.nCurState = nState
  self._mapNode.rtObserve:SetActive(nState == 1)
  self._mapNode.rtOperate:SetActive(nState == 0)
  self._mapNode.btnOperate.gameObject:SetActive(nState == 1)
  self._mapNode.btnObserve.gameObject:SetActive(nState == 0)
  if nState == 1 then
    self._mapNode.rtContact:RemoveAllInteractiveBtn()
    self:InitFurnitureBtns()
  else
    self:RecycleAllInteractiveHudCtrl()
  end
end

function DormInteractiveCtrl:RegisterVirtualJoystick()
  NovaAPI.UnRegisterVirtualJoystick("Horizontal", "Vertical")
  NovaAPI.RegisterVirtualJoystick("Horizontal", "Vertical", self._mapNode.goJoystick)
end

function DormInteractiveCtrl:GetInteractiveHudCtrl()
  if #self.tbHudPool == 0 then
    local goHud = instantiate(self._mapNode.goCharHud, self._mapNode.rtHud.transform)
    local mapCtrl = self:BindCtrlByNode(goHud, "Game.UI.Dorm.DormInteractive.InteractiveHUDCtrl")
    mapCtrl.gameObject:SetActive(true)
    return mapCtrl
  else
    local mapCtrl = table.remove(self.tbHudPool, 1)
    mapCtrl.gameObject.transform:SetParent(self._mapNode.rtHud.transform)
    mapCtrl.gameObject:SetActive(true)
    return mapCtrl
  end
end

function DormInteractiveCtrl:RecycleInteractiveHudCtrl(nUid)
  local mapCtrl = self.mapHudCtrls[nUid]
  if mapCtrl == nil then
    return
  end
  self.mapHudCtrls[nUid] = nil
  mapCtrl:Hide()
  mapCtrl.gameObject.transform:SetParent(self._mapNode.rtHudPool.transform)
  mapCtrl.gameObject:SetActive(false)
  table.insert(self.tbHudPool, mapCtrl)
end

function DormInteractiveCtrl:RecycleAllInteractiveHudCtrl()
  local tbUids = {}
  for nUid, _ in pairs(self.mapHudCtrls) do
    table.insert(tbUids, nUid)
  end
  for _, nUid in ipairs(tbUids) do
    self:RecycleInteractiveHudCtrl(nUid)
  end
end

function DormInteractiveCtrl:ClearAllInteractiveHudCtrl()
  self:RecycleAllInteractiveHudCtrl()
  for _, mapCtrl in ipairs(self.tbHudPool) do
    local go = mapCtrl.gameObject
    self:UnbindCtrlByNode(mapCtrl)
    destroyImmediate(go)
  end
  self.tbHudPool = {}
end

function DormInteractiveCtrl:InitFurnitureBtns()
  self:RecycleAllInteractiveHudCtrl()
  local mapData = self._panel.mapDormRoomInfo[self._panel.nCurRoom]
  local tbFurnitureList = mapData.FurnitureList
  local mapAddedFurniture = {}
  for _, mapFurniture in ipairs(tbFurnitureList) do
    local mapFurnitureCfgData = ConfigTable.GetData("DormFurniture", mapFurniture.FurnitureId)
    if mapFurnitureCfgData ~= nil then
      local bHasReward = false
      if #mapFurnitureCfgData.ProduceItemId > 0 and mapAddedFurniture[mapFurniture.FurnitureId] == nil then
        for _, nRewardId in ipairs(mapFurnitureCfgData.ProduceItemId) do
          if PlayerData.PlayerDormData:CheckHasRewardById(nRewardId) then
            bHasReward = true
            break
          end
        end
      end
      if bHasReward or 0 < mapFurnitureCfgData.Function then
        local tbEntityId, tbTransform = safe_call_cs_func2(CS.DormModuleHelper_HotFix.GetFur_EntityId_RootBubbleTrans, mapFurniture.FurnitureId)
        if tbEntityId ~= nil and tbTransform ~= nil then
          local nCount = tbEntityId.Length
          for i = 0, nCount - 1 do
            local nUid = tbEntityId[i]
            local rtItemTransform = tbTransform[i]
            if self.mapHudCtrls[nUid] ~= nil then
              return
            end
            local mapCtrl = self:GetInteractiveHudCtrl()
            self.mapHudCtrls[nUid] = mapCtrl
            mapCtrl:Show(nUid, rtItemTransform, mapFurniture.FurnitureId, mapFurnitureCfgData.BubbleIcon)
          end
          mapAddedFurniture[mapFurniture.FurnitureId] = nCount
        end
      end
    end
  end
end

function DormInteractiveCtrl:CheckRewardFurnitureHuds()
  local removedHud = {}
  for nUid, mapCtrl in pairs(self.mapHudCtrls) do
    local nFurnitureId = mapCtrl.nFurId
    local mapTempFurnitureCfgData = ConfigTable.GetData("DormFurniture", nFurnitureId)
    local bShow = false
    if mapTempFurnitureCfgData ~= nil then
      if mapTempFurnitureCfgData.Function > 0 then
        bShow = true
      else
        for _, nRewardId in ipairs(mapTempFurnitureCfgData.ProduceItemId) do
          if PlayerData.PlayerDormData:CheckHasRewardById(nRewardId) then
            bShow = true
            break
          end
        end
      end
    end
    if not bShow then
      table.insert(removedHud, nUid)
    end
  end
  for _, nUid in ipairs(removedHud) do
    self:RecycleInteractiveHudCtrl(nUid)
  end
end

function DormInteractiveCtrl:SetShowBtns(bShow)
  local DormGuideUI = require("Game.UI.Dorm.DormGuideUI")
  DormGuideUI._bBusinessShowBtns = bShow
  if DormGuideUI._bHideChrome then
    self._mapNode.rtListHideRoot:SetActive(true)
    DormGuideUI._ApplyChrome(true)
    return
  end
  self._mapNode.rtListHideRoot:SetActive(bShow)
end

function DormInteractiveCtrl:SetCharCount()
  local mapRoomInfo = self._panel.mapDormRoomInfo[self._panel.nCurRoom]
  local mapDormRoomCfgData = ConfigTable.GetData("DormRoom", self._panel.nCurRoom)
  local maxCharCount = 0
  if mapDormRoomCfgData ~= nil then
    maxCharCount = mapDormRoomCfgData.RoleNum
  end
  if mapRoomInfo ~= nil then
    local tbRoleList = mapRoomInfo.RoleList
    NovaAPI.SetTMPText(self._mapNode.txtnum, string.format("%d/%d", #tbRoleList, maxCharCount))
  else
    NovaAPI.SetTMPText(self._mapNode.txtnum, string.format("%d/%d", 0, maxCharCount))
  end
end

function DormInteractiveCtrl:SetFastInteractiveBtn()
  local bEnable = true
  local nDayCount = PlayerData.PlayerDormData:GetRoleInteractionDayCount()
  if nDayCount < 1 then
    bEnable = false
  end
  if not bEnable then
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgBtnInteractive, 0.5)
    return
  end
  local nActiveChar = 0
  for nRoomId, mapRoomData in pairs(self._panel.mapDormRoomInfo) do
    for _, mapRoleInfo in ipairs(mapRoomData.RoleList) do
      if not PlayerData.PlayerDormData:CheckRoleInteraction(mapRoleInfo.RoleId) then
        nActiveChar = nActiveChar + 1
      end
    end
  end
  if nActiveChar < 1 then
    bEnable = false
  end
  if not bEnable then
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgBtnInteractive, 0.5)
  else
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgBtnInteractive, 1)
  end
end

function DormInteractiveCtrl:SetQuestInfo()
  local nCurGroup, nGroupState, tbQuestOri = PlayerData.PlayerDormData:GetDormQuestDataWithGroup()
  if tbQuestOri == nil then
    self._mapNode.rtQuest:SetActive(false)
    self.curShowQuestData = nil
    return
  end
  local tbQuest = {}
  for _, value in ipairs(tbQuestOri) do
    if value.nStatus < 2 then
      table.insert(tbQuest, value)
    end
  end
  if #tbQuest == 0 then
    if nGroupState == 1 then
      self._mapNode.rtQuest:SetActive(false)
      self.curShowQuestData = nil
    else
      self.curShowQuestData = {nStatus = 0, nCurProgress = 0}
      local nTotalCount = 0
      local nCurCount = 0
      if tbQuestOri ~= nil then
        for _, v in ipairs(tbQuestOri) do
          nTotalCount = nTotalCount + 1
          if v.nStatus == 2 then
            nCurCount = nCurCount + 1
          end
        end
      end
      self._mapNode.goRedDotQuest:SetActive(nTotalCount <= nCurCount)
      NovaAPI.SetTMPText(self._mapNode.TMPDescQuest, ConfigTable.GetUIText("Dorm_Interactive_GroupTitle"))
      NovaAPI.SetTMPText(self._mapNode.TMPProcess, string.format("%d/%d", nCurCount, nTotalCount))
      self._mapNode.rtBarFill.sizeDelta = Vector2(nCurCount / nTotalCount * totalLength, totalHeight)
    end
    return
  end
  local statusOrder = {
    [0] = 1,
    [1] = 2,
    [2] = 0
  }
  
  local function sort(a, b)
    if a.nStatus ~= b.nStatus then
      return statusOrder[a.nStatus] > statusOrder[b.nStatus]
    end
    return a.nTid < b.nTid
  end
  
  table.sort(tbQuest, sort)
  local mapQuest = tbQuest[1]
  local mapQuestCfgData = ConfigTable.GetData("DormQuest", mapQuest.nTid)
  if mapQuestCfgData ~= nil then
    self.curShowQuestData = clone(mapQuest)
    self._mapNode.rtQuest:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.TMPDescQuest, mapQuestCfgData.Title)
    NovaAPI.SetTMPText(self._mapNode.TMPProcess, string.format("%d/%d", mapQuest.nCurProgress, mapQuest.nGoal))
    self._mapNode.rtBarFill.sizeDelta = Vector2(mapQuest.nCurProgress / mapQuest.nGoal * totalLength, totalHeight)
  else
    self._mapNode.rtQuest:SetActive(false)
    self.curShowQuestData = nil
    return
  end
  self._mapNode.goRedDotQuest:SetActive(mapQuest.nStatus == 1)
end

function DormInteractiveCtrl:OnEvent_QuestRefresh(sType)
  if sType ~= "Dorm" then
    return
  end
  self:SetQuestInfo()
end

function DormInteractiveCtrl:OnBtnClick_Quest(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.DormQuestPanel)
end

function DormInteractiveCtrl:OnEvent_ActiveHud(rtTransform, nType, nDataId, nEntityId, canInteract)
  if self._panel.nCurMode == 3 then
    return
  end
  if nType == 0 then
    self._mapNode.rtContact:AddInteractiveBtn(rtTransform, nType, nDataId, nEntityId)
  else
    if canInteract then
      self._mapNode.rtContact:AddInteractiveBtn(rtTransform, nType, nDataId, nEntityId)
    end
    local mapFurnitureCfgData = ConfigTable.GetData("DormFurniture", nDataId)
    if mapFurnitureCfgData ~= nil then
      local bHasReward = false
      if 0 < #mapFurnitureCfgData.ProduceItemId then
        for _, nRewardId in ipairs(mapFurnitureCfgData.ProduceItemId) do
          if PlayerData.PlayerDormData:CheckHasRewardById(nRewardId) then
            bHasReward = true
            break
          end
        end
      end
      if 0 < mapFurnitureCfgData.Function then
        self._mapNode.rtContact:AddInteractiveBtn(rtTransform, 3, nDataId, nEntityId)
      elseif bHasReward then
        self._mapNode.rtContact:AddInteractiveBtn(rtTransform, 4, nDataId, nEntityId)
      end
    end
  end
end

function DormInteractiveCtrl:OnEvent_DeactiveHud(nEntityId, nType)
  if self._panel.nCurMode == 3 then
    return
  end
  self._mapNode.rtContact:RemoveInteractiveBtn(nEntityId)
end

function DormInteractiveCtrl:OnEvent_DormEnterActive(rtTransform, nType, nDataId, nEntityId)
  WwiseAudioMgr:PostEvent("Home_UI_char_point")
  self._mapNode.rtContact:EnterCharActiveViewMode(rtTransform, nType, nDataId, nEntityId)
end

function DormInteractiveCtrl:OnEvent_DormShowInteractiveBtns(bShow)
  if bShow then
    local DormGuideUI = require("Game.UI.Dorm.DormGuideUI")
    if DormGuideUI._bHideChrome then
      return
    end
  end
  self._mapNode.rtInteractiveHide:SetActive(bShow)
end

function DormInteractiveCtrl:OnEvent_FurnitureFunctionBtnClick(nUid, nFurId)
  local mapFurnitureCfgData = ConfigTable.GetData("DormFurniture", nFurId)
  if mapFurnitureCfgData ~= nil then
    local tbRewardIds = mapFurnitureCfgData.ProduceItemId
    if 0 < #tbRewardIds then
      local function callback(changeInfo, tbRewardIds)
        if self._panel.mapDormBaseData ~= nil then
          self._panel.mapDormBaseData.rewardIds = tbRewardIds
        end
        local afterIds = self._panel:GetDormRewardId()
        self._mapNode.rtGiftHint:SetActive(0 < #afterIds)
        self._mapNode.rtContact:RemoveRewardHud(nUid, nFurId)
        self:CheckRewardFurnitureHuds()
        UTILS.OpenReceiveByChangeInfo(changeInfo)
      end
      
      PlayerData.PlayerDormData:DormRewardReceive(tbRewardIds, callback)
    elseif mapFurnitureCfgData.Function > 0 then
      if mapFurnitureCfgData.Function == 1 then
        PlayerData.Phone:OpenPhonePanel()
      elseif mapFurnitureCfgData.Function == 2 then
        local function callback()
          PanelManager.SetMainViewSkipAnimIn(false)
          
          local function func()
            EventManager.Hit(EventId.OpenPanel, PanelId.Crafting)
          end
          
          EventManager.Hit(EventId.SetTransition, 5, func)
        end
        
        PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.Crafting, callback)
      elseif mapFurnitureCfgData.Function == 3 then
        local mapDormInfo = clone(self._panel.mapDormRoomInfo)
        local tbDormInfo = {}
        for _, mapDormInfo in pairs(mapDormInfo) do
          table.insert(tbDormInfo, mapDormInfo)
        end
        
        local function sort(a, b)
          return a.DormRoomId < b.DormRoomId
        end
        
        table.sort(tbDormInfo, sort)
        local nCurRoom = self._panel.nCurRoom
        local nIdx = 1
        for index, mapRoomInfo in ipairs(tbDormInfo) do
          if nCurRoom == mapRoomInfo.DormRoomId then
            nIdx = index
          end
        end
        EventManager.Hit(EventId.OpenPanel, PanelId.DormMusicSelectPanel, nIdx, tbDormInfo)
      end
    end
  end
end

function DormInteractiveCtrl:OnEvent_DormNameUpdate(nRoomId, sName)
  if nRoomId == self._panel.nCurRoom then
    self._panel.mapDormRoomInfo[self._panel.nCurRoom].RoomName = sName
    if sName == nil or sName == "" then
      local mapRoomConfig = ConfigTable.GetData("DormRoom", self._panel.nCurRoom)
      if mapRoomConfig ~= nil then
        sName = mapRoomConfig.DefaultName
      end
    end
    NovaAPI.SetTMPText(self._mapNode.TMPDormName, sName)
  end
end

function DormInteractiveCtrl:OnEvent_DormRoleInteraction()
  self:SetFastInteractiveBtn()
end

function DormInteractiveCtrl:OnBtnClick_Operate()
  WwiseAudioMgr:PostEvent("ui_home_swicthMode_setstate_mowang")
  EventManager.Hit("DormPanel_BtnClickOperate")
end

function DormInteractiveCtrl:OnBtnClick_Observe()
  WwiseAudioMgr:PostEvent("ui_home_swicthMode_setstate_normal")
  EventManager.Hit("DormPanel_BtnClickObserve")
end

function DormInteractiveCtrl:OnBtnClick_EditMode()
  EventManager.Hit("DormPanel_BtnClickEdit")
end

function DormInteractiveCtrl:OnBtnClick_Character()
  EventManager.Hit("DormPanel_OpenSelectChar")
end

function DormInteractiveCtrl:OnBtnClick_Visit()
  EventManager.Hit(EventId.OpenPanel, PanelId.DormFriendPanel)
end

function DormInteractiveCtrl:OnBtnClick_Elevator()
  self:RecycleAllInteractiveHudCtrl()
  EventManager.Hit("DormPanel_NextRoom")
end

function DormInteractiveCtrl:OnBtnClick_ReceiveDormReward()
  local tbRewardIds = self._panel:GetDormRewardId()
  local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
  if #tbRewardIds < 1 then
    self._mapNode.rtGiftHint:SetActive(false)
    DormGuideAdapter.NoteQuest(nil, false)
    return
  end
  
  local function callback(changeInfo, tbRewardIds)
    if self._panel.mapDormBaseData ~= nil then
      self._panel.mapDormBaseData.rewardIds = tbRewardIds
    end
    local afterIds = self._panel:GetDormRewardId()
    self._mapNode.rtGiftHint:SetActive(0 < #afterIds)
    self:CheckRewardFurnitureHuds()
    UTILS.OpenReceiveByChangeInfo(changeInfo)
    DormGuideAdapter.NoteQuest(nil, true)
  end
  
  PlayerData.PlayerDormData:DormRewardReceive(tbRewardIds, callback)
end

function DormInteractiveCtrl:OnEvent_CloseContactHud()
  self._mapNode.rtContact:ExitCharActive()
end

function DormInteractiveCtrl:OnBtnClick_FastInteractive(btn)
  local nDayCount = PlayerData.PlayerDormData:GetRoleInteractionDayCount()
  if nDayCount < 1 then
    local sTip = ConfigTable.GetUIText("Dorm_Interaction_DayLimitHint")
    EventManager.Hit(EventId.OpenMessageBox, sTip)
    return
  end
  local tbInteractiveChar = {}
  for nRoomId, mapRoomData in pairs(self._panel.mapDormRoomInfo) do
    for _, mapRoleInfo in ipairs(mapRoomData.RoleList) do
      if not PlayerData.PlayerDormData:CheckRoleInteraction(mapRoleInfo.RoleId) then
        table.insert(tbInteractiveChar, {
          DormRoomId = nRoomId,
          RoleId = mapRoleInfo.RoleId
        })
      end
    end
  end
  local tbFinalChar
  if nDayCount >= #tbInteractiveChar then
    tbFinalChar = tbInteractiveChar
  else
    tbFinalChar = {}
    for i = 1, nDayCount do
      local randomIdx = math.random(#tbInteractiveChar)
      local mapChar = table.remove(tbInteractiveChar, randomIdx)
      table.insert(tbFinalChar, mapChar)
    end
  end
  
  local function NetCallback(tbInfo, mapChange)
    if tbInfo ~= nil and 0 < #tbInfo then
      local function ShowCallback()
        local tbAffinityShowData = {}
        
        for _, mapAffinityData in ipairs(tbInfo) do
          if mapAffinityData.AffinityInfo.AffinityLevel ~= mapAffinityData.AffinityInfo.nBeforeLevel then
            table.insert(tbAffinityShowData, {
              charID = mapAffinityData.AffinityInfo.CharId,
              curLevel = mapAffinityData.AffinityInfo.AffinityLevel,
              lastLevel = mapAffinityData.AffinityInfo.nBeforeLevel,
              curExp = mapAffinityData.AffinityInfo.AffinityExp,
              lastExp = mapAffinityData.AffinityInfo.nBeforeExp
            })
          end
        end
        if 0 < #tbAffinityShowData then
          EventManager.Hit(EventId.OpenPanel, PanelId.CharFavourLevelUp, tbAffinityShowData)
        end
      end
      
      EventManager.Hit(EventId.OpenPanel, PanelId.DormInteractiveAffinityPanel, tbInfo, ShowCallback)
    end
  end
  
  if tbFinalChar ~= nil and 0 < #tbFinalChar then
    PlayerData.PlayerDormData:DormRoleInteraction(tbFinalChar, NetCallback)
  else
    local sTip = ConfigTable.GetUIText("Dorm_Interaction_NoCharHint")
    EventManager.Hit(EventId.OpenMessageBox, sTip)
  end
end

function DormInteractiveCtrl:OnBtnClick_Phone()
  EventManager.Hit(EventId.OpenPanel, PanelId.DormMainMenuPanel, self._panel.nCurRoom)
end

function DormInteractiveCtrl:OnBtnClick_HideUI()
  EventManager.Hit("Dorm_HideUI")
end

return DormInteractiveCtrl
