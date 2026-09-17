local this = class("moduleChatBaseInfo", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {photoEntity = nil}
end

function this.bind()
  return {
    txt_name = "",
    cellChatHead = {
      moduleName = "pages/chat/cellChatHead"
    }
  }
end

function this.methods()
  return {
    cellChatHead = {
      onClick = function(self, bind)
        self:emit("onClick_head", self.bind)
      end
    }
  }
end

function this:refresh()
end

function this:initShow()
  local _isSelfPlayer = L_PlayerStore:getPlayerId() == self.bind.uid
  self.modules.cellChatHead:refreshWithId(self.bind.uid)
end

return this
