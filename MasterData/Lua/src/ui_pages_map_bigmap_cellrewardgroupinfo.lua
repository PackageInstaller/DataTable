local this = class("cellRewardGroupInfo", G_UIModuleBase)

local function getRewardKey(itemType, itemId)
  return string.format("%s_%s", itemType, itemId)
end

local function getSortedRewardData(rewardList, clientSortRwdList)
  if table.isEmpty(rewardList) then
    return {}
  end
  local parsedRewardData = L_DataUtil.parseRangeRewardConfig(rewardList)
  local rewardKeyMap = {}
  local sortRewardList = {}
  for i, reward in ipairs(rewardList) do
    if reward.itemNumTxt ~= nil then
      parsedRewardData[i].itemNumTxt = reward.itemNumTxt
    end
    table.insert(sortRewardList, {
      reward[1],
      reward[2],
      reward[3] or 0
    })
    local key = getRewardKey(reward[1], reward[2])
    rewardKeyMap[key] = rewardKeyMap[key] or {}
    table.insert(rewardKeyMap[key], parsedRewardData[i])
  end
  local sortedRewardList = L_DataUtil.parseRewardConfig(sortRewardList, false, true, clientSortRwdList)
  local result = {}
  for _, reward in ipairs(sortedRewardList) do
    local key = getRewardKey(reward.itemType, reward.itemId)
    local queue = rewardKeyMap[key]
    if not table.isEmpty(queue) then
      table.insert(result, table.remove(queue, 1))
    end
  end
  return result
end

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    desc = "",
    rewardSize = C_Vector2(490, 166),
    rewardList = L_Const.ModuleInfo.CellIconBag
  }
end

function this.methods()
  return {}
end

function this:open()
  self:initReward()
end

function this:close()
end

function this:initReward()
  local reward_data = self.bind.reward and getSortedRewardData(self.bind.reward, self.bind.clientSortRwdList) or nil
  if not table.isEmpty(reward_data) then
    self.bind.rewardList:clear()
    self.bind.rewardList:insert_array(reward_data)
    local row = #reward_data // 4
    local offset = #reward_data % 4
    if row < 1 then
      row = 1
    end
    if 1 <= row and 0 < offset and 4 < #reward_data then
      row = row + 1
    end
    self.bind.rewardSize = C_Vector2(490, 26 + row * 140)
    L_GameUtil.forceRebuildLayout(self.bindComponents.cellRewardTrans)
  end
end

return this
