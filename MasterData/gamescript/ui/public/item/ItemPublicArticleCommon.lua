local ItemPublicArticleCommon, Super = System.NewComponent("ItemPublicArticleCommon")

function ItemPublicArticleCommon:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Common_Item_ArticleResource(uiNode)
  self.itemTid = data.itemTid or 0
  self.showText = Vue.ref(data.showText)
  self.ifShowDesc = data.ifShowDesc
  self.ifShowAppr = data.ifShowAppr
  self.callback = data.callback
  self.itemType = data.itemType
end

function ItemPublicArticleCommon:OnBind(binder)
  self.binder = binder
  local copyItemMap = {
    [CommonDefine.CurrencyType.CopiesMoney] = {
      name = "PhiloStone",
      icon = DT.GetOriginalConstant("PhiloStone")[2]
    }
  }
  if copyItemMap[self.itemTid] then
    self.itemType = CommonDefine.ItemType.CopiesItem
  end
  if self.showText.value then
    binder:BindToText(self.ui.Text_Count, function()
      return self.showText.value
    end)
  end
  self.binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClick))
  binder:BindToImage(self.ui.Icon_D_Article, function()
    if 0 == self.itemTid then
      return ""
    end
    if self.itemType == CommonDefine.ItemType.CopiesItem then
      return copyItemMap[self.itemTid].icon
    end
    if self.itemType == CommonDefine.ItemType.Rune then
      return DT.EnchantConfig[self.itemTid].SmallIcon
    end
    if self.itemType == CommonDefine.ItemType.Relic then
      return DT.RelicConfig[self.itemTid].SmallIcon
    end
    local iconPath = ItemDataUtils.GetItemIcon(self.itemTid)
    return iconPath
  end)
  binder:BindToVisible(self.ui.Icon_D_Article, function()
    return self.itemTid > 0
  end)
  binder:BindToImage(self.ui.Image_D_Bg, function()
    if 0 == self.itemTid or self.itemType == CommonDefine.ItemType.CopiesItem then
      return "UIResources/AtlasSource/2_Icon/ToolQuality/UI_Tool_Quality_Nil.png"
    end
    local cfg
    if self.itemType == CommonDefine.ItemType.Relic then
      cfg = DT.RelicConfig[self.itemTid]
    elseif self.itemType == CommonDefine.ItemType.Rune then
      cfg = DT.EnchantConfig[self.itemTid]
    else
      cfg = ItemDataUtils.GetItemConfig(self.itemTid)
    end
    assert(cfg, string.format("DT.Item[%d] is nil", self.itemTid))
    assert(DT.ItemQuality[cfg.Quality], string.format("DT.ItemQuality[DT.Item[%d].Quality] is nil", self.itemTid))
    assert(DT.ItemQuality[cfg.Quality], string.format("DT.ItemQuality[DT.Item[%d].Quality].ItemQualityFrame is nil", self.itemTid))
    return DT.ItemQuality[cfg.Quality].ItemQualityColor
  end)
end

function ItemPublicArticleCommon:OnClick()
  if self.callback then
    self.callback(self.itemTid)
  end
  if self.ifShowDesc and 0 ~= self.itemTid then
    ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.uiNode, nil, self.itemTid)
  end
end

function ItemPublicArticleCommon:SetNumText(text)
  self.showText.value = text
end

function ItemPublicArticleCommon:SetCallback(callback)
  self.callback = callback
end

function ItemPublicArticleCommon:GetNumText()
  return self.showText
end

function ItemPublicArticleCommon:SetIsShowDesc(isShowDesc, isShowAppear)
  self.ifShowDesc = isShowDesc
  self.ifShowAppr = isShowAppear
end

function ItemPublicArticleCommon:SetVisible(show)
  self.binder:SetActive(self.ui.uiNode, show)
end

return ItemPublicArticleCommon
