local this = class("modulePhotoGroup_setting", require("ui.pages.photo.group.modulePhotoGroup_base"))

function this.bind()
  return {
    list = {
      moduleName = "pages/photo/cell/cellPhotoSetting"
    }
  }
end

function this.methods()
  return {
    list = {
      onValueChanged_select = function(self, id, isOn)
        local mediator = L_PhotoManager:getMediator()
        mediator:setSetting(id, isOn)
      end
    },
    onClickHideGroup = function(self)
      L_PhotoManager:sendEvent(L_PhotoManager.event.isActiveBg)
      self:hideGroup()
    end
  }
end

function this:open()
  self:initGroupList(L_Const.photoGroup.setting)
  L_PhotoManager:addListener(L_PhotoManager.event.photoSettingChange, self.onEvent_photoSettingChange, self)
end

function this:close()
  L_PhotoManager:removeListener(L_PhotoManager.event.photoSettingChange, self.onEvent_photoSettingChange, self)
end

function this:packList(data, tpl, index)
  this.super.packList(self, data, tpl, index)
  local mediator = L_PhotoManager:getMediator()
  data.isOn = mediator:getSettingOrDefault(data.id)
end

function this:onEvent_photoSettingChange()
  if not self.isBind then
    return
  end
  self:initGroupList(L_Const.photoGroup.setting)
end

return this
