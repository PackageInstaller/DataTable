local this = class("cellFriendPlayer", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {photoEntity = nil}
end

function this.bind()
  return {
    txt_name = "",
    txt_level = "",
    go_state = false,
    txt_state = "",
    txt_sign = L_WordsTpl:getValue("ui_systemMessage_18"),
    operate_friend = false,
    operate_apply = false,
    state_online = false,
    state_offline = false,
    state_busy = false,
    go_shield = false
  }
end

function this.methods()
  return {
    onClick_head = function(self)
      local worldPosition = self.bindComponents.img_head.position
      self:emit("onClick_head", self.bind.uid, worldPosition)
    end,
    onClick_join = function(self)
      self:emit("onClick_join", self.bind.uid)
    end,
    onClick_chat = function(self)
      self:emit("onClick_chat", self.bind.uid)
    end,
    onClick_agree = function(self)
      self:emit("onClick_agree", self.bind.uid)
    end,
    onClick_refuse = function(self)
      self:emit("onClick_refuse", self.bind.uid)
    end,
    onClick_remove = function(self)
      self:emit("onClick_remove", self.bind.uid)
    end,
    onClick_addToChat = function(self)
      self:emit("onClick_addToChat", self.bind.uid)
    end
  }
end

function this:close()
  if self.data.photoEntity then
    self.data.photoEntity:dispose()
    self.data.photoEntity = nil
  end
end

function this:refresh()
  if not string.isEmpty(self.bind.url_defaultHero) then
    if self.data.photoEntity == nil then
      self.data.photoEntity = L_PhotoManager:bindPhotoEntity(self.bindComponents.img_head.gameObject, self.bind.url_defaultHero)
    else
      self.data.photoEntity:bindGameObject(self.bindComponents.img_head.gameObject)
    end
  end
  self.bind.go_shield = L_FriendStore:getIsBlockChatList(self.bind.uid)
  if self.bindComponents.img_bg_line then
    self.bindComponents.img_bg_line.gameObject:ActiveTrans(self.bind.go_bgLine)
  end
end

return this
