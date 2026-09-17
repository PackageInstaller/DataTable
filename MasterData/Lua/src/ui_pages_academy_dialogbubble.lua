local dialogBubble = class("dialogBubble", G_UIModuleBase)

function dialogBubble.bind()
  return {
    desc = "",
    rectSize = C_Vector2(958, 30)
  }
end

function dialogBubble.methods()
  return {}
end

function dialogBubble:toBind(uiBinding)
  self.super.toBind(self, uiBinding)
  self.bind.rectSize = C_Vector2(math.min(392, self.bindComponents.Text.preferredWidth) + 111, self.bindComponents.Text.preferredHeight + 121)
end

function dialogBubble:setText(text)
  self.bind.desc = text
  self.bind.rectSize = C_Vector2(math.min(392, self.bindComponents.Text.preferredWidth) + 111, self.bindComponents.Text.preferredHeight + 121)
end

return dialogBubble
