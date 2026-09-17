local this = class("cellChatPlayer", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {photoEntity = nil, isAni = false}
end

function this.bind()
  return {
    go_active = false,
    go_normal = false,
    txt_name_active = "",
    txt_name_normal = "",
    go_meetingHead_active = false,
    go_meetingHead_normal = false,
    go_head = true
  }
end

function this.methods()
  return {
    onClick_select = function(self)
      if not self.bind.go_active then
        self.bindComponents.ani_active:Play()
        self.data.isAni = true
      end
      self:emit("onClick_select", self.bind)
    end
  }
end

function this:refresh()
  local id = self.bind.meeting ~= true and self.bind.serverData.playerUid or 0
  if not self.data.isAni and self.parent.data.selectPlayerUid == id then
    self.data.isAni = true
    self.bindComponents.ani_active:Play()
  end
  local unreadMessageNum = L_ChatStore:getUnreadMessageNum(self.bind.serverData)
  self.bindComponents.go_messageNum.gameObject:ActiveTrans(not math.isEmpty(unreadMessageNum))
  if not math.isEmpty(unreadMessageNum) then
    self.bindComponents.txt_messageNum.text = 99 < unreadMessageNum and "99+" or tostring(unreadMessageNum)
  end
  if not string.isEmpty(self.bind.url_head) then
    if self.data.photoEntity == nil then
      self.data.photoEntity = L_PhotoManager:bindPhotoEntity(self.bindComponents.img_head.gameObject, self.bind.url_head)
    else
      self.data.photoEntity:bindGameObject(self.bindComponents.img_head.gameObject)
    end
  elseif self.data.photoEntity then
    self.data.photoEntity:dispose()
    self.data.photoEntity = nil
  end
end

function this:close()
  if self.data.photoEntity then
    self.data.photoEntity:dispose()
    self.data.photoEntity = nil
  end
end

return this
