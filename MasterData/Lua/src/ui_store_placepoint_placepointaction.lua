local this = {}

function this:rsp_pointSync(data)
  if not table.isEmpty(data.del_ids) then
    for i, v in ipairs(data.del_ids) do
      self.data.guidToPlacePointInfo[v] = nil
    end
  end
  if not table.isEmpty(data.places) then
    for i, v in ipairs(data.places) do
      local pointData = self:getPlacePointDataByGuid(v.guid, true)
      pointData.place_id = v.place_id
      pointData.building_guid = v.building_guid
      pointData.times = v.times
      pointData.extra_times = v.extra_times
      pointData.storage_counts = v.storage_counts
      pointData.extra_storage_counts = v.extra_storage_counts
      pointData.extra_storage = {}
      pointData.extra_storage.rewards = {}
      for i1, v1 in ipairs(v.extra_storage.rewards) do
        if v1.itemid ~= 0 then
          table.insert(pointData.extra_storage.rewards, v1)
        end
      end
      pointData.heros = v.heros or {}
    end
  end
  self:call(self.event.CSProtoPlaceSync, data)
end

function this:rsp_pointTake(data)
  local standReward = {}
  for i, v in ipairs(data.rewards.rewards) do
    local parseData = L_ItemManager:parseItem(v.itemtype, v.itemid)
    table.insert(standReward, {parseData = parseData, server = v})
  end
  table.sort(standReward, function(a, b)
    if a.parseData.quality == b.parseData.quality then
      return a.parseData.itemID < b.parseData.itemID
    end
    return a.parseData.quality > b.parseData.quality
  end)
  local exReward = {}
  for i, v in ipairs(data.extra_rewards.rewards) do
    if v.itemid ~= 0 then
      local parseData = L_ItemManager:parseItem(v.itemtype, v.itemid)
      table.insert(exReward, {parseData = parseData, server = v})
    end
  end
  table.sort(exReward, function(a, b)
    if a.parseData.quality == b.parseData.quality then
      return a.parseData.itemID < b.parseData.itemID
    end
    return a.parseData.quality > b.parseData.quality
  end)
  local rewards = {}
  for i, v in ipairs(standReward) do
    table.insert(rewards, v.server)
  end
  for i, v in ipairs(exReward) do
    table.insert(rewards, v.server)
  end
  if table.isEmpty(rewards) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_common_1"))
    self:call(self.event.CSProtoPlaceTake, data)
    return
  end
  L_RewardManager:showPage(rewards, data.rewards.src)
  self:call(self.event.CSProtoPlaceTake, data)
end

return this
