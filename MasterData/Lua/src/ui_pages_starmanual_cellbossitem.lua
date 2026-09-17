local this = class("cellBossItem", G_UIModuleBase)
local starManualLevelTpl = L_GameTpl:getStarManualLevelTpl()

function this:created(...)
  this.super.created(self, ...)
end

function this.bind()
  return {
    icon_1 = "",
    icon_2 = "",
    icon_3 = "",
    icon_4 = "",
    cost = "",
    rewardList = {
      moduleName = "modulePages/cellIconCircle"
    },
    name = "",
    name_2 = "",
    topTips = false,
    show_close = false,
    show_goto = false
  }
end

function this.methods()
  return {
    onClick_goto = function(self)
      self:emit("onClick_goto", self.bind)
    end
  }
end

function this:open()
  self.bind.name_2 = self.bind.name
  if not math.isEmpty(self.bind.id) then
    local icon = starManualLevelTpl:getPicBoss(starManualLevelTpl:getTplById(self.bind.id))
    for i = 1, 4 do
      self.bind["icon_" .. i] = string.format("%s_%d.png", icon, i)
    end
    if self.bindComponents.outSizeIcon.sprite == nil then
      self.bindComponents.outSizeIcon.color = C_Color(1, 1, 1, 0)
    else
      self.bindComponents.outSizeIcon.color = C_Color(1, 1, 1, 1)
    end
  end
  if not table.isEmpty(self.bind.itemList) then
    local data = {}
    self.bind.rewardList:clear()
    for i, v in pairs(self.bind.itemList) do
      table.insert(data, {
        itemType = v[1],
        itemId = v[2],
        itemNumTxt = 1 >= v[3] and "" or tostring(v[3])
      })
    end
    self.bind.rewardList:insert_array(data)
  end
end

function this:refresh()
end

return this
