_class("UICustomUIEventListener", Object)
UICustomUIEventListener = UICustomUIEventListener

function UICustomUIEventListener:Constructor()
  self.uiCustomEventListener = {}
end

function UICustomUIEventListener:Dispose()
  self:RemoveAllCustomEventListener()
end

function UICustomUIEventListener:RemoveCustomEventListener(delegate)
  self.uiCustomEventListener[delegate] = nil
end

function UICustomUIEventListener:AddUICustomEventListener(go, type, func)
  if type == UIEvent.Guide then
  elseif type == UIEvent.Click then
    go.onClick = func
    self.uiCustomEventListener[go.onClick] = func
  elseif type == UIEvent.DoubleClick then
    go.onDoubleClick = func
    self.uiCustomEventListener[go.onDoubleClick] = func
  elseif type == UIEvent.Press then
    go.onDown = func
    self.uiCustomEventListener[go.onDown] = func
  elseif type == UIEvent.Release then
    go.onUp = func
    self.uiCustomEventListener[go.onUp] = func
  elseif type == UIEvent.Hovered then
    go.onEnter = func
    self.uiCustomEventListener[go.onEnter] = func
  elseif type == UIEvent.Unhovered then
    go.onExit = func
    self.uiCustomEventListener[go.onExit] = func
  elseif type == UIEvent.Select then
    go.onSelect = func
    self.uiCustomEventListener[go.onSelect] = func
  elseif type == UIEvent.UpdateSelect then
  elseif type == UIEvent.BeginDrag then
    if go.onBeginDrag then
      go.onBeginDrag = go.onBeginDrag + func
    else
      go.onBeginDrag = func
    end
    self.uiCustomEventListener[go.onBeginDrag] = func
  elseif type == UIEvent.Drag then
    if go.onDrag then
      go.onDrag = go.onDrag + func
    else
      go.onDrag = func
    end
    self.uiCustomEventListener[go.onDrag] = func
  elseif type == UIEvent.EndDrag then
    if go.onEndDrag then
      go.onEndDrag = go.onEndDrag + func
    else
      go.onEndDrag = func
    end
    self.uiCustomEventListener[go.onEndDrag] = func
  elseif type == UIEvent.Scroll then
    go.onScroll = func
    self.uiCustomEventListener[go.onScroll] = func
  elseif type == UIEvent.ApplicationFocus then
    go.onApplicationFocus = func
    self.uiCustomEventListener[go.onApplicationFocus] = func
  elseif type == UIEvent.LongClick then
    go.onLongClick = func
    self.uiCustomEventListener[go.onLongClick] = func
  elseif type == UIEvent.LongPress then
    go.onLongPress = func
    self.uiCustomEventListener[go.onLongPress] = func
  elseif type == UIEvent.ToggleChanged then
  elseif type == UIEvent.SliderChanged then
  elseif type == UIEvent.DropdownChanged then
  elseif type == UIEvent.ScrollRectChanged then
  elseif type == UIEvent.InputFieldChanged then
    go.OnIptValueChanged = func
    self.uiCustomEventListener[go.OnIptValueChanged] = func
  elseif type == UIEvent.InputFieldEndEdit then
  elseif type == UIEvent.InputFieldValidate then
  end
end

function UICustomUIEventListener:RemoveAllCustomEventListener()
  for k, v in pairs(self.uiCustomEventListener) do
    self.uiCustomEventListener[k] = nil
  end
end

function UICustomUIEventListener.Get(go)
  return UIEventTriggerListener.Get(go)
end
