local this = class("cellAchievementAwardPreView", G_UIModuleBase)
local _achievementGroupTpl = L_GameTpl:getAchievementGroupTpl()
local _achievementTpl = L_GameTpl:getAchievementTpl()
local REWARDNUM = 3

function this.bind()
  return {
    txt_Num = "",
    list_cellItem = {
      moduleName = "modulePages/cellIconBag"
    },
    obj_select = false
  }
end

function this.methods()
  return {}
end

function this:open()
  local rewardTab = {}
  local isReceived = false
  self.bind.obj_select = isReceived
  if self.bind.nextAwardId < self.bind.id then
    isReceived = true
  elseif self.bind.nextAwardId == self.bind.id then
    self.bind.obj_select = true
  end
  self.bind.txt_Num = tostring(self.bind.point)
  for i = 1, REWARDNUM do
    local data = {}
    if i <= #self.bind.rewardDatas then
      data = L_DataUtil.parseRewardConfigItem(self.bind.rewardDatas[i])
    end
    table.insert(rewardTab, {
      itemId = data.itemId,
      itemType = data.itemType,
      itemNum = data.itemNum
    })
  end
  for _, v in pairs(self.bind.rewardDatas) do
  end
  self.bind.list_cellItem:clear()
  self.bind.list_cellItem:insert_array(rewardTab)
end

return this
