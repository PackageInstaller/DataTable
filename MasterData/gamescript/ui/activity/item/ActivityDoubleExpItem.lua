local ActivityDoubleExpItem, Super = System.NewClass("ActivityDoubleExpItem", ActivityBaseComp)

function ActivityDoubleExpItem:ctor(res, func)
  Super.ctor(self)
  self.ui = UI_Events_Item_DoubleDropResource(res)
  self.func = func
end

function ActivityDoubleExpItem:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Image_Location, System.fn(self, self.JumpFunction))
  self.ui.Text_Title:SetActive(false)
  self.ui.Text_Task:SetActive(false)
end

function ActivityDoubleExpItem:JumpFunction()
  self.func()
end

return ActivityDoubleExpItem
