local this = class("cellEmotionEdit", G_UIModuleBase)
local emojiTpl = L_GameTpl:getChatEmojiTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {}
end

function this.bind()
  return {go_self = ""}
end

function this.methods()
  return {
    onClick_edit = function(self)
      self:emit("onClick_edit", self.bind)
    end
  }
end

return this
