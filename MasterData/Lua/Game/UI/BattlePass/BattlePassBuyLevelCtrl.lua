local BattlePassBuyLevelCtrl = class("BattlePassBuyLevelCtrl", BaseCtrl)
BattlePassBuyLevelCtrl._mapNodeConfig = {
  TMPHintLevelBuy = {sComponentName = "TMP_Text"},
  TMP_costCount = {sComponentName = "TMP_Text"},
  TMPBuyLevel = {sComponentName = "TMP_Text"},
  TMPLevelTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePassLevelBuyTitle"
  },
  goQuantitySelector = {
    sNodeName = "tc_quantity_selector",
    sCtrlName = "Game.UI.TemplateEx.TemplateQuantitySelectorCtrl"
  },
  imgCostIcon = {sComponentName = "Image"},
  srItemList = {
    sComponentName = "LoopScrollView"
  },
  btnConfirm1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Buy"
  },
  btnCancel = {sComponentName = "UIButton", callback = "ClosePanel"},
  btnClose = {sComponentName = "UIButton", callback = "ClosePanel"},
  BtnCloseScreen = {sComponentName = "UIButton", callback = "ClosePanel"},
  txtTitleBuyLevel2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePassLevelBuy"
  },
  txtStock = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePassLevelBuy"
  },
  TMP_costTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePassLevelBuyCost"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePassLevelBuyConfirm"
  },
  txtBtnCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePassLevelBuyCancel"
  },
  AnimRoot = {
    sNodeName = "t_window_04",
    sComponentName = "Animator"
  }
}
BattlePassBuyLevelCtrl._mapEventConfig = {}
BattlePassBuyLevelCtrl._mapRedDotConfig = {}

function BattlePassBuyLevelCtrl:Awake()
  self._mapGridCtrl = {}
  self.upgradeCostId = ConfigTable.GetData("BattlePassLevel", 1).Tid
  self:SetSprite_Coin(self._mapNode.imgCostIcon, self.upgradeCostId)
end

function BattlePassBuyLevelCtrl:FadeIn()
end

function BattlePassBuyLevelCtrl:FadeOut()
end

function BattlePassBuyLevelCtrl:OnEnable()
  self.gameObject:SetActive(false)
end

function BattlePassBuyLevelCtrl:OnDisable()
  self:UnbindAllCtrl()
end

function BattlePassBuyLevelCtrl:OnDestroy()
end

function BattlePassBuyLevelCtrl:OnRelease()
end

function BattlePassBuyLevelCtrl:UnbindAllCtrl()
  for _, mapCtrl in pairs(self._mapGridCtrl) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self._mapGridCtrl = {}
end

function BattlePassBuyLevelCtrl:ClosePanel()
  local function waitCallback()
    self:UnbindAllCtrl()
    
    self.gameObject:SetActive(false)
  end
  
  self._mapNode.AnimRoot:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, waitCallback, true, true, true, nil)
end

function BattlePassBuyLevelCtrl:ShowPanel(nCurLevel, tbReward, nSeasonId, bPremium)
  self.gameObject:SetActive(true)
  self._mapNode.TMPHintLevelBuy.gameObject:SetActive(false)
  self._mapNode.srItemList.gameObject:SetActive(false)
  self.curAddLevel = 1
  self.curCost = 0
  self.tbReward = tbReward
  self.curLevel = nCurLevel
  self.bPremium = bPremium
  self.rewards = {}
  self._mapNode.srItemList:SetAnim(0.08)
  self:RefreshAddCount()
  
  local function callback(nCount)
    self.curAddLevel = nCount
    self:RefreshAddCount()
  end
  
  local nMaxLevel = #self.tbReward
  self._mapNode.goQuantitySelector:Init(callback, 1, nMaxLevel - nCurLevel)
  self._mapNode.AnimRoot:Play("t_window_04_t_in")
end

function BattlePassBuyLevelCtrl:OnGridRefresh(goGrid, gridIndex)
  if self._mapGridCtrl[goGrid] == nil then
    local mapCtrl = self:BindCtrlByNode(goGrid, "Game.UI.BattlePass.BattlePassBuyLevelItemGridCtrl")
    self._mapGridCtrl[goGrid] = mapCtrl
  end
  local nIdx = gridIndex
  if nIdx == nil then
    return
  end
  nIdx = nIdx + 1
  self._mapGridCtrl[goGrid]:Refresh(self.rewards[nIdx][1], self.rewards[nIdx][2])
end

function BattlePassBuyLevelCtrl:RefreshAddCount()
  local mapReward = {}
  self.curCost = 0
  for i = self.curLevel + 1, self.curLevel + self.curAddLevel do
    local mapRewardData = self.tbReward[i]
    if mapRewardData ~= nil then
      local mapLevel = ConfigTable.GetData("BattlePassLevel", i)
      if mapLevel == nil then
        return
      end
      self.curCost = self.curCost + mapLevel.Qty
      if 0 < mapRewardData.nNormalTid then
        if mapReward[mapRewardData.nNormalTid] == nil then
          mapReward[mapRewardData.nNormalTid] = 0
        end
        mapReward[mapRewardData.nNormalTid] = mapReward[mapRewardData.nNormalTid] + mapRewardData.nNormalQty
      end
      if self.bPremium then
        if 0 < mapRewardData.nVipTid1 then
          if mapReward[mapRewardData.nVipTid1] == nil then
            mapReward[mapRewardData.nVipTid1] = 0
          end
          mapReward[mapRewardData.nVipTid1] = mapReward[mapRewardData.nVipTid1] + mapRewardData.nVipQty1
        end
        if 0 < mapRewardData.nVipTid2 then
          if mapReward[mapRewardData.nVipTid2] == nil then
            mapReward[mapRewardData.nVipTid2] = 0
          end
          mapReward[mapRewardData.nVipTid2] = mapReward[mapRewardData.nVipTid2] + mapRewardData.nVipQty2
        end
      end
    end
  end
  NovaAPI.SetTMPText(self._mapNode.TMP_costCount, self.curCost)
  local nDefaultCount = PlayerData.Item:GetItemCountByID(self.upgradeCostId)
  if nDefaultCount < self.curCost then
    NovaAPI.SetTMPColor(self._mapNode.TMP_costCount, Red_Unable)
  else
    NovaAPI.SetTMPColor(self._mapNode.TMP_costCount, Blue_Normal)
  end
  self.rewards = {}
  for nTid, nCount in pairs(mapReward) do
    table.insert(self.rewards, {nTid, nCount})
  end
  if 0 < #self.rewards then
    self._mapNode.srItemList.gameObject:SetActive(true)
    self._mapNode.srItemList:Init(#self.rewards, self, self.OnGridRefresh, nil, true, nil)
    self._mapNode.TMPHintLevelBuy.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.TMPHintLevelBuy, orderedFormat(ConfigTable.GetUIText("BattlePassLevelBuyInfo") or "", self.curLevel + self.curAddLevel))
    NovaAPI.SetTMPText(self._mapNode.TMPBuyLevel, self.curAddLevel)
  else
    self._mapNode.TMPHintLevelBuy.gameObject:SetActive(false)
    self._mapNode.srItemList.gameObject:SetActive(false)
  end
end

function BattlePassBuyLevelCtrl:OnBtnClick_Buy()
  self:BuyOrExchangeCoin()
end

function BattlePassBuyLevelCtrl:BuyOrExchangeCoin()
  local function ConfirmPanel(sTip, confirmCallback)
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      
      sContent = sTip,
      callbackConfirm = confirmCallback,
      callbackCancel = nil,
      bBlur = false
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
  
  local mapCostCfgData = ConfigTable.GetData_Item(AllEnum.CoinItemId.STONE)
  local mapJadeCfgData = ConfigTable.GetData_Item(AllEnum.CoinItemId.Jade)
  if mapJadeCfgData == nil then
    return
  end
  if mapCostCfgData == nil then
    return
  end
  
  local function BuyCallback(mapData)
    self:ClosePanel()
  end
  
  local nDefaultCount = PlayerData.Item:GetItemCountByID(self.upgradeCostId)
  if nDefaultCount >= self.curCost then
    local function confirmCallback()
      PlayerData.BattlePass:NetMsg_BuyBattlePassLevel(self.curAddLevel, BuyCallback)
    end
    
    local sTips = orderedFormat(ConfigTable.GetUIText("Shop_BuyComfirm") or "", self.curCost, mapJadeCfgData.Title, ConfigTable.GetUIText("BattlePassLevelTitle"))
    ConfirmPanel(sTips, confirmCallback)
  elseif self.upgradeCostId == AllEnum.CoinItemId.Jade then
    local nNeedCount = self.curCost - nDefaultCount
    local sTips1 = orderedFormat(ConfigTable.GetUIText("Recruit_ExchangeGemZero") or "", mapJadeCfgData.Id, nNeedCount, mapCostCfgData.Id)
    
    local function confirmCallbackStone()
      local nCurStoneCount = PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.STONE)
      nCurStoneCount = nCurStoneCount + PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.FREESTONE)
      if nCurStoneCount >= nNeedCount then
        local function convertCallback()
          local nDefaultCountAfter = PlayerData.Item:GetItemCountByID(self.upgradeCostId)
          
          if nDefaultCountAfter < self.curCost then
            NovaAPI.SetTMPColor(self._mapNode.TMP_costCount, Red_Unable)
          else
            NovaAPI.SetTMPColor(self._mapNode.TMP_costCount, Blue_Normal)
          end
        end
        
        PlayerData.Coin:SendGemConvertReqReq(nNeedCount, convertCallback)
      else
        local sTips2 = orderedFormat(ConfigTable.GetUIText("Recruit_Charge") or "", mapCostCfgData.Id)
        
        local function confirmCallbackExchange()
          EventManager.Hit(EventId.OpenPanel, PanelId.Mall, AllEnum.MallToggle.Gem)
        end
        
        ConfirmPanel(sTips2, confirmCallbackExchange)
      end
    end
    
    ConfirmPanel(sTips1, confirmCallbackStone)
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("NotEnoughItem"))
  end
end

return BattlePassBuyLevelCtrl
