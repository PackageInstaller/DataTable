local MallPackageDetailCtrl = class("MallPackageDetailCtrl", BaseCtrl)
MallPackageDetailCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_TitleBuy"
  },
  txtName = {sComponentName = "TMP_Text"},
  imgDetailIcon = {sComponentName = "Image"},
  goCurrency = {},
  imgCurrency = {sComponentName = "Image"},
  txtPrice = {sComponentName = "TMP_Text"},
  txtPriceCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Package_PriceTitle"
  },
  goTime = {},
  txtLimit = {sComponentName = "TMP_Text"},
  txtLimitCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Package_LimitTitle"
  },
  txtTime = {sComponentName = "TMP_Text"},
  txtTimeCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Package_TimeTitle"
  },
  txtTitleDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Package_Detail"
  },
  btnBuy1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Buy"
  },
  btnBuy2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Disable"
  },
  btnAll = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_All"
  },
  txtBtnBuy = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Btn_Buy"
  },
  txtBtnAll = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Btn_All"
  },
  goShow = {
    nCount = 5,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnShow = {
    nCount = 5,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tips"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtDisable = {sComponentName = "TMP_Text"}
}
MallPackageDetailCtrl._mapEventConfig = {}

function MallPackageDetailCtrl:Refresh(mapData)
  self.sId = mapData.sId
  local mapCfg = ConfigTable.GetData("MallPackage", mapData.sId)
  self:PlayInAni()
  self:RefreshInfo(mapCfg)
  self:RefreshPrice(mapCfg)
  self:RefreshLimit(mapCfg, mapData)
  self:RefreshTime(mapData)
  self:RefreshItem(mapCfg)
  self:RefreshBuy(mapCfg, mapData)
end

function MallPackageDetailCtrl:RefreshInfo(mapCfg)
  NovaAPI.SetTMPText(self._mapNode.txtName, mapCfg.DetailName)
  self:SetPngSprite(self._mapNode.imgDetailIcon, mapCfg.Icon)
end

function MallPackageDetailCtrl:RefreshPrice(mapCfg)
  if mapCfg.CurrencyType == GameEnum.currencyType.Cash then
    self._mapNode.goCurrency:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.txtPrice, tostring(mapCfg.CurrencyShowPrice))
  elseif mapCfg.CurrencyType == GameEnum.currencyType.Item then
    self._mapNode.goCurrency:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtPrice, mapCfg.CurrencyItemQty)
    self:SetPngSprite(self._mapNode.imgCurrency, ConfigTable.GetData_Item(mapCfg.CurrencyItemId).Icon2)
  elseif mapCfg.CurrencyType == GameEnum.currencyType.Free then
    self._mapNode.goCurrency:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.txtPrice, ConfigTable.GetUIText("Mall_Package_Free"))
  end
end

function MallPackageDetailCtrl:RefreshLimit(mapCfg, mapData)
  NovaAPI.SetTMPText(self._mapNode.txtLimit, mapData.nCurStock .. "/" .. mapCfg.Stock)
  if mapCfg.RefreshType == GameEnum.mallPackageRefreshType.None then
    NovaAPI.SetTMPText(self._mapNode.txtLimitCn, ConfigTable.GetUIText("Mall_Package_LimitTitle"))
  elseif mapCfg.RefreshType == GameEnum.mallPackageRefreshType.Day then
    NovaAPI.SetTMPText(self._mapNode.txtLimitCn, ConfigTable.GetUIText("Mall_Package_DayLimitTitle"))
  elseif mapCfg.RefreshType == GameEnum.mallPackageRefreshType.Week then
    NovaAPI.SetTMPText(self._mapNode.txtLimitCn, ConfigTable.GetUIText("Mall_Package_WeekLimitTitle"))
  elseif mapCfg.RefreshType == GameEnum.mallPackageRefreshType.Month then
    NovaAPI.SetTMPText(self._mapNode.txtLimitCn, ConfigTable.GetUIText("Mall_Package_MonthLimitTitle"))
  end
end

function MallPackageDetailCtrl:RefreshTime(mapData)
  self._mapNode.goTime:SetActive(mapData.nNextRefreshTime > 0)
  if mapData.nNextRefreshTime > 0 then
    local sSuffix = mapData.bPrioritizeDeList and ConfigTable.GetUIText("Mall_Package_Delist") or ConfigTable.GetUIText("Mall_Package_Refresh")
    local sPrefix
    local nRemaining = mapData.nNextRefreshTime - CS.ClientManager.Instance.serverTimeStamp
    if nRemaining <= 3600 then
      sPrefix = ConfigTable.GetUIText("Mall_Package_WithinHour")
    elseif 3600 < nRemaining and nRemaining <= 86400 then
      sPrefix = orderedFormat(ConfigTable.GetUIText("Mall_Package_Hour") or "", math.floor(nRemaining / 3600))
    elseif 86400 < nRemaining then
      sPrefix = orderedFormat(ConfigTable.GetUIText("Mall_Package_Day") or "", math.floor(nRemaining / 86400))
    end
    NovaAPI.SetTMPText(self._mapNode.txtTime, sPrefix .. sSuffix)
  end
end

function MallPackageDetailCtrl:RefreshItem(mapCfg)
  local tbItem = decodeJson(mapCfg.Items)
  self.tbShow = {}
  for k, v in pairs(tbItem) do
    local nId = tonumber(k)
    table.insert(self.tbShow, {
      nId = nId,
      nCount = v,
      nRarity = ConfigTable.GetData_Item(nId).Rarity
    })
  end
  table.sort(self.tbShow, function(a, b)
    if a.nRarity ~= b.nRarity then
      return a.nRarity < b.nRarity
    else
      return a.nId < b.nId
    end
  end)
  local nItemCount = #self.tbShow
  self._mapNode.btnAll.gameObject:SetActive(5 < nItemCount)
  for i = 1, 5 do
    if i <= nItemCount then
      self._mapNode.goShow[i]:SetItem(self.tbShow[i].nId, nil, self.tbShow[i].nCount, nil, nil, nil, nil, true)
    else
      self._mapNode.goShow[i]:SetItem()
    end
    self._mapNode.btnShow[i].interactable = i <= nItemCount
  end
end

function MallPackageDetailCtrl:RefreshBuy(mapCfg, mapData)
  local tbCond = decodeJson(mapCfg.OrderCondParams)
  local bPurchaseAble = PlayerData.Shop:CheckShopCond(mapCfg.OrderCondType, tbCond)
  local bAble = bPurchaseAble and mapData.nCurStock > 0
  self._mapNode.btnBuy1.gameObject:SetActive(bAble)
  self._mapNode.btnBuy2.gameObject:SetActive(not bAble)
  self._mapNode.txtDisable.gameObject:SetActive(not bAble)
  local sDisable
  if not bPurchaseAble then
    if mapCfg.OrderCondType == GameEnum.shopCond.WorldClassSpecific then
      sDisable = orderedFormat(ConfigTable.GetUIText("Shop_Cond_WorldClassShort") or "", tbCond[1])
    end
    self.sDisableTip = ConfigTable.GetUIText("Shop_Condition")
  elseif mapData.nCurStock == 0 then
    sDisable = ConfigTable.GetUIText("Shop_Cond_SoldOutShort")
    self.sDisableTip = ConfigTable.GetUIText("Shop_GoodsEmpty")
  end
  NovaAPI.SetTMPText(self._mapNode.txtDisable, sDisable)
end

function MallPackageDetailCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self.ani:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function MallPackageDetailCtrl:PlayOutAni()
  self.ani:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, "Close", true, true, true)
end

function MallPackageDetailCtrl:Close()
  self.gameObject:SetActive(false)
end

function MallPackageDetailCtrl:Awake()
  self.ani = self.gameObject.transform:GetComponent("Animator")
end

function MallPackageDetailCtrl:OnEnable()
end

function MallPackageDetailCtrl:OnDisable()
end

function MallPackageDetailCtrl:OnDestroy()
end

function MallPackageDetailCtrl:OnBtnClick_Buy()
  local mapCfg = ConfigTable.GetData("MallPackage", self.sId)
  if not mapCfg then
    return
  end
  local nCurrencyType = mapCfg.CurrencyType
  if nCurrencyType == GameEnum.currencyType.Cash then
    PlayerData.Mall:BuyPackage(self.sId, mapCfg.StatisticalGroup)
  else
    local bShowConfirm = false
    if nCurrencyType == GameEnum.currencyType.Item then
      local nHas = 0
      if mapCfg.CurrencyItemId == AllEnum.CoinItemId.FREESTONE or mapCfg.CurrencyItemId == AllEnum.CoinItemId.STONE then
        bShowConfirm = true
        nHas = PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.FREESTONE) + PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.STONE)
      else
        nHas = PlayerData.Coin:GetCoinCount(mapCfg.CurrencyItemId)
      end
      if nHas < mapCfg.CurrencyItemQty then
        local msg = {
          nType = AllEnum.MessageBox.Confirm,
          sContent = orderedFormat(ConfigTable.GetUIText("Recruit_Charge") or "", ConfigTable.GetData_Item(AllEnum.CoinItemId.STONE).Id),
          callbackConfirm = function()
            EventManager.Hit("MallCloseDetail")
            EventManager.Hit("OpenMallTog", AllEnum.MallToggle.Gem)
          end,
          bBlur = false
        }
        EventManager.Hit(EventId.OpenMessageBox, msg)
        return
      end
    end
    if bShowConfirm then
      local msg = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = orderedFormat(ConfigTable.GetUIText("Mall_Package_Buy_Confirm") or "", mapCfg.CurrencyItemQty, mapCfg.CurrencyItemId, mapCfg.DetailName),
        callbackConfirm = function()
          PlayerData.Mall:SendMallPackageOrderReq(self.sId)
        end,
        bBlur = false
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    else
      PlayerData.Mall:SendMallPackageOrderReq(self.sId)
    end
  end
end

function MallPackageDetailCtrl:OnBtnClick_Disable()
  EventManager.Hit(EventId.OpenMessageBox, self.sDisableTip)
end

function MallPackageDetailCtrl:OnBtnClick_All()
  local msg = {
    nType = AllEnum.MessageBox.ItemList,
    tbItem = self.tbShow,
    bBlur = false
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function MallPackageDetailCtrl:OnBtnClick_Close()
  EventManager.Hit("MallCloseDetail")
end

function MallPackageDetailCtrl:OnBtnClick_Tips(btn, nIndex)
  UTILS.ClickItemGridWithTips(self.tbShow[nIndex].nId, btn.transform, true, true, false)
end

return MallPackageDetailCtrl
