local MallShopDetailCtrl = class("MallShopDetailCtrl", BaseCtrl)
MallShopDetailCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_TitleBuy"
  },
  goItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txtName = {sComponentName = "TMP_Text"},
  txtDesc = {sComponentName = "TMP_Text"},
  txtHas = {sComponentName = "TMP_Text"},
  txtPriceCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_UnitPrice"
  },
  imgCoin = {nCount = 2, sComponentName = "Image"},
  goOrigin = {},
  txtOrigin = {sComponentName = "TMP_Text"},
  txtPrice = {sComponentName = "TMP_Text"},
  imgDiscount = {},
  txtDiscount = {
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_Discount"
  },
  txtStock = {sComponentName = "TMP_Text"},
  goStock = {},
  txtBtnBuy = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_Btn_Buy"
  },
  txtCoinCount = {sComponentName = "TMP_Text"},
  btnBuy = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Buy"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnBuy2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Disable"
  },
  txtDisable = {sComponentName = "TMP_Text"},
  goQuantitySelector = {
    sNodeName = "tc_quantity_selector",
    sCtrlName = "Game.UI.TemplateEx.TemplateQuantitySelectorCtrl"
  }
}
MallShopDetailCtrl._mapEventConfig = {}

function MallShopDetailCtrl:Refresh(mapData, topbar)
  self.mapData = mapData
  self.mapCfg = ConfigTable.GetData("MallShop", mapData.sId)
  self:PlayInAni()
  self:RefreshInfo()
  self:RefreshPrice()
  self:RefreshBuyState()
  self:RefreshBuyCount()
  self.TopBar = topbar
end

function MallShopDetailCtrl:RefreshInfo()
  local mapItemCfg = ConfigTable.GetData_Item(self.mapCfg.ItemId)
  if not mapItemCfg then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtName, self.mapCfg.Name)
  self._mapNode.goItem:SetItem(self.mapCfg.ItemId, nil, self.mapCfg.ItemQty, nil, nil, nil, nil, true)
  if mapItemCfg.Type == GameEnum.itemType.Disc or mapItemCfg.Type == GameEnum.itemType.Char or mapItemCfg.Type == GameEnum.itemType.CharacterSkin or mapItemCfg.Stype == GameEnum.itemStype.DormFurniture then
    self._mapNode.txtHas.gameObject:SetActive(false)
  else
    self._mapNode.txtHas.gameObject:SetActive(true)
    local nCount = PlayerData.Item:GetItemCountByID(self.mapCfg.ItemId)
    if 999999 < nCount then
      local nFloor = math.floor(nCount / 100)
      local nK = string.format("%.0f", nFloor / 10)
      local sCount = nK .. "k"
      NovaAPI.SetTMPText(self._mapNode.txtHas, ConfigTable.GetUIText("Shop_Has") .. sCount)
    else
      NovaAPI.SetTMPText(self._mapNode.txtHas, ConfigTable.GetUIText("Shop_Has") .. nCount)
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtDesc, self.mapCfg.Desc)
  local bLimit = self.mapCfg.Stock > 0
  if bLimit then
    local nLeft = self.mapData.nCurStock
    NovaAPI.SetTMPText(self._mapNode.txtStock, orderedFormat(ConfigTable.GetUIText("Shop_Stock"), nLeft))
    NovaAPI.SetTMPColor(self._mapNode.txtStock, nLeft == 0 and Red_Unable or Blue_Dark)
  else
    NovaAPI.SetTMPText(self._mapNode.txtStock, ConfigTable.GetUIText("Shop_Unlimited"))
    NovaAPI.SetTMPColor(self._mapNode.txtStock, Blue_Dark)
  end
  self._mapNode.btnDetail.interactable = mapItemCfg and (mapItemCfg.Stype == GameEnum.itemStype.Disc or mapItemCfg.Stype == GameEnum.itemStype.Char or mapItemCfg.Stype == GameEnum.itemStype.RandomPackage or mapItemCfg.Stype == GameEnum.itemStype.ComCYO or mapItemCfg.Stype == GameEnum.itemStype.OutfitCYO)
end

function MallShopDetailCtrl:RefreshPrice()
  for i = 1, 2 do
    self:SetSprite_Coin(self._mapNode.imgCoin[i], self.mapCfg.ExchangeItemId)
  end
  NovaAPI.SetTMPText(self._mapNode.txtPrice, self.mapCfg.ExchangeItemQty)
end

function MallShopDetailCtrl:RefreshBuyCount()
  local nCost = self.nBuyCount * self.mapCfg.ExchangeItemQty
  NovaAPI.SetTMPText(self._mapNode.txtCoinCount, nCost)
  local nHasCoin = PlayerData.Coin:GetCoinCount(self.mapCfg.ExchangeItemId)
  NovaAPI.SetTMPColor(self._mapNode.txtCoinCount, nCost > nHasCoin and Red_Unable or Blue_Normal)
end

function MallShopDetailCtrl:RefreshBuyState()
  local tbCond = decodeJson(self.mapCfg.OrderCondParams)
  local bPurchaseAble = PlayerData.Shop:CheckShopCond(self.mapCfg.OrderCondType, tbCond)
  local bAble = bPurchaseAble and (self.mapData.nCurStock > 0 or self.mapCfg.Stock == 0)
  self._mapNode.btnBuy.gameObject:SetActive(bAble)
  self._mapNode.btnBuy2.gameObject:SetActive(not bAble)
  self._mapNode.txtDisable.gameObject:SetActive(not bAble)
  self.nBuyCount = bAble and 1 or 0
  local nMax = self:CountMaxBuy()
  
  local function callback(nCount)
    self.nBuyCount = nCount
    self:RefreshBuyCount()
  end
  
  self._mapNode.goQuantitySelector:Init(callback, self.nBuyCount, nMax)
  local sDisable = ""
  if not bPurchaseAble then
    if self.mapCfg.OrderCondType == GameEnum.shopCond.WorldClassSpecific then
      sDisable = orderedFormat(ConfigTable.GetUIText("Shop_Cond_WorldClassShort") or "", tbCond[1])
    end
    self.sDisableTip = ConfigTable.GetUIText("Shop_Condition")
  elseif self.mapData.nCurStock == 0 then
    sDisable = ConfigTable.GetUIText("Shop_Cond_SoldOutShort") or ""
    self.sDisableTip = ConfigTable.GetUIText("Shop_GoodsEmpty")
  end
  NovaAPI.SetTMPText(self._mapNode.txtDisable, sDisable)
end

function MallShopDetailCtrl:CountMaxBuy()
  local nHasCoin = PlayerData.Coin:GetCoinCount(self.mapCfg.ExchangeItemId)
  local nMax = math.floor(nHasCoin / self.mapCfg.ExchangeItemQty)
  if nMax == 0 then
    return 1
  end
  if 0 < self.mapCfg.Stock then
    local nRemain = self.mapData.nCurStock
    return nMax > nRemain and nRemain or nMax
  else
    return nMax
  end
end

function MallShopDetailCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self.ani:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function MallShopDetailCtrl:PlayOutAni()
  self.ani:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, "Close", true, true, true)
end

function MallShopDetailCtrl:Close()
  self.gameObject:SetActive(false)
end

function MallShopDetailCtrl:Awake()
  self.ani = self.gameObject.transform:GetComponent("Animator")
end

function MallShopDetailCtrl:OnEnable()
end

function MallShopDetailCtrl:OnDisable()
end

function MallShopDetailCtrl:OnDestroy()
end

function MallShopDetailCtrl:OnBtnClick_Buy()
  local nCost = self.nBuyCount * self.mapCfg.ExchangeItemQty
  local nHasCoin = PlayerData.Coin:GetCoinCount(self.mapCfg.ExchangeItemId)
  local sName = ConfigTable.GetData_Item(self.mapCfg.ExchangeItemId).Title
  if nCost > nHasCoin then
    if self.mapCfg.ExchangeItemId == AllEnum.CoinItemId.Jade then
      local needCount = nCost - nHasCoin
      local sTips1 = orderedFormat(ConfigTable.GetUIText("Recruit_ExchangeGemZero") or "", ConfigTable.GetData_Item(AllEnum.CoinItemId.Jade).Id, needCount, ConfigTable.GetData_Item(AllEnum.CoinItemId.STONE).Id)
      
      local function cancelCallback()
        EventManager.Hit("TopRes", false, self.TopBar.gameObject:GetInstanceID(), {
          AllEnum.CoinItemId.Jade
        }, true)
      end
      
      local function confirmCallback()
        local nCurStoneCount = PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.STONE)
        nCurStoneCount = nCurStoneCount + PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.FREESTONE)
        if nCurStoneCount >= needCount then
          local function successCallback()
            EventManager.Hit("TopRes", false, self.TopBar.gameObject:GetInstanceID(), {
              AllEnum.CoinItemId.Jade
            }, true)
            
            local function wait()
              coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
              self:Refresh(self.mapData)
            end
            
            cs_coroutine.start(wait)
          end
          
          PlayerData.Coin:SendGemConvertReqReq(needCount, successCallback)
        else
          local sTips2 = orderedFormat(ConfigTable.GetUIText("Recruit_Charge") or "", ConfigTable.GetData_Item(AllEnum.CoinItemId.STONE).Id)
          
          local function confirmCallbackExchange()
            EventManager.Hit("TopRes", false, self.TopBar.gameObject:GetInstanceID(), {
              AllEnum.CoinItemId.Jade
            })
            EventManager.Hit("MallCloseDetail")
            EventManager.Hit("OpenMallTog", AllEnum.MallToggle.Gem)
          end
          
          local msg = {
            nType = AllEnum.MessageBox.Confirm,
            sContent = sTips2,
            callbackConfirm = confirmCallbackExchange,
            callbackCancel = cancelCallback
          }
          EventManager.Hit(EventId.OpenMessageBox, msg)
          EventManager.Hit("TopRes", true, self.TopBar.gameObject:GetInstanceID(), {
            AllEnum.CoinItemId.Jade,
            AllEnum.CoinItemId.STONE
          })
        end
      end
      
      local msg = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = sTips1,
        callbackConfirm = confirmCallback,
        callbackCancel = cancelCallback,
        bBlur = false
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
      EventManager.Hit("TopRes", true, self.TopBar.gameObject:GetInstanceID(), {
        AllEnum.CoinItemId.Jade,
        AllEnum.CoinItemId.STONE
      })
      return
    end
    EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("Shop_NotEnough") or "", sName))
    return
  end
  
  local function buy()
    PlayerData.Mall:SendMallShopOrderReq(self.mapData.sId, self.nBuyCount)
  end
  
  local function buy_confirm()
    local nAll = self.mapCfg.ItemQty * self.nBuyCount
    local sTip = 1 < nAll and orderedFormat(ConfigTable.GetUIText("Shop_MultiBuyComfirm"), nCost, sName, nAll, self.mapCfg.Name) or orderedFormat(ConfigTable.GetUIText("Shop_BuyComfirm"), nCost, sName, self.mapCfg.Name)
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = sTip,
      callbackConfirm = buy,
      bBlur = false
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
  
  local mapCfg = ConfigTable.GetData_Item(self.mapCfg.ItemId)
  local sTip
  if mapCfg.Type == GameEnum.itemType.Disc then
    sTip = PlayerData.Item:GetDiscHoldingState(self.mapCfg.ItemId, self.nBuyCount)
  elseif mapCfg.Type == GameEnum.itemType.Char then
    sTip = PlayerData.Item:GetCharHoldingState(self.mapCfg.ItemId, self.nBuyCount)
  elseif mapCfg.Stype == GameEnum.itemStype.CharShard then
    local nCharId = PlayerData.Talent:GetFragmentsToChar(self.mapCfg.ItemId)
    sTip = PlayerData.Item:GetCharHoldingState(nCharId, 0, self.nBuyCount)
  end
  if sTip then
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = sTip,
      callbackConfirm = buy_confirm,
      bBlur = false
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  else
    buy_confirm()
  end
end

function MallShopDetailCtrl:OnBtnClick_Close()
  EventManager.Hit("MallCloseDetail")
end

function MallShopDetailCtrl:OnBtnClick_Detail()
  local mapCfg = ConfigTable.GetData_Item(self.mapCfg.ItemId)
  if not mapCfg then
    return
  end
  if mapCfg.Stype == GameEnum.itemStype.Disc then
    EventManager.Hit(EventId.OpenPanel, PanelId.DiscSample, self.mapCfg.ItemId)
  elseif mapCfg.Stype == GameEnum.itemStype.Char then
    EventManager.Hit(EventId.OpenPanel, PanelId.CharBgTrialPanel, PanelId.CharInfoTrial, self.mapCfg.ItemId)
  elseif mapCfg.Stype == GameEnum.itemStype.RandomPackage or mapCfg.Stype == GameEnum.itemStype.ComCYO then
    local tbDetailItem, sDetailTitle = PlayerData.Item:GetCYODisplayItem(self.mapCfg.ItemId)
    local msg = {
      nType = AllEnum.MessageBox.ItemList,
      tbItem = tbDetailItem,
      sTitle = sDetailTitle,
      bBlur = false
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  elseif mapCfg.Stype == GameEnum.itemStype.OutfitCYO then
    EventManager.Hit(EventId.OpenPanel, PanelId.DiscPreview, self.mapCfg.ItemId)
  end
end

function MallShopDetailCtrl:OnBtnClick_Disable()
  EventManager.Hit(EventId.OpenMessageBox, self.sDisableTip)
end

return MallShopDetailCtrl
