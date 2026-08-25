local RpgMoneyLevelItem, Super = System.NewComponent("RpgMoneyLevelItem")

function RpgMoneyLevelItem:ctor(res, data)
  Super.ctor(self)
  self.ui = Item_List_Gold_RpgResource(res)
  self.data = data
  self.selected = Vue.ref(false)
end

function RpgMoneyLevelItem:OnBind(binder)
  self.binder = binder
  if not self.data then
    return
  end
  binder:BindButtonClick(self.ui.Btn_Dialog, System.fn(self, self.OnClick))
  binder:BindToVisible(self.ui.Image_Select, function()
    return self.selected.value
  end)
end

function RpgMoneyLevelItem:SetSelected(selected)
  self.selected.value = selected
end

function RpgMoneyLevelItem:OnClick()
  if not self.data or not self.data.callback then
    return
  end
  self.data.callback(self.data.level.tid)
end

return RpgMoneyLevelItem
