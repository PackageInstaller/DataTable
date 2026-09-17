local this = class("cellBlackPlayer", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {photoEntity = nil}
end

function this.bind()
  return {txt_name = "", txt_level = ""}
end

function this.methods()
  return {
    onClick_head = function(self)
      local worldPosition = self.bindComponents.img_head.position
      self:emit("onClick_head", self.bind.uid, worldPosition)
    end,
    onClick_remove = function(self)
      self:emit("onClick_remove", self.bind.uid)
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
end

return this
