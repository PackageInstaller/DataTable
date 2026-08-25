local UIClickableScrollView = NewClass("UIClickableScrollView")
local T_DragGesture = typeof(CS.Z1Client.General.DragGesture)

function UIClickableScrollView:ctor(scrollview, clickCallback)
  self.scrollview = scrollview
  self.clickCallback = clickCallback
  self.gesture = scrollview:GetComponent(T_DragGesture)
  if not self.gesture then
    self.gesture = scrollview:AddComponent(T_DragGesture)
  end
  self.gesture:onDrag("+", System.fn(self, self.OnDragScrollview))
  self.gesture:onPointerDown("+", System.fn(self, self.OnPointerDownUpponScrollview))
  self.gesture:onPointerClick("+", System.fn(self, self.OnPointerClickScrollview))
  self.isDragScrollview = false
end

function UIClickableScrollView:OnPointerDownUpponScrollview()
  self.isDragScrollview = false
end

function UIClickableScrollView:OnDragScrollview()
  self.isDragScrollview = true
end

function UIClickableScrollView:OnPointerClickScrollview()
  if self.isDragScrollview then
    return
  end
  if self.clickCallback then
    self.clickCallback()
  end
end

function UIClickableScrollView:Dispose()
  self.gesture:onDrag("-", System.fn(self, self.OnDragScrollview))
  self.gesture:onPointerDown("-", System.fn(self, self.OnPointerDownUpponScrollview))
  self.gesture:onPointerClick("-", System.fn(self, self.OnPointerClickScrollview))
end

return UIClickableScrollView
