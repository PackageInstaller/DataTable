require("base_ins_r")
_class("PlayTransportInstruction", BaseInstruction)
PlayTransportInstruction = PlayTransportInstruction

function PlayTransportInstruction:Constructor(paramList)
end

function PlayTransportInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Transport)
  if resultArray == nil then
    Log.fatal("PlayTransportInstruction, result is nil.")
    return
  end
  local playSkillInstructionService = world:GetService("PlaySkillInstruction")
  local pieceService = world:GetService("Piece")
  local boardServiceRender = world:GetService("BoardRender")
  local trapSvc = world:GetService("TrapRender")
  local playBuffService = world:GetService("PlayBuff")
  local renderBoardEntity = world:GetRenderBoardEntity()
  local renderBoardComponent = renderBoardEntity:RenderBoard()
  for _, v in ipairs(resultArray) do
    local arrPiece = {}
    local allEntity = {}
    local arrMovers = {}
    local entityResult = v:GetTransportEntities()
    local pieceResult = v:GetTransportPieceResult()
    local prismResult = v:GetTransportPrisms()
    local convertResult = v:GetConvertColors()
    local trapResult = v:GetTrapSkillResults()
    local isLoop = v:IsLoop()
    for i, r in ipairs(pieceResult) do
      local oldPos, newPos = r[1], r[2]
      local pieceEntity = pieceService:FindPieceEntity(oldPos)
      if pieceEntity then
        local t = {
          pieceEntity,
          oldPos,
          newPos
        }
        allEntity[#allEntity + 1] = t
        arrPiece[#arrPiece + 1] = t
      end
    end
    for i, r in ipairs(entityResult) do
      local eid, oldPos, newPos = table.unpack(r)
      local e = world:GetEntityByID(eid)
      if e then
        local t = {
          e,
          oldPos,
          newPos
        }
        allEntity[#allEntity + 1] = t
        arrMovers[#arrMovers + 1] = t
      end
    end
    local tempEntity, lastPieceEntity
    if isLoop == 0 then
      local firstPieceRes = pieceResult[1]
      local firstPiecePos = firstPieceRes[1]
      local oriFirstPieceEntity = pieceService:FindPieceEntity(firstPiecePos)
      local pieceType = oriFirstPieceEntity:Piece():GetPieceType()
      for _, v in ipairs(convertResult) do
        if firstPiecePos == v[1] then
          pieceType = v[3]
          break
        end
      end
      tempEntity = self:_CreatePieceEntity(world, pieceType, firstPiecePos)
      pieceService:SetPieceEntityAnimNormal(tempEntity)
      local lastPieceRes = pieceResult[#pieceResult]
      local lastPiecePos = lastPieceRes[2]
      lastPieceEntity = pieceService:FindPieceEntity(lastPiecePos)
      if lastPieceEntity then
        lastPieceEntity:SetLocationHeight(-0.001)
      end
    end
    for i, v in ipairs(allEntity) do
      local e = v[1]
      local posTarget = v[3]
      local gridPos = boardServiceRender:GetRealEntityGridPos(e)
      local canMoving = self:OnCheckCanMoving(world, e)
      if canMoving then
        if not e:HasTeam() then
          e:AddGridMove(BattleConst.ConveySpeed, posTarget, gridPos)
          if e:HasTrapRoundInfoRender() then
            local eid = e:TrapRoundInfoRender():GetRoundInfoEntityID()
            if eid then
              local eff = world:GetEntityByID(eid)
              eff:AddGridMove(BattleConst.ConveySpeed, posTarget, gridPos)
            end
          end
        end
        if e:HasTeam() then
          e:AddGridMove(BattleConst.ConveySpeed, posTarget, gridPos)
          local entityList = e:Team():GetTeamPetEntities()
          for k, entity in pairs(entityList) do
            entity:AddGridMove(BattleConst.ConveySpeed, posTarget, gridPos)
          end
        end
      end
    end
    while self:IsMoving(allEntity) do
      YIELD(TT)
    end
    local notRefreshPrism = true
    if isLoop == 0 then
      if tempEntity then
        world:DestroyEntity(tempEntity)
      end
      if lastPieceEntity then
        lastPieceEntity:SetLocationHeight(0)
      end
      for _, t in ipairs(arrPiece) do
        local e = t[1]
        local oldPos = t[2]
        local gridLocationCmp = e:GridLocation()
        if gridLocationCmp then
          e:SetGridPosition(oldPos)
          e:SetLocation(oldPos, e:GetGridDirection())
        end
      end
      for _, v in ipairs(convertResult) do
        local pos = v[1]
        local elementType = v[3]
        playSkillInstructionService:GridConvert(TT, casterEntity, pos, 0, elementType, notRefreshPrism)
      end
    else
      for _, t in ipairs(arrPiece) do
        local e = t[1]
        local newPos = t[3]
        renderBoardComponent:SetGridRenderEntityData(newPos, e)
        pieceService:SetPieceAnimation(newPos, "Normal")
        e:SetGridPosition(newPos)
      end
      for _, v in ipairs(convertResult) do
        local pos = v[1]
        local elementType = v[3]
        local gridEntity = pieceService:FindPieceEntity(pos)
        if gridEntity:Piece():GetPieceType() ~= elementType then
          playSkillInstructionService:GridConvert(TT, casterEntity, pos, 0, elementType, notRefreshPrism)
        end
      end
    end
    for i, v in ipairs(allEntity) do
      local e = v[1]
      local posTarget = v[3]
      trapSvc:OnCheckTrapViewSetPieceExtraLayer(e, posTarget)
    end
    for _, v in ipairs(trapResult) do
      local eId = v[1]
      local e = world:GetEntityByID(eId)
      local skillEffectResultContainer = v[2]
      local triggerEid = v[3]
      local triggerEntity = world:GetEntityByID(triggerEid)
      e:SkillRoutine():SetResultContainer(skillEffectResultContainer)
      trapSvc:PlayTrapTriggerSkill(TT, e, false, triggerEntity)
    end
    for _, v in pairs(prismResult) do
      local oldPos = v[1]
      pieceService:SetPieceRenderEffect(oldPos, PieceEffectType.Normal)
    end
    for _, v in pairs(prismResult) do
      local newPos = v[2]
      local pieceEffectType = v[4]
      if newPos then
        pieceService:SetPieceRenderEffect(newPos, pieceEffectType)
      end
    end
    pieceService:RefreshPieceAnim()
    for _, v in ipairs(arrMovers) do
      playBuffService:PlayBuffView(TT, NTTransportEachMoveEnd:New(v[1], v[2], v[3]))
    end
    YIELD(TT)
  end
end

function PlayTransportInstruction:OnCheckCanMoving(world, e)
  if e:HasTrapID() then
    local trapSvc = world:GetService("TrapRender")
    local isPieceExtraLayerTrap = trapSvc:IsPieceExtraLayerTrap(e)
    if isPieceExtraLayerTrap == true then
      return false
    end
  end
  return true
end

function PlayTransportInstruction:IsMoving(es)
  for _, t in ipairs(es) do
    local e = t[1]
    if e:HasGridMove() then
      return true
    end
  end
end

function PlayTransportInstruction:_CreatePieceEntity(world, pieceType, pos)
  local sEntity = world:GetService("RenderEntity")
  local pieceEntity = sEntity:CreateRenderEntity(EntityConfigIDRender.Grid)
  local pieceService = world:GetService("Piece")
  pieceService:SetPieceEntityPieceType(pieceEntity, pieceType)
  pieceEntity:SetGridPosition(pos)
  pieceEntity:SetPosition(pos)
  pieceEntity:SetLocationHeight(-0.001)
  pieceEntity:RemoveOutsideRegion()
  return pieceEntity
end
