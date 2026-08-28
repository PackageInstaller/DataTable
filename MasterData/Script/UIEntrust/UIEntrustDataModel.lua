local DataModel = {
  entrustList = {},
  timeList = {},
  limitCharacter = 5,
  basicBuildingIncrease = 0,
  curEntrustedCount = 0,
  maxEntrustedCount = 0,
  entrustedQueueLimit = false,
  entrustState = {
    Lock = 0,
    CanAccept = 1,
    Ing = 2,
    Complete = 3
  },
  toSaveEntrustUpdateIdx = false,
  showEntrustIdx = {},
  curEntrustSelectIdx = 0,
  timer = nil,
  QualityToType = {
    "N",
    "R",
    "SR",
    "SSR"
  },
  cacheRolesInEntrustId = {},
  roles = {},
  recommendSideDic = {},
  cacheMoveRoleElement = {},
  boundaryEnum = {
    None = 0,
    Left = 1,
    Right = 2,
    Up = 3,
    Bottom = 4
  },
  cacheBoundary = {},
  cacheMoveTimeLimit = {},
  idleTime = 0,
  speed = 0,
  standAniName = "dorm_stand",
  walkAniName = "dorm_walk",
  actionList = {},
  cacheUpdateRoleMoveInfo = {},
  recommendLayout = nil,
  updateLayout = false,
  isRewardUp = false,
  nextRewardUpRefreshTime = 0,
  coinBuffIncrease = 0
}

function DataModel.Init()
  DataModel.updateLayout = false
  DataModel.cacheUpdateRoleMoveInfo = {}
  DataModel.coinBuffIncrease = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddEntrustReward)
  local entrustConfig = PlayerData:GetFactoryData(99900069)
  DataModel.speed = entrustConfig.characterSpeed
  DataModel.cacheMoveTimeLimit.min = entrustConfig.triggerTimeMin
  DataModel.cacheMoveTimeLimit.max = entrustConfig.triggerTimeMax
  DataModel.idleTime = entrustConfig.idleTime
  DataModel.actionList = entrustConfig.actionList
  DataModel.limitCharacter = entrustConfig.entrustCharacter
  DataModel.timeList = entrustConfig.timeList
  DataModel.entrustList = {}
  local buildingNum = 0
  local branchLevelNum = 0
  local buildingInfo = PlayerData.ServerData.security_levels
  local homeSafeIncrease = 0
  if buildingInfo then
    for i, v in ipairs(entrustConfig.openBuildingList) do
      local strId = tostring(v.id)
      if buildingInfo[strId] then
        buildingNum = buildingNum + 1
        for levelPondId, levels in pairs(buildingInfo[strId]) do
          for levelId, levelInfo in pairs(levels.branch_levels) do
            if 0 < levelInfo.status then
              branchLevelNum = branchLevelNum + 1
            end
          end
        end
      end
    end
    homeSafeIncrease = branchLevelNum
    DataModel.maxEntrustedCount, DataModel.entrustedQueueLimit = DataModel.GetEntrustMaxCount()
  else
    homeSafeIncrease = 0
  end
  local battleCenterIncrease = 0
  local homeConfig = PlayerData:GetFactoryData(99900014)
  for i, stationId in ipairs(homeConfig.stationList) do
    local stationCA = PlayerData:GetFactoryData(stationId.id)
    if stationCA.isOpen and stationCA.isHomeBattleCentre then
      for i1, battleLevelId in ipairs(stationCA.battleLevelList) do
        if PlayerData:GetLevelPass(battleLevelId.id) then
          battleCenterIncrease = battleCenterIncrease + 1
        end
      end
    end
  end
  DataModel.basicBuildingIncrease = (homeSafeIncrease + battleCenterIncrease) * entrustConfig.levelCoefficient
  DataModel.cacheRolesInEntrustId = {}
  DataModel.curEntrustedCount = 0
  local cacheStartTimeList = {}
  if PlayerData.ServerData.entrust == nil then
    PlayerData.ServerData.entrust = {}
  end
  for i, v in ipairs(entrustConfig.entrustList) do
    local serverInfo = PlayerData.ServerData.entrust[tostring(v.id)]
    local curTime = TimeUtil:GetServerTimeStamp()
    local t = {}
    t = Clone(PlayerData:GetFactoryData(v.id))
    t.idx = i
    t.queueIdx = -1
    t.cacheTimeSelectIdx = PlayerData:GetPlayerPrefs("int", "EntrustTimeSelected" .. v.id)
    if 0 >= t.cacheTimeSelectIdx or t.cacheTimeSelectIdx > #DataModel.timeList then
      t.cacheTimeSelectIdx = 1
    end
    if serverInfo then
      t.roles = {}
      for i1, roleId in ipairs(serverInfo.roles) do
        t.roles[i1] = tonumber(roleId) or -1
      end
      PlayerData:SetPlayerPrefs("string", "EntrustRolesSelected" .. v.id, Json.encode(t.roles))
      t.totalTime = serverInfo.end_ts - serverInfo.create_ts
      t.startTime = serverInfo.create_ts
      t.endTime = serverInfo.end_ts
      local deltaTime = t.endTime - t.startTime
      local serverHour = deltaTime / 3600
      if serverHour ~= DataModel.timeList[t.cacheTimeSelectIdx].time then
        for i1, v1 in ipairs(DataModel.timeList) do
          if v1.time == serverHour then
            t.cacheTimeSelectIdx = i1
            PlayerData:SetPlayerPrefs("int", "EntrustTimeSelected" .. v.id, i1)
            break
          end
        end
      end
      t.award = serverInfo.award
      if curTime >= serverInfo.end_ts then
        t.state = DataModel.entrustState.Complete
      else
        t.state = DataModel.entrustState.Ing
      end
      DataModel.curEntrustedCount = DataModel.curEntrustedCount + 1
      local timeInfo = {}
      timeInfo.startTime = t.startTime
      timeInfo.idx = i
      table.insert(cacheStartTimeList, timeInfo)
    else
      t.roles = {
        -1,
        -1,
        -1,
        -1,
        -1
      }
      local cacheRoles = PlayerData:GetPlayerPrefs("string", "EntrustRolesSelected" .. v.id)
      if not string.nilorempty(cacheRoles) then
        t.roles = Json.decode(cacheRoles)
      end
      t.totalTime = 0
      t.startTime = 0
      t.endTime = 0
      t.award = nil
      t.state = DataModel.entrustState.CanAccept
    end
    for idx, roleId in ipairs(t.roles) do
      if 0 < roleId then
        if PlayerData.ServerData.roles[tostring(roleId)] == nil then
          t.roles[idx] = -1
        elseif DataModel.cacheRolesInEntrustId[roleId] then
          if serverInfo == nil then
            t.roles[idx] = -1
          end
        else
          DataModel.cacheRolesInEntrustId[roleId] = t.id
        end
      end
    end
    DataModel.entrustList[i] = t
  end
  table.sort(cacheStartTimeList, function(a, b)
    if a.startTime == b.startTime then
      return a.idx < b.idx
    end
    return a.startTime < b.startTime
  end)
  for i, v in ipairs(cacheStartTimeList) do
    DataModel.entrustList[v.idx].queueIdx = i
  end
  DataModel.SortEntrustList()
  DataModel.CheckIsRewardUp()
end

function DataModel.SaveRoleToEntrust(idx, roleId)
  local info = DataModel.entrustList[idx]
  local roleIdx = -1
  for i, id in ipairs(info.roles) do
    if id == -1 then
      info.roles[i] = roleId
      roleIdx = i
      break
    end
  end
  DataModel.SaveEntrustRolesToLocal(DataModel.curEntrustSelectIdx)
  return roleIdx
end

function DataModel.RemoveRoleToEntrust(idxOrId, roleId)
  local info, idx
  if 0 < idxOrId and idxOrId <= #DataModel.entrustList then
    info = DataModel.entrustList[idxOrId]
    idx = idxOrId
  else
    for i, v in ipairs(DataModel.entrustList) do
      if v.id == idxOrId then
        info = DataModel.entrustList[i]
        idx = i
        break
      end
    end
  end
  local roleIdx = -1
  for i, id in ipairs(info.roles) do
    if roleId == id then
      info.roles[i] = -1
      roleIdx = i
      break
    end
  end
  DataModel.SaveEntrustRolesToLocal(idx)
  return roleIdx
end

function DataModel.SaveEntrustRolesToLocal(idx)
  local info = DataModel.entrustList[idx]
  PlayerData:SetPlayerPrefs("string", "EntrustRolesSelected" .. info.id, Json.encode(info.roles))
end

function DataModel.InitRoleInfo()
  DataModel.roles = {}
  local cacheEntrustedIdx = {}
  for i, v in ipairs(DataModel.entrustList) do
    if v.state ~= DataModel.entrustState.CanAccept then
      cacheEntrustedIdx[v.id] = 1
    end
  end
  for roleId, v in pairs(PlayerData.ServerData.roles) do
    local t = {}
    t.id = tonumber(roleId)
    local unitCA = PlayerData:GetFactoryData(t.id)
    local skinId = v.current_skin and v.current_skin[1] or ""
    if string.nilorempty(skinId) then
      skinId = unitCA.viewId
    end
    t.skinId = skinId
    local unitViewCA = PlayerData:GetFactoryData(skinId)
    t.face = unitViewCA.face
    t.name = unitCA.name
    t.sideId = unitCA.sideId
    t.qualityInt = unitCA.qualityInt
    local tagCA = PlayerData:GetFactoryData(t.sideId)
    t.sideIconPath = tagCA.recommendPath
    t.lv = v.lv
    t.entrusted = false
    t.entrustId = -1
    local entrustId = DataModel.cacheRolesInEntrustId[t.id]
    if entrustId then
      t.entrustId = entrustId
      t.entrusted = cacheEntrustedIdx[entrustId] ~= nil
    end
    table.insert(DataModel.roles, t)
  end
end

function DataModel.RefreshEntrustInfoByIdx(idx)
  local t = DataModel.entrustList[idx]
  local serverInfo = PlayerData.ServerData.entrust[tostring(t.id)]
  local curTime = TimeUtil:GetServerTimeStamp()
  if serverInfo then
    t.roles = {}
    for i1, roleId in ipairs(serverInfo.roles) do
      t.roles[i1] = tonumber(roleId) or -1
    end
    t.totalTime = serverInfo.end_ts - serverInfo.create_ts
    t.startTime = serverInfo.create_ts
    t.endTime = serverInfo.end_ts
    t.award = serverInfo.award
    if curTime >= serverInfo.end_ts then
      t.state = DataModel.entrustState.Complete
    else
      t.state = DataModel.entrustState.Ing
    end
  else
    t.totalTime = 0
    t.startTime = 0
    t.endTime = 0
    t.award = nil
    t.state = DataModel.entrustState.CanAccept
  end
end

function DataModel.RefreshRolesInfo(idx)
  local info = DataModel.entrustList[idx]
  local cacheRoleId = {}
  for i, v in ipairs(info.roles) do
    cacheRoleId[v] = 1
  end
  for i, v in ipairs(DataModel.roles) do
    if cacheRoleId[v.id] then
      v.entrusted = info.state ~= DataModel.entrustState.CanAccept
    end
  end
end

function DataModel.SortEntrustList()
  table.sort(DataModel.entrustList, function(a, b)
    if a.state == DataModel.entrustState.Complete and b.state ~= DataModel.entrustState.Complete then
      return true
    end
    if a.state ~= DataModel.entrustState.Complete and b.state == DataModel.entrustState.Complete then
      return false
    end
    if a.state == DataModel.entrustState.Ing and b.state ~= DataModel.entrustState.Ing then
      return true
    end
    if a.state ~= DataModel.entrustState.Ing and b.state == DataModel.entrustState.Ing then
      return false
    end
    return a.idx < b.idx
  end)
end

function DataModel.SortRoles()
  local info = DataModel.entrustList[DataModel.curEntrustSelectIdx]
  DataModel.recommendSideDic = {}
  for i, v in ipairs(info.recommendSideList) do
    DataModel.recommendSideDic[v.id] = 1
  end
  local curSelectEntrustId = DataModel.entrustList[DataModel.curEntrustSelectIdx].id
  table.sort(DataModel.roles, function(a, b)
    if a.entrustId == curSelectEntrustId and b.entrustId ~= curSelectEntrustId then
      return true
    elseif a.entrustId ~= curSelectEntrustId and b.entrustId == curSelectEntrustId then
      return false
    end
    if a.entrusted and not b.entrusted then
      return false
    elseif not a.entrusted and b.entrusted then
      return true
    end
    if DataModel.recommendSideDic[a.sideId] ~= nil and DataModel.recommendSideDic[b.sideId] == nil then
      return true
    elseif DataModel.recommendSideDic[a.sideId] == nil and DataModel.recommendSideDic[b.sideId] ~= nil then
      return false
    end
    if a.lv > b.lv then
      return true
    elseif a.lv < b.lv then
      return false
    end
    if a.qualityInt > b.qualityInt then
      return true
    elseif a.qualityInt < b.qualityInt then
      return false
    end
    return a.id < b.id
  end)
end

function DataModel.CalcRolesInfo(idx)
  local info = DataModel.entrustList[idx]
  info.recommendCount = 0
  info.rolesIncrease = 0
  local rolesCount = DataModel.GetRolesCount(idx)
  if info.roles == nil or rolesCount < DataModel.limitCharacter then
    return
  end
  local entrustConfig = PlayerData:GetFactoryData(99900069)
  for i, roleId in ipairs(info.roles) do
    if 0 < roleId then
      local unitCA = PlayerData:GetFactoryData(roleId)
      local qualityType = DataModel.QualityToType[unitCA.qualityInt]
      local gradeCoefficient = entrustConfig["gradeCoefficient" .. qualityType]
      local resonanceCoefficient = entrustConfig["resonanceCoefficient" .. qualityType]
      local awakeCoefficient = entrustConfig["awakeCoefficient" .. qualityType]
      local unitServerInfo = PlayerData.ServerData.roles[tostring(roleId)]
      if unitServerInfo then
        info.rolesIncrease = info.rolesIncrease + gradeCoefficient * unitServerInfo.lv + resonanceCoefficient * unitServerInfo.resonance_lv + awakeCoefficient * unitServerInfo.awake_lv
      end
      for i1, sideInfo in ipairs(info.recommendSideList) do
        if sideInfo.id == unitCA.sideId then
          info.recommendCount = info.recommendCount + 1
          break
        end
      end
    end
  end
end

function DataModel.CalcRewardIncrease(idx, itemIdx)
  local info = DataModel.entrustList[idx]
  local rewardInfo = info.rewardList[itemIdx]
  if info.award then
    for i, reward in ipairs(info.award) do
      if tonumber(reward.id) == rewardInfo.id then
        return math.floor(reward.num + 0.001)
      end
    end
  end
  local num = rewardInfo.basicsNum
  local rewardNum = num
  local rolesCount = DataModel.GetRolesCount(idx)
  if info.roles == nil or rolesCount < DataModel.limitCharacter then
    return math.floor(rewardNum * (1 + DataModel.coinBuffIncrease))
  end
  local entrustConfig = PlayerData:GetFactoryData(99900069)
  local time = DataModel.timeList[info.cacheTimeSelectIdx].time
  if info.rewardType == "Coin" then
    rewardNum = (num * rolesCount + info.rolesIncrease + DataModel.basicBuildingIncrease * rolesCount) * (1 + info.recommendCount * entrustConfig.recommendCoefficient) * time
    rewardNum = rewardNum * (1 + DataModel.coinBuffIncrease)
  elseif info.rewardType == "Other" then
    if rewardInfo.id == 11400001 then
      rewardNum = (num * rolesCount + info.rolesIncrease + DataModel.basicBuildingIncrease * rolesCount) * (1 + info.recommendCount * entrustConfig.recommendCoefficient) * time * 0.5
      rewardNum = rewardNum * (1 + DataModel.coinBuffIncrease)
    else
      rewardNum = num * time * (1 + info.recommendCount * entrustConfig.recommendCoefficient)
    end
  end
  rewardNum = math.floor(rewardNum)
  return rewardNum
end

function DataModel.GetEntrustState(idx)
  local info = DataModel.entrustList[idx]
  if info.state == DataModel.entrustState.CanAccept then
    local rolesCount = DataModel.GetRolesCount(idx)
    if info.roles == nil or rolesCount < DataModel.limitCharacter then
      return DataModel.entrustState.Lock, 1
    elseif DataModel.curEntrustedCount >= DataModel.maxEntrustedCount then
      if DataModel.entrustedQueueLimit then
        return DataModel.entrustState.Lock, 3
      else
        return DataModel.entrustState.Lock, 2
      end
    end
  end
  return info.state, 1
end

function DataModel.GetRolesCount(idx)
  local info = DataModel.entrustList[idx]
  local rolesCount = 0
  for i, roleId in ipairs(info.roles) do
    if 0 < roleId then
      rolesCount = rolesCount + 1
    end
  end
  return rolesCount
end

function DataModel.RefreshCurSelectEntrustIdx(id)
  if id == nil or id <= 0 then
    return
  end
  for i, v in ipairs(DataModel.entrustList) do
    if v.id == id then
      DataModel.curEntrustSelectIdx = i
      break
    end
  end
end

function DataModel.EntrustToReward(idx)
  local info = DataModel.entrustList[idx]
  local t = {}
  t.id = info.id
  t.timeIdx = info.cacheTimeSelectIdx
  t.time = DataModel.timeList[t.timeIdx].time
  t.roles = info.roles
  t.rewardList = {}
  for i, v in ipairs(info.rewardList) do
    local tempReward = {}
    tempReward.id = v.id
    tempReward.num = DataModel.CalcRewardIncrease(idx, i)
    t.rewardList[i] = tempReward
  end
  return t
end

local function CheckMoveOnBoundary(roleInfo)
  if roleInfo.moveDir == nil or roleInfo.moveDir.x == nil or roleInfo.moveDir.y == nil then
    return DataModel.boundaryEnum.None
  end
  if math.abs(roleInfo.pos.x) - DataModel.cacheBoundary.x >= 0.5 then
    if roleInfo.pos.x < 0 and roleInfo.moveDir.x < 0 then
      return DataModel.boundaryEnum.Left
    elseif roleInfo.pos.x > 0 and roleInfo.moveDir.x > 0 then
      return DataModel.boundaryEnum.Right
    end
  end
  if roleInfo.pos.y - DataModel.cacheBoundary.y >= 0.5 and roleInfo.moveDir.y > 0 then
    return DataModel.boundaryEnum.Up
  elseif roleInfo.pos.y <= DataModel.cacheBoundary.offsetY and roleInfo.moveDir.y < 0 then
    return DataModel.boundaryEnum.Bottom
  end
  return DataModel.boundaryEnum.None
end

local function RandomRoleMove(roleInfo)
  local randomFace
  roleInfo.move = 1
  roleInfo.changeAction = true
  roleInfo.action = DataModel.walkAniName
  local boundaryEnum = CheckMoveOnBoundary(roleInfo)
  local minAngle = 0
  local maxAngle = 0
  if boundaryEnum == DataModel.boundaryEnum.Left then
    randomFace = 1
    local random = math.random(1, 2)
    minAngle = random == 1 and 0 or -90
    maxAngle = random == 1 and 90 or 0
  elseif boundaryEnum == DataModel.boundaryEnum.Right then
    randomFace = 2
    local random = math.random(1, 2)
    minAngle = random == 1 and 90 or 180
    maxAngle = random == 1 and 180 or 270
  elseif boundaryEnum == DataModel.boundaryEnum.Up then
    randomFace = math.random(1, 2)
    minAngle = randomFace == 1 and 270 or 180
    maxAngle = randomFace == 1 and 360 or 270
  elseif boundaryEnum == DataModel.boundaryEnum.Bottom then
    randomFace = math.random(1, 2)
    minAngle = randomFace == 1 and 0 or 90
    maxAngle = randomFace == 1 and 90 or 180
  end
  roleInfo.moveDir = {}
  randomFace = randomFace or math.random(1, 2)
  if minAngle == 0 and maxAngle == 0 then
    minAngle = randomFace == 1 and -90 or 90
    maxAngle = randomFace == 1 and 90 or 270
  end
  local oldFaceAngle = roleInfo.faceAngle
  roleInfo.faceAngle = randomFace == 1 and 0 or 180
  roleInfo.changeFaceAngle = roleInfo.faceAngle ~= oldFaceAngle
  local angle = math.random(minAngle, maxAngle)
  local radians = angle / 180 * math.pi
  roleInfo.moveDir.x = math.cos(radians)
  roleInfo.moveDir.y = math.sin(radians)
  roleInfo.time = math.random(DataModel.cacheMoveTimeLimit.min, DataModel.cacheMoveTimeLimit.max)
end

local function RandomRoleAction(roleInfo)
  roleInfo.move = 0
  roleInfo.changeAction = true
  if 0 < #DataModel.actionList then
    local random = math.random(1, #DataModel.actionList)
    local actionInfo = DataModel.actionList[random]
    roleInfo.action = actionInfo.action
    roleInfo.time = actionInfo.time
  else
    roleInfo.action = DataModel.standAniName
    roleInfo.time = DataModel.idleTime
  end
end

function DataModel.InitRoleMoveInfo(idx)
  local info = DataModel.entrustList[idx]
  local width = info.walkWidth * 0.5
  local height = info.walkHeight
  DataModel.cacheBoundary.x = width
  DataModel.cacheBoundary.y = height
  DataModel.cacheBoundary.offsetY = info.offsetY or 0
  if DataModel.cacheUpdateRoleMoveInfo[info.id] then
    local rolesInfo = DataModel.cacheUpdateRoleMoveInfo[info.id]
    for i, roleInfo in ipairs(rolesInfo) do
      RandomRoleMove(roleInfo)
      roleInfo.changeFaceAngle = true
    end
    return
  end
  local rolesInfo = {}
  for i, roleId in ipairs(info.roles) do
    local t = {}
    t.id = roleId
    local x = math.random(-width, width)
    local y = math.random(DataModel.cacheBoundary.offsetY, height)
    t.pos = {x = x, y = y}
    RandomRoleMove(t)
    table.insert(rolesInfo, t)
  end
  DataModel.cacheUpdateRoleMoveInfo[info.id] = rolesInfo
end

function DataModel.UpdateMove(roleInfo)
  if roleInfo.time <= 0 then
    if roleInfo.move == 0 then
      RandomRoleMove(roleInfo)
    else
      RandomRoleAction(roleInfo)
    end
  end
  if roleInfo.move == 1 then
    if CheckMoveOnBoundary(roleInfo) ~= DataModel.boundaryEnum.None then
      roleInfo.move = 0
      roleInfo.changeAction = true
      roleInfo.action = DataModel.standAniName
      roleInfo.time = DataModel.idleTime + 0.02
    else
      roleInfo.pos.x = roleInfo.pos.x + roleInfo.moveDir.x * DataModel.speed
      roleInfo.pos.y = roleInfo.pos.y + roleInfo.moveDir.y * DataModel.speed
    end
  end
  roleInfo.time = roleInfo.time - 0.02
end

function DataModel.GetEntrustMaxCount()
  local count = 0
  local entrustConfig = PlayerData:GetFactoryData(99900069)
  local buildingInfo = PlayerData.ServerData.security_levels
  local limit = false
  if buildingInfo then
    for i, v in ipairs(entrustConfig.entrustQueueList) do
      local strId = tostring(v.id)
      if buildingInfo[strId] then
        local checkExpelComplete = true
        for levelPondId, levels in pairs(buildingInfo[strId]) do
          local pondCA = PlayerData:GetFactoryData(levelPondId)
          checkExpelComplete = checkExpelComplete and pondCA.expelNum <= levels.expel_num
        end
        if checkExpelComplete then
          count = count + 1
        else
          limit = true
        end
      elseif 0 >= v.id then
        count = count + 1
      end
    end
  end
  local hasBattlePass = false
  for _, passInfo in ipairs(PlayerData:GetActiveBattlePassList()) do
    local passData = PlayerData:GetBattlePass(passInfo.kind)
    if passData and passData.pass_type and 0 < passData.pass_type then
      hasBattlePass = true
      break
    end
  end
  if hasBattlePass then
    count = count + PlayerData:GetFactoryData(99900069).itemAddNum
  end
  return count, limit
end

function DataModel.CheckIsRewardUp()
  local entrustConfig = PlayerData:GetFactoryData(99900069)
  local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
  local h = tonumber(string.sub(defaultConfig.dailyRefreshTime, 1, 2))
  local curTime = TimeUtil:GetServerTimeStamp()
  local isRewardUp = false
  local nextRewardUpRefreshTime = 0
  for i, v in ipairs(entrustConfig.weekDayList) do
    isRewardUp = TimeUtil:CheckWDay(v.day, h, curTime)
    if isRewardUp then
      nextRewardUpRefreshTime = TimeUtil:GetNextWeekTime(v.day + 1, h, curTime)
      break
    else
      local time = TimeUtil:GetNextWeekTime(v.day, h, curTime)
      if nextRewardUpRefreshTime == 0 then
        nextRewardUpRefreshTime = TimeUtil:GetNextWeekTime(v.day, h, curTime)
      elseif time < nextRewardUpRefreshTime then
        nextRewardUpRefreshTime = time
      end
    end
  end
  DataModel.isRewardUp = isRewardUp
  DataModel.nextRewardUpRefreshTime = nextRewardUpRefreshTime
end

function DataModel.SetReportIsRewardUp(toReport, reward)
  local cacheItem = {}
  for i, v in ipairs(toReport) do
    for i1, rewardInfo in ipairs(v.rewardList) do
      if cacheItem[rewardInfo.id] == nil then
        cacheItem[rewardInfo.id] = rewardInfo.num
      else
        cacheItem[rewardInfo.id] = cacheItem[rewardInfo.id] + rewardInfo.num
      end
    end
  end
  local entrustConfig = PlayerData:GetFactoryData(99900069)
  local isRewardUp = false
  local isBattlePassUp = false
  local battlePassRito = 1
  for _, passInfo in ipairs(PlayerData:GetActiveBattlePassList()) do
    local passData = PlayerData:GetBattlePass(passInfo.kind)
    if passData and passData.pass_type and passData.pass_type == 2 then
      battlePassRito = battlePassRito + entrustConfig.battlePassCoefficient
    end
  end
  for k, v in pairs(reward) do
    for k1, v1 in pairs(v) do
      local key = tonumber(k1)
      local curNum = cacheItem[key]
      local diff = curNum and (v1.num or 1) / curNum
      if diff == entrustConfig.weekDayCoefficient then
        isRewardUp = true
        break
      elseif diff == battlePassRito then
        isBattlePassUp = true
        break
      elseif diff == entrustConfig.weekDayCoefficient * battlePassRito then
        isRewardUp = true
        isBattlePassUp = true
        break
      end
    end
  end
  if isRewardUp or isBattlePassUp then
    for k, v in ipairs(toReport) do
      v.isRewardUp = isRewardUp
      v.isBattlePassUp = isBattlePassUp
    end
  end
end

return DataModel
