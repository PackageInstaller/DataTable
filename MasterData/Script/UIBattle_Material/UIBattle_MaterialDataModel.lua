local DataModel = {CurrentNum = 0}

function DataModel:Init(initParams)
  local params = Json.decode(initParams)
  DataModel.initParams = params
  local id = params.id
  DataModel.activityId = params.activityId
  DataModel.maxNum = params.maxNum
  DataModel.titleIndex = params.titleIndex
  DataModel.battleLeftIndex = params.battleLeftIndex
  DataModel.LevelConfig = PlayerData:GetFactoryData(id)
  local levelList = DataModel.LevelConfig.levelList
  DataModel.LevelList = {}
  local unLockIndex = 0
  for k, v in pairs(levelList) do
    local row = {}
    local levelCA = PlayerData:GetFactoryData(v.id)
    row.levelId = v.id
    row.unlockLv = v.UnlockLv
    row.unlock = PlayerData:GetUserInfo().lv >= v.UnlockLv
    if PlayerData:GetUserInfo().lv >= v.UnlockLv then
      unLockIndex = unLockIndex + 1
    end
    row.isEnemyLvEquilsPlayer = levelCA.isEnemyLvEquilsPlayer
    row.recomGrade = levelCA.recomGrade
    row.extraLevelOffset = levelCA.extraLevelOffset
    row.iconPath = DataModel.LevelConfig.iconPath
    row.levelName = levelCA.levelName
    row.description = levelCA.description
    row.dropList = PlayerData:GetLevelDropListNew(v.id)
    row.cost = DataModel.LevelConfig.cost
    local bossViewId = PlayerData:GetFactoryData(levelCA.bossId).viewId
    row.resDir = PlayerData:GetFactoryData(bossViewId).resDir
    row.isFinish = PlayerData:GetLevelPass(v.id)
    table.insert(DataModel.LevelList, row)
  end
  if unLockIndex == 0 then
    unLockIndex = 1
  end
  DataModel.LeftIndex = params.leftIndex or unLockIndex
end

function DataModel.GetConfig()
  local config = PlayerData:GetFactoryData(99900140)
  return config
end

function DataModel:SetCurrentNum(num)
  DataModel.CurrentNum = num
end

function DataModel:BattleEndSetCurrentNum()
  DataModel.CurrentNum = DataModel.CurrentNum + 1
end

function DataModel:CheckIsActive()
  local isActivity = false
  if #DataModel.LevelConfig.openDay > 0 then
    for m, n in pairs(DataModel.LevelConfig.openDay) do
      if TimeUtil:CheckWDay(n.week, 5) == true then
        isActivity = true
        break
      end
    end
  else
    isActivity = true
  end
  return isActivity
end

return DataModel
