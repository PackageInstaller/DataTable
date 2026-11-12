local EnergyBuyConfirmCtrl = class("EnergyBuyConfirmCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
EnergyBuyConfirmCtrl._mapNodeConfig = {
  goWindow = {},
  animWindow = {sNodeName = "goWindow", sComponentName = "Animator"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Buy_Confirm_Title"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  imgCoin = {sComponentName = "Image"},
  txtCoinCount = {sComponentName = "TMP_Text"},
  imgEnergy = {sComponentName = "Image"},
  txtEnergyCount = {sComponentName = "TMP_Text"},
  txtBuyCount = {sComponentName = "TMP_Text"},
  txtHave = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Buy_Confirm_Text"
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
EnergyBuyConfirmCtrl._mapEventConfig = {}

function EnergyBuyConfirmCtrl:Awake()
end

function EnergyBuyConfirmCtrl:OnEnable()
end

function EnergyBuyConfirmCtrl:ShowPanel()
  self._mapNode.animWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  self.nBuyCount = 1
  self.nBuyCountLimit = 0
  self.nBuyCountMax = 0
  self.nCurBuyCount = PlayerData.Base:GetEnergyBuyCount()
  self:RefreshAddCount()
  
  local function callback(nCount)
    self.nBuyCount = nCount
    self:RefreshAddCount()
  end
  
  self._mapNode.goQuantitySelector:Init(callback, 1, self.nBuyCountLimit - self.nCurBuyCount)
end

function EnergyBuyConfirmCtrl:OnDisable()
end

function EnergyBuyConfirmCtrl:OnDestroy()
end

function EnergyBuyConfirmCtrl:RefreshAddCount()
  local sEnergyName, sCoinName = "", ""
  local mapEnergyCfgData = ConfigTable.GetData_Item(AllEnum.CoinItemId.Energy)
  if mapEnergyCfgData ~= nil then
    self:SetPngSprite(self._mapNode.imgEnergy, mapEnergyCfgData.Icon)
    sEnergyName = mapEnergyCfgData.Title
  end
  local nHas = PlayerData.Base:GetCurEnergy()
  local tbGroupEnergy = PlayerData.Base:GetCurEnergyBuyGroup(self.nCurBuyCount + self.nBuyCount)
  self.nBuyCountLimit = 0
  self.nBuyCountMax = 0
  local nMinBuyCount = 0
  local sPriceDesc = ""
  if nil ~= tbGroupEnergy then
    self.nBuyEnergy = 0
    self.nCost = 0
    self.nCoinId = 0
    local nEnergyLimit = nHas.nEnergy
    for nId, v in pairs(tbGroupEnergy) do
      if nMinBuyCount == 0 or nId < nMinBuyCount then
        nMinBuyCount = nId
      end
      if nId > self.nCurBuyCount and nId <= self.nCurBuyCount + self.nBuyCount then
        self.nBuyEnergy = self.nBuyEnergy + v.EnergyValue
        self.nCost = self.nCost + v.CurrencyItemQty
        self.nCoinId = v.CurrencyItemId
        sPriceDesc = v.GroupName
      end
      if nId > self.nBuyCountMax then
        self.nBuyCountMax = nId
        if nEnergyLimit <= self._panel.nMaxEnergy then
          self.nBuyCountLimit = nId
          nEnergyLimit = nEnergyLimit + v.EnergyValue
        end
      end
    end
    if self.nCoinId ~= 0 then
      local mapCoinCfg = ConfigTable.GetData_Item(self.nCoinId)
      if mapCoinCfg ~= nil then
        self:SetPngSprite(self._mapNode.imgCoin, mapCoinCfg.Icon)
        sCoinName = mapCoinCfg.Title
      end
    end
    NovaAPI.SetTMPText(self._mapNode.txtBeforeValue, nHas.nEnergy)
    NovaAPI.SetTMPText(self._mapNode.txtAfterValue, nHas.nEnergy + self.nBuyEnergy)
    self._mapNode.goMaxValue.gameObject:SetActive(nHas.nEnergy + self.nBuyEnergy >= self._panel.nMaxEnergy)
    NovaAPI.SetTMPText(self._mapNode.txtCoinCount, string.format("%sx%s", sCoinName, self.nCost))
    NovaAPI.SetTMPText(self._mapNode.txtEnergyCount, string.format("%sx%s", sEnergyName, self.nBuyEnergy))
    local nCurBuyMax = self.nBuyCountMax - nMinBuyCount + 1
    NovaAPI.SetTMPText(self._mapNode.txtBuyCount, string.format("%s：%s/%s", sPriceDesc, nCurBuyMax - (self.nCurBuyCount - nMinBuyCount + 1), nCurBuyMax))
  end
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtGoValue)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtCountBg)
end

function EnergyBuyConfirmCtrl:Close()
  self._mapNode.animWindow:Play("t_window_04_t_out")
end

function EnergyBuyConfirmCtrl:OnBtnClick_Close()
  EventManager.Hit("CloseEnergyBuyPanel")
end

function EnergyBuyConfirmCtrl:OnBtnClick_Cancel()
  EventManager.Hit("CloseEnergyBuyPanel")
end

function EnergyBuyConfirmCtrl:OnBtnClick_Confirm()
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
            if nil ~= self._panel.callback then
              self._panel.callback()
            end
            EventManager.Hit("CloseEnergyBuyPanel", true)
            local nState = ConfigTable.GetConfigNumber("IsShowComBtn")
            if nState == 1 then
              EventManager.Hit(EventId.OpenPanel, PanelId.Mall, AllEnum.MallToggle.Gem)
            else
              local sContent = ConfigTable.GetUIText("Function_NotAvailable")
              EventManager.Hit(EventId.OpenMessageBox, sContent)
            end
          end,
          bBlur = false
        }
        EventManager.Hit(EventId.OpenMessageBox, msg)
      else
        PlayerData.Coin:SendGemConvertReqReq(self.nCost - nHasCoin, nil)
      end
      EventManager.Hit("ShowEnergyTopRes", false)
    end
    
    local function cancelCallback()
      EventManager.Hit("ShowEnergyTopRes", true)
    end
    
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = sTip,
      callbackConfirm = confirmCallback,
      callbackCancel = cancelCallback,
      bBlur = false
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
    EventManager.Hit("ShowEnergyTopRes", false)
    return
  end
  
  local function callback()
    EventManager.Hit(EventId.OpenPanel, PanelId.ReceivePropsTips, {
      {
        id = AllEnum.CoinItemId.Energy,
        count = self.nBuyEnergy
      }
    })
    EventManager.Hit("CloseEnergyBuyPanel")
    EventManager.Hit("RefreshEnergyBuyCount")
  end
  
  PlayerData.Base:SendEnergyBuy(self.nBuyCount, callback)
end

return EnergyBuyConfirmCtrl
