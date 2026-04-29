require("base_service")
_class("RideServiceLogic", BaseService)
RideServiceLogic = RideServiceLogic

function RideServiceLogic:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
  self._boardSvc = self._world:GetService("BoardLogic")
end

function RideServiceLogic:RideTrap(rideID, mountID, height)
  local rideEntity = self._world:GetEntityByID(rideID)
  local mountEntity = self._world:GetEntityByID(mountID)
  local mountPos = mountEntity:GetGridPosition()
  local petEntity = self._world:Player():GetCurrentTeamEntity()
  local posPet = petEntity:GetGridPosition()
  local newDir = GameHelper.ComputeLogicDir(posPet - mountPos)
  local blockFlag = self._boardSvc:GetBlockFlag(rideEntity)
  self._boardSvc:SetEntityBlockFlag(rideEntity, mountPos, blockFlag)
  rideEntity:SetGridLocation(mountPos, newDir)
  rideEntity:SetGridHeight(height)
  rideEntity:ReplaceRide(rideID, mountID)
  self._world:GetService("Trigger"):Notify(NTRideStateChange:New(rideEntity, true))
  mountEntity:ReplaceRide(rideID, mountID)
  Log.debug("[RideServiceLogic:RideTrap] ride_id = ", rideID, ", trap_id = ", mountID)
end

function RideServiceLogic:RideMonster(rideID, mountID, height, offset, changeBodyArea, onlyRiderCanClick)
  local rideEntity = self._world:GetEntityByID(rideID)
  local mountEntity = self._world:GetEntityByID(mountID)
  local mountBodyArea = mountEntity:BodyArea():GetArea()
  local mountPos = mountEntity:GetGridPosition()
  local mountDir = mountEntity:GetGridDirection()
  if changeBodyArea then
    rideEntity:ReplaceBodyArea(mountBodyArea)
  end
  rideEntity:SetGridLocationAndOffset(mountPos, mountDir, offset)
  rideEntity:SetGridHeight(height)
  rideEntity:ReplaceRide(rideID, mountID)
  rideEntity:Ride():SetOnlyRiderCanClick(onlyRiderCanClick)
  local ridGridLocationCmpt = rideEntity:GridLocation()
  ridGridLocationCmpt:SetModifyLocationCallback(function(pos, dir)
    self:SetTargetLocation(pos, dir, mountEntity)
  end)
  self._world:GetService("Trigger"):Notify(NTRideStateChange:New(rideEntity, true))
  mountEntity:ReplaceRide(rideID, mountID)
  mountEntity:Ride():SetOnlyRiderCanClick(onlyRiderCanClick)
  local mountGridLocationCmpt = mountEntity:GridLocation()
  mountGridLocationCmpt:SetModifyLocationCallback(function(pos, dir)
    self:SetTargetLocation(pos, dir, rideEntity)
  end)
  Log.debug("[RideServiceLogic:RideMonster] ride_id = ", rideID, ", monster_id = ", mountID)
end

function RideServiceLogic:RemoveRide(rideID, mountID)
  local rideEntity = self._world:GetEntityByID(rideID)
  local mountEntity = self._world:GetEntityByID(mountID)
  Log.debug("[RideServiceLogic:RemoveRide] ride_id = ", rideID, ", mount_id = ", mountID)
  rideEntity:RemoveRide()
  local ridGridLocationCmpt = rideEntity:GridLocation()
  ridGridLocationCmpt:SetModifyLocationCallback(nil)
  self._world:GetService("Trigger"):Notify(NTRideStateChange:New(rideEntity, false))
  mountEntity:RemoveRide()
  local mountGridLocationCmpt = mountEntity:GridLocation()
  mountGridLocationCmpt:SetModifyLocationCallback(nil)
  if mountEntity:HasTrapID() then
    self._boardSvc:RemoveEntityBlockFlag(rideEntity, rideEntity:GetGridPosition())
  end
  rideEntity:SetGridHeight(0)
  rideEntity:SetGridOffset(Vector2.zero)
end

function RideServiceLogic:ResetBodyArea(entity)
  if entity:HasMonsterID() then
    local monsterID = entity:MonsterID():GetMonsterID()
    local monsterConfigData = self._configService:GetMonsterConfigData()
    local bodyArea = monsterConfigData:GetMonsterArea(monsterID)
    entity:ReplaceBodyArea(bodyArea)
  end
end

function RideServiceLogic:SetNoRidePos(rideID, targetPos, fromTrap)
  local rideEntity = self._world:GetEntityByID(rideID)
  local oldPos = rideEntity:GetGridPosition()
  rideEntity:SetGridPosition(targetPos)
  if fromTrap then
    self._boardSvc:RemoveEntityBlockFlag(rideEntity, oldPos)
  end
  local blockFlag = self._boardSvc:GetBlockFlag(rideEntity)
  self._boardSvc:SetEntityBlockFlag(rideEntity, targetPos, blockFlag)
end

function RideServiceLogic:ReplaceRide(rideID, mountID, height, offset, changeBodyArea, onlyRiderCanClick)
  local rideEntity = self._world:GetEntityByID(rideID)
  local oldMountID
  if rideEntity:HasRide() then
    local rideCmpt = rideEntity:Ride()
    oldMountID = rideCmpt:GetMountID()
    if oldMountID == mountID then
      return
    end
    self:RemoveRide(rideID, oldMountID)
  else
    self._boardSvc:RemoveEntityBlockFlag(rideEntity, rideEntity:GetGridPosition())
  end
  self:ResetBodyArea(rideEntity)
  local mountEntity = self._world:GetEntityByID(mountID)
  if mountEntity:HasTrap() then
    self:RideTrap(rideID, mountID, height)
  elseif mountEntity:HasMonsterID() then
    self:RideMonster(rideID, mountID, height, offset, changeBodyArea, onlyRiderCanClick)
  end
end

function RideServiceLogic:SetTargetLocation(pos, dir, targetEntity)
  if not targetEntity:HasGridLocation() then
    return
  end
  local gridLocCmpt = targetEntity:GridLocation()
  gridLocCmpt:CallBackModifyLocation(pos, dir)
end
