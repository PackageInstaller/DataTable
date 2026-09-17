local this = class("cellChannelInfo", G_UIModuleBase)
local imageMap = {
  [1] = "UI/Atlas/Chat/tex_chat_icon_04.png",
  [2] = "UI/Atlas/Chat/tex_chat_icon_05.png",
  [3] = "UI/Atlas/Chat/tex_chat_icon_06.png",
  [4] = "UI/Atlas/Chat/tex_chat_icon_06.png"
}

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {photoEntity = nil}
end

function this.bind()
  return {
    uid = 1,
    txt_title = "",
    txt_titleUns = "",
    img_item = "",
    img_itemUn = "",
    txt_word = "",
    active_select = true,
    active_unSelect = false
  }
end

function this.methods()
  return {
    onClick_Channel = function(self)
      self:emit("onClick_Channel", self.bind.uid)
    end
  }
end

function this:open()
  self.bind.img_item = imageMap[self.bind.uid]
  self.bind.img_itemUn = imageMap[self.bind.uid]
  if self.bindComponents.reddotSmall then
    if self.bind.reddotKey then
      self:registerReddot(self.bindComponents.reddotSmall, self.bind.reddotKey)
    elseif self.bindComponents.reddotSmall then
      self.bindComponents.reddotSmall.gameObject:SetActive(false)
    end
  end
end

function this:close()
  L_TimerManager:clearTimer(self)
end

function this:refresh()
end

function this:refreshShow(id)
  self.bindComponents.tabItem.id = self.bind.uid
  local select = self.bind.uid == id
  self.bind.active_select = select
  self.bind.active_unSelect = not select
end

return this
