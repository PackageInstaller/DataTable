local ItemPublicArticle, Super = System.NewComponent("ItemPublicArticle")

function ItemPublicArticle:ctor(uiNode, itemTid, botText, ifSub, ifShowDesc, ifShowAppr, callback, subCallback, useCallback)
  Super.ctor(self)
  self.ui = Item_Public_ArticleResource(uiNode)
  self.itemTid = Vue.ref(itemTid)
  self.botText = Vue.ref(botText)
  self.ifSub = Vue.ref(ifSub)
  self.ifShowDesc = ifShowDesc
  self.ifShowAppr = ifShowAppr
  self.callback = callback
  self.subCallback = subCallback
  self.useCallback = useCallback
end

function ItemPublicArticle:OnBind(binder)
  self.binder = binder
  binder:BindToVisible(self.ui.Group_Sub, function()
    return self.ifSub.value
  end)
  local config = ItemDataUtils.GetItemConfig(self.itemTid.value)
  if nil ~= config and 4 == config.Type and 2 == config.SubType then
    self.botText.value = nil
  end
  if self.botText.value then
    binder:BindToText(self.ui.Text_Article_Number, function()
      return self.botText.value
    end)
    self.ui.Group_Number:SetActive(true)
  else
    self.ui.Group_Number:SetActive(false)
  end
  binder:BindToVisible(self.ui.Group_Number, function()
    return self.botText.value and self.botText.value ~= ""
  end)
  binder:BindLongPressButton(self.ui.Btn_Click, System.fn(self, self.OnLongPressedCallback), System.fn(self, self.OnClick), tonumber(DT.GetConstant("Role_Press_Time")))
  binder:BindLongPressButton(self.ui.Btn_Sub, System.fn(self, self.OnLongPressedSubCallback), System.fn(self, self.OnClickSubBtn), tonumber(DT.GetConstant("Role_Press_Time")))
  binder:BindToImage(self.ui.Icon_Article, function()
    if 0 == self.itemTid.value then
      return ""
    end
    local iconPath = ItemDataUtils.GetItemIcon(self.itemTid.value)
    return iconPath
  end)
  binder:BindToImage(self.ui.Image_Bg, function()
    if 0 == self.itemTid.value then
      return
    end
    local cfg = ItemDataUtils.GetItemConfig(self.itemTid.value)
    assert(cfg, string.format("DT.Item[%d] is nil", self.itemTid.value))
    if cfg.Type == CommonDefine.ItemType.Material and cfg.SubType == CommonDefine.ItemSubType.StoryItem then
      return
    end
    assert(DT.ItemQuality[cfg.Quality], string.format("DT.ItemQuality[DT.Item[%d].Quality] is nil", self.itemTid.value))
    assert(DT.ItemQuality[cfg.Quality], string.format("DT.ItemQuality[DT.Item[%d].Quality].ItemQualityFrame is nil", self.itemTid.value))
    return DT.ItemQuality[cfg.Quality].ItemQualityColor
  end)
end

function ItemPublicArticle:OnLongPressedCallback()
  if self.longPressedCallback then
    self.longPressedCallback()
  end
end

function ItemPublicArticle:OnLongPressedSubCallback()
  if self.longPressedSubCallback then
    self.longPressedSubCallback()
  end
end

function ItemPublicArticle:OnClick()
  if self.callback then
    self.callback(self.itemTid.value)
  end
  if self.ifShowDesc and 0 ~= self.itemTid.value then
    ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.uiNode, nil, self.itemTid.value)
  end
end

function ItemPublicArticle:OnClickSubBtn()
  if self.subCallback then
    self.subCallback(self.itemTid.value)
  end
end

function ItemPublicArticle:SetCallback(callback)
  self.callback = callback
end

function ItemPublicArticle:SetLongPressedCallback(longPressedCb)
  self.longPressedCallback = longPressedCb
end

function ItemPublicArticle:SetLongPressedSubCallback(longPressedSubCb)
  self.longPressedSubCallback = longPressedSubCb
end

function ItemPublicArticle:SetSubCallback(subCallback)
  self.subCallback = subCallback
end

function ItemPublicArticle:SetItemTid(tid)
  self.itemTid.value = tid
end

function ItemPublicArticle:SetNumText(text)
  self.botText.value = text
end

function ItemPublicArticle:GetNumText()
  return self.botText.value
end

function ItemPublicArticle:SetSubBtnShow(ifSub)
  self.ifSub.value = ifSub
end

function ItemPublicArticle:SetIsShowDesc(isShowDesc, isShowAppear)
  self.ifShowDesc = isShowDesc
  self.ifShowAppr = isShowAppear
end

function ItemPublicArticle:SetVisible(show)
  self.binder:SetActive(self.ui.uiNode, show)
end

return ItemPublicArticle
