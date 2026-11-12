local StarTowerMapCtrl = class("StarTowerMapCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
StarTowerMapCtrl._mapNodeConfig = {
  blurBg = {},
  sv = {
    sComponentName = "LoopScrollView",
    callback = "OnScrollRectValueChanged"
  },
  svGamepad = {
    sNodeName = "sv",
    sComponentName = "GamepadScroll"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  Title = {},
  txtTitle = {sComponentName = "TMP_Text"},
  txtdifficulty = {sComponentName = "TMP_Text"},
  btnTempLeave = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Leave"
  },
  btnBack = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Close"
  },
  btnGiveUp = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_GiveUp"
  },
  btnResetTop = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ResetUp"
  },
  btnResetBot = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_ResetDown"
  },
  btnPopSkill = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Skill"
  },
  btnSettings = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Settings"
  },
  goHorrorRoom = {},
  rtHorrorRoom = {
    sNodeName = "goHorrorRoom",
    sComponentName = "RectTransform"
  },
  goRankTime = {},
  txtBattleTimeCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Battle_Time"
  },
  txtBattleTimeSec = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Battle_Time_Sec"
  },
  txtBattleTime = {sComponentName = "TMP_Text"},
  txtBtnGiveup = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTowerMap_Btn_GiveUp"
  },
  txtBtnLeave = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTowerMap_Btn_Leave"
  },
  txtBtnSkill = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTowerMap_Btn_Skill"
  },
  ActionBar = {
    sCtrlName = "Game.UI.ActionBar.ActionBarCtrl"
  }
}
StarTowerMapCtrl._mapEventConfig = {
  OpenStarTowerMap = "OnEvent_OpenStarTowerMap",
  RefreshCheckGridStatus = "OnEvent_RefreshCheckGridStatus",
  StartClientRankTimer = "OnEvent_StartClientRankTimer",
  ResetClientRankTimer = "OnEvent_ResetClientRankTimer",
  GamepadUIChange = "OnEvent_GamepadUIChange"
}

function StarTowerMapCtrl:Refresh(tbStageInfo, nCurLayer, nStarTowerId, bHorrorRoom, nTime)
  self.nTime = nTime and nTime or 0
  self.bRank = nTime ~= nil
  if self.bRank then
    self._mapNode.goRankTime.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtBattleTime, nTime + self.nClientRankTime)
  else
    self._mapNode.goRankTime.gameObject:SetActive(false)
  end
  if nStarTowerId == 999 then
    self._mapNode.Title.gameObject:SetActive(false)
  else
    self._mapNode.Title.gameObject:SetActive(true)
    local mapStarTower = ConfigTable.GetData("StarTower", nStarTowerId)
    if mapStarTower ~= nil then
      NovaAPI.SetTMPText(self._mapNode.txtTitle, mapStarTower.Name)
      NovaAPI.SetTMPText(self._mapNode.txtdifficulty, ConfigTable.GetUIText("Diffculty_" .. tostring(mapStarTower.Difficulty)))
    else
      NovaAPI.SetTMPText(self._mapNode.txtTitle, "")
      NovaAPI.SetTMPText(self._mapNode.txtdifficulty, "")
    end
  end
  self.tbStageInfo = tbStageInfo
  self.curLayer = nCurLayer
  if self.curLayer == nil then
    return
  end
  if bHorrorRoom then
    self._mapNode.sv.gameObject:SetActive(false)
    self._mapNode.goHorrorRoom.gameObject:SetActive(true)
    self:ShowHorrorRoom()
  else
    self._mapNode.sv.gameObject:SetActive(true)
    self._mapNode.goHorrorRoom.gameObject:SetActive(false)
    self.nCurCount = #self.tbStageInfo
    self._mapNode.sv:Init(self.nCurCount, self, self.OnGridRefresh)
    self._mapNode.sv:SetCheckGirdIndex(self.nCurCount - self.curLayer)
    if self.curLayer <= 2 then
      self._mapNode.sv:SetScrollPos(0)
    elseif self.nCurCount - self.curLayer <= 4 then
      self._mapNode.sv:SetScrollPos(1)
    else
      self._mapNode.sv:SetScrollPos(1)
      local index = self.nCurCount - self.curLayer
      self._mapNode.sv:SetScrollGridPos(index, 0, 0)
    end
    self.nPos = self._mapNode.sv:GetScrollPos()
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      self.bVertical = self._mapNode.sv.vertical
      if not self.bVertical then
        self._mapNode.btnResetTop.gameObject:SetActive(false)
        for i = 1, 2 do
          self._mapNode.btnResetBot[i].gameObject:SetActive(false)
        end
      end
    end
    
    cs_coroutine.start(wait)
  end
end

function StarTowerMapCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  nIndex = self.nCurCount - nIndex + 1
  local mapData = self.tbStageInfo[nIndex]
  local roomType = mapData.RoomType
  local rtGrid = goGrid:GetComponent("RectTransform")
  NovaAPI.SetCanvasGroupAlpha(rtGrid:GetComponent("CanvasGroup"), 1)
  rtGrid:Find("L/Stair").gameObject:SetActive(nIndex ~= 1)
  rtGrid:Find("R/Stair").gameObject:SetActive(nIndex ~= 1)
  local Node
  if nIndex % 2 == 1 then
    Node = rtGrid:Find("L"):GetComponent("RectTransform")
    Node.gameObject:SetActive(true)
    rtGrid:Find("R").gameObject:SetActive(false)
  else
    Node = rtGrid:Find("R"):GetComponent("RectTransform")
    Node.gameObject:SetActive(true)
    rtGrid:Find("L").gameObject:SetActive(false)
  end
  if nIndex == self.curLayer then
    Node:GetComponent("RectTransform"):Find("MapNode").gameObject:SetActive(false)
    local CurMapNode = Node:Find("CurMapNode"):GetComponent("RectTransform")
    CurMapNode.gameObject:SetActive(true)
    local txtCurLevel = CurMapNode:Find("imgMapIconBg/txtLevelNum"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(txtCurLevel, orderedFormat(ConfigTable.GetUIText("StarTower_Level_Title_Layer") or "", tostring(nIndex) .. "/" .. tostring(self.nTotalLevel)))
    local txtCurLevelName = CurMapNode:Find("imgMapIconBg/txtLevelName"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(txtCurLevelName, ConfigTable.GetUIText(AllEnum.StarTowerRoomName[roomType].Language))
    local imgMapIcon = CurMapNode:Find("imgMapIconBg/imgMapIcon"):GetComponent("Image")
    self:SetAtlasSprite(imgMapIcon, "10_ico", AllEnum.StarTowerRoomName[roomType].Icon)
  else
    Node:GetComponent("RectTransform"):Find("CurMapNode").gameObject:SetActive(false)
    local MapNode = Node:Find("MapNode"):GetComponent("RectTransform")
    MapNode.gameObject:SetActive(true)
    local imgPlatform = MapNode:Find("imgPlatform"):GetComponent("Image")
    local imgMapIcon = MapNode:Find("imgMapIcon"):GetComponent("Image")
    local _, color = ColorUtility.TryParseHtmlString(AllEnum.StarTowerRoomName[roomType].Color)
    NovaAPI.SetImageColor(imgPlatform, color)
    self:SetAtlasSprite(imgMapIcon, "10_ico", AllEnum.StarTowerRoomName[roomType].Icon)
    local txtLevel = MapNode:Find("txtLevelNum"):GetComponent("Text")
    local txtLevelName = MapNode:Find("txtLevelName"):GetComponent("Text")
    if mapData.Floor ~= -1 and mapData.Stage ~= -1 then
      NovaAPI.SetText(txtLevel, tostring(mapData.Stage) .. "-" .. tostring(mapData.Floor))
      NovaAPI.SetTextColor(txtLevel, color)
      NovaAPI.SetText(txtLevelName, ConfigTable.GetUIText(AllEnum.StarTowerRoomName[roomType].Language))
      NovaAPI.SetTextColor(txtLevelName, color)
      if nIndex < self.curLayer then
        NovaAPI.SetCanvasGroupAlpha(rtGrid:GetComponent("CanvasGroup"), 0.5)
      end
    else
      NovaAPI.SetText(txtLevel, "")
      NovaAPI.SetText(txtLevelName, "")
    end
  end
end

function StarTowerMapCtrl:ShowHorrorRoom()
  self._mapNode.goHorrorRoom.gameObject:SetActive(true)
  local MapNode = self._mapNode.rtHorrorRoom:Find("CurMapNode"):GetComponent("RectTransform")
  local imgPlatform = MapNode:Find("imgPlatform"):GetComponent("Image")
  local imgMapIcon = MapNode:Find("imgMapIconBg/imgMapIcon"):GetComponent("Image")
  self:SetAtlasSprite(imgMapIcon, "10_ico", AllEnum.StarTowerRoomName[GameEnum.starTowerRoomType.HorrorRoom].Icon)
  local txtLevel = MapNode:Find("imgMapIconBg/txtLevelNum"):GetComponent("TMP_Text")
  local txtLevelName = MapNode:Find("imgMapIconBg/txtLevelName"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtLevel, ConfigTable.GetUIText("StarTower_HorrorRoom_Layer"))
  NovaAPI.SetTMPText(txtLevelName, ConfigTable.GetUIText("StarTower_Enter_HorrorRoomName"))
end

function StarTowerMapCtrl:RefreshBottomBtn()
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType == AllEnum.GamepadUIType.Other then
    self.nBottomIndex = 1
  else
    self.nBottomIndex = 2
  end
  self:OnScrollRectValueChanged()
end

function StarTowerMapCtrl:Awake()
  self.nTime = 0
  self.nClientRankTime = 0
  self.nPos = 0
  self._mapNode.safeAreaRoot:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
  self.nBottomIndex = 1
  local tbConfig = {
    {
      sAction = "Back",
      sLang = "ActionBar_Back"
    },
    {
      sAction = "Giveup",
      sLang = "ActionBar_GiveUp"
    },
    {
      sAction = "Leave",
      sLang = "ActionBar_Leave"
    },
    {
      sAction = "Skill",
      sLang = "ActionBar_Skill"
    },
    {
      sAction = "Settings",
      sLang = "ActionBar_Settings"
    }
  }
  self._mapNode.ActionBar:InitActionBar(tbConfig)
end

function StarTowerMapCtrl:OnEnable()
  self.tbStageInfo = nil
end

function StarTowerMapCtrl:OnDisable()
end

function StarTowerMapCtrl:OnDestroy()
end

function StarTowerMapCtrl:OnEvent_OpenStarTowerMap(tbStageInfo, nCurLayer, nStarTowerId, tbChar, bHorrorRoom, nTime, mapCharData, nTotalLevel)
  PanelManager.InputDisable()
  EventManager.Hit("StarTowerSetButtonEnable", false, false)
  GamepadUIManager.EnableGamepadUI("StarTowerMapCtrl", self.tbGamepadUINode)
  self.tbChar = tbChar
  self.mapCharData = mapCharData
  self.nTotalLevel = nTotalLevel
  self._mapNode.blurBg:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.safeAreaRoot:SetActive(true)
    self:Refresh(tbStageInfo, nCurLayer, nStarTowerId, bHorrorRoom, nTime)
    self:RefreshBottomBtn()
  end
  
  cs_coroutine.start(wait)
end

function StarTowerMapCtrl:OnEvent_RefreshCheckGridStatus(nStatus)
  self.nStatus = nStatus
end

function StarTowerMapCtrl:OnBtnClick_Close(btn)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, "OnPanelClose", true, true, true, false)
  EventManager.Hit(EventId.BattleDashboardVisible, true)
end

function StarTowerMapCtrl:OnBtnClick_Leave(btn)
  EventManager.Hit(EventId.StarTowerLeave)
end

function StarTowerMapCtrl:OnPanelClose(_, bGiveUp)
  PanelManager.InputEnable()
  EventManager.Hit("StarTowerSetButtonEnable", true, true)
  GamepadUIManager.DisableGamepadUI("StarTowerMapCtrl")
  self._mapNode.safeAreaRoot:SetActive(false)
  self._mapNode.blurBg:SetActive(false)
  if bGiveUp then
    EventManager.Hit("AbandonStarTower")
  end
end

function StarTowerMapCtrl:OnBtnClick_GiveUp(btn)
  local sContent
  if self.bRank then
    sContent = ConfigTable.GetUIText("StarTower_Ranking_Abandon_Tip")
  else
    sContent = ConfigTable.GetUIText("StarTower_Pause_Tips")
  end
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = sContent or "",
    callbackConfirm = function()
      EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
      self:AddTimer(1, 0.2, "OnPanelClose", true, true, true, true)
    end
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function StarTowerMapCtrl:OnBtnClick_ResetUp(btn)
  self._mapNode.sv:SetScrollPos(1, 0.8)
end

function StarTowerMapCtrl:OnBtnClick_ResetDown(btn)
  if self.nStatus == 1 then
    self._mapNode.sv:SetScrollPos(self.nPos, 0.8)
  end
end

function StarTowerMapCtrl:OnBtnClick_Skill(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.PopupSkillPanel, self.tbChar, false, {}, self.mapCharData)
end

function StarTowerMapCtrl:OnBtnClick_Settings(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleSettings)
end

function StarTowerMapCtrl:OnScrollRectValueChanged()
  if self.bVertical == nil then
    return
  end
  local nPos = self._mapNode.sv.verticalNormalizedPosition
  self._mapNode.btnResetTop.gameObject:SetActive(nPos < 0.99 and self.bVertical)
  for i = 1, 2 do
    if i == self.nBottomIndex then
      self._mapNode.btnResetBot[i].gameObject:SetActive(nPos > self.nPos and self.bVertical)
    else
      self._mapNode.btnResetBot[i].gameObject:SetActive(false)
    end
  end
end

function StarTowerMapCtrl:OnEvent_StartClientRankTimer()
  if nil == self.rankTimer then
    self.rankTimer = self:AddTimer(0, 1, function()
      self.nClientRankTime = self.nClientRankTime + 1
      NovaAPI.SetTMPText(self._mapNode.txtBattleTime, self.nTime + self.nClientRankTime)
    end, true, true, true)
  end
end

function StarTowerMapCtrl:OnEvent_ResetClientRankTimer()
  if nil ~= self.rankTimer then
    self.rankTimer:Cancel()
  end
  self.rankTimer = nil
  self.nClientRankTime = 0
end

function StarTowerMapCtrl:OnEvent_GamepadUIChange(sName, nBeforeType, nAfterType)
  self:RefreshBottomBtn()
end

return StarTowerMapCtrl
