local HexAStarPathfinder = require("Managers.WorldStage.NewMap.Utils.HexAStarPathfinder")
local MapModel = NewClass("MapModel", BaseModel)

function MapModel:OnInit()
  self:OnReset()
end

function MapModel:OnReset()
  self.stageData = nil
  self.mapData = nil
  self.gearData = nil
  self.roleFOV = 1
  self.cfgData = nil
  self.gearByPos = {}
  self.gearByUid = {}
  self.materials = {}
  self.materialList = {}
  self.gearRuntime = {}
  self.serverPos = {x = 0, y = 0}
  self.currentPos = {x = 0, y = 0}
end

function MapModel:Setup(stageData, cfgData)
  self.stageData = stageData
  self.mapData = stageData and stageData.map or {}
  self.gearData = stageData and stageData.gears or {}
  self.roleFOV = stageData and stageData.shiye or 1
  self.cfgData = cfgData
  self.gearByPos = {}
  self.gearByUid = {}
  self.materials = {}
  self.materialList = {}
  self.gearRuntime = {}
  self.serverPos = {x = 0, y = 0}
  self.currentPos = {x = 0, y = 0}
  self:AppendFinishGears(stageData and stageData.finishGears)
  self:BuildMaterialIndex()
  self:BuildGearIndex()
  local pos = self:GetRolePos()
  if pos then
    self:SyncMovePos(pos.x, pos.y)
  end
end

function MapModel:GetStageData()
  return self.stageData
end

function MapModel:GetMapData()
  return self.mapData
end

function MapModel:GetRoleFOV()
  return self.roleFOV
end

function MapModel:GetMapWidth()
  return WorldStageConst.MAP_WIDTH
end

function MapModel:GetMapHeight()
  return WorldStageConst.MAP_HEIGHT
end

function MapModel:IsInMapRange(x, y)
  return x >= 1 and x <= self:GetMapWidth() and y >= 1 and y <= self:GetMapHeight()
end

function MapModel:GetIdxByPos(posX, posY)
  return posX + (posY - 1) * self:GetMapWidth()
end

function MapModel:GetPosByIdx(idx)
  local width = self:GetMapWidth()
  local posY = math.ceil(idx / width)
  local posX = idx - (posY - 1) * width
  return posX, posY
end

function MapModel:GetGearPosKey(x, y)
  return x * 100 + y
end

function MapModel:AppendFinishGears(finishGears)
  for _, gear in pairs(finishGears or {}) do
    gear.isFinished = true
    table.insert(self.gearData, gear)
  end
end

function MapModel:BuildMaterialIndex()
  for _, v in pairs(self.mapData and self.mapData.materialList or {}) do
    local idx = self:GetIdxByPos(v.x, v.y)
    self.materials[idx] = v.material
    self.materialList[idx] = v
  end
end

function MapModel:BuildGearIndex()
  self.gearByPos = {}
  self.gearByUid = {}
  for _, gear in pairs(self.gearData or {}) do
    self:IndexGearData(gear)
  end
end

function MapModel:IndexGearData(gear)
  if not gear then
    return
  end
  if gear.uid then
    self.gearByUid[gear.uid] = gear
    self:GetGearRuntime(gear.uid)
  end
  if gear.x and gear.y then
    self.gearByPos[self:GetGearPosKey(gear.x, gear.y)] = gear
  end
end

function MapModel:GetGearData()
  return self.gearData
end

function MapModel:GetGearDataByUid(uid)
  return uid and self.gearByUid[uid] or nil
end

function MapModel:GetGearDataByPos(x, y)
  return self.gearByPos[self:GetGearPosKey(x, y)]
end

function MapModel:AddGearData(gear)
  if not gear or not gear.uid then
    return
  end
  local oldGear = self:GetGearDataByUid(gear.uid)
  if oldGear then
    self:SyncGearData(gear.uid, gear)
    return
  end
  table.insert(self.gearData, gear)
  self:IndexGearData(gear)
end

function MapModel:SyncGearData(uid, data)
  local gear = self:GetGearDataByUid(uid or data and data.uid)
  if not gear or not data then
    return
  end
  local oldKey
  if gear.x and gear.y then
    oldKey = self:GetGearPosKey(gear.x, gear.y)
  end
  for k, v in pairs(data) do
    gear[k] = v
  end
  if oldKey then
    self.gearByPos[oldKey] = nil
  end
  self:IndexGearData(gear)
end

function MapModel:SetGearFinishedByPos(x, y)
  local gear = self:GetGearDataByPos(x, y)
  if gear then
    gear.isFinished = true
    self:SetGearRemoved(gear.uid, true)
  end
end

function MapModel:GetGearRuntime(uid)
  if not uid then
    return {}
  end
  local runtime = self.gearRuntime[uid]
  if runtime then
    return runtime
  end
  local gear = self:GetGearDataByUid(uid)
  local isRemovedMark = false
  if gear then
    isRemovedMark = gear.isFinished
  end
  runtime = {
    isRemovedMark = isRemovedMark,
    isInTrigger = false,
    isWaitingProto = false,
    isRecovering = nil,
    isEventPanelOpen = nil,
    isChoas = nil ~= self:GetGearChoasEffect(uid),
    svrTriggerData = nil,
    pendingMovePos = nil,
    isCancel = nil
  }
  self.gearRuntime[uid] = runtime
  return runtime
end

function MapModel:GetGearConfigData(uid)
  local gear = self:GetGearDataByUid(uid)
  if not gear then
    return {}
  end
  local cfg = DT.MapNode[gear.tid]
  if not cfg then
    Logger.Warn("MapModel.GetGearConfigData tid Error " .. tostring(gear.tid))
    return {}
  end
  return cfg
end

function MapModel:GetGearNodeTypeConfig(uid)
  local cfg = self:GetGearConfigData(uid)
  if not cfg then
    return
  end
  local nodeType = cfg.NodeType
  return nodeType and DT.MapNodeType[nodeType]
end

function MapModel:GetGearChoasEffect(uid)
  do return self.GetGearChoasEffectByType, self, uid end
  return self.GetGearChoasEffectByType, self, uid, 1
end

function MapModel:GetGearMonitoredEffect(uid)
  do return self.GetGearChoasEffectByType, self, uid end
  return self.GetGearChoasEffectByType, self, uid, 2
end

function MapModel:GetGearChoasEffectByType(uid, choasType)
  local nodeCfg = self:GetGearConfigData(uid)
  if not nodeCfg then
    return
  end
  local chaosEffect = nodeCfg.ChaosEffect or {}
  for i = 1, #chaosEffect, 2 do
    if chaosEffect[i] == choasType then
      return chaosEffect[i + 1]
    end
  end
end

function MapModel:IsGearChoas(uid)
  return self:GetGearRuntime(uid).isChoas
end

function MapModel:SetGearDismissChoas(uid, isDismiss)
  local runtime = self:GetGearRuntime(uid)
  if not runtime then
    return
  end
  local isPreChoas = runtime.isChoas
  if isDismiss then
    runtime.isChoas = false
  end
  return isPreChoas
end

function MapModel:IsGearChoasNode(uid)
  if not self:IsGearChoas(uid) then
    return
  end
  do return self.GetGearChoasEffect, self end
  return self.GetGearChoasEffect, self, uid
end

function MapModel:IsGearMonitored(uid)
  local gear = self:GetGearDataByUid(uid)
  if gear then
    return gear.monitored
  end
end

function MapModel:GetGearTid(uid)
  local gear = self:GetGearDataByUid(uid)
  if gear then
    return gear.tid
  end
end

function MapModel:GetGearType(uid)
  local gear = self:GetGearDataByUid(uid)
  if gear then
    return gear.type
  end
end

function MapModel:GetGearStatus(uid)
  local gear = self:GetGearDataByUid(uid)
  if gear then
    return gear.state
  end
end

function MapModel:GetGearPos(uid)
  local gear = self:GetGearDataByUid(uid)
  if gear then
    return gear.x, gear.y
  end
end

function MapModel:IsGearRemoved(uid)
  if self:IsGearMonitored(uid) then
    return false
  end
  return self:GetGearRuntime(uid).isRemovedMark
end

function MapModel:IsGearRemovedMark(uid)
  return self:GetGearRuntime(uid).isRemovedMark
end

function MapModel:SetGearRemoved(uid, isRemoved)
  local runtime = self:GetGearRuntime(uid)
  if not runtime then
    return
  end
  runtime.isRemovedMark = isRemoved
  local gear = self:GetGearDataByUid(uid)
  if gear then
    gear.isFinished = isRemoved
  end
end

function MapModel:SetGearInTrigger(uid)
  self:GetGearRuntime(uid).isInTrigger = true
end

function MapModel:EndGearTrigger(uid)
  self:GetGearRuntime(uid).isInTrigger = false
end

function MapModel:IsGearTriggering(uid)
  return self:GetGearRuntime(uid).isInTrigger
end

function MapModel:SetGearWaitingForProto(uid, isWaiting)
  self:GetGearRuntime(uid).isWaitingProto = isWaiting
end

function MapModel:IsGearWaitingForProto(uid)
  return self:GetGearRuntime(uid).isWaitingProto
end

function MapModel:SetGearTriggerTime(uid, triggerTime)
  self:GetGearRuntime(uid).triggerTime = triggerTime
end

function MapModel:IsGearTriggerInCooldown(uid, interval)
  local triggerTime = self:GetGearRuntime(uid).triggerTime or 0
  return TimerManager.totalTime - triggerTime < (interval or 0)
end

function MapModel:SetGearRecovering(uid, isRecovering)
  self:GetGearRuntime(uid).isRecovering = isRecovering
  if isRecovering then
    self:SetGearInTrigger(uid)
  end
end

function MapModel:IsGearRecovering(uid)
  return self:GetGearRuntime(uid).isRecovering
end

function MapModel:SetGearEventPanelOpen(uid, isOpen)
  self:GetGearRuntime(uid).isEventPanelOpen = isOpen
end

function MapModel:IsGearEventPanelOpen(uid)
  return self:GetGearRuntime(uid).isEventPanelOpen
end

function MapModel:SetGearSvrTriggerData(uid, svrData)
  self:GetGearRuntime(uid).svrTriggerData = svrData
end

function MapModel:SetGearPendingMovePos(uid, x, y)
  self:GetGearRuntime(uid).pendingMovePos = {x = x, y = y}
end

function MapModel:TakeGearPendingMovePos(uid)
  local runtime = self:GetGearRuntime(uid)
  if not runtime then
    return
  end
  local pos = runtime.pendingMovePos
  runtime.pendingMovePos = nil
  return pos
end

function MapModel:SetGearCancel(uid, isCancel)
  self:GetGearRuntime(uid).isCancel = isCancel
end

function MapModel:IsGearCancel(uid)
  return self:GetGearRuntime(uid).isCancel
end

function MapModel:InGearTrigger()
  for uid, runtime in pairs(self.gearRuntime) do
    if runtime.isInTrigger and self:GetGearType(uid) ~= CommonDefine.GearItemType.DropTerrain then
      return true
    end
  end
  return false
end

function MapModel:GetTriggerGearUid()
  for uid, runtime in pairs(self.gearRuntime) do
    if runtime.isInTrigger then
      return uid
    end
  end
end

function MapModel:ClearAllWaitingForProto()
  for uid, runtime in pairs(self.gearRuntime) do
    if runtime.isWaitingProto then
      self:SetGearWaitingForProto(uid, false)
    end
  end
end

function MapModel:GetRolePos()
  return self.mapData and self.mapData.pos
end

function MapModel:SetRolePos(x, y)
  if not self.mapData then
    return
  end
  self.mapData.pos = self.mapData.pos or {}
  self.mapData.pos.x = x
  self.mapData.pos.y = y
end

function MapModel:SyncMovePos(x, y)
  self.serverPos.x = x
  self.serverPos.y = y
  self.currentPos.x = x
  self.currentPos.y = y
end

function MapModel:SetServerPos(x, y)
  self.serverPos.x = x
  self.serverPos.y = y
  self:SetRolePos(x, y)
end

function MapModel:SetCurrentPos(x, y)
  self.currentPos.x = x
  self.currentPos.y = y
end

function MapModel:GetServerPos()
  return self.serverPos.x, self.serverPos.y
end

function MapModel:GetCurrentPos()
  return self.currentPos.x, self.currentPos.y
end

function MapModel:GetFieldOfView(y, level)
  local lv = level or self.roleFOV
  if 1 == y % 2 then
    return WorldStageConst.OddView[lv]
  else
    return WorldStageConst.EvenView[lv]
  end
end

function MapModel:SetRoleFOV(roleFOV)
  self.roleFOV = roleFOV
  if self.stageData then
    self.stageData.shiye = roleFOV
  end
end

function MapModel:GetRoleFOV()
  return self.roleFOV
end

function MapModel:GetMistData()
  return self.mapData and self.mapData.moveList
end

function MapModel:GetMaterialTid(posX, posY)
  local gridIdx = self:GetIdxByPos(posX, posY)
  local material = self.materialList and self.materialList[gridIdx]
  return material and material.materialTid
end

function MapModel:GetUnitGridPath(posX, posY)
  local gridIdx = self:GetIdxByPos(posX, posY)
  local material = self.materials and self.materials[gridIdx]
  if material then
    return material
  end
  do return self.GetUnitGridDefaultPath end
  return self.GetUnitGridDefaultPath, self
end

local DefaultGridPath = "MUnit/MUnit_02/Grid/MUnit_Grid_M0001/MUnit_Grid_M0001.prefab"

function MapModel:GetUnitGridDefaultPath()
  local stageId = self.stageData and self.stageData.stageId
  local stageCfg = DT.Stage[stageId]
  local cfgMaterialList = stageCfg and stageCfg.Material or {}
  local stageMaterialId = cfgMaterialList[1] or 0
  local materialCfg = DT.MapTileMaterial[stageMaterialId]
  if materialCfg and #materialCfg.data_list > 0 then
    return materialCfg.data_list[1].Path
  end
  return DefaultGridPath
end

function MapModel:IsBloodPoolFinished(x, y)
  local gearData = self:GetGearDataByPos(x, y)
  if not gearData then
    return false
  end
  return gearData.isFinished and gearData.type == CommonDefine.GearItemType.BloodPool
end

function MapModel:IsInMoveArea(curPosX, curPosY, destPosX, destPosY)
  local field = self:GetFieldOfView(curPosY, 1)
  for _, v in ipairs(field) do
    if curPosX + v[1] == destPosX and curPosY + v[2] == destPosY then
      return true
    end
  end
  return false
end

function MapModel:IsForbidBack(curPosX, curPosY, destPosX, destPosY, prevPosX, prevPosY)
  local curGear = self:GetGearDataByPos(curPosX, curPosY)
  if curGear and curGear.type == CommonDefine.GearItemType.DropTerrain then
    return prevPosX == destPosX and prevPosY == destPosY
  end
end

function MapModel:IsAdjacent(x1, y1, x2, y2)
  local offsets = HexAStarPathfinder.GetNeighborOffsets(y1)
  for _, offset in ipairs(offsets) do
    if x1 + offset[1] == x2 and y1 + offset[2] == y2 then
      return true
    end
  end
  return false
end

function MapModel:IsWalkable(x, y, terrainMgr)
  if not self:IsInMapRange(x, y) then
    return false
  end
  if terrainMgr then
    local terrain = terrainMgr:GetTerrainByPos(x, y)
    if not terrain or not terrain.isVisible then
      return false
    end
  end
  local gear = self:GetGearDataByPos(x, y)
  if gear and not self:IsGearRemoved(gear.uid) then
    if gear.type == CommonDefine.GearItemType.Obstacle then
      return false
    end
    if gear.type == CommonDefine.GearItemType.DropTerrain and 6 == gear.state then
      return false
    end
  end
  return true
end

function MapModel:CanStandOnAdjacentTerrain(x, y, terrainMgr)
  if not self:IsWalkable(x, y, terrainMgr) then
    return false
  end
  local gear = self:GetGearDataByPos(x, y)
  if not gear then
    return true
  end
  do return self.IsGearRemoved, self end
  return self.IsGearRemoved, self, gear.uid, terrainMgr
end

return MapModel
