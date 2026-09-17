local this = class("modulePhotoGroup_param", require("ui.pages.photo.group.modulePhotoGroup_base"))

function this.bind()
  return {
    list = {
      moduleName = "pages/photo/cell/cellPhotoParams"
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
  self.mediator = L_PhotoManager:getMediator()
  self.paramDic = self.mediator.paramDic
  self.bind.selectedId = L_Const.photoParam.wideIntensity
end

function this:close()
end

function this:show()
  self:initGroupList(L_Const.photoGroup.param)
end

function this:update()
end

function this:setVal(id, val)
  L_PhotoManager:getMediator():setPhotoParmVal(id, val)
  local defaultMin, defaultMax = this.super.getDefaultMinAndMax(self, id)
end

function this:getDefaultVal(id)
  if self.settingId == L_Const.photoParam.rotation then
    return self.mediator:getPhotoParmVal(self.settingId)
  end
  local val = self.paramDic[id] or this.super.getDefaultVal(self, id)
  return val
end

function this:resetAll()
  for i, v in pairs(self.modules.list) do
    v:resetVal()
  end
end

return this
