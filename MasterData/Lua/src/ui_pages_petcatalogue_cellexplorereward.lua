local module = class("cellPetExploreReward", G_UIModuleBase)

function module.bind()
  return {
    currActive = false,
    iconLevel = "",
    txtLevel = "",
    txtDesc = "",
    listReward = {
      moduleName = "pages/explore/cell/cellIconCommon"
    },
    txtActive = 22
  }
end

function module:refresh()
  self.bind.currActive = self.bind.needSelect or false
  self.bind.iconLevel = self.bind.icon or ""
  self.bind.txtLevel = self.bind.iconTxt or ""
  self.bind.txtDesc = self.bind.text or ""
  self.bind.txtActive = 22
  self.bind.listReward:clear()
  local rewards = {}
  if self.bind.reward then
    rewards = L_DataUtil.parseRewardConfig(self.bind.reward) or {}
    for _, rewardItem in ipairs(rewards) do
      rewardItem.go_received = self.bind.isComplete or false
      rewardItem.isEmpty = false
    end
  end
  for i = 1, 3 do
    if not rewards[i] then
      table.insert(rewards, {
        isEmpty = true,
        itemType = 0,
        itemId = 0,
        itemNum = 0,
        go_received = false,
        isSpecialEmpty = true,
        emptyIndex = i
      })
    end
  end
  self.bind.listReward:insert_array(rewards)
end

return module
