local WorldStageShopItem, Super = System.NewComponent("WorldStageShopItem")
local originColor, notEnoughColor

function WorldStageShopItem:ctor(uiNode, tid, uid, type, callback)
  Super.ctor(self)
  self.ui = UI_Dbgcopy_Item_Select_GoodsResource(uiNode)
  self.tid = tid
  self.uid = uid
  self.type = type
  self.callback = callback
  originColor = "#FFFFFF"
  notEnoughColor = StrUtils.GetWordsEffectColor(DT.WordsEffectConfig.Shop3)
end

function WorldStageShopItem:OnBind(binder)
  self.binder = binder
  binder:BindToRaw(function(cbinder, shopData)
    if not shopData then
      self.ui.uiNode:SetActive(false)
      return
    end
    self.ui.uiNode:SetActive(true)
    cbinder:BindButtonClick(self.ui.Button_Click, System.fn(self, self.OnClick))
    cbinder:BindToText(self.ui.Text_Money, System.fn(self, self.GetMoneyText))
    cbinder:BindToText(self.ui.Text_Title, function()
      if self.tid <= 0 then
        return ""
      end
      if self:IsRelicItem() then
        local cfg = DT.RelicConfig[self.tid]
        return cfg and cfg.Name or ""
      elseif self:IsEnchantItem() then
        local cfg = DT.EnchantConfig[self.tid]
        return cfg and cfg.Name or ""
      end
      return ""
    end)
    cbinder:BindToText(self.ui.Text_State, function()
      local relicTypeMap = CommonDefine.GetRelicTypeNameMap()
      local enchantTypeMap = CommonDefine.GetEnchantTypeNameMap()
      if self:IsRelicItem() then
        local cfg = DT.RelicConfig[self.tid]
        return cfg and relicTypeMap[cfg.Quality or "White"] or ""
      elseif self:IsEnchantItem() then
        local cfg = DT.EnchantConfig[self.tid]
        return cfg and enchantTypeMap[cfg.Quality or "White"] or ""
      end
      return ""
    end)
    cbinder:BindToImage(self.ui.Image_Icon, function()
      if self.tid <= 0 then
        return ""
      end
      if self:IsRelicItem() then
        local cfg = DT.RelicConfig[self.tid]
        return cfg and cfg.Icon or ""
      elseif self:IsEnchantItem() then
        local cfg = DT.EnchantConfig[self.tid]
        return cfg and cfg.Icon or ""
      end
      return ""
    end)
    cbinder:BindToImage(self.ui.Image_Money, function()
      return DT.GetOriginalConstant("PhiloStone")[2]
    end)
    cbinder:BindToVisible(self.ui.Image_Mask, function()
      do return self.HaveSell end
      return self.HaveSell, self
    end)
  end, function()
    do return ShopDataUtils.GetShopItem end
    return ShopDataUtils.GetShopItem, self.uid
  end)
end

function WorldStageShopItem:GetMoneyText()
  local cost = ShopDataUtils.GetShopItem(self.uid).price
  local have = DataCenter.playerData.DMoney.gold or 0
  if 0 == cost then
    local ShopEnchantAsGiftState = DT.GetConstant("ShopEnchantAsGift")
    local layer = StateDataUtils.GetLayer(ShopEnchantAsGiftState)
    if layer > 0 then
      do return string.color, (LT.Text("ShopEnchantGiftText")) end
      return string.color, LT.Text("ShopEnchantGiftText"), originColor
    end
  end
  if have < math.abs(cost) then
    do return string.color, cost end
    return string.color, cost, notEnoughColor, LT.Text("ShopEnchantGiftText"), originColor
  else
    do return string.color, cost end
    return string.color, cost, originColor, LT.Text("ShopEnchantGiftText"), originColor
  end
  return cost
end

function WorldStageShopItem:IsRelicItem()
  return self.type == CommonDefine.WorldStageShopItemType.Relic
end

function WorldStageShopItem:IsEnchantItem()
  return self.type == CommonDefine.WorldStageShopItemType.Enchant
end

function WorldStageShopItem:OnClick()
  if self:HaveSell() then
    Alert.ShowStr("StoreSoldOut")
  elseif self.callback then
    self.callback(self.uid)
  end
end

function WorldStageShopItem:HaveSell()
  do return ShopDataUtils.CheckGoodsSoldOut end
  return ShopDataUtils.CheckGoodsSoldOut, self.uid
end

return WorldStageShopItem
