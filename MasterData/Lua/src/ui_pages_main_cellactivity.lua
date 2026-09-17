local this = class("cellActivity", G_UIModuleBase)
local _bannerTpl = L_GameTpl:getCommonBannerTpl()

function this.bind()
  return {img_activity = nil}
end

function this.methods()
  return {
    onClick_activity = function(self)
      local tpl = _bannerTpl:getTplById(self.bind.activityId)
      local bannerType = _bannerTpl:getType(tpl)
      local eventData = {
        banner_id = self.bind.activityId,
        banner_type = bannerType
      }
      L_GameUtil.logEvent(L_Const.logEventName.banner_click, eventData)
      if self.bind.clickBannerCallback then
        self.bind.clickBannerCallback(self, self.bind.param)
        return
      end
      L_UI:open("pageGameAct")
    end,
    onPointerEnter = function(self)
      self:emit("onPointerEnter")
    end,
    onPointerExit = function(self)
      self:emit("onPointerExit")
    end
  }
end

function this:refreshData(data)
  self.bind.img_activity = data.img_activity
  self.bind.clickBannerCallback = data.clickBannerCallback
  self.bind.activityId = data.activityId
  self.bind.order = data.order
  self.bind.param = data.param
end

return this
