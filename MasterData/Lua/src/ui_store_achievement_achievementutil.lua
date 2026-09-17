local this = {}
local C_AchievementStore = CS.Lens.Gameplay.UI.AchievementStore

function this.getStore()
  return C_AchievementStore.GetStore()
end

local function toArray(list)
  local res = {}
  if list == nil then
    return res
  end
  local count = list.Count or list.Length or 0
  for i = 0, count - 1 do
    res[#res + 1] = list[i]
  end
  return res
end

function this.toMapFromPairs(list)
  local res = {}
  if list == nil then
    return res
  end
  local count = list.Count or 0
  for i = 0, count - 1 do
    local kv = list[i]
    if kv ~= nil then
      res[kv.Key] = kv.Value
    end
  end
  return res
end

local function toIntArray(arr)
  local res = {}
  if arr == nil then
    return res
  end
  local len = arr.Length or 0
  for i = 0, len - 1 do
    res[#res + 1] = arr[i]
  end
  return res
end

function this.toAchievementItem(item)
  if item == nil then
    return nil
  end
  return {
    guid = item.guid,
    achievementId = item.achievementId,
    groupId = item.groupId,
    isReward = item.isReward,
    count = toIntArray(item.count),
    finishTime = item.finishTime,
    sub_ach_id = toIntArray(item.subAchIds),
    sub_ach_fini_time = toArray(item.subAchFiniTimes),
    version = item.version
  }
end

function this.toAchievementMapFromPairs(list)
  local res = {}
  if list == nil then
    return res
  end
  local count = list.Count or 0
  for i = 0, count - 1 do
    local kv = list[i]
    if kv ~= nil then
      res[kv.Key] = this.toAchievementItem(kv.Value)
    end
  end
  return res
end

function this.tableToIntArray(args)
  if args == nil then
    return nil
  end
  local res = {}
  for i, v in ipairs(args) do
    res[i] = v
  end
  return res
end

function this.getAchieveIndexbyId(id)
  local idx = this.getStore():GetAchieveIndexbyId(id)
  if idx == nil then
    return 1, 1
  end
  return idx.firstIndex, idx.secondIndex
end

function this.getAchievementItem(achievementId, isCreate)
  local store = this.getStore()
  if isCreate == nil then
    return this.toAchievementItem(store:GetAchievementItem(achievementId))
  end
  return this.toAchievementItem(store:GetAchievementItem(achievementId, isCreate))
end

function this.getAchievementListByGroupId(groupId)
  return this.toAchievementMapFromPairs(this.getStore():GetAchievementListByGroupId(groupId))
end

function this.getFinishMap()
  return this.toMapFromPairs(this.getStore():GetFinishMap())
end

function this.getAchievementList()
  return this.toAchievementMapFromPairs(this.getStore():GetAchievementList())
end

function this.getEachLevelFinishNum()
  return this.toMapFromPairs(this.getStore():GetEachLevelFinishNum())
end

function this.req_collectAchievementGroupReward(guid, callback)
  this.getStore():Req_collectAchievementGroupReward(guid, function(data)
    if callback and data then
      callback(data.rewards, data.src)
    end
  end)
end

function this.req_collectAchievementReward(guid, callback)
  this.getStore():Req_collectAchievementReward(guid, function(data)
    if callback and data then
      callback(data.rewards, data.src)
    end
  end)
end

function this.req_clientBehaviourRecord(key, args, callback)
  this.getStore():Req_clientBehaviourRecord(key, this.tableToIntArray(args), callback)
end

function this.req_getAchievementPointRewaed(configId, callback)
  this.getStore():Req_getAchievementPointRewaed(configId, callback)
end

return this
