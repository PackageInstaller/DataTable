local CoinItemId = AllEnum.CoinItemId
local TopBarCtrl = class("TopBarCtrl", BaseCtrl)
TopBarCtrl._mapNodeConfig = {
  CanvasGroup = {
    sNodeName = "Area",
    sComponentName = "CanvasGroup"
  },
  cgBack = {sNodeName = "goBack"},
  btnBack = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Back"
  },
  txtTitle = {nCount = 2, sComponentName = "TMP_Text"},
  btnHelp = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Help"
  },
  goEnergy = {
    sCtrlName = "Game.UI.TemplateEx.TemplateTopEnergyCtrl"
  },
  cgEnergy = {
    sNodeName = "goEnergy",
    sComponentName = "CanvasGroup"
  },
  goResBar = {},
  cgResBar = {
    sNodeName = "goResBar",
    sComponentName = "CanvasGroup"
  },
  goCoinGold = {
    sCtrlName = "Game.UI.TemplateEx.TemplateCoinCtrl"
  },
  goCoinOther = {
    sCtrlName = "Game.UI.TemplateEx.TemplateCoinCtrl"
  },
  goCoin = {
    nCount = 4,
    sCtrlName = "Game.UI.TemplateEx.TemplateCoinCtrl"
  },
  btnCoin = {
    nCount = 4,
    sNodeName = "goCoin",
    sComponentName = "UIButton",
    callback = "OnBtnClick_CoinTips"
  },
  btnCoinGold = {
    sNodeName = "goCoinGold",
    sComponentName = "UIButton",
    callback = "OnBtnClick_CoinFirstTips"
  },
  btnCoinOther = {
    sNodeName = "goCoinOther",
    sComponentName = "UIButton",
    callback = "OnBtnClick_CoinFirstTips"
  },
  btnAdd = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_AddCoin"
  },
  btnAddFirst = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AddCoinFirst"
  },
  btnRoot = {nCount = 4},
  btnRootFirst = {},
  btnHome = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Home"
  }
}
TopBarCtrl._mapEventConfig = {
  [EventId.CoinResChange] = "OnEvent_CoinResChange",
  [EventId.SetTopBarVisible] = "OnEvent_SetVisible",
  [EventId.SetCoinVisible] = "SetCoinVisible",
  [EventId.SetEnergyVisible] = "SetEnergyVisible",
  TopRes = "OnEvent_TopRes"
}
local tbShowCoinAdd = {
  [CoinItemId.Jade] = true,
  [CoinItemId.STONE] = true,
  [CoinItemId.FREESTONE] = true
}
local mapConfig = {
  [PanelId.RoguelikeLevel] = {bEvent = true},
  [PanelId.MainlineFormation] = {bEvent = true},
  [PanelId.MainlineFormationDisc] = {bEvent = true},
  [PanelId.RegionBossFormation] = {bEvent = true},
  [PanelId.RogueBossBuildBrief] = {bEvent = true},
  [PanelId.RogueBossLevel] = {bEvent = true},
  [PanelId.TrekkerVersus] = {bEvent = true},
  [PanelId.DictionaryFR] = {bEvent = true},
  [PanelId.Dictionary] = {bEvent = true},
  [PanelId.Quest] = {bEvent = true},
  [PanelId.DiscSample] = {bEvent = true},
  [PanelId.ChooseHomePageRolePanel] = {bEvent = true},
  [PanelId.ChooseHomePageSkinPanel] = {bEvent = true},
  [PanelId.CharacterSkinPanel] = {bEvent = true},
  [PanelId.InfinityTowerSelectTower] = {bEvent = true},
  [PanelId.BattlePass] = {bEvent = true},
  [PanelId.Achievement] = {bEvent = true},
  [PanelId.EquipmentInstanceLevelSelect] = {bEvent = true},
  [PanelId.StarTowerLevelSelect] = {bEvent = true},
  [PanelId.CharUpPanel] = {bEvent = true},
  [PanelId.MainlineEx] = {bEvent = true},
  [PanelId.StarTowerBook] = {bEvent = true},
  [PanelId.StoryChapter] = {bEvent = true},
  [PanelId.LevelMenu] = {bEvent = true},
  [PanelId.VampireSurvivorLevelSelectPanel] = {bEvent = true},
  [PanelId.ScoreBossSelectPanel] = {bEvent = true},
  [PanelId.SkillInstanceLevelSelect] = {bEvent = true},
  [PanelId.TrialFormation] = {bEvent = true},
  [PanelId.TrialDepot] = {bEvent = true},
  [PanelId.JointDrillLevelSelect_Mode1] = {bEvent = true},
  [PanelId.TowerDefenseCharacterDetailPanel] = {bEvent = true},
  [PanelId.MallSkinPreview] = {bEvent = true},
  [PanelId.StorySet] = {bEvent = true},
  [PanelId.BdConvertPanel] = {bEvent = true},
  [PanelId.GachaSpin] = {bEvent = true},
  [PanelId.JointDrillLevelSelect_Mode2] = {bEvent = true},
  [PanelId.PotentialPreselectionEdit] = {bEvent = true},
  [PanelId.GoldenSpyLevelSelectPanel_400017] = {bEvent = true},
  [PanelId.GoldenSpyLevelSelectPanel_400012] = {bEvent = true},
  [PanelId.TraceHunt] = {bEvent = true},
  [PanelId.TrialSkinSelectPanel] = {bEvent = true},
  [PanelId.TrialSkinFormationScenePanel] = {bEvent = true},
  [PanelId.DormPanel] = {bEvent = true},
  [PanelId.DormRoomSelectPanel] = {bEvent = true},
  [PanelId.ActivityLevelsSelectPanel_20104] = {bEvent = true}
}

function TopBarCtrl:CreateCoin(tbCoin, bHideCoinAdd)
  self.mapCoinIndex, self.mapItemIndex = nil, nil
  local coinList = {}
  local bHasGold = false
  for _, v in ipairs(tbCoin) do
    if v == CoinItemId.Gold then
      bHasGold = true
      break
    end
  end
  if bHasGold then
    table.sort(tbCoin, function(a, b)
      local aIsGold = a == CoinItemId.Gold
      local bIsGold = b == CoinItemId.Gold
      return aIsGold and not bIsGold
    end)
  end
  for _, v in ipairs(tbCoin) do
    table.insert(coinList, v)
  end
  self.bForceHide = bHideCoinAdd or false
  if 0 < #coinList then
    if not self.mapCoinIndex then
      self.mapCoinIndex = {}
    else
      for coinItmeId, _ in pairs(self.mapCoinIndex) do
        self.mapCoinIndex[coinItmeId] = nil
      end
    end
    if coinList[1] == CoinItemId.Gold then
      self.mapCoinIndex[coinList[1]] = 5
      self._mapNode.goCoinGold:SetCoin(coinList[1], self:GetCoinCount(coinList[1]), true, 99999999)
      self._mapNode.goCoinGold.gameObject:SetActive(true)
      self._mapNode.goCoinOther.gameObject:SetActive(false)
    else
      self.mapCoinIndex[coinList[1]] = 5
      self._mapNode.goCoinOther:SetCoin(coinList[1], self:GetCoinCount(coinList[1]), true, 999999)
      local curShowAddBtn = (tbShowCoinAdd[coinList[1]] or false) and not self.bForceHide
      self._mapNode.btnRootFirst:SetActive(curShowAddBtn)
      self._mapNode.goCoinGold.gameObject:SetActive(false)
      self._mapNode.goCoinOther.gameObject:SetActive(true)
    end
    for i = 1, 4 do
      local nCoinId = coinList[i + 1]
      if nCoinId then
        self.mapCoinIndex[nCoinId] = i
        self._mapNode.goCoin[i]:SetCoin(nCoinId, self:GetCoinCount(nCoinId), true, 999999)
        local curShowAddBtn = (tbShowCoinAdd[nCoinId] or false) and not self.bForceHide
        self._mapNode.btnRoot[i]:SetActive(curShowAddBtn)
        self._mapNode.goCoin[i].gameObject:SetActive(true)
      else
        self._mapNode.goCoin[i].gameObject:SetActive(false)
      end
    end
  end
end

function TopBarCtrl:RefreshCoin(nCoinId)
  if not self.mapCoinIndex then
    return
  end
  local index = self.mapCoinIndex[nCoinId]
  if index then
    if index == 5 then
      if nCoinId == CoinItemId.Gold then
        self._mapNode.goCoinGold:SetCoin(nil, self:GetCoinCount(nCoinId), true, 99999999)
      else
        self._mapNode.goCoinOther:SetCoin(nil, self:GetCoinCount(nCoinId), true, 999999)
      end
    else
      self._mapNode.goCoin[index]:SetCoin(nil, self:GetCoinCount(nCoinId), true, 999999)
    end
  end
end

function TopBarCtrl:RefreshEnergy()
  self._mapNode.goEnergy:Refresh()
end

function TopBarCtrl:AddEnergyAddBtnCallBack(callback)
  self._mapNode.goEnergy:AddCallBack(callback)
end

function TopBarCtrl:SetEnergyVisible(bVisible)
  if bVisible == nil then
    bVisible = true
  end
  if type(bVisible) ~= "boolean" then
    return
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgEnergy, bVisible and 1 or 0)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgEnergy, bVisible)
end

function TopBarCtrl:SetCoinVisible(bVisible)
  if bVisible == nil then
    bVisible = true
  end
  if type(bVisible) ~= "boolean" then
    return
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgResBar, bVisible and 1 or 0)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgResBar, bVisible)
end

function TopBarCtrl:GetCoinCount(nId)
  if nId == AllEnum.CoinItemId.FREESTONE or nId == AllEnum.CoinItemId.STONE then
    return PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.FREESTONE) + PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.STONE)
  elseif nId == AllEnum.CoinItemId.StarTowerSweepTick or nId == AllEnum.CoinItemId.StarTowerSweepTickLimit then
    return PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.StarTowerSweepTick) + PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.StarTowerSweepTickLimit)
  else
    return PlayerData.Item:GetItemCountByID(nId)
  end
end

function TopBarCtrl:InitTopBar(nPanelId)
  local mapCfg = mapConfig[nPanelId] or {}
  local sKey = table.keyof(PanelId, nPanelId)
  local mapTopBar = ConfigTable.GetData("TopBar", sKey, true)
  if mapTopBar == nil then
    self.gameObject:SetActive(false)
    return
  end
  if mapTopBar.DelayShow == true then
    self.bDelayShow = true
    self.gameObject:SetActive(false)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      self.gameObject:SetActive(true)
    end
    
    cs_coroutine.start(wait)
  else
    self.bDelayShow = false
    self.gameObject:SetActive(true)
  end
  local bHideBackBtn = mapTopBar.HideBack
  if type(bHideBackBtn) ~= "boolean" then
    bHideBackBtn = true
  end
  self._mapNode.btnBack.gameObject:SetActive(not bHideBackBtn)
  self._mapNode.cgBack.gameObject:SetActive(not bHideBackBtn)
  self._mapNode.btnHome.gameObject:SetActive(not mapTopBar.HideHome)
  if type(mapCfg.bEvent) == "boolean" then
    self.bEvent = mapCfg.bEvent
  else
    self.bEvent = false
  end
  local sTitle = mapTopBar.Title
  if type(sTitle) == "string" and sTitle ~= "" then
    NovaAPI.SetTMPText(self._mapNode.txtTitle[1], sTitle)
    NovaAPI.SetTMPText(self._mapNode.txtTitle[2], sTitle)
    self._mapNode.txtTitle[1].gameObject:SetActive(true)
  end
  local bHasSubTitle = mapCfg.bHasSubTitle
  if type(bHasSubTitle) ~= "boolean" then
    bHasSubTitle = false
  end
  if bHasSubTitle == true then
    self.bHasSubTitle = bHasSubTitle
    EventManager.Add(EventId.SetSubTitle, self, self.OnEvent_SetSubTitleTxt)
  end
  self._mapNode.goResBar.gameObject:SetActive(mapTopBar.Coin)
  if mapTopBar.Coin ~= nil and next(mapTopBar.CoinIds) then
    self:CreateCoin(mapTopBar.CoinIds, mapTopBar.HideCoinAdd)
  end
  local bShowEnergy = mapTopBar.Energy
  if type(bShowEnergy) ~= "boolean" then
    bShowEnergy = false
  end
  self._mapNode.goEnergy.gameObject:SetActive(bShowEnergy)
  if bShowEnergy then
    self:RefreshEnergy()
  end
  self.nEntryId = mapTopBar.EntryId
  self._mapNode.btnHelp.gameObject:SetActive(self.nEntryId > 0)
end

function TopBarCtrl:ShowGoEnergy(isShow)
  self._mapNode.goEnergy.gameObject:SetActive(isShow)
end

function TopBarCtrl:ShowGoBossTick(isShow)
  self._mapNode.goResBar.gameObject:SetActive(isShow)
end

function TopBarCtrl:Awake()
  self.mapCoinIndex = {}
  self.mapItemIndex = {}
end

function TopBarCtrl:OnEnable()
  local nPanelId = self:GetPanelId()
  self:InitTopBar(nPanelId)
end

function TopBarCtrl:OnDisable()
  if self.bHasSubTitle then
    EventManager.Remove(EventId.SetSubTitle, self, self.OnEvent_SetSubTitleTxt)
    self.bHasSubTitle = nil
  end
  if self._mapNode.goResBar and self._mapNode.goResBar ~= 0 then
    NovaAPI.SetComponentEnableByName(self._mapNode.goResBar.gameObject, "TopGridCanvas", false)
  end
end

function TopBarCtrl:OnBtnClick_Back()
  if self.bEvent == true then
    EventManager.Hit(EventId.BattleDashboardVisible, true)
    EventManager.Hit(EventId.UIBackConfirm, self._panel._nPanelId)
  else
    EventManager.Hit(EventId.ClosePanel, self._panel._nPanelId)
  end
end

function TopBarCtrl:OnBtnClick_Home()
  if self.bEvent == true then
    EventManager.Hit(EventId.UIHomeConfirm, self._panel._nPanelId)
  else
    PanelManager.Home()
  end
end

function TopBarCtrl:OnBtnClick_Help()
  if not self.nEntryId then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, self.nEntryId)
end

function TopBarCtrl:OnEvent_TopRes(bTop, nInstanceId, tbCoin, bHideCoinAdd)
  if nInstanceId ~= self.gameObject:GetInstanceID() then
    return
  end
  NovaAPI.SetComponentEnableByName(self._mapNode.goResBar.gameObject, "TopGridCanvas", bTop)
  NovaAPI.SetTopGridCanvasSorting(self._mapNode.goResBar.gameObject, AllEnum.UI_SORTING_ORDER.MessageBox)
  if tbCoin then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      
      local bHide = bTop
      if bHideCoinAdd ~= nil then
        bHide = bHideCoinAdd
      end
      self:CreateCoin(tbCoin, bHide)
    end
    
    cs_coroutine.start(wait)
  end
end

function TopBarCtrl:OnBtnClick_AddCoin(_, index)
  local curCoinItmeId = -1
  for coinItmeId, coinIndex in pairs(self.mapCoinIndex) do
    if index == coinIndex then
      curCoinItmeId = coinItmeId
      break
    end
  end
  if 0 <= curCoinItmeId and tbShowCoinAdd[curCoinItmeId] and curCoinItmeId == AllEnum.CoinItemId.FREESTONE then
    local panelId = self:GetPanelId()
    if panelId == PanelId.Mall then
      EventManager.Hit("OpenMallTog", AllEnum.MallToggle.Gem)
    else
      local nState = ConfigTable.GetConfigNumber("IsShowComBtn")
      if nState == 1 then
        EventManager.Hit(EventId.OpenPanel, PanelId.Mall, AllEnum.MallToggle.Gem)
      else
        local sContent = ConfigTable.GetUIText("Function_NotAvailable")
        EventManager.Hit(EventId.OpenMessageBox, sContent)
      end
    end
  end
end

function TopBarCtrl:OnBtnClick_AddCoinFirst(btn)
  local index = 5
  local curCoinItmeId = -1
  for coinItmeId, coinIndex in pairs(self.mapCoinIndex) do
    if index == coinIndex then
      curCoinItmeId = coinItmeId
      break
    end
  end
  if 0 <= curCoinItmeId and tbShowCoinAdd[curCoinItmeId] then
    if curCoinItmeId == AllEnum.CoinItemId.FREESTONE then
      local panelId = self:GetPanelId()
      if panelId == PanelId.Mall then
        EventManager.Hit("OpenMallTog", AllEnum.MallToggle.Gem)
      elseif panelId == PanelId.MallPopup then
        EventManager.Hit(EventId.ClosePanel, PanelId.MallPopup)
        EventManager.Hit("OpenMallTog", AllEnum.MallToggle.Gem)
      else
        local nState = ConfigTable.GetConfigNumber("IsShowComBtn")
        if nState == 1 then
          EventManager.Hit(EventId.OpenPanel, PanelId.Mall, AllEnum.MallToggle.Gem)
        else
          local sContent = ConfigTable.GetUIText("Function_NotAvailable")
          EventManager.Hit(EventId.OpenMessageBox, sContent)
        end
      end
    elseif curCoinItmeId == AllEnum.CoinItemId.Jade then
      local data = {exchangeCount = 1}
      EventManager.Hit(EventId.OpenPanel, PanelId.ExChangePanel, data)
    end
  end
end

function TopBarCtrl:OnBtnClick_CoinTips(btn, nIndex)
  local curCoinItmeId = -1
  for coinItmeId, coinIndex in pairs(self.mapCoinIndex) do
    if nIndex == coinIndex then
      curCoinItmeId = coinItmeId
      break
    end
  end
  if 0 <= curCoinItmeId then
    local bShowJumpto = true
    if self.bForceHide then
      bShowJumpto = false
    end
    UTILS.ClickItemGridWithTips(curCoinItmeId, btn.transform, true, true, bShowJumpto)
  end
end

function TopBarCtrl:OnBtnClick_CoinFirstTips(btn)
  local index = 5
  local curCoinItmeId = -1
  for coinItmeId, coinIndex in pairs(self.mapCoinIndex) do
    if index == coinIndex then
      curCoinItmeId = coinItmeId
      break
    end
  end
  if 0 <= curCoinItmeId then
    local bShowJumpto = true
    if self.bForceHide then
      bShowJumpto = false
    end
    UTILS.ClickItemGridWithTips(curCoinItmeId, btn.transform, true, true, bShowJumpto)
  end
end

function TopBarCtrl:OnEvent_CoinResChange(nCoinItemId, nCount, nDelCount)
  self:RefreshCoin(nCoinItemId)
end

function TopBarCtrl:OnEvent_SetSubTitleTxt(txt)
end

function TopBarCtrl:SetTitleTxt(txt)
  if type(txt) == "string" then
    NovaAPI.SetTMPText(self._mapNode.txtTitle[1], txt)
    NovaAPI.SetTMPText(self._mapNode.txtTitle[2], txt)
    self._mapNode.txtTitle[1].gameObject:SetActive(true)
  else
    NovaAPI.SetTMPText(self._mapNode.txtTitle[1], "")
    NovaAPI.SetTMPText(self._mapNode.txtTitle[2], "")
    self._mapNode.txtTitle[1].gameObject:SetActive(false)
  end
end

function TopBarCtrl:OnEvent_SetVisible(bVisible, ctrl)
  if bVisible == nil then
    bVisible = true
  end
  if type(bVisible) ~= "boolean" or self == ctrl then
    return
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.CanvasGroup, bVisible and 1 or 0)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.CanvasGroup, bVisible)
end

return TopBarCtrl
