require("base_ins_r")
_class("PlayPushBoardInstruction", BaseInstruction)
PlayPushBoardInstruction = PlayPushBoardInstruction

function PlayPushBoardInstruction:Constructor(paramList)
  self._dirX = tonumber(paramList.dirX) or 0
  self._dirY = tonumber(paramList.dirY) or 0
  self._dir = Vector2(self._dirX, self._dirY)
end

function PlayPushBoardInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.PushBoard)
  if resultArray == nil then
    Log.fatal("PlayPushBoardInstruction, result is nil.")
    return
  end
  local playSkillInstructionService = world:GetService("PlaySkillInstruction")
  local pieceSvc = world:GetService("Piece")
  local boardSvcR = world:GetService("BoardRender")
  local trapSvc = world:GetService("TrapRender")
  local renderEntitySvc = world:GetService("RenderEntity")
  local renderBoardEntity = world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local renderBoardPushCmpt = renderBoardEntity:RenderBoardPush()
  for moveIndex, pushRes in ipairs(resultArray) do
    local basePos = boardSvcR:GetBaseGridRenderPos()
    local pushVec = Vector3(self._dir.x, 0, self._dir.y)
    basePos = basePos - pushVec
    boardSvcR:SetBaseGridRenderPos(basePos)
    local pool = {}
    for i, pos in ipairs(pushRes:GetRemoveBoardPiece()) do
      local pieceEntity = renderBoardCmpt:GetGridRenderEntity(pos)
      if pieceEntity then
        pieceEntity:SetViewVisible(false)
        pool[i] = pieceEntity
      end
      renderBoardCmpt:RemoveGridRenderEntityData(pos)
    end
    for _, moveInfo in ipairs(pushRes:GetMoveBoardPiece()) do
      local oldPos, newPos = moveInfo[1], moveInfo[2]
      local pieceEntity = pieceSvc:FindPieceEntity(oldPos)
      if pieceEntity then
        local gridLocationCmp = pieceEntity:GridLocation()
        if gridLocationCmp then
          pieceEntity:SetGridPosition(newPos)
        end
        renderBoardCmpt:SetGridRenderEntityData(newPos, pieceEntity)
      end
    end
    for i, newInfo in ipairs(pushRes:GetNewBoardPiece()) do
      local pos, pieceType, fakeGridPos = newInfo[1], newInfo[2], newInfo[3]
      local fakeGridEntity = renderBoardPushCmpt:GetGridRenderEntity(fakeGridPos)
      pieceSvc:DestroyPieceEntity(fakeGridEntity)
      renderBoardPushCmpt:RemoveGridRenderEntityData(fakeGridPos)
      local gridEntity = pool[i]
      gridEntity = boardSvcR:ModifyGridEntity(gridEntity, pos, pieceType)
      renderBoardCmpt:SetGridRenderEntityData(pos, gridEntity)
      pieceSvc:SetPieceEntityAnimNormal(gridEntity)
    end
    for _, entityID in ipairs(pushRes:GetLogicMoveEntity()) do
      local entity = world:GetEntityByID(entityID)
      if entity:HasTrapID() then
        local trapRCmpt = entity:TrapRender()
        if trapRCmpt:GetTrapType() == TrapType.Auras then
          entity:ReplaceTrapAurasOutline()
        end
      end
    end
    for _, moveInfo in ipairs(pushRes:GetRenderMoveEntity()) do
      local entity = world:GetEntityByID(moveInfo[1])
      local canMoving = self:OnCheckCanMoving(world, entity)
      if canMoving then
        local posTarget = moveInfo[2]
        local gridPos = boardSvcR:GetRealEntityGridPos(entity)
        entity:RemoveGridMove()
        entity:AddGridMove(BattleConst.ConveySpeed, posTarget, gridPos)
        if entity:HasTeam() then
          local petList = entity:Team():GetTeamPetEntities()
          for _, pet in pairs(petList) do
            pet:RemoveGridMove()
            pet:AddGridMove(BattleConst.ConveySpeed, posTarget, gridPos)
          end
        elseif entity:MonsterID() then
          renderEntitySvc:DestroyMonsterAreaOutLineEntity(entity)
          local pos = gridPos - entity:GridLocation():GetGridOffset()
          local bodyArea = entity:BodyArea():GetArea()
          for _, area in ipairs(bodyArea) do
            local workPos = area + pos
            local curPieceAnim = pieceSvc:GetPieceAnimation(workPos)
            if curPieceAnim == "Down" then
              pieceSvc:SetPieceAnimUp(workPos)
            end
          end
        elseif entity:HasTrapID() then
        end
      end
    end
    if moveIndex == 1 then
      local moveStep = #resultArray
      local offsetPos = Vector3(self._dir.x * moveStep, 0, self._dir.y * moveStep)
      local battleRenderCmpt = world:BattleRenderConfig()
      local boardCenterPos = battleRenderCmpt:GetCurWaveBoardCenter()
      if boardCenterPos then
        boardCenterPos = boardCenterPos - offsetPos
      else
        local configService = world:GetService("Config")
        local levelConfig = configService:GetLevelConfigData()
        boardCenterPos = levelConfig:GetBoardCenterPos() - offsetPos
      end
      local mainCameraCmpt = world:MainCamera()
      local mainCamera = mainCameraCmpt:Camera()
      local cameraTran = mainCamera.transform
      local targetMovePos = cameraTran.position - offsetPos
      local moveTime = 1 / BattleConst.ConveySpeed * moveStep
      cameraTran:DOMove(targetMovePos, moveTime, false):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
        mainCameraCmpt:SetCameraPos(targetMovePos)
        battleRenderCmpt:SetCurWaveBoardCenter(boardCenterPos)
      end)
    end
    YIELD(TT, 1 / BattleConst.ConveySpeed * 1000)
    local notRefreshPrism = true
    for _, convertInfo in ipairs(pushRes:GetConvertInfo()) do
      local pos = convertInfo[1]
      local elementType = convertInfo[2]
      playSkillInstructionService:GridConvert(TT, casterEntity, pos, 0, elementType, notRefreshPrism)
    end
    for _, moveInfo in ipairs(pushRes:GetRenderMoveEntity()) do
      local entity = world:GetEntityByID(moveInfo[1])
      local posTarget = moveInfo[2]
      trapSvc:OnCheckTrapViewSetPieceExtraLayer(entity, posTarget)
    end
    for _, trapSkillRes in ipairs(pushRes:GetTrapSkillResults()) do
      local entityID = trapSkillRes[1]
      local trapEntity = world:GetEntityByID(entityID)
      local skillEffectResultContainer = trapSkillRes[2]
      local triggerEntityID = trapSkillRes[3]
      local triggerEntity = world:GetEntityByID(triggerEntityID)
      trapEntity:SkillRoutine():SetResultContainer(skillEffectResultContainer)
      trapSvc:PlayTrapTriggerSkill(TT, trapEntity, false, triggerEntity)
    end
    for _, entityID in ipairs(pushRes:GetTrapDestroyList()) do
      local entity = world:GetEntityByID(entityID)
      trapSvc:PlayTrapDieSkill(TT, {entity}, true)
      local trapRCmpt = entity:TrapRender()
      if trapRCmpt:GetTrapType() == TrapType.Auras then
        trapRCmpt:SetAurasStatus(TrapAurasState.Close)
        entity:ReplaceTrapAurasOutline()
      end
    end
    for _, prismInfo in pairs(pushRes:GetMoveBoardPrisms()) do
      local oldPos = prismInfo[1]
      pieceSvc:SetPieceRenderEffect(oldPos, PieceEffectType.Normal)
      local newPos = prismInfo[2]
      local pieceEffectType = prismInfo[4]
      if newPos then
        pieceSvc:SetPieceRenderEffect(newPos, pieceEffectType)
      end
    end
  end
  pieceSvc:RefreshPieceAnim()
  pieceSvc:RefreshMonsterAreaOutLine(TT)
end

function PlayPushBoardInstruction:OnCheckCanMoving(world, e)
  if e:HasTrapID() then
    local trapSvc = world:GetService("TrapRender")
    local isPieceExtraLayerTrap = trapSvc:IsPieceExtraLayerTrap(e)
    if isPieceExtraLayerTrap == true then
      return false
    end
  end
  return true
end
