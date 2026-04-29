_class("LuaUIView", Object)
LuaUIView = LuaUIView
local UIEvent = {
  Guide = 0,
  Click = 1,
  DoubleClick = 2,
  Press = 3,
  Release = 4,
  Hovered = 5,
  Unhovered = 6,
  Select = 7,
  UpdateSelect = 8,
  BeginDrag = 9,
  Drag = 10,
  EndDrag = 11,
  Scroll = 12,
  ApplicationFocus = 13,
  LongClick = 14,
  LongPress = 15,
  ToggleChanged = 16,
  SliderChanged = 17,
  DropdownChanged = 18,
  ScrollRectChanged = 19,
  InputFieldChanged = 20,
  InputFieldEndEdit = 21,
  InputFieldValidate = 22
}
_enum("UIEvent", UIEvent)
local UIEventFuncs = {
  {
    "OnClick",
    "onClick",
    "AddClickListener"
  },
  {
    "OnDoubleClick",
    "onDoubleClick",
    "AddDoubleClickListener"
  },
  {
    "OnPressed",
    "onDown",
    "AddPressListener"
  },
  {
    "OnReleased",
    "onUp",
    "AddReleaseListener"
  },
  {
    "OnHovered",
    "onEnter",
    "AddHoveredListener"
  },
  {
    "OnUnhovered",
    "onExit",
    "AddUnhoveredListener"
  },
  {
    "OnSelect",
    "onSelect",
    "AddSelectListener"
  },
  {
    "OnUpdateSelect",
    "onUpdateSelect",
    "AddUpdateSelectListener"
  },
  {
    "OnBeginDrag",
    "onBeginDrag",
    "AddBeginDragListener"
  },
  {
    "OnDrag",
    "onDrag",
    "AddDragListener"
  },
  {
    "OnEndDrag",
    "onEndDrag",
    "AddEndDragListener"
  },
  {
    "OnScroll",
    "onScroll",
    "AddScrollListener"
  },
  {
    "OnApplicationFocus",
    "onApplicationFocus",
    "AddFocusListener"
  },
  {
    "OnLongClick",
    "onClick",
    "AddLongClickListener"
  },
  {
    "OnLongPress",
    "onLongPress",
    "AddLongPressListener"
  },
  {
    "OnValueChanged",
    "onValueChanged",
    "AddToggleListener"
  },
  {
    "OnValueChanged",
    "onValueChanged",
    "AddSliderListener"
  },
  {
    "OnValueChanged",
    "onValueChanged",
    "AddDropDownListener"
  },
  {
    "OnValueChanged",
    "onValueChanged",
    "AddScrollRectListener"
  },
  {
    "OnValueChanged",
    "onValueChanged",
    "AddInputFieldListener"
  },
  {
    "OnEndEdit",
    "onEndEdit",
    "AddInputFieldEndEdit"
  },
  {
    "OnValidateInput",
    "onValidateInput",
    "AddInputFieldValidate"
  }
}

function LuaUIView:Constructor()
  self.uiEventListeners = {}
end

function LuaUIView:Dispose()
end

function LuaUIView:SetShow(bShow, ui)
  if self.isShow == bShow then
    return
  end
  self.isShow = bShow
  if bShow then
    self:OnShow(ui)
  else
    self:OnHide()
  end
end

function LuaUIView:OnShow(ui)
  self.ui = ui
  self:AddUIListeners()
end

function LuaUIView:OnHide()
  self:RemoveUIListeners()
end

function LuaUIView:AddUIEvent(uiEventType, widget, name)
  self[UIEventFuncs[uiEventType][3]](self, widget, name)
end

function LuaUIView:AddClickListener(widget, name)
  name = name or widget.name
  local listener = UIClickListener:New(self.ui, name, widget)
  if not listener:IsSucceed() then
    return
  end
  local listeners = self.uiEventListeners[UIEvent.Click]
  if not listeners then
    self.uiEventListeners[UIEvent.Click] = {}
    listeners = self.uiEventListeners[UIEvent.Click]
  end
  listeners[name] = listener
end

function LuaUIView:AddDoubleClickListener(widget, name)
  name = name or widget.name
  local listener = UIDoubleClickListener:New(self.ui, name, widget)
  if not listener:IsSucceed() then
    return
  end
  local listeners = self.uiEventListeners[UIEvent.DoubleClick]
  if not listeners then
    self.uiEventListeners[UIEvent.DoubleClick] = {}
    listeners = self.uiEventListeners[UIEvent.DoubleClick]
  end
  listeners[name] = listener
end

function LuaUIView:AddPressListener(widget, name)
  name = name or widget.name
  local listener = UIPressedListener:New(self.ui, name, widget)
  if not listener:IsSucceed() then
    return
  end
  local listeners = self.uiEventListeners[UIEvent.Press]
  if not listeners then
    self.uiEventListeners[UIEvent.Press] = {}
    listeners = self.uiEventListeners[UIEvent.Press]
  end
  listeners[name] = listener
end

function LuaUIView:AddReleaseListener(widget, name)
  name = name or widget.name
  local listener = UIReleaseListener:New(self.ui, name, widget)
  if not listener:IsSucceed() then
    return
  end
  local listeners = self.uiEventListeners[UIEvent.Release]
  if not listeners then
    self.uiEventListeners[UIEvent.Release] = {}
    listeners = self.uiEventListeners[UIEvent.Release]
  end
  listeners[name] = listener
end

function LuaUIView:AddHoveredListener(widget, name)
  name = name or widget.name
  local listener = UIHoveredListener:New(self.ui, name, widget)
  if not listener:IsSucceed() then
    return
  end
  local listeners = self.uiEventListeners[UIEvent.Hovered]
  if not listeners then
    self.uiEventListeners[UIEvent.Hovered] = {}
    listeners = self.uiEventListeners[UIEvent.Hovered]
  end
  listeners[name] = listener
end

function LuaUIView:AddUnhoveredListener(widget, name)
  name = name or widget.name
  local listener = UIUnHoveredListener:New(self.ui, name, widget)
  if not listener:IsSucceed() then
    return
  end
  local listeners = self.uiEventListeners[UIEvent.Unhovered]
  if not listeners then
    self.uiEventListeners[UIEvent.Unhovered] = {}
    listeners = self.uiEventListeners[UIEvent.Unhovered]
  end
  listeners[name] = listener
end

function LuaUIView:AddSelectListener(widget, name)
  name = name or widget.name
  local listener = UISelectListener:New(self.ui, name, widget)
  if not listener:IsSucceed() then
    return
  end
  local listeners = self.uiEventListeners[UIEvent.Select]
  if not listeners then
    self.uiEventListeners[UIEvent.Select] = {}
    listeners = self.uiEventListeners[UIEvent.Select]
  end
  listeners[name] = listener
end

function LuaUIView:AddUpdateSelectListener(widget, name)
  name = name or widget.name
  local listener = UIUpdateSelectListener:New(self.ui, name, widget)
  if not listener:IsSucceed() then
    return
  end
  local listeners = self.uiEventListeners[UIEvent.UpdateSelect]
  if not listeners then
    self.uiEventListeners[UIEvent.UpdateSelect] = {}
    listeners = self.uiEventListeners[UIEvent.UpdateSelect]
  end
  listeners[name] = listener
end

function LuaUIView:AddBeginDragListener(widget, name)
  name = name or widget.name
  local listener = UIBeginDragListener:New(self.ui, name, widget)
  if not listener:IsSucceed() then
    return
  end
  local listeners = self.uiEventListeners[UIEvent.BeginDrag]
  if not listeners then
    self.uiEventListeners[UIEvent.BeginDrag] = {}
    listeners = self.uiEventListeners[UIEvent.BeginDrag]
  end
  listeners[name] = listener
end

function LuaUIView:AddDragListener(widget, name)
  name = name or widget.name
  local listener = UIDragListener:New(self.ui, name, widget)
  if not listener:IsSucceed() then
    return
  end
  local listeners = self.uiEventListeners[UIEvent.Drag]
  if not listeners then
    self.uiEventListeners[UIEvent.Drag] = {}
    listeners = self.uiEventListeners[UIEvent.Drag]
  end
  listeners[name] = listener
end

function LuaUIView:AddEndDragListener(widget, name)
  name = name or widget.name
  local listener = UIEndDragListener:New(self.ui, name, widget)
  if not listener:IsSucceed() then
    return
  end
  local listeners = self.uiEventListeners[UIEvent.EndDrag]
  if not listeners then
    self.uiEventListeners[UIEvent.EndDrag] = {}
    listeners = self.uiEventListeners[UIEvent.EndDrag]
  end
  listeners[name] = listener
end

function LuaUIView:AddScrollListener(widget, name)
  name = name or widget.name
  local listener = UIScrollListener:New(self.ui, name, widget)
  if not listener:IsSucceed() then
    return
  end
  local listeners = self.uiEventListeners[UIEvent.Scroll]
  if not listeners then
    self.uiEventListeners[UIEvent.Scroll] = {}
    listeners = self.uiEventListeners[UIEvent.Scroll]
  end
  listeners[name] = listener
end

function LuaUIView:AddFocusListener(widget, name)
  name = name or widget.name
  local listener = UIFocusListener:New(self.ui, name, widget)
  if not listener:IsSucceed() then
    return
  end
  local listeners = self.uiEventListeners[UIEvent.ApplicationFocus]
  if not listeners then
    self.uiEventListeners[UIEvent.ApplicationFocus] = {}
    listeners = self.uiEventListeners[UIEvent.ApplicationFocus]
  end
  listeners[name] = listener
end

function LuaUIView:AddLongClickListener(widget, name)
  name = name or widget.name
  local listener = LongClickListener:New(self.ui, name, widget)
  if not listener:IsSucceed() then
    return
  end
  local listeners = self.uiEventListeners[UIEvent.LongClick]
  if not listeners then
    self.uiEventListeners[UIEvent.LongClick] = {}
    listeners = self.uiEventListeners[UIEvent.LongClick]
  end
  listeners[name] = listener
end

function LuaUIView:AddLongPressListener(widget, name)
  name = name or widget.name
  local listener = LongPressListener:New(self.ui, name, widget)
  if not listener:IsSucceed() then
    return
  end
  local listeners = self.uiEventListeners[UIEvent.LongPress]
  if not listeners then
    self.uiEventListeners[UIEvent.LongPress] = {}
    listeners = self.uiEventListeners[UIEvent.LongPress]
  end
  listeners[name] = listener
end

function LuaUIView:AddToggleListener(widget, name)
  name = name or widget.name
  local listener = ToggleListener:New(self.ui, name, widget)
  local listeners = self.uiEventListeners[UIEvent.ToggleChanged]
  if not listeners then
    self.uiEventListeners[UIEvent.ToggleChanged] = {}
    listeners = self.uiEventListeners[UIEvent.ToggleChanged]
  end
  listeners[name] = listener
end

function LuaUIView:AddSliderListener(widget, name)
  name = name or widget.name
  local listener = SliderListener:New(self.ui, name, widget)
  local listeners = self.uiEventListeners[UIEvent.SliderChanged]
  if not listeners then
    self.uiEventListeners[UIEvent.SliderChanged] = {}
    listeners = self.uiEventListeners[UIEvent.SliderChanged]
  end
  listeners[name] = listener
end

function LuaUIView:AddDropDownListener(widget, name)
  name = name or widget.name
  local listener = DropDownListener:New(self.ui, name, widget)
  local listeners = self.uiEventListeners[UIEvent.DropdownChanged]
  if not listeners then
    self.uiEventListeners[UIEvent.DropdownChanged] = {}
    listeners = self.uiEventListeners[UIEvent.DropdownChanged]
  end
  listeners[name] = listener
end

function LuaUIView:AddScrollRectListener(widget, name)
  name = name or widget.name
  local listener = ScrollRectListener:New(self.ui, name, widget)
  local listeners = self.uiEventListeners[UIEvent.ScrollRectChanged]
  if not listeners then
    self.uiEventListeners[UIEvent.ScrollRectChanged] = {}
    listeners = self.uiEventListeners[UIEvent.ScrollRectChanged]
  end
  listeners[name] = listener
end

function LuaUIView:AddInputFieldListener(widget, name)
  name = name or widget.name
  local listener = InputFieldListener:New(self.ui, name, widget)
  local listeners = self.uiEventListeners[UIEvent.InputFieldChanged]
  if not listeners then
    self.uiEventListeners[UIEvent.InputFieldChanged] = {}
    listeners = self.uiEventListeners[UIEvent.InputFieldChanged]
  end
  listeners[name] = listener
end

function LuaUIView:AddInputFieldEndEdit(widget, name)
  name = name or widget.name
  local listener = InputFieldEndEdit:New(self.ui, name, widget)
  local listeners = self.uiEventListeners[UIEvent.InputFieldEndEdit]
  if not listeners then
    self.uiEventListeners[UIEvent.InputFieldEndEdit] = {}
    listeners = self.uiEventListeners[UIEvent.InputFieldEndEdit]
  end
  listeners[name] = listener
end

function LuaUIView:AddInputFieldValidate(widget, name)
  name = name or widget.name
  local listener = InputFieldValidata:New(self.ui, name, widget)
  local listeners = self.uiEventListeners[UIEvent.InputFieldValidate]
  if not listeners then
    self.uiEventListeners[UIEvent.InputFieldValidate] = {}
    listeners = self.uiEventListeners[UIEvent.InputFieldValidate]
  end
  listeners[name] = listener
end

function LuaUIView:AddUIListeners()
end

function LuaUIView:RemoveUIListeners()
  for _, listeners in next, self.uiEventListeners, nil do
    for _, v in next, listeners, nil do
      v:RemoveListener()
      v:Dispose()
    end
  end
  table.clear(self.uiEventListeners)
end

_class("UIListener", Object)
UIListener = UIListener
local widgets = {}

function UIListener:Constructor(target, name, widget)
  self.widget = widget
  self.name = name
  self.target = target
end

function UIListener:IsSucceed()
  return self.handler ~= nil
end

function UIListener:AddEvent()
  local methodName = self.name .. UIEventFuncs[self.kind][1]
  self.handler = self:CreateVoidEventHandler(self.target, methodName)
  if self.handler then
    self:AddListener()
  end
end

function UIListener:CreateVoidEventHandler(target, methodName)
  if not target then
    Log.fatal("[UI] Cannot Find Lua Table For UIEvent")
    return
  end
  local func = target[methodName]
  if not func then
    Log.fatal("[UI] Cannot Find Lua Function For UIEvent, ", methodName, "  ui ", target._className)
    return
  end
  return func
end

function UIListener.CallMethond(widget, kind, ...)
  local listener = widgets[kind][widget]
  return listener.handler(listener.target, ...)
end

function UIListener:AddListener()
  if self.widget then
    self.event = self.widget[UIEventFuncs[self.kind][2]]
    local widget = tostring(self.widget)
    self.address = widget
    local kind = self.kind
    if not widgets[kind] then
      widgets[kind] = {}
    end
    widgets[kind][widget] = self
    self.event:AddListener(function(...)
      UIListener.CallMethond(widget, kind, ...)
    end)
  end
end

function UIListener:RemoveListener()
  if self.widget then
    self.event:RemoveAllListeners()
  end
end

function UIListener:Dispose()
  widgets[self.kind][self.address] = nil
  self.widget = nil
  self.handler = nil
  self.target = nil
  self.event = nil
end

_class("TriggerListener", UIListener)
TriggerListener = TriggerListener

function TriggerListener:AddListener()
  if self.widget then
    local widget = tostring(self.widget)
    self.address = widget
    local kind = self.kind
    if not widgets[kind] then
      widgets[kind] = {}
    end
    widgets[kind][widget] = self
    self.event = UIEventTriggerListener.Get(self.widget.gameObject)
    self.event[UIEventFuncs[self.kind][2]] = function(...)
      UIListener.CallMethond(widget, kind, ...)
    end
  end
end

function TriggerListener:RemoveListener()
  if self.widget then
    self.event[UIEventFuncs[self.kind][2]] = nil
  end
end

_class("LongPressTrigger", TriggerListener)
LongPressTrigger = LongPressTrigger

function LongPressTrigger:AddListener()
  if self.widget then
    local widget = tostring(self.widget)
    self.address = widget
    local kind = self.kind
    if not widgets[kind] then
      widgets[kind] = {}
    end
    widgets[kind][widget] = self
    self.event = UILongPressTriggerListener.Get(self.widget.gameObject)
    self.event[UIEventFuncs[self.kind][2]] = function(...)
      UIListener.CallMethond(widget, kind, ...)
    end
  end
end

_class("UIClickListener", TriggerListener)
UIClickListener = UIClickListener

function UIClickListener:Constructor()
  self.kind = UIEvent.Click
  self:AddEvent()
end

_class("UIDoubleClickListener", TriggerListener)
UIDoubleClickListener = UIDoubleClickListener

function UIDoubleClickListener:Constructor()
  self.kind = UIEvent.DoubleClick
  self:AddEvent()
end

_class("UIPressedListener", TriggerListener)
UIPressedListener = UIPressedListener

function UIPressedListener:Constructor()
  self.kind = UIEvent.Press
  self:AddEvent()
end

_class("UIReleaseListener", TriggerListener)
UIReleaseListener = UIReleaseListener

function UIReleaseListener:Constructor()
  self.kind = UIEvent.Release
  self:AddEvent()
end

_class("UIHoveredListener", TriggerListener)
UIHoveredListener = UIHoveredListener

function UIHoveredListener:Constructor()
  self.kind = UIEvent.Hovered
  self:AddEvent()
end

_class("UIUnHoveredListener", TriggerListener)
UIUnHoveredListener = UIUnHoveredListener

function UIUnHoveredListener:Constructor()
  self.kind = UIEvent.Unhovered
  self:AddEvent()
end

_class("UISelectListener", TriggerListener)
UISelectListener = UISelectListener

function UISelectListener:Constructor()
  self.kind = UIEvent.Select
  self:AddEvent()
end

_class("UIUpdateSelectListener", TriggerListener)
UIUpdateSelectListener = UIUpdateSelectListener

function UIUpdateSelectListener:Constructor()
  self.kind = UIEvent.UpdateSelect
  self:AddEvent()
end

_class("UIBeginDragListener", TriggerListener)
UIBeginDragListener = UIBeginDragListener

function UIBeginDragListener:Constructor()
  self.kind = UIEvent.BeginDrag
  self:AddEvent()
end

_class("UIDragListener", TriggerListener)
UIDragListener = UIDragListener

function UIDragListener:Constructor()
  self.kind = UIEvent.Drag
  self:AddEvent()
end

_class("UIEndDragListener", TriggerListener)
UIEndDragListener = UIEndDragListener

function UIEndDragListener:Constructor()
  self.kind = UIEvent.EndDrag
  self:AddEvent()
end

_class("UIScrollListener", TriggerListener)
UIScrollListener = UIScrollListener

function UIScrollListener:Constructor()
  self.kind = UIEvent.Scroll
  self:AddEvent()
end

_class("UIFocusListener", TriggerListener)
UIFocusListener = UIFocusListener

function UIFocusListener:Constructor()
  self.kind = UIEvent.ApplicationFocus
  self:AddEvent()
end

_class("LongClickListener", LongPressTrigger)
LongClickListener = LongClickListener

function LongClickListener:Constructor()
  self.kind = UIEvent.LongClick
  self:AddEvent()
end

_class("LongPressListener", LongPressTrigger)
LongPressListener = LongPressListener

function LongPressListener:Constructor()
  self.kind = UIEvent.LongPress
  self:AddEvent()
end

_class("ToggleListener", UIListener)
ToggleListener = ToggleListener

function ToggleListener:Constructor()
  self.kind = UIEvent.ToggleChanged
  self:AddEvent()
end

function ToggleListener:AddListener()
  if self.widget then
    if not self.h3dToggle then
      local go = self.widget.gameObject
      local h3dToggle = go:GetComponent("H3DToggle")
      h3dToggle = h3dToggle or go:AddComponent(typeof(H3DToggle))
      self.h3dToggle = h3dToggle
    end
    local widget = tostring(self.widget)
    self.address = widget
    local kind = self.kind
    if not widgets[kind] then
      widgets[kind] = {}
    end
    widgets[kind][widget] = self
    self.h3dToggle:OnValueChanged(function(...)
      UIListener.CallMethond(widget, kind, ...)
    end)
  end
end

function ToggleListener:RemoveListener()
  if self.widget and self.h3dToggle then
    self.h3dToggle:OnValueChanged(nil)
  end
end

function ToggleListener:Dispose()
  self.h3dToggle = nil
end

_class("SliderListener", UIListener)
SliderListener = SliderListener

function SliderListener:Constructor()
  self.kind = UIEvent.SliderChanged
  self:AddEvent()
end

_class("DropDownListener", UIListener)
DropDownListener = DropDownListener

function DropDownListener:Constructor()
  self.kind = UIEvent.DropdownChanged
  self:AddEvent()
end

_class("ScrollRectListener", UIListener)
ScrollRectListener = ScrollRectListener

function ScrollRectListener:Constructor()
  self.kind = UIEvent.ScrollRectChanged
  self:AddEvent()
end

_class("InputFieldListener", UIListener)
InputFieldListener = InputFieldListener

function InputFieldListener:Constructor()
  self.kind = UIEvent.InputFieldChanged
  self:AddEvent()
end

_class("InputFieldEndEdit", UIListener)
InputFieldEndEdit = InputFieldEndEdit

function InputFieldEndEdit:Constructor()
  self.kind = UIEvent.InputFieldEndEdit
  self:AddEvent()
end

_class("InputFieldValidata", UIListener)
InputFieldValidata = InputFieldValidata

function InputFieldValidata:Constructor()
  self.kind = UIEvent.InputFieldValidate
  self:AddEvent()
end

function InputFieldValidata:AddListener()
  if self.widget then
    local widget = tostring(self.widget)
    self.address = widget
    local kind = self.kind
    if not widgets[kind] then
      widgets[kind] = {}
    end
    widgets[kind][widget] = self
    self.widget[UIEventFuncs[self.kind][2]] = function(...)
      return UIListener.CallMethond(widget, kind, ...)
    end
  end
end

function InputFieldValidata:RemoveListener()
  if self.widget then
    self.widget[UIEventFuncs[self.kind][2]] = nil
  end
end
