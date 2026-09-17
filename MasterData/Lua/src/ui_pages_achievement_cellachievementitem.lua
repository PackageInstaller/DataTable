local module = class("cellAchievementItem", G_UIModuleBase)

function module.bind()
  return {
    img_quality = nil,
    txt_name = nil,
    txt_condition = "",
    go_slider = true,
    value_slider = 0,
    not_slider = 1,
    go_reward = true,
    completed = false,
    txt_completeTime = nil,
    txt_progress = "",
    module_icon = L_Const.ModuleInfo.CellIcon,
    go_rewardCanCollect = false
  }
end

function module.methods()
  return {
    onClick_collect = function(self)
      self:emit("onClick_collect", self.bind.serverData.guid)
    end
  }
end

function module:refresh()
  self.modules.module_icon:setGeneralContent(self.bind.itemType, self.bind.itemId, {
    itemNum = self.bind.itemNum
  })
end

return module
