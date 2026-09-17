local cls = class("cellEntrustStarReward", G_UIModuleBase)
local _dungeonEntrustRewardTpl = L_GameTpl:getDungeonEntrustRewardTpl()

function cls.bind()
  return {
    active_curReward = false,
    txt_starNum = "",
    list_boxReward = {
      moduleName = "pages/entrustTask/cellEntrustReward"
    }
  }
end

function cls:refresh()
  self.cfg = _dungeonEntrustRewardTpl:getTplById(self.bind.rewardId)
  self.bind.txt_starNum = string.format("x%s", _dungeonEntrustRewardTpl:getStarNum(self.cfg))
  self:refreshReward()
end

function cls:refreshReward()
  local received = L_EntrustStore:checkEntrustRewardReceived(self.bind.rewardId)
  local reward = _dungeonEntrustRewardTpl:getReward(self.cfg)
  local rewardItems = {}
  for i = 1, #reward do
    local item = L_ItemTplManager:getItemConfig(reward[i].itemType, reward[i].itemId)
    table.insert(rewardItems, {
      itemType = item.itemType,
      itemId = item.itemId,
      num = reward[i].itemNum,
      received = received
    })
  end
  for i = #reward + 1, 3 do
    table.insert(rewardItems, {received = false})
  end
  self.bind.list_boxReward:clear()
  self.bind.list_boxReward:insert_array(rewardItems)
end

return cls
