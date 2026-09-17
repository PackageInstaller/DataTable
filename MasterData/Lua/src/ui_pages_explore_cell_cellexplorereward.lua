local this = class("cellExploreReward", G_UIModuleBase)

function this.bind()
  return {
    go_curLevel = false,
    levelIcon = "",
    list_reward = L_Const.ModuleInfo.CellIconBag,
    go_reward = false,
    go_reward_iffly = false
  }
end

function this.methods()
  return {}
end

function this:open()
  if self.isBind then
    self:initCell()
  end
end

function this:initCell()
  if self.bind.iffly == 1 then
    self:showCommonReward(false)
  elseif self.bind.reward then
    self:showCommonReward(true)
    local tmp = {}
    for i, v in pairs(self.bind.reward) do
      local isReceived = L_WorldExploreStore:getExploreGotId(self.bind.id, self.bind.sceneId)
      table.insert(tmp, {
        itemType = v.itemType,
        itemId = v.itemId,
        itemNum = v.itemNum,
        isReceived = isReceived
      })
    end
    self.bind.list_reward:clear()
    self.bind.list_reward:insert_array(tmp)
  end
end

function this:showCommonReward(commonReward)
  self.bind.go_reward = commonReward
  self.bind.go_reward_iffly = not commonReward
end

return this
