local StarTowerTokenBuyConfirmCtrl = class("StarTowerTokenBuyConfirmCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
StarTowerTokenBuyConfirmCtrl._mapNodeConfig = {
  goWindow = {},
  animWindow = {sNodeName = "goWindow", sComponentName = "Animator"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TokenBuy_Confirm_Title"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  imgCoin = {sComponentName = "Image"},
  txtCoinCount = {sComponentName = "TMP_Text"},
  imgToken = {sComponentName = "Image"},
  txtTokenCount = {sComponentName = "TMP_Text"},
  txtHave = {
    sComponentName = "TMP_Text",
    sLanguageId = "TokenBuy_Confirm_Text"
  },
  txtBeforeValue = {sComponentName = "TMP_Text"},
  txtAfterValue = {sComponentName = "TMP_Text"},
  goMaxValue = {},
  txtMaxValue = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Count_Max"
  },
  rtGoValue = {
    sNodeName = "goValue",
    sComponentName = "RectTransform"
  },
  rtCountBg = {
    sNodeName = "imgCountBg",
    sComponentName = "RectTransform"
  },
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  btnConfirm1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtCancelBtn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Buy_Cancel_Btn_Text"
  },
  txtConfirmBtn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Buy_Confirm_Btn_Text"
  },
  goQuantitySelector = {
    sNodeName = "tc_quantity_selector",
    sCtrlName = "Game.UI.TemplateEx.TemplateQuantitySelectorCtrl"
  }
}
StarTowerTokenBuyConfirmCtrl._mapEventConfig = {}

function StarTowerTokenBuyConfirmCtrl:Awake()
end

function StarTowerTokenBuyConfirmCtrl:OnEnable()
end

function StarTowerTokenBuyConfirmCtrl:ShowPanel()
  self._mapNode.animWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  self.nBuyCount = 1
  self.nTokenEveryBuy = ConfigTable.GetConfigNumber("TowerVitaEnergyPurchasedValue")
  local mapVitaTokenPrice = ConfigTable.GetConfigArray("TowerVitaEnergyPurchasedPrice")
  self.nTokenPrice = tonumber(mapVitaTokenPrice[2])
  self.nCoinId = tonumber(mapVitaTokenPrice[1])
  self.nMaxToken = self._panel.nMaxToken or ConfigTable.GetConfigNumber("TowerVitaEnergyMax")
  self:RefreshMaxBuy()
  self:RefreshAddCount()
end

function StarTowerTokenBuyConfirmCtrl:OnDisable()
end

function StarTowerTokenBuyConfirmCtrl:OnDestroy()
end

function StarTowerTokenBuyConfirmCtrl:RefreshMaxBuy()
  self.nCurTokenCount = PlayerData.StarTowerAutoPlan:GetTokenCount()
  self.nMaxBuy = math.ceil((self.nMaxToken - self.nCurTokenCount) / self.nTokenEveryBuy)
  
  local function callback(nCount)
    self.nBuyCount = nCount
    self:RefreshAddCount()
  end
  
  self._mapNode.goQuantitySelector:Init(callback, 1, self.nMaxBuy)
end

function StarTowerTokenBuyConfirmCtrl:RefreshAddCount()
  local sTokenName, sCoinName = "", ""
  local mapTokenCfgData = ConfigTable.GetData_Item(AllEnum.CoinItemId.AutoDecisionToken)
  if mapTokenCfgData ~= nil then
    self:SetPngSprite(self._mapNode.imgToken, mapTokenCfgData.Icon)
    sTokenName = mapTokenCfgData.Title
  end
  local nHas = PlayerData.StarTowerAutoPlan:GetTokenCount()
  if self.nCoinId ~= 0 then
    local mapCoinCfg = ConfigTable.GetData_Item(self.nCoinId)
    if mapCoinCfg ~= nil then
      self:SetPngSprite(self._mapNode.imgCoin, mapCoinCfg.Icon)
      sCoinName = mapCoinCfg.Title
    end
  end
  self.nCost = self.nBuyCount * self.nTokenPrice
  local nRatio = nHas * 100 / self.nMaxToken
  if nRatio < 1 and 0 < nRatio then
    nRatio = 1
  end
  local nCurRatio = 0 < self.nMaxToken and math.floor(nRatio) or 0
  NovaAPI.SetTMPText(self._mapNode.txtBeforeValue, nCurRatio .. "%")
  local nAfterTemp = (nHas + self.nBuyCount * self.nTokenEveryBuy) * 100 / self.nMaxToken
  if nAfterTemp < 1 and 0 < nAfterTemp then
    nAfterTemp = 1
  end
  local nAfterRatio = 0 < self.nMaxToken and math.floor(nAfterTemp) or 0
  NovaAPI.SetTMPText(self._mapNode.txtAfterValue, nAfterRatio .. "%")
  self._mapNode.goMaxValue.gameObject:SetActive(nHas + self.nBuyCount * self.nTokenEveryBuy >= self.nMaxToken)
  NovaAPI.SetTMPText(self._mapNode.txtCoinCount, string.format("%sx%s", sCoinName, self.nCost))
  local nCountTemp = self.nBuyCount * self.nTokenEveryBuy * 100 / self._panel.nMaxToken
  if nCountTemp < 1 and 0 < nCountTemp then
    nCountTemp = 1
  end
  NovaAPI.SetTMPText(self._mapNode.txtTokenCount, string.format("%sx%s", sTokenName, math.floor(nCountTemp) .. "%"))
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtGoValue)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtCountBg)
end

function StarTowerTokenBuyConfirmCtrl:Close()
  self._mapNode.animWindow:Play("t_window_04_t_out")
end

function StarTowerTokenBuyConfirmCtrl:OnBtnClick_Close()
  EventManager.Hit("CloseTokenBuyPanel")
end

function StarTowerTokenBuyConfirmCtrl:OnBtnClick_Cancel()
  EventManager.Hit("CloseTokenBuyPanel")
end

function StarTowerTokenBuyConfirmCtrl:OnBtnClick_Confirm()
  local nHasCoin = PlayerData.Coin:GetCoinCount(self.nCoinId)
  if nHasCoin < self.nCost then
    local itemCfg = ConfigTable.GetData_Item(self.nCoinId)
    local itemCostCfg = ConfigTable.GetData_Item(AllEnum.CoinItemId.STONE)
    if not itemCfg or not itemCostCfg then
      return
    end
    local sTip = orderedFormat(ConfigTable.GetUIText("Recruit_ExchangeGemZero"), itemCfg.Id, self.nCost - nHasCoin, itemCostCfg.Id)
    
    local function confirmCallback()
      local nStoneCount = PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.STONE)
      nStoneCount = nStoneCount + PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.FREESTONE)
      if nStoneCount < self.nCost - nHasCoin then
        local msg = {
          nType = AllEnum.MessageBox.Confirm,
          sContent = orderedFormat(ConfigTable.GetUIText("Recruit_Charge") or "", itemCostCfg.Id),
          callbackConfirm = function()
            self._panel:JumpToRecharge()
          end,
          bBlur = false
        }
        EventManager.Hit(EventId.OpenMessageBox, msg)
      else
        PlayerData.Coin:SendGemConvertReqReq(self.nCost - nHasCoin, nil)
      end
      EventManager.Hit("ShowTokenTopRes", false)
    end
    
    local function cancelCallback()
      EventManager.Hit("ShowTokenTopRes", false)
    end
    
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = sTip,
      callbackConfirm = confirmCallback,
      callbackCancel = cancelCallback,
      bBlur = false
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
    EventManager.Hit("ShowTokenTopRes", false)
    return
  end
  
  local function callback(bSuccess)
    if bSuccess then
      local nCountTemp = self.nBuyCount * self.nTokenEveryBuy * 100 / self._panel.nMaxToken
      if nCountTemp < 1 and 0 < nCountTemp then
        nCountTemp = 1
      end
      local nRatio = math.floor(nCountTemp)
      EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("TokenBuy_Success"), nRatio))
      EventManager.Hit("RefreshTokenItemList")
      EventManager.Hit("CloseTokenBuyPanel")
    end
  end
  
  PlayerData.StarTowerAutoPlan:SendTokenBuy(self.nBuyCount, callback)
end

return StarTowerTokenBuyConfirmCtrl
