require("base_ins_r")
_class("PlayStuntMonsterInstruction", BaseInstruction)
PlayStuntMonsterInstruction = PlayStuntMonsterInstruction

function PlayStuntMonsterInstruction:Constructor(paramList)
  self._stuntTag = paramList.tag or "default"
  self._remove = paramList.remove
  self._monsterClassID = tonumber(paramList.monsterClassID)
end

function PlayStuntMonsterInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if not casterEntity:HasMonsterID() then
    return
  end
  if not self._remove then
    self:_CreateStunt(TT, casterEntity, phaseContext)
  else
    self:_DestroyStunt(TT, casterEntity, phaseContext)
  end
end

function PlayStuntMonsterInstruction:_CreateStunt(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local resvc = world:GetService("RenderEntity")
  local eStuntMonster = resvc:CreateStuntMonster(casterEntity, self._stuntTag, self._monsterClassID)
  if not eStuntMonster then
    Log.error("Stunt monster create failed. ")
    return
  end
  local renderBoardEntity = world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local tv2GridPos = {}
  for x, groupX in pairs(renderBoardCmpt._gridEntityTable) do
    for y, _ in pairs(groupX) do
      table.insert(tv2GridPos, Vector2.New(x, y))
    end
  end
  local v2TargetPos, v2BackupTargetPos
  local bodyArea = casterEntity:BodyArea():GetArea()
  local v2CasterGridPos = casterEntity:GetGridPosition()
  local blockData = casterEntity:MonsterID():GetMonsterBlockData()
  local utilDataSvc = world:GetService("UtilData")
  while not v2TargetPos and 0 < #tv2GridPos do
    local v2Candidate = tv2GridPos[math.random(1, #tv2GridPos)]
    local isPosValid = true
    for _, v2BodyArea in ipairs(bodyArea) do
      local v2AbsBody = v2BodyArea + v2Candidate
      if not utilDataSvc:IsValidPiecePos(v2AbsBody) or utilDataSvc:IsPosBlock(v2AbsBody, blockData) then
        isPosValid = false
        break
      end
    end
    if isPosValid then
      v2TargetPos = v2Candidate
      break
    end
    if not v2BackupTargetPos then
      local isPosBackup = true
      for _, v2BodyArea in ipairs(bodyArea) do
        local v2AbsBody = v2BodyArea + v2Candidate
        if not utilDataSvc:IsValidPiecePos(v2AbsBody) then
          isPosBackup = false
          break
        end
        local pieceBlock = utilDataSvc:FindBlockByPos(v2AbsBody)
        if pieceBlock and (pieceBlock:FindEntity(world, EnumTargetEntity.Pet) or pieceBlock:GetEntityBlock(casterEntity:GetID())) then
          isPosBackup = false
          break
        end
      end
      if isPosBackup then
        v2BackupTargetPos = v2Candidate
      end
    end
  end
  if not v2TargetPos and not v2BackupTargetPos then
    v2TargetPos = Vector2.New(5, 5)
  end
  v2TargetPos = v2TargetPos or v2BackupTargetPos
  local v2Dir = 5 <= v2TargetPos.y and Vector2.down or Vector2.up
  eStuntMonster:SetLocation(v2TargetPos, v2Dir)
end

function PlayStuntMonsterInstruction:_DestroyStunt(TT, casterEntity, phaseContext)
  if not casterEntity:HasStuntOwnerComponent() then
    return
  end
  local cStunt = casterEntity:StuntOwnerComponent()
  cStunt:RemoveStunt(self._stuntTag)
end
