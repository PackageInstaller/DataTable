local ShopItem, Super = System.NewComponent("ShopItem")

function ShopItem:ctor(res, uid, callback, fromShop, tid, type)
  Super.ctor(self)
  self.ui = ShopRelicItemResource(res)
  self.uid = Vue.ref(uid)
  self.callback = callback
  self.fromShop = fromShop
  self.type = type
  self.tid = Vue.ref(tid)
end

function ShopItem:OnBind(binder)
  self.binder = binder
  binder:SetActive(self.ui.Group_Type, false)
  binder:SetActive(self.ui.NoBuy, false)
  binder:SetActive(self.ui.GroupDiscount_01, false)
  binder:SetActive(self.ui.SellOut, false)
  binder:SetActive(self.ui.CostInfo, true)
  binder:SetActive(self.ui.Image_goldIcon, true)
  binder:SetActive(self.ui.Text_Cost, true)
  binder:BindToImage(self.ui.Image_goldIcon, function()
    return DT.GetOriginalConstant("PhiloStone")[2]
  end)
  binder:BindToVisible(self.ui.SellOut, function()
    local uid = self.uid.value
    local item = ShopDataUtils.GetShopItem(uid)
    if item and item.use and item.use >= 1 then
      return true
    else
      return false
    end
  end)
  local originColor = "#000000"
  local notEnoughColor = StrUtils.GetWordsEffectColor(DT.WordsEffectConfig.Shop3)
  
  local function TextColorSet(have)
    local shopItem = ShopDataUtils.GetShopItem(self.uid.value)
    if not shopItem then
      return
    end
    local cost = math.modf(shopItem.price)
    if have < math.abs(cost) then
      binder:SetTextColorByHtml(self.ui.Text_Cost, notEnoughColor)
    else
      binder:SetTextColorByHtml(self.ui.Text_Cost, originColor)
    end
  end
  
  binder:BindToRaw(function(_, nVal, _)
    nVal = nVal or 0
    TextColorSet(nVal)
  end, function()
    return DataCenter.playerData.DMoney.gold
  end)
  binder:BindToText(self.ui.Text_Cost, function()
    local shopItem = ShopDataUtils.GetShopItem(self.uid.value)
    return math.modf(shopItem.price) .. LT.Text("PhiloStone")
  end)
  binder:BindToText(self.ui.Text_Type, function()
    if self.type == CommonDefine.WorldStageShopItemType.Relic then
      do return LT.Text end
      return LT.Text, "StoreGoodsTypeRelic"
    end
    if self.type == CommonDefine.WorldStageShopItemType.Enchant then
      do return LT.Text end
      return LT.Text, "StoreGoodsTypeEnchantment"
    end
    do return LT.Text end
    return LT.Text, "StoreGoodsTypeItem"
  end)
  binder:BindToImage(self.ui.Icon, function()
    if self.tid.value <= 0 then
      return ""
    end
    if self.type == CommonDefine.WorldStageShopItemType.Relic then
      return DT.RelicConfig[self.tid.value].Icon or ""
    end
    if self.type == CommonDefine.WorldStageShopItemType.Enchant then
      return DT.EnchantConfig[self.tid.value].Icon or ""
    end
    return DT.Item[self.tid.value].Icon or ""
  end)
  binder:BindToText(self.ui.Text_Name, function()
    if self.tid.value <= 0 then
      return ""
    end
    if self.type == CommonDefine.WorldStageShopItemType.Relic then
      return DT.RelicConfig[self.tid.value].Name or ""
    end
    if self.type == CommonDefine.WorldStageShopItemType.Enchant then
      return DT.EnchantConfig[self.tid.value].Name or ""
    end
    return DT.Item[self.tid.value].Name or ""
  end)
  binder:BindToTextColorOld(self.ui.Text_Name, function()
    local config = DT.Item[self.tid.value]
    if self.type == CommonDefine.WorldStageShopItemType.Relic then
      config = DT.RelicConfig[self.tid.value]
    end
    if self.type == CommonDefine.WorldStageShopItemType.Enchant then
      config = DT.EnchantConfig[self.tid.value]
    end
    if config.Quality == "White" then
      return "#000000"
    end
    do return string.format end
    return string.format, "#" .. DT.ItemQuality[config.Quality].ItemNameColor, DT.ItemQuality[config.Quality].ItemNameColor, config.Quality
  end)
  binder:BindToText(self.ui.Text_Article_Number, function()
    local item = ShopDataUtils.GetShopItem(self.uid.value)
    return item.count
  end)
  binder:BindToVisible(self.ui.Text_Article_Number, function()
    local item = ShopDataUtils.GetShopItem(self.uid.value)
    return 0 ~= item.count
  end)
  binder:BindToText(self.ui.Text_Desc, function()
    if self.tid.value <= 0 then
      return ""
    end
    if self.type == CommonDefine.WorldStageShopItemType.Relic then
      do return RelicDataUtils.GetRelicDesc end
      return RelicDataUtils.GetRelicDesc, self.tid.value
    end
    if self.type == CommonDefine.WorldStageShopItemType.Enchant then
      return DT.EnchantConfig[self.tid.value].Desc or ""
    end
    return DT.Item[self.tid.value].Desc or ""
  end)
  binder:BindButtonClick(self.ui.Btn_Click, function()
    if self.callback then
      self.callback(self.uid.value)
    end
  end)
end

function ShopItem:SetShopData(uid, tid)
  self.uid.value = uid
  self.tid.value = tid
end

return ShopItem
