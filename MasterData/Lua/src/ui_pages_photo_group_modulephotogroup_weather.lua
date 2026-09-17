local this = class("modulePhotoGroup_weather", require("ui.pages.photo.group.modulePhotoGroup_base"))

function this.bind()
  return {
    selectedId = 0,
    list = {
      moduleName = "pages/photo/cell/cellPhotoMenu"
    }
  }
end

function this.methods()
  return {
    onValueChanged_selection = function(self, id)
      self:refreshSelection(id)
    end
  }
end

function this:open()
  self:initGroupList(L_Const.photoGroup.weather)
end

function this:refreshSelection(id)
end

return this
