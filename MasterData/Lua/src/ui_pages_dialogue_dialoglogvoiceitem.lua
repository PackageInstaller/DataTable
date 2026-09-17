local dialogLogVoiceItem = class("dialogLogVoiceItem", G_UIModuleBase)
local tag = "dialogLogVoiceItem"

function dialogLogVoiceItem.methods()
  return {}
end

function dialogLogVoiceItem.bind()
  return {
    content = "",
    rectSize = C_Vector2(1080, 200)
  }
end

function dialogLogVoiceItem:created(data, meth, parent)
  self.super.created(self, data, meth, parent)
  self._parent = parent
  self._data = data
end

function dialogLogVoiceItem:open(options)
  self.bind.rectSize = C_Vector2(1080, self.bindComponents.TextContent.preferredHeight + 99)
end

return dialogLogVoiceItem
