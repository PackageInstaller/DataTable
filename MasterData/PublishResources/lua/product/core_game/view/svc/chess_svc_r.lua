_class("ChessServiceRender", BaseService)
ChessServiceRender = ChessServiceRender

function ChessServiceRender:ClearAllChessUnitPreview()
  self:ClearChessMonsterPreview()
  self:ClearChessPetPreview()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local resCmpt = renderBoardEntity:PickUpChessResult()
  resCmpt:ResetChessPickUp()
  resCmpt:SetChessPetMovePath({})
end

function ChessServiceRender:ClearChessMonsterPreview()
  local previewActiveSkillSvc = self._world:GetService("PreviewActiveSkill")
  previewActiveSkillSvc:_RevertAllConvertElement(true)
  previewActiveSkillSvc:ResetPreview()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local resCmpt = renderBoardEntity:PickUpChessResult()
  local effectIDList = resCmpt:GetMonsterChessTargetEffectEntityIDList()
  for i, id in ipairs(effectIDList) do
    local effectEntity = self._world:GetEntityByID(id)
    self._world:DestroyEntity(effectEntity)
  end
  resCmpt:ClearMonsterChessTargetEffectEntityIDList()
  local prvwSvc = self._world:GetService("PreviewMonsterTrap")
  prvwSvc:HideHideInUIBar()
  local renderEntityService = self._world:GetService("RenderEntity")
  renderEntityService:DestroyGhost()
  renderEntityService:DestroyMonsterPreviewAreaOutlineEntity()
  local previewActiveSkillSvc = self._world:GetService("PreviewActiveSkill")
  self._world:GetService("MonsterShowRender"):MonsterGridAnimDown()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  previewActiveSkillService:HideSkillTips()
  local pieceService = self._world:GetService("Piece")
  pieceService:RefreshPieceAnim()
  local GLOBALmonsterGroupEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(GLOBALmonsterGroupEntities) do
    e:ReplaceChessTargetedMark(false)
    local view = e:View()
    local go = view:GetGameObject()
    local outlineCmpt = go:GetComponent(typeof(OutlineComponent))
    if outlineCmpt then
      outlineCmpt.enabled = false
    end
    local comp = e:MaterialAnimationComponent()
    comp:StopLayer(MaterialAnimLayer.SkillPreview)
  end
  local entityList = self._world:GetGroupEntities(self._world.BW_WEMatchers.ChessPet)
  for _, v in ipairs(entityList) do
    local comp = v:MaterialAnimationComponent()
    comp:StopLayer(MaterialAnimLayer.SkillPreview)
  end
end

function ChessServiceRender:ClearChessPetPreview()
  local renderEntityService = self._world:GetService("RenderEntity")
  renderEntityService:DestroyGhost()
  local pieceService = self._world:GetService("Piece")
  pieceService:RefreshPieceAnim()
  local linkageRenderService = self._world:GetService("LinkageRender")
  linkageRenderService:DestroyAllLinkLine()
  self:DestroyPreviewChessPetEffectEntity()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local resCmpt = renderBoardEntity:PickUpChessResult()
  local entityID = resCmpt:GetPickUpChessPetEntityID()
  local chessPetEntity = self._world:GetEntityByID(entityID)
  self:RefreshChessPetSelectStateRender(chessPetEntity, false)
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.HP)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    e:ReplaceChessTargetedMark(false)
  end
  self._world:EventDispatcher():Dispatch(GameEventType.ChessUIStateTransit, UIBattleWidgetChessState.FinishTurnOnly)
  self:HideChessPetSkillTips()
end

function ChessServiceRender:DestroyPreviewChessPetEffectEntity()
  local effectSvc = self._world:GetService("Effect")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local previewChessPetCmpt = renderBoardEntity:PreviewChessPet()
  local moveRangeEntityIDList = previewChessPetCmpt:GetMoveRangeEffectEntityIDList()
  local attackRangeEntityIDList = previewChessPetCmpt:GetAttackRangeEffectEntityIDList()
  effectSvc:_DestroyEffectArray(moveRangeEntityIDList)
  effectSvc:_DestroyEffectArray(attackRangeEntityIDList)
  previewChessPetCmpt:ClearChessPetPreviewList()
end

function ChessServiceRender:RestartChessPetPreviewAttackRange()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local resCmpt = renderBoardEntity:PickUpChessResult()
  local walkRange = resCmpt:GetChessPetWalkRange()
  local attackRange = resCmpt:GetChessPetAttackRange()
  local isRecover = resCmpt:GetSkillIsRecover()
  self:ShowChessPetPreviewRange(walkRange, attackRange, {}, {}, isRecover)
end

function ChessServiceRender:ShowChessPetPreviewRange(walkRange, attackRange, selectRange, targetIDs, isRecover)
  local effectSvc = self._world:GetService("Effect")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local previewChessPetCmpt = renderBoardEntity:PreviewChessPet()
  self:DestroyPreviewChessPetEffectEntity()
  for k, pos in ipairs(selectRange) do
    local effectEntity = effectSvc:CreateCommonGridEffect(GameResourceConst.ChessPet_AttackTarget_EffectID, pos)
    previewChessPetCmpt:AddAttackRangeEffectEntityID(effectEntity:GetID())
  end
  local targetEffectID = GameResourceConst.ChessPet_AttackRange_EffectID
  if isRecover then
    targetEffectID = GameResourceConst.ChessPet_RecoverRange_EffectID
  end
  for k, pos in ipairs(attackRange) do
    if not table.intable(selectRange, pos) then
      local effectEntity = effectSvc:CreateCommonGridEffect(targetEffectID, pos)
      previewChessPetCmpt:AddAttackRangeEffectEntityID(effectEntity:GetID())
    end
  end
  for k, pos in ipairs(walkRange) do
    if not table.intable(attackRange, pos) and not table.intable(selectRange, pos) then
      local effectEntity = effectSvc:CreateCommonGridEffect(GameResourceConst.ChessPet_MoveRange_EffectID, pos)
      previewChessPetCmpt:AddMoveRangeEffectEntityID(effectEntity:GetID())
    end
  end
  local pieceService = self._world:GetService("Piece")
  local pieceGroup = self._world:GetGroup(self._world.BW_WEMatchers.Piece)
  for _, e in ipairs(pieceGroup:GetEntities()) do
    local pos = e:GetGridPosition()
    if not table.icontains(walkRange, pos) then
      pieceService:SetPieceAnimDown(pos)
    end
  end
  local entitySelectedDic = {}
  for _, eid in ipairs(targetIDs) do
    entitySelectedDic[eid] = true
  end
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.HP)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    if not e:HasDeadMark() then
      e:ReplaceChessTargetedMark(entitySelectedDic[e:GetID()], isRecover)
    end
  end
end

function ChessServiceRender:GetPreviewChessPetDir()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local resCmpt = renderBoardEntity:PickUpChessResult()
  local entityID = resCmpt:GetPickUpChessPetEntityID()
  local pickUpMonsterEntityID = resCmpt:GetPickUpMonsterEntityID()
  local chessPetEntity = self._world:GetEntityByID(entityID)
  local chessPetDir = chessPetEntity:GetDirection()
  local pickUpPos = resCmpt:GetCurChessPickUpPos()
  local bodyArea = chessPetEntity:BodyArea():GetArea()
  if table.count(bodyArea) == 1 then
    local movePath = resCmpt:GetChessPetMovePath()
    if pickUpMonsterEntityID and table.count(movePath) > 0 then
      chessPetDir = pickUpPos - movePath[#movePath]
    elseif table.count(movePath) > 1 then
      chessPetDir = movePath[#movePath] - movePath[#movePath - 1]
    end
  end
  return chessPetDir
end

function ChessServiceRender:ShowChessPetPreviewGhost(gridPos)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local resCmpt = renderBoardEntity:PickUpChessResult()
  local entityID = resCmpt:GetPickUpChessPetEntityID()
  local chessPetEntity = self._world:GetEntityByID(entityID)
  local previewGhostEntity = self:_CreateChessPetPreviewGhost(chessPetEntity, gridPos)
  local previewDir = self:GetPreviewChessPetDir()
  local bodyArea = chessPetEntity:BodyArea():GetArea()
  if table.count(bodyArea) == 1 then
    self:OnCalcMovePath(gridPos)
    self:OnShowMovePathLineRender()
    previewGhostEntity:SetLocation(gridPos, previewDir)
  else
    local chessPetCenterPos = chessPetEntity:GridLocation():GetGridPos()
    local chessPetOffset = chessPetEntity:GridLocation():GetGridOffset()
    local chessPetCenter = chessPetEntity:GridLocation():Center()
    if chessPetCenterPos == gridPos then
      resCmpt:SetChessPetMovePath({chessPetCenterPos})
      previewGhostEntity:SetLocation(chessPetCenter, previewDir)
    else
      local dirs = {
        Vector2(0, 1),
        Vector2(1, 0),
        Vector2(0, -1),
        Vector2(-1, 0)
      }
      local setLocationPos, setGridPosition
      for _, dir in ipairs(dirs) do
        local targetPos = chessPetCenterPos + dir
        for i, area in ipairs(bodyArea) do
          local posWork = targetPos + area
          if posWork == gridPos then
            setGridPosition = targetPos
            setLocationPos = targetPos + chessPetOffset
            break
          end
        end
        if setLocationPos then
          resCmpt:SetChessPetMovePath({targetPos})
          break
        end
      end
      previewGhostEntity:SetLocation(setLocationPos, previewDir)
      if setGridPosition then
        previewGhostEntity:SetGridPosition(setGridPosition)
      end
    end
  end
end

function ChessServiceRender:_CreateChessPetPreviewGhost(chessPetEntity, gridPos)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local resCmpt = renderBoardEntity:PickUpChessResult()
  local previewGhostEntityID = resCmpt:GetPickUpPreviewGhostEntityID()
  local previewGhostEntity = self._world:GetEntityByID(previewGhostEntityID)
  if not previewGhostEntity then
    local renderEntityService = self._world:GetService("RenderEntity")
    previewGhostEntity = renderEntityService:CreateGhost(gridPos, chessPetEntity)
    resCmpt:SetPickUpPreviewGhostEntityID(previewGhostEntity:GetID())
  end
  return previewGhostEntity
end

function ChessServiceRender:OnPickUpChessPetAttackRange(gridPos)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local resCmpt = renderBoardEntity:PickUpChessResult()
  local entityID = resCmpt:GetPickUpChessPetEntityID()
  local chessPetEntity = self._world:GetEntityByID(entityID)
  local chessPetCmpt = chessPetEntity:ChessPet()
  local chessPetID = chessPetCmpt:GetChessPetID()
  local chessPetPos = chessPetEntity:GridLocation():GetGridPos()
  local walkRange = resCmpt:GetChessPetWalkRange()
  local attackRange = resCmpt:GetChessPetAttackRange()
  local previewSkill = chessPetCmpt:GetPreviewSkillID()
  local cfgSvc = self._world:GetService("Config")
  local chessPetConfigData = cfgSvc:GetChessPetConfigData()
  local skillConfigData = cfgSvc:GetSkillConfigData(previewSkill, chessPetEntity)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeResult = utilScopeSvc:CalcSkillScope(skillConfigData, gridPos, chessPetEntity)
  local scopeList = scopeResult:GetAttackRange()
  local bodyArea = chessPetEntity:BodyArea():GetArea()
  local walkCanAttackPosList = {}
  for _, pos in ipairs(scopeList) do
    if table.intable(walkRange, pos) then
      for _, area in ipairs(bodyArea) do
        local centerPos = pos - area
        if table.intable(walkRange, centerPos) and not table.intable(walkCanAttackPosList, centerPos) then
          local posInBodyAreaCanMove = 0
          for _, areaNew in ipairs(bodyArea) do
            local workPos = centerPos + areaNew
            if table.intable(walkRange, workPos) then
              posInBodyAreaCanMove = posInBodyAreaCanMove + 1
            end
          end
          if posInBodyAreaCanMove == table.count(bodyArea) then
            if table.count(bodyArea) == 1 then
              table.insert(walkCanAttackPosList, centerPos)
            else
              local scopeResultTmp = utilScopeSvc:CalcSkillScope(skillConfigData, centerPos, chessPetEntity)
              local scopeListTmp = scopeResultTmp:GetAttackRange()
              if table.intable(scopeListTmp, gridPos) then
                table.insert(walkCanAttackPosList, centerPos)
              end
            end
          end
        end
      end
    end
  end
  local targetMovePos = walkCanAttackPosList[1]
  local lastMovePath = resCmpt:GetChessPetMovePath()
  if table.count(lastMovePath) == 0 then
    targetMovePos = self:_OnCompareNearestPos(walkCanAttackPosList, chessPetPos)
  else
    targetMovePos = self:_OnCalcWithAttackRangeAndMovePath(targetMovePos, chessPetPos, lastMovePath, walkCanAttackPosList)
  end
  self:ShowChessPetPreviewGhost(targetMovePos)
  local attackSkill = chessPetCmpt:GetAttackSkillID()
  local pickUpPos = resCmpt:GetCurChessPickUpPos()
  local previewLogicDir = utilScopeSvc:GetChessEntityGridDirWithPickUpPos(chessPetEntity, pickUpPos, targetMovePos)
  local attackSkillConfigData = cfgSvc:GetSkillConfigData(attackSkill, chessPetEntity)
  local castPos = targetMovePos
  local curMovePath = resCmpt:GetChessPetMovePath()
  if 0 < table.count(curMovePath) then
    castPos = curMovePath[#curMovePath]
  end
  local scopeResultSelect = utilScopeSvc:CalcSkillScope(attackSkillConfigData, castPos, chessPetEntity, previewLogicDir)
  local selectRange = scopeResultSelect:GetAttackRange()
  local targetSelector = SkillScopeTargetSelector:New(self._world)
  local tTargetID = targetSelector:DoSelectSkillTarget(chessPetEntity, attackSkillConfigData:GetSkillTargetType(), scopeResultSelect, attackSkillConfigData:GetID(), attackSkillConfigData:GetSkillTargetTypeParam())
  table.removev(tTargetID, entityID)
  local isRecover = false
  local skillEffectArray = skillConfigData:GetSkillEffect()
  for _, skillEffect in ipairs(skillEffectArray) do
    if skillEffect:GetEffectType() == SkillEffectType.AddBlood then
      isRecover = true
      break
    end
  end
  self:ShowChessPetPreviewRange(walkRange, attackRange, selectRange, tTargetID, isRecover)
  self:ShowChessPetSkillTips(attackSkillConfigData)
end

function ChessServiceRender:ShowChessPetSkillTips(skillConfigData)
  local cRenderState = self._world:GetPreviewEntity():RenderState()
  local eSkillTips = self._world:GetEntityByID(cRenderState:GetSkillTipsEntityID())
  if not eSkillTips then
    local entityRenderSvc = self._world:GetService("RenderEntity")
    eSkillTips = entityRenderSvc:CreateRenderEntity(EntityConfigIDRender.SkillTips)
    cRenderState:SetSkillTipsEntityID(eSkillTips:GetID())
  end
  local name = skillConfigData:GetSkillName()
  local desc = skillConfigData:GetSkillDesc()
  eSkillTips:ReplaceSkillTips(name, desc)
  eSkillTips:SkillTips():SetTriggeredByChessPet(true)
  eSkillTips:SetViewVisible(true)
end

function ChessServiceRender:HideChessPetSkillTips()
  local cRenderState = self._world:GetPreviewEntity():RenderState()
  local eSkillTips = self._world:GetEntityByID(cRenderState:GetSkillTipsEntityID())
  if not eSkillTips then
    return
  end
  eSkillTips:SetViewVisible(false)
end

function ChessServiceRender:_OnCalcWithAttackRangeAndMovePath(targetMovePos, chessPetPos, lastMovePath, walkCanAttackPosList)
  local curMovePos
  for _, pos in ipairs(walkCanAttackPosList) do
    if pos == lastMovePath[#lastMovePath] then
      curMovePos = pos
      break
    end
  end
  if not curMovePos then
    for i = table.count(lastMovePath), 1, -1 do
      local pos = lastMovePath[i]
      for _, movePos in ipairs(walkCanAttackPosList) do
        if pos == movePos then
          curMovePos = pos
          break
        end
      end
      if curMovePos then
        break
      end
    end
  end
  if curMovePos then
    targetMovePos = curMovePos
  else
    targetMovePos = self:_OnCompareNearestPos(walkCanAttackPosList, chessPetPos)
  end
  return targetMovePos
end

function ChessServiceRender:OnCalcMovePath(targetMovePos)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local resCmpt = renderBoardEntity:PickUpChessResult()
  local entityID = resCmpt:GetPickUpChessPetEntityID()
  local chessPetEntity = self._world:GetEntityByID(entityID)
  local chessPetCmpt = chessPetEntity:ChessPet()
  local chessPetID = chessPetCmpt:GetChessPetID()
  local chessPetPos = chessPetEntity:GridLocation():GetGridPos()
  local lastMovePath = resCmpt:GetChessPetMovePath()
  local curMovePath = {}
  local cfgSvc = self._world:GetService("Config")
  local chessPetConfigData = cfgSvc:GetChessPetConfigData()
  local walkStep = chessPetConfigData:GetChessPetWalkStep(chessPetID)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local chessPetList, chessPetPosList = utilScopeSvc:SelectAllChessPet()
  if table.count(lastMovePath) == 0 then
    table.insert(curMovePath, chessPetPos)
    if chessPetPos == targetMovePos then
    else
      local movePath = self:_OnCalcShortestPath(chessPetPos, targetMovePos, chessPetPosList)
      table.appendArray(curMovePath, movePath)
    end
  elseif table.intable(lastMovePath, targetMovePos) then
    for _, pos in ipairs(lastMovePath) do
      table.insert(curMovePath, pos)
      if pos == targetMovePos then
        break
      end
    end
  else
    local hasWalkStep = table.count(lastMovePath) - 1
    local movePath = self:_OnCalcShortestPath(lastMovePath[#lastMovePath], targetMovePos, chessPetPosList, lastMovePath)
    local needWalkStep = table.count(movePath)
    if needWalkStep == 0 then
      table.insert(curMovePath, chessPetPos)
      movePath = self:_OnCalcShortestPath(chessPetPos, targetMovePos, chessPetPosList)
      table.appendArray(curMovePath, movePath)
    elseif 0 <= walkStep - hasWalkStep - needWalkStep then
      table.appendArray(curMovePath, lastMovePath)
      table.appendArray(curMovePath, movePath)
    else
      table.insert(curMovePath, chessPetPos)
      movePath = self:_OnCalcShortestPath(chessPetPos, targetMovePos, chessPetPosList)
      table.appendArray(curMovePath, movePath)
    end
  end
  resCmpt:SetChessPetMovePath(curMovePath)
end

function ChessServiceRender:_OnCompareNearestPos(posList, targetPos)
  local nearestPos = posList[1]
  for _, pos in ipairs(posList) do
    local dis1 = Vector2.Distance(nearestPos, targetPos)
    local dis2 = Vector2.Distance(pos, targetPos)
    if dis1 > dis2 then
      nearestPos = pos
    end
  end
  return nearestPos
end

function ChessServiceRender:_OnCalcShortestPath(posStart, posEnd, chessPetPosList, lastMovePath)
  local utilDataSvc = self._world:GetService("UtilData")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local resCmpt = renderBoardEntity:PickUpChessResult()
  local entityID = resCmpt:GetPickUpChessPetEntityID()
  local chessPetEntity = self._world:GetEntityByID(entityID)
  local chessPetCmpt = chessPetEntity:ChessPet()
  local chessPetID = chessPetCmpt:GetChessPetID()
  local blockData = chessPetCmpt:GetChessPetBlockData()
  local cfgSvc = self._world:GetService("Config")
  local chessPetConfigData = cfgSvc:GetChessPetConfigData()
  local walkStep = chessPetConfigData:GetChessPetWalkStep(chessPetID)
  local dirs = {
    Vector2(0, 1),
    Vector2(1, 0),
    Vector2(0, -1),
    Vector2(-1, 0)
  }
  local movePath = {}
  local walkLastPos = posStart
  for i = 1, walkStep do
    local sortPosList = {}
    for _, dir in ipairs(dirs) do
      local targetPos = walkLastPos + dir
      if not lastMovePath or lastMovePath and not table.intable(lastMovePath, targetPos) then
        local isBlocked = utilDataSvc:IsPosBlock(targetPos, blockData)
        if isBlocked and table.intable(chessPetPosList, targetPos) then
          isBlocked = false
        end
        if isBlocked == false then
          table.insert(sortPosList, targetPos)
        end
      end
    end
    local curMovePos = self:_OnCompareNearestPos(sortPosList, posEnd)
    table.insert(movePath, curMovePos)
    walkLastPos = movePath[#movePath]
    if walkLastPos == posEnd or walkLastPos == nil then
      break
    end
  end
  return movePath
end

function ChessServiceRender:OnShowMovePathLineRender()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local resCmpt = renderBoardEntity:PickUpChessResult()
  local movePath = resCmpt:GetChessPetMovePath()
  local pieceType = 1
  local linkageRenderService = self._world:GetService("LinkageRender")
  linkageRenderService:DestroyAllLinkLine()
  for i, pos in ipairs(movePath) do
    if i ~= 1 then
      local dir = movePath[i - 1] - movePath[i]
      linkageRenderService:CreateLineRender(movePath[i - 1], movePath[i], i, pos, dir, pieceType)
    end
  end
end

function ChessServiceRender:RefreshChessPetFinishStateRender(entityID, finishTurn)
  if finishTurn then
    self:HdieChessPetCanMoveEffect(entityID)
    local chessPetEntity = self._world:GetEntityByID(entityID)
    local matCmpt = chessPetEntity:MaterialAnimationComponent()
    matCmpt:PlayInvalid()
  else
    self:ShowChessPetCanMoveEffect(entityID)
  end
end

function ChessServiceRender:RefreshChessPetSelectStateRender(entity, select)
  if not entity then
    return
  end
  local chessPetRenderCmpt = entity:ChessPetRender()
  local effectEntityID = chessPetRenderCmpt:GetSelectEffectEntityID()
  local effectEntity = self._world:GetEntityByID(effectEntityID)
  if select == false then
    if effectEntity then
      effectEntity:SetViewVisible(false)
    end
  else
    if not effectEntity then
      local bodyArea = entity:BodyArea():GetArea()
      local effectID = GameResourceConst.ChessPet_CanAction_Selected_SingleGridEffectID
      if table.count(bodyArea) == 4 then
        effectID = GameResourceConst.ChessPet_CanAction_Selected_MultiGridEffectID
      end
      effectEntity = self._world:GetService("Effect"):CreateEffect(effectID, entity)
      chessPetRenderCmpt:SetSelectEffectEntityID(effectEntity:GetID())
    end
    effectEntity:SetViewVisible(true)
  end
end

function ChessServiceRender:DoRenderChessPetPathMove(TT)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderChessPathComponent = renderBoardEntity:RenderChessPath()
  local chessPetEntityID = renderChessPathComponent:GetRenderChessPetEntityID()
  local chessPetEntity = self._world:GetEntityByID(chessPetEntityID)
  local walkResultList = renderChessPathComponent:GetRenderWalkResultList()
  local boardServiceRender = self._world:GetService("BoardRender")
  local moveSpeed = self:_GetMoveSpeed(chessPetEntity)
  local hasWalkPoint = false
  if 0 < #walkResultList then
    hasWalkPoint = true
  end
  if hasWalkPoint then
    self:StartMoveAnimation(chessPetEntity, true)
    boardServiceRender:RefreshPiece(chessPetEntity, true, true)
  end
  for _, v in ipairs(walkResultList) do
    local walkRes = v
    local walkPos = walkRes:GetWalkPos()
    local curPos = boardServiceRender:GetRealEntityGridPos(chessPetEntity)
    chessPetEntity:AddGridMove(moveSpeed, walkPos, curPos)
    local walkDir = walkPos - curPos
    local bodyAreaCmpt = chessPetEntity:BodyArea()
    local areaCount = bodyAreaCmpt:GetAreaCount()
    if areaCount == 4 then
      local leftDownPos = Vector2(curPos.x - 0.5, curPos.y - 0.5)
      walkDir = walkPos - leftDownPos
    end
    chessPetEntity:SetDirection(walkDir)
    while chessPetEntity:HasGridMove() do
      YIELD(TT)
    end
    self:_PlayArrivePos(TT, chessPetEntity, walkRes)
  end
  if hasWalkPoint then
    self:StartMoveAnimation(chessPetEntity, false)
    boardServiceRender:RefreshPiece(chessPetEntity, false, true)
  end
end

function ChessServiceRender:_GetMoveSpeed(chessPetEntity)
  local cfgSvc = self._world:GetService("Config")
  local chessPetConfigData = cfgSvc:GetChessPetConfigData()
  local chessPetCmpt = chessPetEntity:ChessPet()
  local chessPetID = chessPetCmpt:GetChessPetID()
  local speed = chessPetConfigData:GetChessPetMoveSpeed(chessPetID)
  speed = speed or 1
  return speed
end

function ChessServiceRender:StartMoveAnimation(targetEntity, isMove)
  local curVal = targetEntity:GetAnimatorControllerBoolsData("Move")
  if curVal ~= isMove then
    targetEntity:SetAnimatorControllerBools({Move = isMove})
  end
end

function ChessServiceRender:_PlayArrivePos(TT, monsterEntity, walkRes)
  local trapSvc = self._world:GetService("TrapRender")
  local trapResList = walkRes:GetWalkTrapResultList()
  for _, v in ipairs(trapResList) do
    local walkTrapRes = v
    local trapEntityID = walkTrapRes:GetTrapEntityID()
    local trapEntity = self._world:GetEntityByID(trapEntityID)
    local trapSkillRes = walkTrapRes:GetTrapResult()
    local skillEffectResultContainer = trapSkillRes:GetResultContainer()
    trapEntity:SkillRoutine():SetResultContainer(skillEffectResultContainer)
    trapSvc:PlayTrapTriggerSkill(TT, trapEntity, false, monsterEntity)
  end
  local passGrids = walkRes:GetWalkPassedGrid()
end

function ChessServiceRender:DoRenderChessPetAttack(TT)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderChessPathComponent = renderBoardEntity:RenderChessPath()
  local chessPetEntityID = renderChessPathComponent:GetRenderChessPetEntityID()
  local chessPetEntity = self._world:GetEntityByID(chessPetEntityID)
  local chessPetCmpt = chessPetEntity:ChessPet()
  local attackSkill = chessPetCmpt:GetAttackSkillID()
  local configSvc = self._world:GetService("Config")
  local skillConfigData = configSvc:GetSkillConfigData(attackSkill, chessPetEntity)
  local skillPhaseArray = skillConfigData:GetSkillPhaseArray()
  local playSkillService = self._world:GetService("PlaySkill")
  local result = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.ActiveAttack)
  local skillResult = result:GetSkillResult()
  chessPetEntity:SkillRoutine():ClearSkillRoutine()
  chessPetEntity:SkillRoutine():SetResultContainer(skillResult)
  local ntChessPetSkillAttackStart = NTChessPetSkillAttackStart:New(chessPetEntity, attackSkill)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, ntChessPetSkillAttackStart)
  local waitTaskID = playSkillService:StartSkillRoutine(chessPetEntity, skillPhaseArray, attackSkill)
  local ntChessPetSkillAttackEnd = NTChessPetSkillAttackEnd:New(chessPetEntity, attackSkill)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, ntChessPetSkillAttackEnd)
  return waitTaskID
end

function ChessServiceRender:HdieChessPetCanMoveEffect(chessPetEntityID)
  local chessPetEntity = self._world:GetEntityByID(chessPetEntityID)
  if not chessPetEntity then
    return
  end
  local chessPetRenderCmpt = chessPetEntity:ChessPetRender()
  local effectEntityID = chessPetRenderCmpt:GetCanMoveEffectEntityID()
  local effectEntity = self._world:GetEntityByID(effectEntityID)
  if effectEntity then
    effectEntity:SetViewVisible(false)
  end
end

function ChessServiceRender:ShowChessPetCanMoveEffect(chessPetEntityID)
  local chessPetEntity = self._world:GetEntityByID(chessPetEntityID)
  local chessPetRenderCmpt = chessPetEntity:ChessPetRender()
  local effectEntityID = chessPetRenderCmpt:GetCanMoveEffectEntityID()
  local effectEntity = self._world:GetEntityByID(effectEntityID)
  if not effectEntity then
    local bodyArea = chessPetEntity:BodyArea():GetArea()
    local effectID = GameResourceConst.ChessPet_CanAction_SingleGridEffectID
    if table.count(bodyArea) == 4 then
      effectID = GameResourceConst.ChessPet_CanAction_MultiGridEffectID
    end
    effectEntity = self._world:GetService("Effect"):CreateEffect(effectID, chessPetEntity)
    chessPetRenderCmpt:SetCanMoveEffectEntityID(effectEntity:GetID())
  end
  effectEntity:SetViewVisible(true)
  local utilDataSvc = self._world:GetService("UtilData")
  if not utilDataSvc:OnCheckEntityHasBuffFlag(chessPetEntity, BuffFlags.SkipTurn) then
    local matCmpt = chessPetEntity:MaterialAnimationComponent()
    matCmpt:StopAll()
  end
end

function ChessServiceRender:HdieAllChessPetCanMoveEffect()
  local group = self._world:GetGroup(self._world.BW_WEMatchers.ChessPetRender)
  for i, v in ipairs(group:GetEntities()) do
    self:HdieChessPetCanMoveEffect(v:GetID())
    local matAnimCmpt = v:MaterialAnimationComponent()
    matAnimCmpt:PlayInvalid()
  end
end

function ChessServiceRender:DoChessPetListDeadRender(TT, deadEntityIDList)
  local deadTaskArray = {}
  for k, v in ipairs(deadEntityIDList) do
    local deadEntity = self._world:GetEntityByID(v)
    local curDeadTaskID = TaskManager:GetInstance():CoreGameStartTask(self._DoOneChessPetDeadRender, self, deadEntity)
    deadTaskArray[#deadTaskArray + 1] = curDeadTaskID
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(deadTaskArray) do
    YIELD(TT)
  end
end

function ChessServiceRender:DoAllChessPetListDeadRender(TT)
  local monsterDeadGroup = self._world:GetGroup(self._world.BW_WEMatchers.DeadFlag)
  if not monsterDeadGroup or table.count(monsterDeadGroup) <= 0 then
    return
  end
  local deadTaskArray = {}
  for _, e in ipairs(monsterDeadGroup:GetEntities()) do
    local curDeadTaskID = TaskManager:GetInstance():CoreGameStartTask(self._DoOneChessPetDeadRender, self, e)
    deadTaskArray[#deadTaskArray + 1] = curDeadTaskID
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(deadTaskArray) do
    YIELD(TT)
  end
end

function ChessServiceRender:_DoOneChessPetDeadRender(TT, deadEntity)
  if deadEntity:HasShowDeath() then
    Log.fatal("entity has play dead")
    return
  end
  if deadEntity == nil or deadEntity:HasShowDeath() then
    return
  end
  if not deadEntity:HasChessPet() then
    return
  end
  deadEntity:AddShowDeath()
  deadEntity:AddDeadFlag()
  deadEntity:ReplaceRedHPAndWhitHP(0)
  local utilDataSvc = self._world:GetService("UtilData")
  local stateId = utilDataSvc:GetCurMainStateID()
  if stateId ~= GameStateID.ChessPetResult then
    local deadSkillTaskID = self:_PlayDeadSkill(TT, deadEntity)
    if deadSkillTaskID then
      while not TaskHelper:GetInstance():IsTaskFinished(deadSkillTaskID) do
        YIELD(TT)
      end
    end
  end
  local sEffect = self._world:GetService("Effect")
  sEffect:DestroyStaticEffect(deadEntity)
  self:_PlayDeathAnimationAudioEffect(deadEntity)
  YIELD(TT, 1000)
  self:_PlayBodyAreaPieceTrap(TT, deadEntity)
  self:_DestroyHpEntity(TT, deadEntity)
  local sPlayBuff = self._world:GetService("PlayBuff")
  sPlayBuff:PlayBuffView(TT, NTChessDead:New(deadEntity))
  YIELD(TT, 2000)
  deadEntity:SetViewVisible(false)
  local fxsvc = self._world:GetService("Effect")
  fxsvc:ClearEntityEffect(deadEntity)
  local showDeathCmpt = deadEntity:ShowDeath()
  showDeathCmpt:SetShowDeathEnd(true)
end

function ChessServiceRender:_PlayDeadSkill(TT, deadEntity)
  local chessPetCmpt = deadEntity:ChessPet()
  local deadSkillTaskID = 0
  local deathSkillID = chessPetCmpt:GetDieSkillID()
  if deathSkillID and 0 < deathSkillID then
    local playSkillService = self._world:GetService("PlaySkill")
    deadSkillTaskID = playSkillService:PlaySkillView(deadEntity, deathSkillID)
  end
  return deadSkillTaskID
end

function ChessServiceRender:_PlayDeathAnimationAudioEffect(deadEntity)
  local deadTriggerParam = "Death"
  deadEntity:SetAnimatorControllerTriggers({deadTriggerParam})
  local deathAudioID = CriAudioIDConst.SouncCoreGameMonsterDeath
  AudioHelperController.PlayInnerGameSfx(deathAudioID)
  local matAnimCmpt = deadEntity:MaterialAnimationComponent()
  if matAnimCmpt then
    matAnimCmpt:StopInvalid()
  end
  deadEntity:NewPlayDeadDark()
end

function ChessServiceRender:_PlayBodyAreaPieceTrap(TT, deadEntity)
  local sTrapRender = self._world:GetService("TrapRender")
  local boardServiceRender = self._world:GetService("BoardRender")
  local curPos = boardServiceRender:GetRealEntityGridPos(deadEntity)
  local workPos = curPos - deadEntity:GridLocation():GetGridOffset()
  local bodyArea = deadEntity:BodyArea():GetArea()
  local pieceService = self._world:GetService("Piece")
  local renderEntityService = self._world:GetService("RenderEntity")
  renderEntityService:DestroyMonsterAreaOutLineEntity(deadEntity)
  local utilDataSvc = self._world:GetService("UtilData")
  local gameFsmStateID = utilDataSvc:GetCurMainStateID()
  for _, p in ipairs(bodyArea) do
    local pos = workPos + p
    local curPieceAnim = pieceService:GetPieceAnimation(pos)
    if curPieceAnim == "Down" then
      pieceService:SetPieceAnimUp(pos)
    end
    sTrapRender:ShowHideTrapAtPos(pos, true)
  end
end

function ChessServiceRender:_DestroyHpEntity(TT, deadEntity)
  local hpCmpt = deadEntity:HP()
  local sliderEntityID = hpCmpt:GetHPSliderEntityID()
  local sliderEntity = self._world:GetEntityByID(sliderEntityID)
  hpCmpt:WidgetPoolCleanup()
  self._world:DestroyEntity(sliderEntity)
  local uiHpBuffInfoWidget = hpCmpt:GetUIHpBuffInfoWidget()
  if uiHpBuffInfoWidget then
    local uiHPBuffInfo = uiHpBuffInfoWidget:GetAllSpawnList()[1]
    uiHPBuffInfo:OnOnwerEntityDead()
  end
end

function ChessServiceRender:ShowCurChessPetEndTurnEffect(TT)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderChessPathComponent = renderBoardEntity:RenderChessPath()
  local chessPetEntityID = renderChessPathComponent:GetRenderChessPetEntityID()
  local chessPetEntity = self._world:GetEntityByID(chessPetEntityID)
  local chessPetCmpt = chessPetEntity:ChessPet()
  local finishTurn = chessPetCmpt:IsChessPetFinishTurn()
  if finishTurn then
    local matAnimCmpt = chessPetEntity:MaterialAnimationComponent()
    matAnimCmpt:PlayInvalid()
  end
end
