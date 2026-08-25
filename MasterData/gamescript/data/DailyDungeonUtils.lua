local DailyDungeonUtils = {}

function DailyDungeonUtils.ResetAll()
  DataCenter.dailyDungeonData.dungeons = {}
  DataCenter.dailyDungeonData.levels = {}
  DataCenter.dailyDungeonData.jumpCopy = 0
  DataCenter.dailyDungeonData.jumpLevel = 0
end

function DailyDungeonUtils.Init(data)
  local dailyDungeons = {}
  DataCenter.dailyDungeonData.dungeons = dailyDungeons
  for k = 1, 10 do
    dailyDungeons[k] = {state = 1}
  end
end

function DailyDungeonUtils.ReqDailyDungeonInfo(callback)
  DataCenter.dailyDungeonData.dungeons = {}
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnGetDailyCopyInfos", function(data)
    for _, v in ipairs(data) do
      local show, unlock = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.DailyCopy, v.tid)
      table.insert(DataCenter.dailyDungeonData.dungeons, {
        id = v.tid,
        show = show,
        unlocked = unlock,
        open = v.open
      })
    end
    if callback then
      callback(DataCenter.dailyDungeonData.dungeons)
    end
  end)
end

function DailyDungeonUtils.ReqDailyDungeonLevels(dungeonType, callback)
  local levels = {}
  DataCenter.dailyDungeonData.levels[dungeonType] = levels
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnGetDailyLevelInfo", function(data)
    for _, v in ipairs(data) do
      table.insert(levels, {
        id = v.levelId,
        unlocked = v.unlocked
      })
    end
    table.sort(levels, function(a, b)
      return a.id < b.id
    end)
    if callback then
      callback(levels)
    end
  end, nil, dungeonType)
end

function DailyDungeonUtils.ReqEnterDungeonLevel(levelId, callback, failCallback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnEnterDailyCopy", function(data)
    Logger.Debug("结算数据 " .. table.tostring(data))
    CopiesDataUtils.SetSettleDataByProto(data)
    if callback then
      callback(data)
    end
  end, failCallback, levelId)
end

function DailyDungeonUtils.GetDailyDungeonData(id)
  for _, v in ipairs(DataCenter.dailyDungeonData.dungeons) do
    if v.id == id then
      return v
    end
  end
end

function DailyDungeonUtils.GetDailyDungeonLevels(dungeonType)
  local levels = DataCenter.dailyDungeonData.levels[dungeonType]
  return levels
end

function DailyDungeonUtils.UpdateDailyDungeons(data)
  for _, v in pairs(data.copyInfos) do
    local show, unlock = PlayerDataUtils.IsFeatureUnlock("DailyCopy", v.tid)
    table.insert(DataCenter.dailyDungeonData.dungeons, {
      id = v.tid,
      show = show,
      unlocked = unlock,
      open = v.open
    })
    DataCenter.dailyDungeonData.levels[v.tid] = {}
  end
  for dungeonType, v in pairs(data.levelInfos) do
    for _, levelInfo in ipairs(v) do
      local levelData = {
        id = levelInfo.levelId,
        unlocked = levelInfo.unlocked
      }
      table.insert(DataCenter.dailyDungeonData.levels[dungeonType], levelData)
    end
    table.sort(DataCenter.dailyDungeonData.levels[dungeonType], function(a, b)
      return a.id < b.id
    end)
  end
end

function DailyDungeonUtils.IsCopyUnlock(tid)
  local unlock = false
  if not DataCenter.dailyDungeonData.dungeons then
    return unlock
  end
  for _, data in pairs(DataCenter.dailyDungeonData.dungeons) do
    if data and data.id == tid then
      unlock = data.unlocked
      break
    end
  end
  return unlock
end

function DailyDungeonUtils.IsDailyCopyLevelUnlock(tid, levelTid)
  local unlock = false
  if not DataCenter.dailyDungeonData.levels or not DataCenter.dailyDungeonData.levels[tid] then
    return unlock
  end
  for _, data in pairs(DataCenter.dailyDungeonData.levels[tid]) do
    if data and data.id == levelTid then
      unlock = data.unlocked
      break
    end
  end
  return unlock
end

function DailyDungeonUtils.UpdateUnlockData(datas)
  if not datas then
    return
  end
  for _, dungeon in pairs(DataCenter.dailyDungeonData.dungeons) do
    local feature = datas[dungeon.tid]
    if dungeon and feature then
      dungeon.show = feature.show
      dungeon.unlock = feature.unlock
    end
  end
end

return DailyDungeonUtils
