local ItemPublicArticleGet, Super = System.NewComponent("ItemPublicArticleGet")

function ItemPublicArticleGet:ctor(res, itemTid, botText, ifSub, ifShowDesc, ifShowAppr, callback, subCallback)
  Super.ctor(self)
  self.ui = Item_Public_Article_GetResource(res)
  self.itemTid = Vue.ref(itemTid)
  self.botText = Vue.ref(botText)
  self.ifSub = Vue.ref(ifSub)
  self.ifShowDesc = ifShowDesc
  self.ifShowAppr = ifShowAppr
  self.callback = callback
  self.subCallback = subCallback
end

function ItemPublicArticleGet:OnBind(binder)
  self.binder = binder
  binder:BindComponent(ItemPublicArticle(self.ui.Item_Public_Article, self.itemTid, self.botText, self.ifSub, self.ifShowDesc, self.ifShowAppr, self.callback, self.subCallback))
  binder:SetActive(self.ui.Image_Bg, false)
end

function ItemPublicArticleGet:SetGetState(isGet)
  self.binder:SetActive(self.ui.Image_Bg, isGet)
end

return ItemPublicArticleGet
