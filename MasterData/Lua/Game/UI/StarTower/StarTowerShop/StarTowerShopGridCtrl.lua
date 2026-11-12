local StarTowerShopGridCtrl = class("StarTowerShopGridCtrl", BaseCtrl)
local colorGray = Color(0.5176470588235295, 0.5176470588235295, 0.5176470588235295, 1)
local colorBlack = Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764, 1)
local colorRed = Color(0.996078431372549, 0.23921568627450981, 0.3607843137254902, 1)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
StarTowerShopGridCtrl._mapNodeConfig = {
  imgIcon = {sComponentName = "Image"},
  imgIconMask = {sComponentName = "Image"},
  imgCharIcon = {sComponentName = "Image"},
  imgPriceBgMask = {},
  imgEmpty = {},
  txtEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "FixedRoguelike_Empty"
  },
  TMPName = {sComponentName = "TMP_Text"},
  imgCoinIcon = {sComponentName = "Image"},
  imgCharEdge = {sComponentName = "Image"},
  TMPPrice = {sComponentName = "TMP_Text"},
  ButtonBuy = {sComponentName = "NaviButton", callback = "OnBtn_Buy"},
  imgDiscount = {},
  txtDiscount = {
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_Discount"
  },
  goOrigin = {},
  txtOrigin = {sComponentName = "TMP_Text"},
  Select = {}
}
StarTowerShopGridCtrl._mapEventConfig = {}

function StarTowerShopGridCtrl:RefreshGrid(mapGoods, nHasCoin)
  self.mapGoods = mapGoods
  if mapGoods == nil then
    self._mapNode.ButtonBuy.gameObject:SetActive(false)
    return
  end
  self._mapNode.ButtonBuy.gameObject:SetActive(true)
  local mapGoodCfgData = ConfigTable.GetData("StarTowerShopGoods", mapGoods.Idx)
  if mapGoodCfgData == nil then
    printError("StarTowerShopGoods Missing" .. mapGoods.Idx)
    return
  end
  local nItemTid
  if mapGoods.nType == 2 then
    nItemTid = mapGoods.nGoodsId
  else
    nItemTid = mapGoodCfgData.ShowItem
  end
  local mapItem = ConfigTable.GetData_Item(nItemTid)
  if mapItem == nil then
    return
  end
  self:SetPngSprite(self._mapNode.imgIcon, mapItem.Icon)
  self:SetPngSprite(self._mapNode.imgIconMask, mapItem.Icon)
  local nPrice = mapGoods.nDiscount > 0 and mapGoods.nDiscount or mapGoods.Price
  if mapGoods.nCharId ~= nil and 0 < mapGoods.nCharId then
    self._mapNode.imgCharEdge.gameObject:SetActive(true)
    local nCharSkinId = PlayerData.Char:GetCharSkinId(mapGoods.nCharId)
    self:SetPngSprite(self._mapNode.imgCharIcon, ConfigTable.GetData_CharacterSkin(nCharSkinId).Icon, AllEnum.CharHeadIconSurfix.S)
  else
    self._mapNode.imgCharEdge.gameObject:SetActive(false)
  end
  local mapItemCoin = ConfigTable.GetData_Item(AllEnum.CoinItemId.FixedRogCurrency)
  if mapItemCoin == nil then
    return
  end
  if 0 < mapGoodCfgData.ShowItemNum then
    NovaAPI.SetTMPText(self._mapNode.TMPName, orderedFormat(ConfigTable.GetUIText("Startower_ShopItemTitleWithNumber") or "", mapItem.Title, mapGoodCfgData.ShowItemNum))
  else
    NovaAPI.SetTMPText(self._mapNode.TMPName, mapItem.Title)
  end
  self:SetPngSprite(self._mapNode.imgCoinIcon, mapItemCoin.Icon)
  NovaAPI.SetTMPText(self._mapNode.TMPPrice, nPrice)
  self.bBuy = nHasCoin >= nPrice and not mapGoods.bSoldOut
  self.bUnable = nHasCoin < nPrice
  self.bEmpty = mapGoods.bSoldOut
  if mapGoods.bSoldOut then
    self._mapNode.imgEmpty:SetActive(true)
    self._mapNode.imgIconMask.gameObject:SetActive(true)
    self._mapNode.imgPriceBgMask:SetActive(true)
    NovaAPI.SetImageColor(self._mapNode.imgCharEdge, colorGray)
    NovaAPI.SetImageColor(self._mapNode.imgCharIcon, colorGray)
  else
    self._mapNode.imgEmpty:SetActive(false)
    self._mapNode.imgIconMask.gameObject:SetActive(false)
    self._mapNode.imgPriceBgMask:SetActive(false)
    NovaAPI.SetImageColor(self._mapNode.imgCharEdge, Color(1, 1, 1, 1))
    NovaAPI.SetImageColor(self._mapNode.imgCharIcon, Color(1, 1, 1, 1))
  end
  if self.bUnable then
    NovaAPI.SetTMPColor(self._mapNode.TMPPrice, colorRed)
  else
    NovaAPI.SetTMPColor(self._mapNode.TMPPrice, colorBlack)
  end
  self._mapNode.imgDiscount:SetActive(mapGoods.nDiscount > 0 and mapGoods.bSoldOut == false)
  self._mapNode.goOrigin:SetActive(mapGoods.nDiscount > 0)
  if mapGoods.nDiscount > 0 then
    NovaAPI.SetTMPText(self._mapNode.txtOrigin, mapGoods.Price)
  end
end

function StarTowerShopGridCtrl:SetSelect(bShow)
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType ~= AllEnum.GamepadUIType.Other and nUIType ~= AllEnum.GamepadUIType.Mouse then
    self._mapNode.Select:SetActive(bShow)
  end
end

function StarTowerShopGridCtrl:Awake()
end

function StarTowerShopGridCtrl:OnEnable()
  self.handler = ui_handler(self, self.OnBtn_Select, self._mapNode.ButtonBuy)
  self._mapNode.ButtonBuy.onSelect:AddListener(self.handler)
  self.handler2 = ui_handler(self, self.OnBtn_Deselect, self._mapNode.ButtonBuy)
  self._mapNode.ButtonBuy.onDeselect:AddListener(self.handler2)
end

function StarTowerShopGridCtrl:OnDisable()
  if self._mapNode.ButtonBuy and not self._mapNode.ButtonBuy:IsNull() then
    self._mapNode.ButtonBuy.onSelect:RemoveListener(self.handler)
    self._mapNode.ButtonBuy.onDeselect:RemoveListener(self.handler2)
  end
end

function StarTowerShopGridCtrl:OnDestroy()
end

function StarTowerShopGridCtrl:OnBtn_Select(btn)
  EventManager.Hit("StarTowerShoopSelectGoods", tonumber(self.gameObject.name))
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType ~= AllEnum.GamepadUIType.Other and nUIType ~= AllEnum.GamepadUIType.Mouse then
    WwiseAudioMgr:PlaySound("ui_common_click_select")
    self._mapNode.Select:SetActive(true)
  else
    self._mapNode.Select:SetActive(false)
  end
end

function StarTowerShopGridCtrl:OnBtn_Deselect(btn)
  self._mapNode.Select:SetActive(false)
end

function StarTowerShopGridCtrl:OnBtn_Buy(btn)
  if self.bBuy then
    EventManager.Hit("OpenFixedRoguelikeShopBuyPanel", self.mapGoods, self.bUnable)
  elseif self.bEmpty then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sSound = "ui_roguelike_shop_unableConfirm",
      sContent = ConfigTable.GetUIText("FIXEDROGUE_01")
    })
  elseif self.bUnable then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sSound = "ui_roguelike_shop_unableConfirm",
      sContent = ConfigTable.GetUIText("FIXEDROGUE_00")
    })
  end
end

return StarTowerShopGridCtrl
