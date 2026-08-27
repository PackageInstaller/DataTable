local base = require("Game.WarChess.Ctrl.Base.WarChessCtrlBase")
local WarChessMapCtrl = class("WarChessMapCtrl", base)
local cs_GameObject = CS.UnityEngine.GameObject
local cs_ResLoader = CS.ResLoader
local cs_wcAnmation = CS.WarChessGridAnimState
local WarChessHelper = require("Game.WarChess.WarChessHelper")
local WarChessAreaData = require("Game.WarChess.Data.WarChessAreaData")
local WarChessGridData = require("Game.WarChess.Data.WarChessGridData")
local WCEntityClassDic = require("Game.WarChess.Data.SpecificEntityData.WCEntityClassDic")
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local IDLE_1_HASH = CS.UnityEngine.Animator.StringToHash("idle_1")

function WarChessMapCtrl:ctor(wcCtrl)
  self.__bfList = nil
  self.__CurShowBFId = nil
  self.__worldSize = nil
  self.__areaMap = nil
  self.__areaDataListDic = nil
  self.__gridDataListDic = nil
  self.__entityDataListDic = nil
  self.__areaDataDic = nil
  self.__gridDataDic = nil
  self.__entityDataDic = nil
  self.__entityDataUIDDic = nil
  self.__fogSightDic = nil
  self.__couldDeployGridDic = nil
  self.__cacheLinkdeGroupListDic = nil
  self.__cacheMonsterPowerDic = nil
end

function WarChessMapCtrl:SetWCMapData(battleFieldList)
  self.__bfList = {}
  self.__areaDataListDic = {}
  self.__gridDataListDic = {}
  self.__entityDataListDic = {}
  self.__fogSightDic = {}
  self.__worldSize = {}
  for _, bfMsg in ipairs(battleFieldList) do
    local BFId = bfMsg.gid
    if self.__CurShowBFId == nil then
      self.__CurShowBFId = BFId
    end
    table.insert(self.__bfList, BFId)
    self.__areaDataListDic[BFId] = bfMsg.areas
    self.__gridDataListDic[BFId] = bfMsg.grids
    self.__entityDataListDic[BFId] = bfMsg.gears
    self.__fogSightDic[BFId] = {}
    self.__worldSize[BFId] = Vector4.New(0, 0, bfMsg.sizeX - 1, bfMsg.sizeY - 1)
    for coordination, _ in pairs(bfMsg.sight) do
      self.__fogSightDic[BFId][coordination] = true
    end
  end
end

function WarChessMapCtrl:GenMap()
  self.__areaDataDic = {}
  self.__gridDataDic = {}
  self.__entityDataDic = {}
  self.__entityDataUIDDic = {}
  self.__couldDeployGridDic = {}
  self.__loadOverFuncList = {}
  local __asyncWaitList = {}
  local asyncWaitList, loadOverFuncList = self:__LoadArea(self.__CurShowBFId)
  table.insertto(__asyncWaitList, asyncWaitList)
  table.insertto(self.__loadOverFuncList, loadOverFuncList)
  local asyncWaitList, loadOverFuncList = self:__GenEntitys(self.__CurShowBFId)
  table.insertto(__asyncWaitList, asyncWaitList)
  table.insertto(self.__loadOverFuncList, loadOverFuncList)
  self:__GenGrids(self.__CurShowBFId)
  return __asyncWaitList
end

function WarChessMapCtrl:RewindMap()
  self:__GenGrids(self.__CurShowBFId)
  for BFId, entityDataXYDic in pairs(self.__entityDataDic) do
    for x, entityDataYDic in pairs(entityDataXYDic) do
      for y, entityData in pairs(entityDataYDic) do
        entityData:WCDeleteEntityGo()
        self:WCDeleteEntity(entityData)
      end
    end
  end
  self.__loadOverFuncList = {}
  local __asyncWaitList = {}
  local asyncWaitList, loadOverFuncList = self:__GenEntitys(self.__CurShowBFId)
  table.insertto(__asyncWaitList, asyncWaitList)
  table.insertto(self.__loadOverFuncList, loadOverFuncList)
  return __asyncWaitList
end

function WarChessMapCtrl:__LoadArea(BFId)
  local modelRoot = self.wcCtrl.bind.trans_AreaRoot
  self.__areaMap = {}
  self.__areaMap[BFId] = {}
  local allAsyncWaitList = {}
  local allLoadOverFunc = {}
  for theBFId, areaDataList in pairs(self.__areaDataListDic) do
    if theBFId == BFId then
      self.__areaDataDic[BFId] = {}
      for areaPos, areaMsg in pairs(areaDataList) do
        local wcAreaData = WarChessAreaData.New(areaPos, areaMsg)
        local asyncWaitList, loadOverFunc = wcAreaData:LoadWCArea(modelRoot)
        table.insertto(allAsyncWaitList, asyncWaitList)
        table.insert(allLoadOverFunc, loadOverFunc)
        self.__areaDataDic[BFId][areaPos] = wcAreaData
        wcAreaData:GenWcAreaGridPosDic(self.__areaMap[BFId])
      end
    end
  end
  return allAsyncWaitList, allLoadOverFunc
end

function WarChessMapCtrl:GetGridAreaPos(BFId, gridCoord)
  if self.__areaMap[BFId] and self.__areaMap[BFId][gridCoord] then
    return self.__areaMap[BFId][gridCoord]
  end
  error(string.format("cant get grid area pos, BFId:%s, gridCoord:%s", BFId, gridCoord))
  return 0
end

function WarChessMapCtrl:ReLoadArea(BFId)
  BFId = BFId or self.__CurShowBFId
  local areaDataDic = self.__areaDataDic[BFId]
  if areaDataDic == nil then
    error("can't reload wc area")
    return
  end
  local modelRoot = self.wcCtrl.bind.trans_AreaRoot
  local allAsyncWaitList = {}
  local allLoadOverFunc = {}
  for areaPos, wcAreaData in pairs(areaDataDic) do
    local asyncWaitList, loadOverFunc = wcAreaData:LoadWCArea(modelRoot)
    table.insertto(allAsyncWaitList, asyncWaitList)
    table.insert(allLoadOverFunc, loadOverFunc)
  end
  self.__loadOverFuncList = allLoadOverFunc
  return allAsyncWaitList
end

function WarChessMapCtrl:__GenGrids(BFId)
  self.__gridDataDic[BFId] = {}
  local fogDic = self.__fogSightDic[BFId]
  for pos, gridCfgMsg in pairs(self.__gridDataListDic[BFId]) do
    self:__GenGrid(BFId, gridCfgMsg, fogDic)
  end
  self.__gridDataListDic = nil
end

function WarChessMapCtrl:__GenGrid(BFId, gridCfgMsg, fogDic)
  local x, y = WarChessHelper.Coordination2Pos(gridCfgMsg.pos)
  local worldLogicPos = Vector2.New(x, y)
  local coordination = WarChessHelper.Pos2Coordination(worldLogicPos)
  local areaCoord = self:GetGridAreaPos(BFId, gridCfgMsg.pos)
  local gridData = WarChessGridData.New(BFId, worldLogicPos, gridCfgMsg, areaCoord)
  if self.__gridDataDic[BFId][x] == nil then
    self.__gridDataDic[BFId][x] = {}
  end
  if fogDic[coordination] then
    gridData:SetWCGridIsInFog(false)
  end
  self.__gridDataDic[BFId][x][y] = gridData
  if gridData:GetIsBornPoint() then
    self.__couldDeployGridDic[gridData] = true
  end
  return gridData
end

function WarChessMapCtrl:__GenEntitys(BFId)
  self.__entityDataDic[BFId] = {}
  local allAsyncWaitList = {}
  local allLoadOverFunc = {}
  for uid, unitCfg in pairs(self.__entityDataListDic[BFId]) do
    local asyncWait, loadOverFunc = self:__GenEntity(BFId, unitCfg, nil, nil)
    table.insert(allAsyncWaitList, asyncWait)
    table.insert(allLoadOverFunc, loadOverFunc)
  end
  self.__entityDataListDic = nil
  return allAsyncWaitList, allLoadOverFunc
end

function WarChessMapCtrl:__GenEntity(BFId, unitCfg, notWait, bind)
  local x, y = WarChessHelper.Coordination2Pos(unitCfg.pos)
  local worldLogicPos = Vector2.New(x, y)
  local clientType = ConfigData.warchess_entity_res[unitCfg.resId].client_cat
  local entityClass = WCEntityClassDic[clientType] or WCEntityClassDic[eWarChessEnum.eEntityShowCat.common]
  local entityData = entityClass.New(BFId, worldLogicPos, unitCfg)
  local asyncWait, loadOverFunc = entityData:InitWCEntity(notWait, bind)
  if self.__entityDataDic[BFId][x] == nil then
    self.__entityDataDic[BFId][x] = {}
  end
  self.__entityDataDic[BFId][x][y] = entityData
  self.__entityDataUIDDic[unitCfg.id] = entityData
  entityData:AutoAddFx()
  if not notWait then
    return asyncWait, loadOverFunc
  end
  return entityData
end

function WarChessMapCtrl:ReLoadEntitys(BFId)
  BFId = BFId or self.__CurShowBFId
  local entityDataXYDic = self.__entityDataDic[BFId]
  if entityDataXYDic == nil then
    return
  end
  for _, entityDataXDic in pairs(entityDataXYDic) do
    for _, entityData in pairs(entityDataXDic) do
      entityData:InitWCEntity(true, self.wcCtrl.bind)
    end
  end
end

function WarChessMapCtrl:ReapplyWCGridAnimation(gridData, isNewOne)
  if isNewOne then
    local gridCfgMsg = gridData:GetGridUnit()
    if gridCfgMsg.lastAnimationClipId ~= 0 then
      local gridGo = self:GetAreaObjectByGridData(gridData)
      if not IsNull(gridGo) then
        local gridGoAnimState = gridGo:GetComponentInChildren(typeof(cs_wcAnmation))
        if not IsNull(gridGoAnimState) then
          gridGoAnimState:SetStageValue(gridCfgMsg.lastAnimationClipId)
          local nameHash = gridGoAnimState:GetCurrentStateNameHash()
          gridData:SaveGridAnimArg(nameHash, gridCfgMsg.lastAnimationClipId)
        end
      end
    end
    if gridCfgMsg.fx ~= nil and 0 < #gridCfgMsg.fx then
      self.wcCtrl.animaCtrl:RefreshSingleCommonFX(gridData, gridCfgMsg.fx, true)
    end
    return
  end
  local saveAnim = gridData:GetGridAnimArg()
  if saveAnim ~= nil then
    local gridGo = self:GetAreaObjectByGridData(gridData)
    if gridGo ~= nil then
      local gridGoAnimState = gridGo:GetComponentInChildren(typeof(cs_wcAnmation))
      if gridGoAnimState ~= nil then
        gridGoAnimState:ReSetState(saveAnim.nameHash, saveAnim.animaId)
      end
    end
  end
end

function WarChessMapCtrl:ReapplyWCEntityAnimation(entityData, isNewOne)
  if isNewOne then
    local unitCfg = entityData:GetEntityUnit()
    if unitCfg.lastAnimationClipId ~= 0 then
      entityData:PlayEntityAnimation(unitCfg.lastAnimationClipId, nil)
    end
    if unitCfg.fx ~= nil and 0 < #unitCfg.fx then
      self.wcCtrl.animaCtrl:RefreshSingleCommonFX(entityData, unitCfg.fx, false)
    end
    return
  end
  local saveAnim = entityData:GetEnitityAnimArg()
  if saveAnim ~= nil then
    entityData:ReapplyEntityAnimation(saveAnim)
  end
end

function WarChessMapCtrl:OnSceneLoadOver(isInit)
  for _, func in pairs(self.__loadOverFuncList) do
    if func ~= nil then
      func(self.wcCtrl.bind)
    end
  end
  for BFId, gridDataXYDic in pairs(self.__gridDataDic) do
    for x, gridDataYDic in pairs(gridDataXYDic) do
      for y, gridData in pairs(gridDataYDic) do
        self:ReapplyWCGridAnimation(gridData, isInit)
      end
    end
  end
  for BFId, entityDataXYDic in pairs(self.__entityDataDic) do
    for x, entityDataYDic in pairs(entityDataXYDic) do
      for y, entityData in pairs(entityDataYDic) do
        self:ReapplyWCEntityAnimation(entityData, isInit)
      end
    end
  end
  self.__loadOverFuncList = nil
end

function WarChessMapCtrl:AfterAnimationCtrlLoadOver()
  self:RefreshAllEntityFx()
  self.wcCtrl.animaCtrl:RefeshAllEntityLinkFx()
end

function WarChessMapCtrl:UpdateMapUnits(unitUpdates)
  local isNeedCleanCacheLinkedGroup = false
  for BFId, unitUpdate in pairs(unitUpdates) do
    for coordination, unit in pairs(unitUpdate.gridUpdate) do
      local x, y = WarChessHelper.Coordination2Pos(unit.pos)
      local gridData
      if self.__gridDataDic[BFId] ~= nil and self.__gridDataDic[BFId][x] ~= nil then
        gridData = self.__gridDataDic[BFId][x][y]
      end
      if gridData ~= nil then
        gridData:SetWCGridUnitCfg(unit)
        self.wcCtrl.animaCtrl:UpdateSingleWCFX(gridData)
      else
        local fogDic = self.__fogSightDic[BFId]
        gridData = self:__GenGrid(BFId, unit, fogDic)
        self:ReapplyWCGridAnimation(gridData, true)
      end
      MsgCenter:Broadcast(eMsgEventId.WC_GridInfoUpdate, gridData)
    end
    for uid, unit in pairs(unitUpdate.gearUpdate) do
      local entityData = self.__entityDataUIDDic[uid]
      if entityData ~= nil then
        entityData:SetWCEntityUnitCfg(unit)
        local curPos = entityData:GetEntityLogicPos()
        local x, y = WarChessHelper.Coordination2Pos(unit.pos)
        if curPos.x ~= x or curPos.y ~= y then
          local oldPos = entityData:GetEntityLogicPos()
          if self.__entityDataDic[BFId] ~= nil and self.__entityDataDic[BFId][oldPos.x] ~= nil then
            local oldPosEntityData = self.__entityDataDic[BFId][oldPos.x][oldPos.y]
            if oldPosEntityData == entityData then
              self.__entityDataDic[BFId][oldPos.x][oldPos.y] = nil
            end
          end
          if self.__entityDataDic[BFId] == nil then
            self.__entityDataDic[BFId] = {}
          end
          if self.__entityDataDic[BFId][x] == nil then
            self.__entityDataDic[BFId][x] = {}
          end
          self.__entityDataDic[BFId][x][y] = entityData
          if isGameDev then
            print(string.format("uid:%s 从%d,%d 移动到%d,%d", tostring(unit), oldPos.x, oldPos.y, x, y))
          end
          entityData:SetNewPos(x, y)
        end
        self.wcCtrl.animaCtrl:UpdateSingleWCFX(entityData)
      else
        local x, y = WarChessHelper.Coordination2Pos(unit.pos)
        entityData = self:__GenEntity(BFId, unit, true, self.wcCtrl.bind)
        self:ReapplyWCEntityAnimation(entityData, true)
      end
      isNeedCleanCacheLinkedGroup = entityData:GetEntitySymbioticId() ~= nil
      MsgCenter:Broadcast(eMsgEventId.WC_EntityInfoUpdate, entityData)
    end
  end
  if isNeedCleanCacheLinkedGroup then
    self:CleanCachedLinkedGroupListDic()
    self.wcCtrl.animaCtrl:RefeshAllEntityLinkFx()
  end
  self:RefreshAllEntityFx()
end

function WarChessMapCtrl:UpdateMapUnitsDelete(unitUpdates)
  local isNeedCleanCacheLinkedGroup
  for BFId, unitUpdate in pairs(unitUpdates) do
    for uid, _ in pairs(unitUpdate.gearDestroy) do
      local entityData = self.__entityDataUIDDic[uid]
      if entityData ~= nil then
        entityData:SetWCEntityIsAlive(false)
        entityData:PlayEntityAnimation(-1)
        self:WCDeleteEntity(entityData)
        isNeedCleanCacheLinkedGroup = entityData:GetEntitySymbioticId() ~= nil
        MsgCenter:Broadcast(eMsgEventId.WC_EntityInfoUpdate, entityData, true)
      end
    end
  end
  if isNeedCleanCacheLinkedGroup then
    self:CleanCachedLinkedGroupListDic()
  end
end

function WarChessMapCtrl:GetMapFogInfo(BFId)
  BFId = BFId or self.__CurShowBFId
  local mapFogInfo = {}
  mapFogInfo.openFogOfWar = self:IsOpenFogOfWar()
  local size = self.__worldSize[BFId]
  local width = size.z - size.x
  local height = size.w - size.y
  mapFogInfo.mapWidth = width
  mapFogInfo.mapHeight = height
  return mapFogInfo
end

function WarChessMapCtrl:IsOpenFogOfWar()
  local levelId = WarChessManager:GetWCLevelId()
  local levelData = ConfigData.warchess_level[levelId]
  if levelData ~= nil and levelData.open_fog_of_war ~= nil then
    return levelData.open_fog_of_war
  end
  return true
end

function WarChessMapCtrl:GetWcMapSizeV4(BFId)
  BFId = BFId or self.__CurShowBFId
  return self.__worldSize[BFId]
end

function WarChessMapCtrl:GetWCFogData(BFId)
  BFId = BFId or self.__CurShowBFId
  return self.__fogSightDic[BFId]
end

function WarChessMapCtrl:UpdateWCFogData(sightDiff)
  for BFId, diffDatas in pairs(sightDiff) do
    if self.__fogSightDic[BFId] == nil then
      self.__fogSightDic[BFId] = {}
    end
    for coordination, bool in pairs(diffDatas.update) do
      self.__fogSightDic[BFId][coordination] = bool
      local x, y = WarChessHelper.Coordination2Pos(coordination)
      local gridData = self.__gridDataDic[BFId][x] ~= nil and self.__gridDataDic[BFId][x][y] or nil
      if gridData ~= nil then
        gridData:SetWCGridIsInFog(not bool)
      end
    end
  end
  self:RefreshAllEntityFx()
end

function WarChessMapCtrl:GetGridDataDic(BFId)
  BFId = BFId or self.__CurShowBFId
  return self.__gridDataDic[BFId]
end

function WarChessMapCtrl:WCDeleteEntity(entityData)
  local BFId = entityData:GetWCEntityBFId()
  local pos = entityData:GetEntityLogicPos()
  local x, y = pos.x, pos.y
  local dataDic = self.__entityDataDic[BFId]
  if dataDic ~= nil and dataDic[x] ~= nil and dataDic[x][y] == entityData then
    dataDic[x][y] = nil
  end
  local uid = entityData:GetEntityUnitId()
  self.__entityDataUIDDic[uid] = nil
end

function WarChessMapCtrl:GetGridDataByGrounPos(BFId, pos)
  BFId = BFId or self.__CurShowBFId
  local x = math.floor(pos.x + 0.5)
  local y = math.floor(pos.z + 0.5)
  if self.__gridDataDic[BFId][x] == nil then
    return
  end
  return self.__gridDataDic[BFId][x][y]
end

function WarChessMapCtrl:GetGridDataByLogicPos(BFId, pos)
  BFId = BFId or self.__CurShowBFId
  local x = pos.x
  local y = pos.y
  return self:GetGridDataByLogicXY(BFId, x, y)
end

function WarChessMapCtrl:GetGridDataByLogicXY(BFId, x, y)
  BFId = BFId or self.__CurShowBFId
  if self.__gridDataDic[BFId][x] == nil then
    return
  end
  return self.__gridDataDic[BFId][x][y]
end

function WarChessMapCtrl:GetEntityDataByLogicPos(BFId, pos)
  BFId = BFId or self.__CurShowBFId
  local x = pos.x
  local y = pos.y
  return self:GetEntityDataByLogicPosXY(BFId, x, y)
end

function WarChessMapCtrl:GetEntityDataByLogicPosXY(BFId, x, y)
  BFId = BFId or self.__CurShowBFId
  if self.__entityDataDic[BFId][x] == nil then
    return
  end
  return self.__entityDataDic[BFId][x][y]
end

function WarChessMapCtrl:GetAreaObjectByGridData(gridData, isGround)
  local logicPos = gridData:GetGridLogicPos()
  local BFId = gridData:GetWCGridBFId()
  local areaPos = gridData:GetWcGridAreaCoordination()
  local areaData = self.__areaDataDic[BFId] and self.__areaDataDic[BFId][areaPos]
  if areaData == nil then
    error(string.format("cant get areaData, BFId:%s, gridCoord:%s", BFId, areaPos))
    return nil
  end
  return self:GetAreaObjectByXY(BFId, areaData, logicPos.x, logicPos.y, isGround)
end

function WarChessMapCtrl:GetAreaObjectByXY(BFId, areaData, x, y, isGround)
  BFId = BFId or self.__CurShowBFId
  if areaData == nil then
    local coordination = WarChessHelper.PosXy2Coordination(x, y)
    local areaPos = self:GetGridAreaPos(BFId, coordination)
    areaData = self.__areaDataDic[BFId] and self.__areaDataDic[BFId][areaPos]
  end
  x, y = WarChessHelper.GenGridInAreaPos(x, y, areaData)
  local go
  if isGround then
    go = areaData:GetWCAreaGroundGo(x, y)
  else
    go = areaData:GetWCAreaGo(x, y)
  end
  if go == nil then
    error("can't get  gridGo, pls chekck is update pfefab script:WCAreaRoot")
  end
  return go
end

function WarChessMapCtrl:TryShowWCMonsterCouldMoveRange(isShow, entityData)
  if isShow then
    local isOK = WarChessHelper.CheckEnemyCanMove(entityData)
    if isOK then
      local teamLogicPos = entityData:GetEntityLogicPos()
      local startGrid = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, teamLogicPos)
      local couldReachGridDic, _, levelNubDic = WarChessHelper.BSFAllCouldReachGrid(self, startGrid, entityData, true)
      self.wcCtrl.animaCtrl:SetMonsterMoveableGridDic(couldReachGridDic, levelNubDic)
    else
      self.wcCtrl.animaCtrl:SetMonsterMoveableGridDic(nil)
    end
  else
    self.wcCtrl.animaCtrl:SetMonsterMoveableGridDic(nil)
  end
end

function WarChessMapCtrl:ReSetEveryAnimation2DefaultState()
  for BFId, gridDataXYDic in pairs(self.__gridDataDic) do
    for x, gridDataYDic in pairs(gridDataXYDic) do
      for y, gridData in pairs(gridDataYDic) do
        local gridGo = self:GetAreaObjectByGridData(gridData)
        if not IsNull(gridGo) then
          local gridGoAnimState = gridGo:GetComponentInChildren(typeof(cs_wcAnmation))
          if gridGoAnimState ~= nil and gridGoAnimState.gridAnimator:HasState(0, IDLE_1_HASH) then
            gridGoAnimState:ReSetState(IDLE_1_HASH, 1)
          end
        end
      end
    end
  end
end

function WarChessMapCtrl:GetAllCouldBornGrid()
  return self.__couldDeployGridDic
end

function WarChessMapCtrl:CleanCachedLinkedGroupListDic()
  self.__cacheLinkdeGroupListDic = nil
end

function WarChessMapCtrl:GetAllLinkedEntityGroupData()
  if self.__cacheLinkdeGroupListDic ~= nil then
    return self.__cacheLinkdeGroupListDic
  end
  local groupListDic = {}
  for BFId, entityDataXYDic in pairs(self.__entityDataDic) do
    for x, entityDataYDic in pairs(entityDataXYDic) do
      for y, entityData in pairs(entityDataYDic) do
        local symbioticId = entityData:GetEntitySymbioticId()
        if symbioticId ~= nil then
          if groupListDic[symbioticId] == nil then
            groupListDic[symbioticId] = {}
          end
          table.insert(groupListDic[symbioticId], entityData)
        end
      end
    end
  end
  self.__cacheLinkdeGroupListDic = groupListDic
  return groupListDic
end

function WarChessMapCtrl:RefreshAllEntityFx()
  for BFId, entityDataXYDic in pairs(self.__entityDataDic) do
    for x, entityDataYDic in pairs(entityDataXYDic) do
      for y, entityData in pairs(entityDataYDic) do
        self:RefreshAlarmEntity(entityData)
        entityData:UpdateEntityWantedMonsterFX()
      end
    end
  end
end

function WarChessMapCtrl:RefreshAlarmEntity(entityData)
  if entityData:GetEntityIsMonster() then
    local alarmCfg = entityData:GetAlarmCfg()
    if alarmCfg.isAlarm then
      local teamLogicPos = entityData:GetEntityLogicPos()
      local startGrid = self:GetGridDataByLogicPos(nil, teamLogicPos)
      local couldReachGridDic, _, levelNubDic = WarChessHelper.BSFAllCouldReachGrid(self, startGrid, entityData, true, true)
      self.wcCtrl.animaCtrl:SetMonsterAlarmGridDic(couldReachGridDic, levelNubDic, entityData, alarmCfg.distance)
    end
  end
end

function WarChessMapCtrl:GetMonsterCouldSecKill(entityData, teamData, callback)
  if not entityData:GetEntityIsMonster() then
    return
  end
  local battleRoomId = entityData:GetBattleRoomID()
  if battleRoomId == nil then
    if callback ~= nil then
      callback(false)
    end
    return
  end
  local monsterGroupCfg = ConfigData.warchess_room_monster[battleRoomId]
  local rate = monsterGroupCfg.quick_kill
  if rate == nil or rate == 0 then
    if callback ~= nil then
      callback(false)
    end
    return
  end
  local teamPower = teamData:GetWCTeamPower()
  local power
  local uid = entityData:GetEntityUnitId()
  local wid, tid = self.wcCtrl.teamCtrl:GetWCTeamIdentify(teamData)
  local pointPos = entityData:GetEntityLogicPos()
  local identify = {wid = wid, tid = tid}
  local WCPos = {
    gid = entityData:GetWCEntityBFId(),
    pos = WarChessHelper.Pos2Coordination(pointPos)
  }
  if self.__cacheMonsterPowerDic == nil then
    self.__cacheMonsterPowerDic = {}
  end
  if self.__cacheMonsterPowerDic[uid] ~= nil then
    power = self.__cacheMonsterPowerDic[uid]
    if callback ~= nil then
      callback(rate <= teamPower / power)
    end
    return
  end
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_MonsterPower(identify, WCPos, function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local msg = args[0]
    if not msg then
      if callback ~= nil then
        callback(false)
      end
      return
    end
    power = WarChessHelper.CalWCRoomBattlePower(msg.monsters, teamData)
    self.__cacheMonsterPowerDic[uid] = power
    if callback ~= nil then
      callback(teamPower / power >= rate)
    end
  end)
end

function WarChessMapCtrl:CleanCacheMonsterPower()
  self.__cacheMonsterPowerDic = {}
end

function WarChessMapCtrl:OnSceneUnload()
  for gearId, entityData in pairs(self.__entityDataUIDDic) do
    entityData:WCEntityDataOnSceneUnload()
    entityData:WCDeleteEntityGo()
  end
end

return WarChessMapCtrl
