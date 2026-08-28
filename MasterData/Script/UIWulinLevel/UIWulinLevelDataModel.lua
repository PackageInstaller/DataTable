local DataModel = {
  activityId = 86000321,
  initParams = {},
  levelInfo = {},
  deepRemainTime = 0,
  curPos = 0,
  preLevelIdx = 0,
  curLevelIdx = 0,
  ChooseRewardList = {},
  constAutoBattleTime = 3,
  remainAutoBattleTime = 3,
  ironSagaLevelAutoBattle = false,
  toPlayFirstPassAnim = false,
  waitToShowComplete = true,
  itemSpacex = -97,
  itemWidth = 400,
  contentMaxPosX = 5000,
  cacheScrollRect = nil,
  cacheTweenTransform = nil,
  isTweenAni = false
}

function DataModel.Init()
  DataModel.isTweenAni = false
  DataModel.curPos = DataModel.initParams.curPos or 0
  DataModel.curLevelIdx = DataModel.initParams.curLevelIdx or 0
  DataModel.ironSagaLevelAutoBattle = false
  DataModel.remainAutoBattleTime = DataModel.constAutoBattleTime
  DataModel.levelInfo = {}
  local activityCA = PlayerData:GetFactoryData(DataModel.activityId)
  for i, v in ipairs(activityCA.levelTypeList) do
    local t = {}
    local activityListCA = PlayerData:GetFactoryData(v.id)
    DataModel.levelInfo[i] = {}
    DataModel.levelInfo[i].levelList = t
    DataModel.levelInfo[i].completeCount = 0
    if v.startTime and v.startTime ~= "" then
      DataModel.levelInfo[i].startTime = TimeUtil:TimeStamp(v.startTime)
    else
      DataModel.levelInfo[i].startTime = 0
    end
    for j, v1 in ipairs(activityListCA.levelList) do
      t[j] = v1.id
      if PlayerData:GetLevelPass(v1.id) then
        DataModel.levelInfo[i].completeCount = DataModel.levelInfo[i].completeCount + 1
      end
    end
  end
end

function DataModel.InitRewardList(levelId)
  local levelCA = PlayerData:GetFactoryData(levelId)
  local firstPassAward = levelCA.firstPassAward
  local dropListNew = PlayerData:GetLevelDropList(levelCA)
  local state = PlayerData:GetLevelPass(levelId)
  DataModel.ChooseRewardList = {}
  for i, v in ipairs(firstPassAward) do
    table.insert(DataModel.ChooseRewardList, {
      num = v.num,
      id = v.itemId,
      type = 1,
      isFinish = state,
      index = i
    })
  end
  for i, v in ipairs(dropListNew) do
    table.insert(DataModel.ChooseRewardList, {
      num = v.num,
      id = v.id,
      type = 2,
      index = i
    })
  end
  if state == true then
    table.sort(DataModel.ChooseRewardList, function(a, b)
      if a.type == b.type then
        return a.index < b.index
      end
      return a.type > b.type
    end)
  else
    table.sort(DataModel.ChooseRewardList, function(a, b)
      if a.type == b.type then
        return a.index < b.index
      end
      return a.type < b.type
    end)
  end
end

function DataModel.GetCurSquadIdx()
  local squadIdx = 1
  local cacheSquadIdx = PlayerData:GetPlayerPrefs("int", "LastBattleSquadIndex")
  if 0 < cacheSquadIdx then
    squadIdx = cacheSquadIdx
  elseif PlayerData.BattleInfo and PlayerData.BattleInfo.squadIndex and 0 < PlayerData.BattleInfo.squadIndex then
    squadIdx = PlayerData.BattleInfo.squadIndex
  end
  return squadIdx
end

function DataModel.IsLevelUnlock(pos, idx)
  if idx == 1 then
    return true
  end
  if 0 < pos and pos < 3 then
    local info = DataModel.levelInfo[pos]
    if idx - 1 < #info.levelList then
      return PlayerData:GetLevelPass(info.levelList[idx - 1])
    end
  end
  return false
end

return DataModel
