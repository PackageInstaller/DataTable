local TraceHuntHelpCtrl = class("TraceHuntHelpCtrl", BaseCtrl)
local ClientManager = CS.ClientManager.Instance
TraceHuntHelpCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  Info = {sNodeName = "---Info---"},
  List = {sNodeName = "---List---"},
  goBoss = {},
  imgBossIcon = {sComponentName = "Image"},
  txtBossName = {sComponentName = "TMP_Text"},
  btnHunt = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Hunt"
  },
  txtBtnHunt = {sComponentName = "TMP_Text"},
  goReqHunt = {},
  imgReqHuntIcon = {sComponentName = "Image"},
  txtReqHuntCount = {sComponentName = "TMP_Text"},
  txtGetReview = {sComponentName = "TMP_Text"},
  txtBossEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_Help_BossEmpty"
  },
  NormalBg = {},
  HardBg = {},
  goSwitch = {},
  txtSwitchTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_HardSwitch_Title"
  },
  btnHardInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_HardInfo"
  },
  imgExtraIcon = {sComponentName = "Image"},
  txtExtraCount = {sComponentName = "TMP_Text"},
  txtSwitchLock = {sComponentName = "TMP_Text"},
  goSwitchBtn = {},
  btnSwitch = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Switch"
  },
  SwitchOn = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_HardSwitch_Open"
  },
  SwitchOff = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_HardSwitch_Close"
  },
  srFriendList = {
    sComponentName = "LoopScrollView"
  },
  trSv = {
    sNodeName = "srFriendList",
    sComponentName = "Transform"
  },
  btnAddFriend = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Add"
  },
  txtBtnAdd = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_Btn_FriendAdd"
  },
  btnRecommend = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Recommend"
  },
  txtBtnRecommend = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_Btn_FriendRecommend"
  },
  imgEmptyBg = {},
  txtEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_Help_ListEmpty"
  },
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_ClosePop"
  },
  Recommend = {
    sNodeName = "---Recommend---",
    sCtrlName = "Game.UI.FriendEx.FriendRecommendCtrl"
  },
  goResCoin2 = {},
  btnResCoin = {
    nCount = 2,
    sNodeName = "goResCoin",
    sComponentName = "UIButton",
    callback = "OnBtnClick_CoinTips"
  },
  imgResCoin = {nCount = 2, sComponentName = "Image"},
  txtResCount = {nCount = 2, sComponentName = "TMP_Text"},
  goTip = {sNodeName = "--Tips--"},
  btnTipsBg = {
    sComponentName = "Button",
    callback = "OnBtnClick_TipsBg"
  },
  txtTipsName = {sComponentName = "TMP_Text"},
  txtTipsContent = {sComponentName = "TMP_Text"},
  txtDailyCount = {sComponentName = "TMP_Text"},
  txtDailyTime = {sComponentName = "TMP_Text"},
  redDotAdd = {},
  redDotResBar = {}
}
TraceHuntHelpCtrl._mapEventConfig = {
  FriendClosePop = "OnBtnClick_ClosePop",
  [EventId.CoinResChange] = "OnEvent_ResChange",
  TraceHuntItemChange = "OnEvent_ResChange",
  [EventId.TransAnimOutClear] = "OnEvent_TransAnimOutClear"
}
TraceHuntHelpCtrl._mapRedDotConfig = {
  [RedDotDefine.Friend_Apply] = {sNodeName = "redDotAdd"},
  [RedDotDefine.TraceHunt_HuntItem] = {
    sNodeName = "redDotResBar"
  }
}

function TraceHuntHelpCtrl:RefreshContent()
  self:RefreshData()
  self:RefreshList()
  self:RefreshBoss()
  self:RefreshRes()
  self:StartTicketsRefreshTimer()
end

function TraceHuntHelpCtrl:RefreshData()
  self.tbRecommend = PlayerData.TraceHunt:GetHuntRecommend()
  self.nSelectIndex = 0
  if next(self.tbRecommend) ~= nil then
    self.nSelectIndex = 1
  end
end

function TraceHuntHelpCtrl:RefreshBoss()
  if self.nSelectIndex == 0 or next(self.tbRecommend) == nil then
    self._mapNode.goBoss:SetActive(false)
    self._mapNode.txtBossEmpty.gameObject:SetActive(true)
    self._mapNode.NormalBg:SetActive(true)
    self._mapNode.HardBg:SetActive(false)
    return
  end
  self._mapNode.goBoss:SetActive(true)
  self._mapNode.txtBossEmpty.gameObject:SetActive(false)
  local mapData = self.tbRecommend[self.nSelectIndex]
  local mapBossCfg = ConfigTable.GetData("TraceHuntBoss", mapData.nBossId)
  if not mapBossCfg then
    return
  end
  self:SetPngSprite(self._mapNode.imgBossIcon, mapBossCfg.Image)
  local mData = ConfigTable.GetData("Monster", mapBossCfg.MonsterId)
  local mSkin = ConfigTable.GetData("MonsterSkin", mData.FAId)
  local mManual = ConfigTable.GetData("MonsterManual", mSkin.MonsterManual)
  NovaAPI.SetTMPText(self._mapNode.txtBossName, mManual.Name)
  self:RefreshHuntBoardHard()
  self:RefreshHuntBtn()
end

function TraceHuntHelpCtrl:RefreshRes()
  local nCount = PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.TraceHunt)
  self:SetSprite_Coin(self._mapNode.imgResCoin[1], AllEnum.CoinItemId.TraceHunt)
  NovaAPI.SetTMPText(self._mapNode.txtResCount[1], self:ThousandsNumber(nCount))
  local nId = ConfigTable.GetConfigNumber("TraceHuntPermitItemTid")
  self:SetSprite_Coin(self._mapNode.imgResCoin[2], nId)
  local tbMax = ConfigTable.GetConfigArray("TraceHuntPermitItem")
  local nHasCoin = PlayerData.TraceHunt:GetHuntTokenCount()
  NovaAPI.SetTMPText(self._mapNode.txtResCount[2], self:ThousandsNumber(nHasCoin) .. "/" .. tbMax[3])
end

function TraceHuntHelpCtrl:RefreshHuntBoardHard()
  local nHard = PlayerData.TraceHunt:GetHelpBossHard()
  self._mapNode.NormalBg:SetActive(nHard == 1)
  self._mapNode.HardBg:SetActive(1 < nHard)
  local bBlock = PlayerData.TraceHunt:GetControlBlockState()
  self._mapNode.goSwitch:SetActive(not bBlock)
  if not bBlock then
    local nHardOpenLevel = PlayerData.TraceHunt:GetHardOpenLevel()
    local nLevel = PlayerData.TraceHunt:GetTraceHuntLevel()
    local bLevelLock = nHardOpenLevel > nLevel
    local nCost = PlayerData.TraceHunt:GetHuntCostCount()
    local nHasCoin = PlayerData.TraceHunt:GetHuntTokenCount()
    local bItemLock = nCost > nHasCoin
    self._mapNode.goSwitchBtn:SetActive(not bLevelLock and not bItemLock)
    self._mapNode.txtSwitchLock.gameObject:SetActive(bLevelLock or bItemLock)
    if bLevelLock then
      NovaAPI.SetTMPText(self._mapNode.txtSwitchLock, orderedFormat(ConfigTable.GetUIText("TraceHunt_HardSwitch_LevelLimit"), nHardOpenLevel))
    elseif bItemLock then
      NovaAPI.SetTMPText(self._mapNode.txtSwitchLock, ConfigTable.GetUIText("TraceHunt_HardSwitch_HuntItemLimit"))
    end
  end
  self:SetSprite_Coin(self._mapNode.imgExtraIcon, AllEnum.CoinItemId.TraceHunt)
  local mapDifficulty = ConfigTable.GetData("TraceHuntDifficulty", 2)
  NovaAPI.SetTMPText(self._mapNode.txtExtraCount, string.format("+%d%%", mapDifficulty.TokenRate))
  self._mapNode.btnSwitch[1].gameObject:SetActive(nHard == 1)
  self._mapNode.btnSwitch[2].gameObject:SetActive(1 < nHard)
end

function TraceHuntHelpCtrl:RefreshHuntBtn()
  local nId = ConfigTable.GetConfigNumber("TraceHuntPermitItemTid")
  local nCost = PlayerData.TraceHunt:GetHuntCostCount()
  local nHasCoin = PlayerData.TraceHunt:GetHuntTokenCount()
  local bOpen = PlayerData.TraceHunt:CheckNoneRewardHelpOpen()
  if not bOpen then
    self:SetSprite_Coin(self._mapNode.imgReqHuntIcon, nId)
    NovaAPI.SetTMPText(self._mapNode.txtReqHuntCount, math.ceil(nCost))
    NovaAPI.SetTMPColor(self._mapNode.txtReqHuntCount, nCost <= nHasCoin and Blue_Normal or Red_Unable)
    NovaAPI.SetTMPText(self._mapNode.txtBtnHunt, ConfigTable.GetUIText("TraceHunt_Btn_HelpHunt"))
    local nMin, nMax = PlayerData.TraceHunt:GetHuntRewardRange()
    NovaAPI.SetTMPText(self._mapNode.txtGetReview, orderedFormat(ConfigTable.GetUIText("TraceHunt_Help_HuntRewardRange"), nMin, nMax))
  elseif nCost > nHasCoin then
    self._mapNode.goReqHunt:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.txtBtnHunt, ConfigTable.GetUIText("TraceHunt_Btn_HelpNoReward"))
    NovaAPI.SetTMPText(self._mapNode.txtGetReview, ConfigTable.GetUIText("TraceHunt_Help_HuntNoneReward"))
  else
    self._mapNode.goReqHunt:SetActive(true)
    self:SetSprite_Coin(self._mapNode.imgReqHuntIcon, nId)
    NovaAPI.SetTMPText(self._mapNode.txtReqHuntCount, math.ceil(nCost))
    NovaAPI.SetTMPColor(self._mapNode.txtReqHuntCount, nCost <= nHasCoin and Blue_Normal or Red_Unable)
    NovaAPI.SetTMPText(self._mapNode.txtBtnHunt, ConfigTable.GetUIText("TraceHunt_Btn_HelpHunt"))
    local nMin, nMax = PlayerData.TraceHunt:GetHuntRewardRange()
    NovaAPI.SetTMPText(self._mapNode.txtGetReview, orderedFormat(ConfigTable.GetUIText("TraceHunt_Help_HuntRewardRange"), nMin, nMax))
  end
end

function TraceHuntHelpCtrl:RefreshList()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  local nCount = #self.tbRecommend
  self._mapNode.srFriendList.gameObject:SetActive(0 < nCount)
  self._mapNode.imgEmptyBg:SetActive(nCount == 0)
  if 0 < nCount then
    self._mapNode.srFriendList:SetAnim(0.04)
    self._mapNode.srFriendList:Init(nCount, self, self.OnGridRefresh, self.OnGridBtnClick)
  end
end

function TraceHuntHelpCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbRecommend[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.TraceHunt.TraceHuntFriendGridCtrl")
  end
  self.tbGridCtrl[nInstanceID]:Refresh(mapData)
  self.tbGridCtrl[nInstanceID]:SetSelect(self.nSelectIndex == nIndex)
end

function TraceHuntHelpCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceID = goGrid:GetInstanceID()
  if self.nSelectIndex then
    local goSelect = self._mapNode.trSv:Find("Viewport/Content/" .. self.nSelectIndex - 1)
    if goSelect then
      self.tbGridCtrl[goSelect.gameObject:GetInstanceID()]:SetSelect(false)
    end
  end
  self.tbGridCtrl[nInstanceID]:SetSelect(true)
  self.nSelectIndex = nIndex
  self:RefreshBoss()
end

function TraceHuntHelpCtrl:StartTicketsRefreshTimer()
  if self.ticketRefreshTimer ~= nil then
    self.ticketRefreshTimer:Cancel()
    self.ticketRefreshTimer = nil
  end
  local nCurTime = ClientManager.serverTimeStamp
  local nNextRefreshTime = CS.ClientManager.Instance:GetNextRefreshTime(nCurTime)
  local nId = ConfigTable.GetConfigNumber("TraceHuntPermitItemTid")
  local mapItemCfg = ConfigTable.GetData_Item(nId)
  
  local function refreshTime()
    nCurTime = ClientManager.serverTimeStamp
    local nRemainTime = nNextRefreshTime - nCurTime
    local sTime = timeFormat_HMS(nRemainTime)
    NovaAPI.SetTMPText(self._mapNode.txtDailyTime, orderedFormat(ConfigTable.GetUIText("TraceHunt_Coin_Time"), mapItemCfg.Title, sTime))
  end
  
  refreshTime()
  self.ticketRefreshTimer = self:AddTimer(0, 1, function()
    refreshTime()
  end, true, true, true)
end

function TraceHuntHelpCtrl:PlayInAni()
  if self._panel._nFadeInType == 1 then
    if #self.tbRecommend > 0 then
      self.animator:Play("TraceHuntHelpPanel_in1", 0, 0)
    else
      self.animator:Play("TraceHuntHelpPanel_in2", 0, 0)
    end
  elseif #self.tbRecommend > 0 then
    self.animator:Play("TraceHuntHelpPanel_in1", 0, 1)
  else
    self.animator:Play("TraceHuntHelpPanel_in2", 0, 1)
  end
end

function TraceHuntHelpCtrl:FadeIn()
end

function TraceHuntHelpCtrl:Awake()
  self.tbGridCtrl = {}
  self._mapNode.Info:SetActive(false)
  self._mapNode.List:SetActive(false)
end

function TraceHuntHelpCtrl:OnEnable()
  self.animator = self.gameObject:GetComponent("Animator")
  self._mapNode.Info:SetActive(false)
  self._mapNode.List:SetActive(false)
  self.bGetInfo = false
  self:RefreshRes()
  
  local function callback()
    self._mapNode.Info:SetActive(true)
    self._mapNode.List:SetActive(true)
    self.bGetInfo = true
    self:RefreshContent()
    self:PlayInAni()
    local bInTransition = PanelManager.CheckInTransition()
    if not bInTransition then
      PlayerData.Friend:TryOpenFriendAddStranger()
    end
  end
  
  PlayerData.TraceHunt:SendTraceHuntRecommendReq(callback)
end

function TraceHuntHelpCtrl:OnDisable()
  if self.tbGridCtrl then
    for k, objCtrl in pairs(self.tbGridCtrl) do
      local obj = objCtrl.gameObject
      self:UnbindCtrlByNode(objCtrl)
      self.tbGridCtrl[k] = nil
      destroyImmediate(obj)
    end
    self.tbGridCtrl = {}
  end
  self._panel._nFadeInType = 2
end

function TraceHuntHelpCtrl:OnDestroy()
end

function TraceHuntHelpCtrl:OnBtnClick_Hunt(btn)
  if self.nSelectIndex == 0 or next(self.tbRecommend) == nil then
    return
  end
  local bOpen = PlayerData.TraceHunt:CheckNoneRewardHelpOpen()
  if not bOpen then
    local nId = ConfigTable.GetConfigNumber("TraceHuntPermitItemTid")
    local nCost = PlayerData.TraceHunt:GetHuntCostCount()
    local nHasCoin = PlayerData.TraceHunt:GetHuntTokenCount()
    if nCost > nHasCoin then
      local mapItemCfg = ConfigTable.GetData_Item(nId)
      EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("TraceHunt_Tips_HuntItemNotEnough"), mapItemCfg.Title))
      return
    end
  end
  if 0 >= PlayerData.TraceHunt:GetControlLeftTime() then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("TraceHunt_Tips_ControlInterrupt"))
    return
  end
  local nBossCreateTime = self.tbRecommend[self.nSelectIndex].nBossCreateTime
  local nLeft = nBossCreateTime + ConfigTable.GetConfigNumber("TraceHuntBossHuntLimitTime") - ClientManager.serverTimeStamp
  if nLeft <= 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("TraceHunt_Tips_HuntInterrupt"))
    return
  end
  
  local function OpenPanel()
    local nBossId = self.tbRecommend[self.nSelectIndex].nBossId
    local nUID = self.tbRecommend[self.nSelectIndex].nUID
    if self.tbRecommend[self.nSelectIndex].bFriend == false then
      local mapFriend = self.tbRecommend[self.nSelectIndex].mapFriend
      EventManager.Hit(EventId.OpenPanel, PanelId.RegionBossFormation, AllEnum.RegionBossFormationType.TraceHunt, nBossId, {
        nUID,
        nBossCreateTime,
        mapFriend
      })
    else
      EventManager.Hit(EventId.OpenPanel, PanelId.RegionBossFormation, AllEnum.RegionBossFormationType.TraceHunt, nBossId, {nUID, nBossCreateTime})
    end
  end
  
  EventManager.Hit(EventId.SetTransition, 2, OpenPanel)
end

function TraceHuntHelpCtrl:OnBtnClick_Add(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.Friend, 3)
end

function TraceHuntHelpCtrl:OnBtnClick_Recommend(btn)
  local function callback(mapData)
    self._mapNode.Recommend:Open(mapData)
    
    self._mapNode.blur:SetActive(true)
  end
  
  PlayerData.Friend:SendFriendRecommendationGetReq(callback)
end

function TraceHuntHelpCtrl:OnBtnClick_ClosePop(btn)
  self._mapNode.Recommend:PlayOutAni()
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.2, function()
    self._mapNode.blur:SetActive(false)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function TraceHuntHelpCtrl:OnBtnClick_HardInfo(btn)
  local mapData = {
    Title = ConfigTable.GetUIText("TraceHunt_HardSwitch_TipsTitle"),
    Desc = {
      ConfigTable.GetUIText("TraceHunt_HardSwitch_TipsDesc")
    }
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.DescTips, btn.transform, mapData)
end

function TraceHuntHelpCtrl:OnBtnClick_Switch(btn, nIndex)
  local nHard = PlayerData.TraceHunt:GetHelpBossHard()
  nHard = 3 - nHard
  PlayerData.TraceHunt:SetHelpBossHard(nHard)
  self:RefreshHuntBoardHard()
  self:RefreshHuntBtn()
  self.animator:Play("TraceHuntHelpPanel_Switch", 0, 0)
end

function TraceHuntHelpCtrl:OnBtnClick_CoinTips(btn, nIndex)
  if nIndex == 1 then
    UTILS.ClickItemGridWithTips(AllEnum.CoinItemId.TraceHunt, self._mapNode.btnResCoin[1].transform, true, true, false)
  else
    self._mapNode.goTip.gameObject:SetActive(true)
    local sortingOrder = NovaAPI.GetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"))
    NovaAPI.SetButtonInteractable(self._mapNode.btnResCoin[2], false)
    NovaAPI.SetComponentEnableByName(self._mapNode.goResCoin2, "TopGridCanvas", true)
    NovaAPI.SetTopGridCanvasSorting(self._mapNode.goResCoin2, sortingOrder + 1)
    local nId = ConfigTable.GetConfigNumber("TraceHuntPermitItemTid")
    local mapItemCfg = ConfigTable.GetData_Item(nId)
    NovaAPI.SetTMPText(self._mapNode.txtTipsName, mapItemCfg.Title)
    local tbMax = ConfigTable.GetConfigArray("TraceHuntPermitItem")
    NovaAPI.SetTMPText(self._mapNode.txtTipsContent, orderedFormat(ConfigTable.GetUIText("TraceHunt_Coin_Rule"), tbMax[1], mapItemCfg.Title))
    local nDaily = PlayerData.TraceHunt:GetHuntTokenDailyCount()
    NovaAPI.SetTMPText(self._mapNode.txtDailyCount, orderedFormat(ConfigTable.GetUIText("TraceHunt_Coin_Daily"), nDaily, tbMax[2]))
  end
end

function TraceHuntHelpCtrl:OnBtnClick_TipsBg()
  NovaAPI.SetButtonInteractable(self._mapNode.btnResCoin[2], true)
  NovaAPI.SetComponentEnableByName(self._mapNode.goResCoin2, "TopGridCanvas", false)
  self._mapNode.goTip.gameObject:SetActive(false)
end

function TraceHuntHelpCtrl:OnEvent_ResChange()
  self:RefreshRes()
  self:RefreshBoss()
end

function TraceHuntHelpCtrl:OnEvent_TransAnimOutClear(...)
  if self.bGetInfo then
    PlayerData.Friend:TryOpenFriendAddStranger()
  end
end

return TraceHuntHelpCtrl
