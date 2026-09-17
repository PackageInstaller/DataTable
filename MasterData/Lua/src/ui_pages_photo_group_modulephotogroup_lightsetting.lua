local this = class("modulePhotoGroup_lightSetting", require("ui.pages.photo.group.modulePhotoGroup_base"))

function this.bind()
  return {
    modulePhotoLightSetting = {
      moduleName = "pages/photo/submodule/modulePhotoLightSetting"
    }
  }
end

function this.methods()
  return {
    modulePhotoLightSetting = {
      setLightColor = function(self, lightData)
        self:setLight()
      end,
      setLightIntensity = function(self, value)
        self:setLight()
      end
    },
    onClickHideGroup = function(self)
      L_PhotoManager:sendEvent(L_PhotoManager.event.isActiveBg)
      self:hideGroup()
    end
  }
end

function this:open()
  local mediator = L_PhotoManager.mediator
  if not mediator then
    return
  end
  self.lightData = mediator:getLightSettingData()
  self.modules.modulePhotoLightSetting.groupBase = self
  self.modules.modulePhotoLightSetting.isActive_togOn = false
  self.modules.modulePhotoLightSetting:initWithData(self.lightData)
  self.modules.modulePhotoLightSetting.bind.isActive_togOn = false
  self.modules.modulePhotoLightSetting.bind.isActive_range = false
  self:setLight()
end

function this:setLight()
  L_PhotoManager.mediator:setLightSetting(self.lightData)
end

function this:show()
  self.lightData = L_PhotoManager.mediator.globalLightData
end

function this:refresh()
end

function this:hide()
end

function this:close()
  self.lightData = {}
end

return this
