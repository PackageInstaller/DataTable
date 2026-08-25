local SchoolTowerData = DataCenter.schoolTowerData
local StageGroupType = CommonDefine.StageGroupType
local STAGE_MAX_STAR_NUM = 3
local SchoolTowerDataUtils = {}

function SchoolTowerDataUtils.ResetAll()
  SchoolTowerData.towerDataGroup = {}
  SchoolTowerData.scheduleID = 0
end

function SchoolTowerDataUtils.InitSchoolTowerData(callback)
  SchoolTowerDataUtils.InitByCfgData()
  SchoolTowerDataUtils.ReqOnOpenSchoolTower(callback)
end

function SchoolTowerDataUtils.InitByCfgData()
  local towerStageMap = {}
  for _, cfg in pairs(DT.Stage) do
    local stageGroupCfg = DT.StageGroup[cfg.BelongGroup]
    if stageGroupCfg.Type == StageGroupType.DisposableSchoolTower or stageGroupCfg.Type == StageGroupType.AlternationSchoolTower then
      if not towerStageMap[stageGroupCfg.ID] then
        towerStageMap[stageGroupCfg.ID] = {}
      end
      table.insert(towerStageMap[stageGroupCfg.ID], cfg)
    end
  end
  for _, cfg in pairs(DT.StageGroup) do
    if cfg.Type == StageGroupType.DisposableSchoolTower or cfg.Type == StageGroupType.AlternationSchoolTower then
      local towerData = SchoolTowerDataUtils.CreateTowerData(cfg.ID, towerStageMap)
      SchoolTowerData.towerDataGroup[cfg.ID] = towerData
    end
  end
end

function SchoolTowerDataUtils.UpdateByServerData(svrData)
  SchoolTowerDataUtils.SetScheduleID(svrData.rotation)
  for stageGroupId, tbl in pairs(svrData.groupList) do
    local towerData = SchoolTowerDataUtils.GetTowerDataGroup(stageGroupId)
    if not towerData then
      SchoolTowerDataUtils.SetTowerDataGroup(stageGroupId, tbl)
    else
      for k, v in pairs(tbl) do
        if "stageList" == k then
          for key, val in pairs(v) do
            towerData[k][key] = val
          end
        else
          towerData[k] = v
        end
      end
    end
  end
end

function SchoolTowerDataUtils.CreateTowerData(stageGroupId, towerStageMap)
  local rst = {}
  rst.totalStar = 0
  rst.stageGroupId = stageGroupId
  rst.starPrize = {}
  rst.stageList = {}
  if not towerStageMap[stageGroupId] then
    return rst
  end
  for _, stageCfg in pairs(towerStageMap[stageGroupId]) do
    rst.stageList[stageCfg.ID] = {
      star = 0,
      stageID = stageCfg.ID,
      firstRewardDraw = false,
      unlock = false
    }
  end
  return rst
end

function SchoolTowerDataUtils.CreateMockSvrData()
  return {
    groupList = {
      [96094] = {
        stageList = {
          [376369] = {
            star = 0,
            stageID = 376369,
            firstRewardDraw = false,
            awakerList = {}
          }
        },
        starPrize = {},
        totalStar = 0
      },
      [96470] = {
        stageList = {
          [381987] = {
            star = 0,
            stageID = 381987,
            firstRewardDraw = false,
            awakerList = {}
          }
        },
        starPrize = {},
        totalStar = 0
      }
    },
    rotation = 1
  }
end

function SchoolTowerDataUtils.ReqOnOpenSchoolTower(callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnOpenSchoolTower", function(data)
    Logger.Info("========== 请求界域塔模块数据成功 ==========\n", table.tostring(data or {}))
    SchoolTowerDataUtils.UpdateByServerData(data)
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 请求界域塔模块数据失败 ==========\n", table.tostring(data or {}))
  end)
end

function SchoolTowerDataUtils.SetScheduleID(val)
  SchoolTowerData.scheduleID = val
end

function SchoolTowerDataUtils.SetTowerDataGroup(stageGroupId, val)
  SchoolTowerData.towerDataGroup[stageGroupId] = val
end

function SchoolTowerDataUtils.GetTowerDataGroup(stageGroupId)
  return SchoolTowerData.towerDataGroup[stageGroupId] or {}
end

function SchoolTowerDataUtils.GetTowerDataByStageGroupType(stageGroupType)
  local rst = {}
  for k, v in pairs(SchoolTowerData.towerDataGroup) do
    local cfg = DT.StageGroup[k]
    if cfg.Type == StageGroupType.DisposableSchoolTower and cfg.Type == stageGroupType then
      table.insert(rst, v)
    elseif cfg.Type == StageGroupType.AlternationSchoolTower and cfg.Type == stageGroupType then
      local scheCfg = DT.StageGroupSchedule[SchoolTowerData.scheduleID]
      if scheCfg and scheCfg.Batch == cfg.Batch then
        table.insert(rst, v)
      end
    end
  end
  return rst
end

function SchoolTowerDataUtils.GetTowerRefreshTs()
  local cfg = DT.StageGroupSchedule[SchoolTowerData.scheduleID]
  if cfg then
    return cfg.CloseDate
  end
  return nil
end

function SchoolTowerDataUtils.GetTowerProgressStars(stageGroupId)
  local towerData = SchoolTowerDataUtils.GetTowerDataGroup(stageGroupId)
  if towerData and towerData.totalStar then
    return towerData.totalStar
  end
  return 0
end

function SchoolTowerDataUtils.GetTowerStageStar(stageGroupId, stageId)
  local towerData = SchoolTowerDataUtils.GetTowerDataGroup(stageGroupId)
  if towerData and towerData.stageList then
    return towerData.stageList[stageId] and towerData.stageList[stageId].star or 0
  end
  return 0
end

function SchoolTowerDataUtils.GetTowerStageData(stageId)
  local stageCfg = DT.Stage[stageId]
  if stageCfg then
    local stageGroupId = stageCfg.BelongGroup
    local towerData = SchoolTowerDataUtils.GetTowerDataGroup(stageGroupId)
    if towerData and towerData.stageList then
      return towerData.stageList[stageId]
    end
  end
  return nil
end

function SchoolTowerDataUtils.GetTowerLimitStars(stageGroupId)
  local rst = 0
  for _, stageData in pairs(SchoolTowerDataUtils.GetTowerDataGroup(stageGroupId).stageList or {}) do
    rst = rst + STAGE_MAX_STAR_NUM
  end
  return rst
end

function SchoolTowerDataUtils.GetTowerStageGroupIdByType(stageGroupType)
  local rst = {}
  for k, v in pairs(SchoolTowerData.towerDataGroup) do
    local cfg = DT.StageGroup[k]
    if cfg.Type == stageGroupType then
      if cfg.Type == StageGroupType.DisposableSchoolTower then
        table.insert(rst, k)
      elseif cfg.Type == StageGroupType.AlternationSchoolTower then
        local scheCfg = DT.StageGroupSchedule[SchoolTowerData.scheduleID]
        if scheCfg and scheCfg.Batch == cfg.Batch then
          table.insert(rst, k)
        end
      end
    end
  end
  return rst
end

function SchoolTowerDataUtils.NeedBanAlternationSchool()
  local hideTs = DT.GetConstant("SchoolTowerOfflineTime")
  return hideTs < TimeUtils.GetServerTime()
end

return SchoolTowerDataUtils
