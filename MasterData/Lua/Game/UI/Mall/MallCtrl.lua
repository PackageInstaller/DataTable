local MallCtrl = class("MallCtrl", BaseCtrl)
MallCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  tog = {
    nCount = 8,
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeSheet"
  },
  ctrlTog = {
    nCount = 8,
    sNodeName = "tog",
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  srTog = {sComponentName = "ScrollRect"},
  scTog = {
    sNodeName = "srTog",
    sComponentName = "UIScrollToClick"
  },
  Recommend = {
    sNodeName = "---Recommend---",
    sCtrlName = "Game.UI.Mall.MallRecommendCtrl"
  },
  Gem = {
    sNodeName = "---Gem---",
    sCtrlName = "Game.UI.Mall.MallGemCtrl"
  },
  Package = {
    sNodeName = "---Package---",
    sCtrlName = "Game.UI.Mall.MallPackageCtrl"
  },
  MonthlyCard = {
    sNodeName = "---MonthlyCard---",
    sCtrlName = "Game.UI.Mall.MallMonthlyCardCtrl"
  },
  Shop = {
    sNodeName = "---Shop---",
    sCtrlName = "Game.UI.Mall.MallShopCtrl"
  },
  Skin = {
    sNodeName = "---Skin---",
    sCtrlName = "Game.UI.Mall.MallSkinCtrl"
  },
  Furniture = {
    sNodeName = "---Furniture---",
    sCtrlName = "Game.UI.Mall.MallFurnitureCtrl"
  },
  Activity = {
    sNodeName = "---Activity---",
    sCtrlName = "Game.UI.Mall.MallActivityCtrl"
  },
  btnCharShard = {
    sNodeName = "btnCharShard",
    sComponentName = "UIButton",
    callback = "OnBtnClick_OpenCharShardPanel"
  },
  aniMonthlyCard = {
    sNodeName = "---MonthlyCard---",
    sComponentName = "Animator"
  },
  redDotTog = {nCount = 8},
  redDot_New = {nCount = 8},
  btnDailyGift = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_DailyGift"
  },
  txtGiftOff = {
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_Received"
  },
  txtDailyGift = {
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_DailyGift"
  },
  goGiftOn = {},
  goGiftOff = {},
  reddotGift = {}
}
MallCtrl._mapEventConfig = {
  OpenMallTog = "OnEvent_OpenMallTog",
  MallChangeTopCoin = "OnEvent_ChangeTopCoin",
  Mall_Refresh_Reddot = "OnEvent_RefreshReddot",
  Mall_UpdateMallPackageRedDot = "OnEvent_RefreshReddot",
  MallActivityChange = "OnEvent_MallActivityChange",
  MallActivityExpire = "OnEvent_MallActivityExpire"
}
MallCtrl._mapRedDotConfig = {
  [RedDotDefine.Mall_Daily] = {sNodeName = "reddotGift"}
}

function MallCtrl:RegisterRedDot()
  RedDotManager.RegisterNode(RedDotDefine.Mall_Page_New, {
    AllEnum.MallToggle.Skin
  }, self._mapNode.redDot_New[5])
  RedDotManager.RegisterNode(RedDotDefine.Mall_Page_New, {
    AllEnum.MallToggle.Furniture
  }, self._mapNode.redDot_New[7])
  RedDotManager.RegisterNode(RedDotDefine.Mall_Page, {
    AllEnum.MallToggle.Activity
  }, self._mapNode.redDotTog[8])
  RedDotManager.RegisterNode(RedDotDefine.Mall_Page_New, {
    AllEnum.MallToggle.Activity
  }, self._mapNode.redDot_New[8], nil, true)
end

function MallCtrl:SwitchTog()
  self._mapNode.Gem.gameObject:SetActive(self._panel.nCurTog == AllEnum.MallToggle.Gem)
  self._mapNode.Package.gameObject:SetActive(self._panel.nCurTog == AllEnum.MallToggle.Package)
  self._mapNode.MonthlyCard.gameObject:SetActive(self._panel.nCurTog == AllEnum.MallToggle.MonthlyCard)
  self._mapNode.Shop.gameObject:SetActive(self._panel.nCurTog == AllEnum.MallToggle.Shop)
  self._mapNode.Skin.gameObject:SetActive(self._panel.nCurTog == AllEnum.MallToggle.Skin)
  self._mapNode.Recommend.gameObject:SetActive(self._panel.nCurTog == AllEnum.MallToggle.Recommend)
  self._mapNode.Furniture.gameObject:SetActive(self._panel.nCurTog == AllEnum.MallToggle.Furniture)
  self._mapNode.Activity.gameObject:SetActive(self._panel.nCurTog == AllEnum.MallToggle.Activity)
  if self._panel.nCurTog == AllEnum.MallToggle.Gem then
    self._mapNode.Gem:Refresh()
    self._mapNode.TopBar:CreateCoin({
      AllEnum.CoinItemId.Jade,
      AllEnum.CoinItemId.FREESTONE
    })
  elseif self._panel.nCurTog == AllEnum.MallToggle.Package then
    self._mapNode.Package:ResetTab(self.nTabParam)
    self._mapNode.Package:Refresh(true)
    self._mapNode.TopBar:CreateCoin({
      AllEnum.CoinItemId.FREESTONE
    })
  elseif self._panel.nCurTog == AllEnum.MallToggle.MonthlyCard then
    self._mapNode.MonthlyCard:Refresh()
    self._mapNode.TopBar:CreateCoin({
      AllEnum.CoinItemId.Jade,
      AllEnum.CoinItemId.FREESTONE
    })
  elseif self._panel.nCurTog == AllEnum.MallToggle.Shop then
    self._mapNode.Shop:ResetTab()
    self._mapNode.Shop:Refresh(true)
  elseif self._panel.nCurTog == AllEnum.MallToggle.Skin then
    self._mapNode.Skin:ResetTab()
    self._mapNode.Skin:Refresh(true)
    self._mapNode.TopBar:CreateCoin({
      AllEnum.CoinItemId.FREESTONE
    })
  elseif self._panel.nCurTog == AllEnum.MallToggle.Furniture then
    self._mapNode.Furniture:ResetTab()
    self._mapNode.Furniture:Refresh(true)
    self._mapNode.TopBar:CreateCoin({
      AllEnum.CoinItemId.Jade,
      AllEnum.CoinItemId.FREESTONE,
      AllEnum.CoinItemId.Furniture
    })
  elseif self._panel.nCurTog == AllEnum.MallToggle.Recommend then
    self._mapNode.Recommend:Refresh()
    self._mapNode.TopBar:CreateCoin({
      AllEnum.CoinItemId.Jade,
      AllEnum.CoinItemId.FREESTONE
    })
  elseif self._panel.nCurTog == AllEnum.MallToggle.Activity then
    self._mapNode.Activity:Refresh()
    self._mapNode.TopBar:CreateCoin({
      AllEnum.CoinItemId.Jade,
      AllEnum.CoinItemId.FREESTONE
    })
  end
  self:RegisterRedDot()
  self:OnEvent_RefreshReddot()
end

function MallCtrl:RefreshActivityTogText(actData)
  local sName
  if actData ~= nil then
    local mapProductCfg = PlayerData.Mall:GetMallActivityCfgByActId(actData:GetActId())
    sName = mapProductCfg ~= nil and mapProductCfg.Name or nil
  end
  if sName == nil or sName == "" then
    sName = ConfigTable.GetUIText("Mall_Tog_Package")
  end
  local tbCtrlTog = self._mapNode.ctrlTog
  tbCtrlTog[AllEnum.MallToggle.Activity]:SetText(sName)
end

function MallCtrl:RefreshActivityTog()
  local actData = PlayerData.Activity:GetMallActivityData()
  self.bHasActivity = actData ~= nil
  self._mapNode.tog[AllEnum.MallToggle.Activity].gameObject:SetActive(self.bHasActivity)
  self:RefreshActivityTogText(actData)
  self._mapNode.Activity:SetExpireTimer(actData)
  PlayerData.Mall:UpdateMallActivityRedDot()
  if not self.bHasActivity and self._panel.nCurTog == AllEnum.MallToggle.Activity then
    self._panel.nCurTog = AllEnum.MallToggle.Recommend
  end
end

function MallCtrl:ApplyActivityTogChange()
  local nLastTog = self._panel.nCurTog
  self:RefreshActivityTog()
  if nLastTog ~= self._panel.nCurTog then
    for i = 1, 8 do
      self._mapNode.ctrlTog[i]:SetDefault(i == self._panel.nCurTog)
    end
    self._mapNode.scTog:ScrollToClick(self._mapNode.tog[self._panel.nCurTog].gameObject)
    self:SwitchTog()
    self:PlayTogAni()
  elseif self._panel.nCurTog == AllEnum.MallToggle.Activity then
    self._mapNode.Activity:Refresh()
  end
end

function MallCtrl:PlayTogAni()
  if self._panel.nCurTog == AllEnum.MallToggle.MonthlyCard then
    self._mapNode.aniMonthlyCard:Play("MonthlyCard_in")
  end
end

function MallCtrl:SetDefaultTog()
  self:RefreshActivityTog()
  local nCurTog = self._panel.nCurTog
  if nCurTog == nil then
    self._panel.nCurTog = self.bHasActivity and AllEnum.MallToggle.Activity or AllEnum.MallToggle.Recommend
  end
  for i = 1, 8 do
    self._mapNode.ctrlTog[i]:SetDefault(i == self._panel.nCurTog)
  end
  if self._panel.nCurTog == AllEnum.MallToggle.Gem or self._panel.nCurTog == AllEnum.MallToggle.Shop then
    NovaAPI.SetVerticalNormalizedPosition(self._mapNode.srTog, 0)
  end
  self:SwitchTog()
  local bActive = PlayerData.Mall:GetDailyMallReward()
  self._mapNode.goGiftOff:SetActive(not bActive)
  self._mapNode.goGiftOn:SetActive(bActive)
end

function MallCtrl:RefreshTogText()
  self._mapNode.ctrlTog[1]:SetText(ConfigTable.GetUIText("Mall_Tog_MonthlyCard"))
  self._mapNode.ctrlTog[2]:SetText(ConfigTable.GetUIText("Mall_Tog_Package"))
  self._mapNode.ctrlTog[3]:SetText(ConfigTable.GetUIText("Mall_Tog_Gem"))
  self._mapNode.ctrlTog[4]:SetText(ConfigTable.GetUIText("Mall_Tog_Exchange"))
  self._mapNode.ctrlTog[5]:SetText(ConfigTable.GetUIText("Mall_Tog_Skin"))
  self._mapNode.ctrlTog[6]:SetText(ConfigTable.GetUIText("Mall_Tog_Recommend"))
  self._mapNode.ctrlTog[7]:SetText(ConfigTable.GetUIText("Mall_Tog_Furniture"))
  self:RefreshActivityTogText(PlayerData.Activity:GetMallActivityData())
end

function MallCtrl:FadeIn(bPlayFadeIn)
  EventManager.Hit(EventId.SetTransition)
  self:PlayTogAni()
end

function MallCtrl:Awake()
  self:RefreshTogText()
end

function MallCtrl:OnEnable()
  EventManager.Hit("MallCloseDetail")
  self:SetDefaultTog()
end

function MallCtrl:OnDisable()
end

function MallCtrl:OnDestroy()
end

function MallCtrl:OnBtnClick_ChangeSheet(btn, nIndex)
  if nIndex == self._panel.nCurTog then
    return
  end
  self._mapNode.ctrlTog[nIndex]:SetTrigger(true)
  self._mapNode.ctrlTog[self._panel.nCurTog]:SetTrigger(false)
  local lastTog = self._panel.nCurTog
  if lastTog == AllEnum.MallToggle.Package then
    local nCurSort = self._mapNode.Package:GetCurSort()
    PlayerData.Mall:RemovePackageNew(GameEnum.MallItemType.Package, nCurSort)
  elseif lastTog == AllEnum.MallToggle.Skin then
    local nCurSort = self._mapNode.Skin:GetCurSort()
    PlayerData.Mall:RemovePackageNew(GameEnum.MallItemType.Skin, nCurSort)
  elseif lastTog == AllEnum.MallToggle.Furniture then
    local nCurSort = self._mapNode.Furniture:GetCurSort()
    PlayerData.Mall:RemovePackageNew(GameEnum.MallItemType.Furniture, nCurSort)
  elseif lastTog == AllEnum.MallToggle.Activity then
    PlayerData.Mall:RemoveMallActivityNew()
  end
  self._panel.nCurTog = nIndex
  self._mapNode.scTog:ScrollToClick(self._mapNode.tog[self._panel.nCurTog].gameObject)
  self:SwitchTog()
  self:PlayTogAni()
end

function MallCtrl:OnBtnClick_OpenCharShardPanel(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.CharShardsConvert)
end

function MallCtrl:OnBtnClick_DailyGift()
  local bActive = PlayerData.Mall:GetDailyMallReward()
  if not bActive then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Shop_DailyGift_Received"))
    return
  end
  
  local function callback()
    local bActive = PlayerData.Mall:GetDailyMallReward()
    self._mapNode.goGiftOff:SetActive(not bActive)
    self._mapNode.goGiftOn:SetActive(bActive)
  end
  
  PlayerData.Mall:SendDailyMallRewardReceiveReq(callback)
end

function MallCtrl:OnEvent_ChangeTopCoin(tbCoin)
  self._mapNode.TopBar:CreateCoin(tbCoin)
end

function MallCtrl:OnEvent_OpenMallTog(nTog)
  if nTog == AllEnum.MallToggle.Activity and not self.bHasActivity then
    return
  end
  self:OnBtnClick_ChangeSheet(nil, nTog)
end

function MallCtrl:OnEvent_MallActivityChange()
  self:ApplyActivityTogChange()
end

function MallCtrl:OnEvent_MallActivityExpire()
  self:ApplyActivityTogChange()
end

function MallCtrl:OnEvent_RefreshReddot()
  local bMallFree = RedDotManager.GetValid(RedDotDefine.Mall_Free)
  if bMallFree then
    self._mapNode.redDotTog[2]:SetActive(true)
  else
    self._mapNode.redDotTog[2]:SetActive(false)
  end
  local bMallPageNew = RedDotManager.GetValid(RedDotDefine.Mall_Page_New, {
    AllEnum.MallToggle.Package
  })
  if bMallPageNew then
    self._mapNode.redDot_New[2]:SetActive(bMallPageNew and not bMallFree)
  else
    self._mapNode.redDot_New[2]:SetActive(false)
  end
  local bActivity = RedDotManager.GetValid(RedDotDefine.Mall_Page, {
    AllEnum.MallToggle.Activity
  })
  local bActivityNew = RedDotManager.GetValid(RedDotDefine.Mall_Page_New, {
    AllEnum.MallToggle.Activity
  })
  self._mapNode.redDot_New[8]:SetActive(bActivityNew and not bActivity)
end

return MallCtrl
