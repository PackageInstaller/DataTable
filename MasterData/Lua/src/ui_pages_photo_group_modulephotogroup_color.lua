local this = class("modulePhotoGroup_color", require("ui.pages.photo.group.modulePhotoGroup_base"))
local IDTOFIELD = L_PhotoManager.IDTOFIELD

function this.bind()
  return {
    selectedId = 0,
    list = {
      moduleName = "pages/photo/cell/cellPhotoColorSlider"
    }
  }
end

function this.methods()
  return {
    onClick_reset = function(self)
      self:resetAll()
    end,
    onClickHideGroup = function(self)
      L_PhotoManager:sendEvent(L_PhotoManager.event.isActiveBg)
      self:hideGroup()
    end
  }
end

function this:open()
end

function this:show()
  self:initGroupList(L_Const.photoGroup.color)
end

function this:close()
end

function this:setVal(id, val)
  local filter = L_PhotoManager:getMediator().photoFilter
  filter[IDTOFIELD[id]] = val
end

function this:getDefaultVal(id)
  local filter = L_PhotoManager:getMediator().photoFilter
  local val = filter[IDTOFIELD[id]]
  return val
end

function this:resetAll()
  for i, v in pairs(self.modules.list) do
    v:resetVal()
  end
end

return this
