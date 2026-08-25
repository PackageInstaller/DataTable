local ActivitySkinItem, Super = System.NewComponent("ActivitySkinItem")

function ActivitySkinItem:ctor(res, itemTid)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_SkinResource(res)
  self.itemTid = itemTid
  self.skinTid = AwakerSkinUtils.UnifyToSkinTid(itemTid)
end

function ActivitySkinItem:OnBind(binder)
  self.binder = binder
  self.binder:SetText(self.ui.Text_AwakerSkinName, AwakerSkinUtils.GetSkinName(self.skinTid))
  self.binder:SetImage(self.ui.Image_AwakerSkin, AwakerSkinUtils.GetSkinFullHeadImg(self.skinTid))
  self.binder:SetImage(self.ui.Image_Quality, AwakerSkinCfgUtils.GetSkinQualityImage(self.skinTid))
  self.binder:SetActive(self.ui.Image_RedDot, false)
  self.binder:BindButtonClick(self.ui.Btn_Skin_Click, System.fn(self, self.OnClickSkin))
end

function ActivitySkinItem:OnClickSkin()
  local previewSkinTid = self.skinTid
  UIManager.Instance:Reopen(Urls.AwakerPaintingView, nil, nil, previewSkinTid)
end

return ActivitySkinItem
