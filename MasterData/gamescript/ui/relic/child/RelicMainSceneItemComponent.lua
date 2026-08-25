local RelicMainSceneItemComponent, Super = System.NewComponent("RelicMainSceneItemComponent")

function RelicMainSceneItemComponent:ctor(res, tid)
  Super.ctor(self)
  self.res = res
  self.ui = Item_MainScene_Relic2Resource(res)
  self.tid = Vue.ref(tid)
  self.isSelected = Vue.ref(false)
end

function RelicMainSceneItemComponent:OnBind(binder)
  binder:BindToText(self.ui.Text_Story, function()
    do return RelicDataUtils.GetRelicDesc end
    return RelicDataUtils.GetRelicDesc, self.tid.value
  end)
  binder:BindToVisible(self.ui.Group_New, function()
    return false
  end)
end

return RelicMainSceneItemComponent
