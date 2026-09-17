local this = class("cellAccessoryHomology", G_UIModuleBase)

function this.bind()
  return {
    txt_Name = "",
    txt_Num = "",
    list_cellAwardItem = {
      moduleName = "pages/achievement/cellAchievementAwardPreViewItem"
    }
  }
end

function this.methods()
  return {
    onclick_OnChange = function(self, isToggle)
      self:emit("onClick_Toggle", isToggle, self.bind.funcIndex)
    end,
    onclick_OnCheck = function(self)
      L_ItemTplManager:showInfoTip(self._itemType, self._itemId, self._guid)
    end
  }
end

function this:open()
  self:refreshData()
end

function this:refresh()
  self:refreshData()
end

function this:refreshData()
  local reward = L_DataUtil.parseRewardConfigItem(self.bind.cost[1])
  self._itemType = reward.itemType
  self._itemId = reward.itemId
  self._guid = 0
  local hadNum = 0
  local conf = L_ItemTplManager:getItemConfig(reward.itemType, reward.itemId)
  hadNum = L_ItemTplManager:getItemNum(reward.itemType, reward.itemId)
  if reward.itemType == 15 and hadNum ~= 0 then
    hadNum = hadNum - 1
  end
  self.bind.txt_Name = conf.name
  if L_DeviceTpl:getIsPc() then
    self.bind.txt_Num = string.format("<size=24>%s</size><size=20>/%s</size>", hadNum, reward.itemNum)
  else
    self.bind.txt_Num = string.format("<size=26>%s</size><size=22>/%s</size>", hadNum, reward.itemNum)
  end
  local data = {
    {
      itemType = reward.itemType,
      itemId = reward.itemId,
      itemNum = reward.itemNum
    }
  }
  self.bind.list_cellAwardItem:clear()
  self.bind.list_cellAwardItem:insert_array(data)
end

return this
