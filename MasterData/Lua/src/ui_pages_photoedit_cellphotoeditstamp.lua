local this = class("cellPhotoEditStamp", G_UIModuleBase)

function this.bind()
  return {img = ""}
end

function this.methods()
  return {
    onSelect = function(self)
      self:emit("onSelect", self.bind.id)
    end
  }
end

function this:open()
end

function this:refresh()
end

function this:close()
end

return this
