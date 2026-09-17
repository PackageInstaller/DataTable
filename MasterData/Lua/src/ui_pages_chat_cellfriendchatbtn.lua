local this = class("cellFriendChatBtn", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {}
end

function this.bind()
  return {txt_content = ""}
end

function this.methods()
  return {
    onclick_btn = function()
      if self.bind.action then
        self.bind.action()
      end
    end
  }
end

function this:refresh()
  self.bind.txt_content = self.bind.content
end

return this
