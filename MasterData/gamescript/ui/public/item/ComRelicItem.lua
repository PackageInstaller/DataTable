local ComRelicItem, Super = System.NewComponent("ComRelicItem")

function ComRelicItem:ctor(res, relicData, callback)
  Super.ctor(self)
  self.ui = UI_Common_Item_RelicResource(res)
  self.relicData = relicData
  self.callback = callback
end

function ComRelicItem:OnBind(binder)
  self.model = binder:createModel(ComRelicItemModel, self.relicData, self.callback)
  binder:BindButtonClick(self.ui.Btn_Click, function()
    if self.model.callback then
      self.model.callback()
    end
    local relicData = Vue.ref({
      relicTid = self.model.relicTid
    })
    local item = binder:BindNewComponentWithMask(CS.UnityEngine.GameObject.Find("UIRoot/SafeArea/TipPopRoot"), RelicBattleDetailItemComponent, Func_Creation_TipsResource, relicData)
    local pos = self.ui.Image_Icon.transform.position
    item:SetItemPos2(pos)
  end)
  binder:BindToText(self.ui.Text_Create, function()
    return self.model.createTypeName
  end)
  binder:BindToText(self.ui.Text_Name, function()
    return self.model.textName
  end)
  binder:BindToImage(self.ui.Image_Icon, function()
    return self.model.imageIcon
  end)
  binder:BindToImage(self.ui.Image_Create, function()
    return self.model.imageCreate
  end)
  binder:BindToImage(self.ui.Image_Quality, function()
    return self.model.imageQuality
  end)
end

return ComRelicItem
