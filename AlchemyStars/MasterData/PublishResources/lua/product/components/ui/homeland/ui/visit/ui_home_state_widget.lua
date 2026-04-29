_class("UIHomeStateWidget", Object)
UIHomeStateWidget = UIHomeStateWidget
local type = {
  SpriteSwap = 1,
  ColorTint = 2,
  TextSwap = 3
}
_enum("UIHomeStateWidgetType", type)

function UIHomeStateWidget:Constructor(widgets)
  self._widgets = widgets
  self._state = nil
end

function UIHomeStateWidget:ChangeState(state)
  if self._state == state then
    return
  end
  self._state = state
  for _, widget in ipairs(self._widgets) do
    local ui = widget.UI
    local type = widget.Type
    local target = widget.States[state]
    if type == UIHomeStateWidgetType.SpriteSwap then
      ui.sprite = target
    elseif type == UIHomeStateWidgetType.ColorTint then
      ui.color = target
    elseif type == UIHomeStateWidgetType.TextSwap then
      ui:SetText(target)
    end
  end
end
