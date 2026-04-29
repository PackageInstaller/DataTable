require("base_ins_r")
_class("PlayTransportByRangeInstruction", BaseInstruction)
PlayTransportByRangeInstruction = PlayTransportByRangeInstruction

function PlayTransportByRangeInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.EffectID) or 41
end

function PlayTransportByRangeInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local effectResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.TransportByRange)
  if effectResult == nil then
    return
  end
  local pieceDataList = effectResult:GetPieceDataList()
  local posList = {}
  for i, data in ipairs(pieceDataList) do
    local pos = data:GetPiecePos()
    table.insert(posList, pos)
  end
  local pieceSvc = self._world:GetService("Piece")
  local moveEntityList = {}
  local utilDataSvc = self._world:GetService("UtilData")
  local trapServiceRender = self._world:GetService("TrapRender")
  local goList = {}
  for _, data in ipairs(pieceDataList) do
    trapServiceRender:OnTakeOutTrapFormPiece(data:GetPiecePos())
    local sourcePieceEntity = pieceSvc:FindPieceEntity(data:GetPiecePos())
    local dis = Vector2.Distance(data:GetNextPos(), data:GetPiecePos())
    sourcePieceEntity:AddGridMove(BattleConst.ConveySpeed * dis, data:GetNextPos(), data:GetPiecePos())
    table.insert(moveEntityList, sourcePieceEntity)
    pieceSvc:SetPieceRenderEffect(data:GetPiecePos(), PieceEffectType.Normal)
    pieceSvc:SetPieceEntityAnimNormal(sourcePieceEntity)
    if not utilDataSvc:IsValidPiecePos(data:GetNextPos()) then
      local go = sourcePieceEntity:View().ViewWrapper.GameObject
      table.insert(goList, go)
      pieceSvc:SetPieceShowRange(sourcePieceEntity, data:GetPiecePos())
    end
  end
  local targetID, targetPos, targetNextPos = effectResult:GetTargetData()
  if targetID then
    local targetEntity = self._world:GetEntityByID(targetID)
    targetEntity:AddGridMove(BattleConst.ConveySpeed, targetNextPos, targetPos)
    table.insert(moveEntityList, targetEntity)
  end
  while self:IsMoving(moveEntityList) do
    YIELD(TT)
  end
  if targetID then
    local targetEntity = self._world:GetEntityByID(targetID)
    local playBuffService = self._world:GetService("PlayBuff")
    playBuffService:PlayBuffView(TT, NTTransportEachMoveEnd:New(targetEntity, targetPos, targetNextPos))
  end
  for _, gameObj in ipairs(goList) do
    pieceSvc:RevertPieceShowRangeByGameObj(gameObj)
  end
  for _, data in ipairs(pieceDataList) do
    local sourcePieceEntity = pieceSvc:FindPieceEntity(data:GetPiecePos())
    local gridLocationCmp = sourcePieceEntity:GridLocation()
    if gridLocationCmp then
      sourcePieceEntity:SetLocation(data:GetPiecePos(), sourcePieceEntity:GetGridDirection())
    end
  end
  local playSkillInstructionService = self._world:GetService("PlaySkillInstruction")
  local utilDataSvc = self._world:GetService("UtilData")
  for _, data in ipairs(pieceDataList) do
    local nextPos = data:GetNextPos()
    if utilDataSvc:IsValidPiecePos(nextPos) then
      playSkillInstructionService:GridConvert(TT, casterEntity, data:GetNextPos(), 0, data:GetPieceType(), true)
    end
  end
  local resetDataList = effectResult:GetResetGridPieceDataList()
  if resetDataList then
    for i, data in ipairs(resetDataList) do
      local nextPos = data:GetNextPos()
      if utilDataSvc:IsValidPiecePos(nextPos) then
        playSkillInstructionService:GridConvert(TT, casterEntity, data:GetNextPos(), 0, data:GetPieceType(), true)
      end
    end
  end
  for _, data in ipairs(pieceDataList) do
    pieceSvc:ResetPieceEffectRender(data:GetPiecePos())
    trapServiceRender:OnGiveBackTrapToPiece(data:GetPiecePos())
  end
end

function PlayTransportByRangeInstruction:IsMoving(es)
  for _, e in ipairs(es) do
    if e:HasGridMove() then
      return true
    end
  end
end

function PlayTransportByRangeInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
