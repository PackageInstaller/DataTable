_class("RideServiceRender", BaseService)
RideServiceRender = RideServiceRender

function RideServiceRender:Constructor(world)
end

function RideServiceRender:Initialize()
  self._entityRenderSvc = self._world:GetService("RenderEntity")
  self._pieceRenderSvc = self._world:GetService("Piece")
  self._utilDataSvc = self._world:GetService("UtilData")
end

function RideServiceRender:RideTrap(rideID, mountID, gridLocRes)
  local rideEntity = self._world:GetEntityByID(rideID)
  local mountEntity = self._world:GetEntityByID(mountID)
  local pos = rideEntity:GetGridPosition() + rideEntity:GetGridOffset()
  local dir = rideEntity:GetGridDirection()
  local targetPos = rideEntity:GetGridPosition()
  local hieght = rideEntity:GetGridHeight()
  if gridLocRes then
    pos = gridLocRes:GetGridLocResultBornPos() + gridLocRes:GetGridLocResultBornOffset()
    dir = gridLocRes:GetGridLocResultBornDir()
    targetPos = gridLocRes:GetGridLocResultBornPos()
    hieght = gridLocRes:GetGridLocResultBornHeight()
  end
  local bodyArea = rideEntity:BodyArea():GetArea()
  for i = 1, #bodyArea do
    local posWork = targetPos + bodyArea[i]
    if self._utilDataSvc:IsValidPiecePos(posWork) then
      self._pieceRenderSvc:SetPieceAnimDown(posWork)
    end
  end
  rideEntity:SetLocation(pos, dir)
  rideEntity:SetLocationHeight(hieght)
  self._entityRenderSvc:CreateMonsterAreaOutlineEntity(rideEntity)
  rideEntity:ReplaceRideRender(rideID, mountID)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, NTRideStateChange:New(rideEntity, true))
  mountEntity:ReplaceRideRender(rideID, mountID)
  Log.debug("[RideServiceRender:RideTrap] ride_id = ", rideID, ", trap_id = ", mountID)
end

function RideServiceRender:RideMonster(rideID, mountID, gridLocRes)
  local rideEntity = self._world:GetEntityByID(rideID)
  local mountEntity = self._world:GetEntityByID(mountID)
  local pos = rideEntity:GetGridPosition() + rideEntity:GetGridOffset()
  local dir = rideEntity:GetGridDirection()
  local hieght = rideEntity:GetGridHeight()
  local rideOffset = Vector2.New(rideEntity:GetGridOffset().x, rideEntity:GetGridOffset().y)
  local mountOffset = Vector2.New(mountEntity:GetGridOffset().x, mountEntity:GetGridOffset().y)
  if gridLocRes then
    pos = gridLocRes:GetGridLocResultBornPos() + gridLocRes:GetGridLocResultBornOffset()
    dir = gridLocRes:GetGridLocResultBornDir()
    hieght = gridLocRes:GetGridLocResultBornHeight()
    rideOffset = Vector2.New(gridLocRes:GetGridLocResultBornOffset().x, gridLocRes:GetGridLocResultBornOffset().y)
  end
  local monsterIDCmpt = rideEntity:MonsterID()
  if monsterIDCmpt then
    monsterIDCmpt:SetNeedOutLineEnable(false)
  end
  rideEntity:SetLocation(pos, dir)
  rideEntity:SetLocationHeight(hieght)
  rideEntity:ReplaceRideRender(rideID, mountID)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, NTRideStateChange:New(rideEntity, true))
  local ridLocationCmpt = rideEntity:Location()
  ridLocationCmpt:SetModifyLocationCallback(function(pos, dir)
    self:SetTargetLocation(pos, dir, mountEntity, rideOffset, mountOffset)
  end)
  mountEntity:ReplaceRideRender(rideID, mountID)
  local mountLocationCmpt = mountEntity:Location()
  mountLocationCmpt:SetModifyLocationCallback(function(pos, dir)
    self:SetTargetLocation(pos, dir, rideEntity, mountOffset, rideOffset)
  end)
  Log.debug("[RideServiceRender:RideMonster] ride_id = ", rideID, ", monster_id = ", mountID)
end

function RideServiceRender:RemoveRideRender(rideID, mountID)
  local rideEntity = self._world:GetEntityByID(rideID)
  local mountEntity = self._world:GetEntityByID(mountID)
  Log.debug("[RideServiceRender:RemoveRideRender] ride_id = ", rideID, ", mount_id = ", mountID)
  rideEntity:RemoveRideRender()
  local ridLocationCmpt = rideEntity:Location()
  ridLocationCmpt:SetModifyLocationCallback(nil)
  if mountEntity then
    mountEntity:RemoveRideRender()
    local mountLocationCmpt = mountEntity:Location()
    mountLocationCmpt:SetModifyLocationCallback(nil)
    if mountEntity:HasTrapID() then
      self._entityRenderSvc:DestroyMonsterAreaOutLineEntity(rideEntity)
      local targetPos = mountEntity:GetGridPosition()
      local bodyArea = mountEntity:BodyArea():GetArea()
      for i = 1, #bodyArea do
        local posWork = targetPos + bodyArea[i]
        if self._utilDataSvc:IsValidPiecePos(posWork) then
          self._pieceRenderSvc:SetPieceAnimUp(posWork)
        end
      end
    end
    if mountEntity:HasMonsterID() then
      local monsterIDCmpt = rideEntity:MonsterID()
      if monsterIDCmpt then
        monsterIDCmpt:SetNeedOutLineEnable(true)
      end
    end
  end
  self._world:GetService("PlayBuff"):PlayBuffView(TT, NTRideStateChange:New(rideEntity, false))
end

function RideServiceRender:SetNoRidePos(rideID, targetPos, fromTrap)
  local rideEntity = self._world:GetEntityByID(rideID)
  rideEntity:SetLocationHeight(0)
  rideEntity:SetPosition(targetPos)
  self._entityRenderSvc:CreateMonsterAreaOutlineEntity(rideEntity)
  local bodyArea = rideEntity:BodyArea():GetArea()
  for i = 1, #bodyArea do
    local posWork = targetPos + bodyArea[i]
    if self._utilDataSvc:IsValidPiecePos(posWork) then
      self._pieceRenderSvc:SetPieceAnimDown(posWork)
    end
  end
end

function RideServiceRender:ReplaceRideRender(rideID, mountID, gridLocRes)
  local rideEntity = self._world:GetEntityByID(rideID)
  local oldMountID
  if rideEntity:HasRideRender() then
    local rideCmpt = rideEntity:RideRender()
    oldMountID = rideCmpt:GetMountID()
    if oldMountID == mountID then
      return
    end
    self:RemoveRideRender(rideID, oldMountID)
  else
    self._entityRenderSvc:DestroyMonsterAreaOutLineEntity(rideEntity)
    local targetPos = rideEntity:GetRenderGridPosition()
    local bodyArea = rideEntity:BodyArea():GetArea()
    for i = 1, #bodyArea do
      local posWork = targetPos + bodyArea[i]
      if self._utilDataSvc:IsValidPiecePos(posWork) then
        self._pieceRenderSvc:SetPieceAnimUp(posWork)
      end
    end
  end
  local mountEntity = self._world:GetEntityByID(mountID)
  if mountEntity:HasTrapRender() then
    self:RideTrap(rideID, mountID, gridLocRes)
  elseif mountEntity:HasMonsterID() then
    self:RideMonster(rideID, mountID, gridLocRes)
  end
end

function RideServiceRender:SetTargetLocation(pos, dir, targetEntity, oriOffset, targetOffset)
  if not targetEntity:HasLocation() then
    return
  end
  local boardServiceRender = self._world:GetService("BoardRender")
  local targetGridPos = boardServiceRender:BoardRenderPos2FloatGridPos_New(pos)
  targetGridPos = targetGridPos - oriOffset + targetOffset
  local targetPos = boardServiceRender:GridPosition2LocationPos(targetGridPos, targetEntity)
  local locationCmpt = targetEntity:Location()
  locationCmpt:CallBackModifyLocation(targetPos, dir, targetEntity)
end
