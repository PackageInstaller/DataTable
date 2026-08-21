require("board_svc_l")

function BoardServiceLogic:IsPosBlockByArea(pos, blockFlag, listArea, entityExcept)
  local utilDataSvc = self._world:GetService("UtilData")
  local ret = false
  for i = 1, #listArea do
    local posWork = pos + listArea[i]
    if utilDataSvc:IsPosBlock(posWork, blockFlag) then
      if not entityExcept then
        return true
      end
      local entityMonster = utilDataSvc:GetMonsterAtPos(posWork)
      if not entityMonster or entityMonster ~= entityExcept then
        return true
      end
      local entityTrap = utilDataSvc:GetTrapsAtPos(posWork)
      if #entityTrap == 0 or table.icontains(entityTrap, entityExcept) then
        return true
      end
    end
  end
  return false
end

function BoardServiceLogic:IsPosBlock(pos, blockFlag)
  if not pos then
    return false
  end
  local utilData = self._world:GetService("UtilData")
  if not utilData:IsValidPiecePos(pos) then
    return true
  end
  if not blockFlag then
    return false
  end
  local pieceBlock = self:FindBlockByPos(pos)
  if nil == pieceBlock then
    return true
  end
  return pieceBlock:CheckBlock(blockFlag)
end

function BoardServiceLogic:FindBlockByPos(pos)
  local boardEntity = self._world:GetBoardEntity()
  local cmptBoard = boardEntity:Board()
  return cmptBoard:FindBlockByPos(pos)
end

function BoardServiceLogic:GetBlockFlagByBlockId(blockId)
  if self._blockDict then
    if self._blockDict[blockId] then
      return self._blockDict[blockId]
    end
  else
    self._blockDict = {}
  end
  local cfgv = Cfg.cfg_block[blockId]
  if cfgv then
    local b = 0
    for _, value in ipairs(cfgv.BlockFlag) do
      b = b | GetBlockFlagByValue(value)
    end
    self._blockDict[blockId] = b
    return b
  else
    Log.fatal("### no block id in cfg_block. blockId=", blockId)
  end
  return 0
end

function BoardServiceLogic:IsPosExistNegtiveBlock(pos)
  local block = self:FindBlockByPos(pos)
  return block:IsExistNegative()
end

function BoardServiceLogic:RemoveEntityBlockFlag(e, posOld)
  if e:HasPetPstID() then
    e = e:Pet():GetOwnerTeamEntity()
  end
  local bodyArea = e:BodyArea():GetArea()
  local blockFlag = self:GetBlockFlag(e)
  for _, area in ipairs(bodyArea) do
    self:RemovePosBlock(e, posOld + area, blockFlag)
  end
  return bodyArea, blockFlag
end

function BoardServiceLogic:RemovePosBlock(e, pos, blockFlag)
  local utilData = self._world:GetService("UtilData")
  if not utilData:IsValidPiecePos(pos) then
    return
  end
  local pieceBlock = self:FindBlockByPos(pos)
  if nil == pieceBlock then
    return
  end
  if e:HasPetPstID() then
    e = e:Pet():GetOwnerTeamEntity()
  end
  pieceBlock:DelBlock(e:GetID(), blockFlag)
  local boardCmpt = self._world:GetBoardEntity():Board()
  boardCmpt:RemovePieceEntity(pos, e)
end

function BoardServiceLogic:UpdateEntityBlockFlag(e, posOld, posNew)
  if e:HasPetPstID() then
    e = e:Pet():GetOwnerTeamEntity()
  end
  local bodyArea, blockFlag = self:RemoveEntityBlockFlag(e, posOld)
  for _, area in ipairs(bodyArea) do
    self:SetPosBlock(e, posNew + area, blockFlag)
  end
end

function BoardServiceLogic:SetEntityBlockFlag(e, pos, blockFlag)
  if e:HasPetPstID() then
    e = e:Pet():GetOwnerTeamEntity()
  end
  local bodyArea = e:BodyArea():GetArea()
  for _, area in ipairs(bodyArea) do
    self:SetPosBlock(e, pos + area, blockFlag)
  end
end

function BoardServiceLogic:SetPosBlock(entity, pos, blockFlag)
  local utilData = self._world:GetService("UtilData")
  if not utilData:IsValidPiecePos(pos) then
    return
  end
  local boardCmpt = self._world:GetBoardEntity():Board()
  boardCmpt:AddPieceEntity(pos, entity)
  local pieceBlock = self:FindBlockByPos(pos)
  if pieceBlock == nil then
    return
  end
  blockFlag = blockFlag or self:GetBlockFlag(entity)
  pieceBlock:AddBlock(entity:GetID(), blockFlag)
end

function BoardServiceLogic:GetBlockFlag(e)
  if e:HasGhost() then
    local ownerId = e:Ghost():GetOwnerID()
    local eOwner = self._world:GetEntityByID(ownerId)
    if eOwner then
      return self:GetBlockFlag(eOwner)
    end
    Log.fatal("### Ghost has not owner.", e:GridLocation() and e:GridLocation().Position, ownerId)
    return 0
  end
  if e:HasGuideGhost() then
    local ownerId = e:GuideGhost():GetOwnerID()
    local eOwner = self._world:GetEntityByID(ownerId)
    if eOwner then
      return self:GetBlockFlag(eOwner)
    end
    Log.fatal("### Guide Ghost has not owner.", e:GridLocation() and e:GridLocation().Position, ownerId)
    return 0
  end
  if e:HasBlockFlag() then
    return e:BlockFlag():GetBlockFlag()
  end
  Log.fatal("### RemoveEntityBlockFlag new entity type.", e:EntityType().Value)
  return 0
end

function BoardServiceLogic:GetPosListByFlag(blockFlag)
  local boardEntity = self._world:GetBoardEntity()
  local cBoard = boardEntity:Board()
  return cBoard:GetPosListByFlag(blockFlag)
end

function BoardServiceLogic:IsMonsterPosBlock(monsterEntity, newPos, blockFlag)
  if not monsterEntity or not monsterEntity:GetID() then
    return false
  end
  local areaCmpt = monsterEntity:BodyArea()
  local areaList = areaCmpt:GetArea()
  return self:IsPosBlockByArea(newPos, blockFlag, areaList)
end
