local dialogLogSpeakItem = class("dialogLogSpeakItem", G_UIModuleBase)
local tag = "dialogLogSpeakItem"

function dialogLogSpeakItem.methods()
  return {}
end

function dialogLogSpeakItem.bind()
  return {
    headIcon = "",
    speaker = "",
    content = "",
    rectSize = C_Vector2(1080, 200)
  }
end

function dialogLogSpeakItem:created(data, meth, parent)
  self.super.created(self, data, meth, parent)
  self._parent = parent
  self._data = data
end

function dialogLogSpeakItem:open(options)
  self.bind.rectSize = C_Vector2(1080, self.bindComponents.TextContent.preferredHeight + 170)
end

return dialogLogSpeakItem
