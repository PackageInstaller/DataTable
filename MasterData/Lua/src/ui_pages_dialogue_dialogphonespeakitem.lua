local dialogPhoneSpeakItem = class("dialogPhoneSpeakItem", G_UIModuleBase)
local tag = "dialogPhoneSpeakItem"

function dialogPhoneSpeakItem.methods()
  return {}
end

function dialogPhoneSpeakItem.bind()
  return {
    headIcon = "",
    speaker = "",
    content = "",
    rectSize = C_Vector2(1080, 200)
  }
end

function dialogPhoneSpeakItem:created(data, meth, parent)
  self.super.created(self, data, meth, parent)
  self._parent = parent
  self._data = data
end

function dialogPhoneSpeakItem:toBind(uiBinding)
  self.super.toBind(self, uiBinding)
  self.bind.rectSize = C_Vector2(1080, self.bindComponents.TextContent.preferredHeight + 170)
end

return dialogPhoneSpeakItem
