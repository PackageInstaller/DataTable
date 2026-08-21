_class("PreviewActiveSkillService", BaseService)
PreviewActiveSkillService = PreviewActiveSkillService

function PreviewActiveSkillService:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
end

function PreviewActiveSkillService:Initialize()
  self._pieceService = self._world:GetService("Piece")
  self._pieceAnimFunc = {}
  self._pieceAnimFunc.Silver = self._pieceService.SetPieceAnimSliver
  self._pieceAnimFunc.Black = self._pieceService.SetPieceAnimBlack
  self._pieceAnimFunc.Gray = self._pieceService.SetPieceAnimGray
  self._pieceAnimFunc.Normal = self._pieceService.SetPieceAnimNormal
  self._pieceAnimFunc.Dark = self._pieceService.SetPieceAnimDark
  self._pieceAnimFunc.Add = self._pieceService.SetPieceAnimAdd
  self._pieceAnimFunc.Reflash = self._pieceService.SetPieceAnimReflash
  self._pieceAnimFunc.Invalid = self._pieceService.SetPieceAnimInvalid
end

function PreviewActiveSkillService:Dispose()
end

function PreviewActiveSkillService:StopAllPreviewActiveSkillEffect(isSwitch, isCast)
  self:_RevertAllConvertElement(true)
  self:_RevertAllLinkLineConvertElement()
  self:CancelAllTransportGrid()
  self:ResetPreview()
  self:_RevertBright()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PetHidePreviewArrow)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangePickUpText, SkillPickUpTextStateType.Normal)
  local curState = self:_GetCurState()
  if isCast ~= true and isSwitch ~= true and curState == GameStateID.PreviewActiveSkill then
    self._world:EventDispatcher():Dispatch(GameEventType.PreviewActiveSkillFinish, 1)
  end
  local flashEnemyEntities = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID):GetEntities()
  if self._world:MatchType() == MatchType.MT_BlackFist then
    flashEnemyEntities = self._world:GetGroup(self._world.BW_WEMatchers.Pet):GetEntities()
  end
  for _, v in ipairs(flashEnemyEntities) do
    local comp = v:MaterialAnimationComponent()
    if not comp then
      Log.error("StopAllPreviewActiveSkillEffect, flashEmemy no materialAnimationCmpt,entityID: ", v:GetID())
      if v:HasMonsterID() then
        local monsterID = v:MonsterID():GetMonsterID()
        Log.error("StopAllPreviewActiveSkillEffect, flashEmemy no materialAnimationCmpt,entityID: ", v:GetID(), " monsterID:", monsterID)
      end
      if v:HasTrapID() then
        local trapID = v:TrapID():GetTrapID()
        Log.error("StopAllPreviewActiveSkillEffect, flashEmemy no materialAnimationCmpt,entityID: ", v:GetID(), " trapID:", trapID)
      end
    else
      comp:StopLayer(MaterialAnimLayer.SkillPreview)
    end
  end
  self:ResetLockGrids()
end

function PreviewActiveSkillService:_RevertAllLinkLineConvertElement()
  local previewEntity = self._world:GetPreviewEntity()
  local previewLinkLineCmpt = previewEntity:PreviewLinkLine()
  local chainPath = previewLinkLineCmpt:GetPreviewChainPath()
  if chainPath == nil then
    return false
  end
  local linkLineService = self._world:GetService("PreviewLinkLine")
  if 0 < #chainPath then
    linkLineService:CancelAllLinkPosPieceType(chainPath)
  end
end

function PreviewActiveSkillService:ResetLockGrids()
  local group = self._world:GetGroup(self._world.BW_WEMatchers.TrapID)
  for i, e in ipairs(group:GetEntities()) do
    if not e:HasDeadFlag() and e:TrapRender():GetTrapRender_IsLockedGrid() and e:View() then
      local go = e:View():GetGameObject()
      local u3dAnimCmpt = go:GetComponent(typeof(UnityEngine.Animation))
      if e:TrapID():GetTrapID() == BattleConst.LockGridTrapID then
        u3dAnimCmpt:Play("eff_2000521_lock_reset01")
      else
        u3dAnimCmpt:Play("eff_2000521_lock_reset")
      end
    end
  end
end

function PreviewActiveSkillService:_GetCurState()
  local utilDataSvc = self._world:GetService("UtilData")
  return utilDataSvc:GetCurMainStateID()
end

function PreviewActiveSkillService:StopDarkScreenImmediately()
  self._world:MainCamera():EnableDarkCamera(false)
  self._world:MainCamera():SetHudBgAlpha(0)
end

function PreviewActiveSkillService:_RevertAllConvertElement(isConvertToNormal)
  local boardService = self._world:GetService("BoardRender")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local pieceService = self._world:GetService("Piece")
  local convertElementGroup = self._world:GetGroup(self._world.BW_WEMatchers.PreviewConvertElement)
  local env = self._world:GetPreviewEntity():PreviewEnv()
  for _, actorEntity in ipairs(convertElementGroup:GetEntities()) do
    local previewConvertElementCmpt = actorEntity:PreviewConvertElement()
    if previewConvertElementCmpt then
      local tempConvertElementDic = previewConvertElementCmpt:GetTempConvertElementDic()
      for gridPos, originalElementType in pairs(tempConvertElementDic) do
        local pieceEntity = renderBoardCmpt:GetGridRenderEntity(gridPos)
        local nowElementType = pieceEntity:Piece():GetPieceType()
        env:SetPieceType(gridPos, originalElementType)
        boardService:ReCreateGridEntity(originalElementType, gridPos, false)
      end
      previewConvertElementCmpt:ClearTempConvertElement()
    end
  end
  self:ResetLockGrids()
end

function PreviewActiveSkillService:ResetPreview()
  local previewEntity = self._world:GetPreviewEntity()
  if previewEntity ~= nil then
    local renderState = previewEntity:RenderState()
    renderState:ResetPreviewRoutine()
  end
end

function PreviewActiveSkillService:GetPreviewIndex()
  local previewEntity = self._world:GetPreviewEntity()
  if previewEntity ~= nil then
    local renderState = previewEntity:RenderState()
    return renderState:GetPreviewRoutineIndex()
  end
  return 0
end

function PreviewActiveSkillService:SetGridMask()
  self:AllPieceDoConvert("Dark")
end

function PreviewActiveSkillService:_RevertBright()
  local sMonsterShowRender = self._world:GetService("MonsterShowRender")
  sMonsterShowRender:MonsterGridAnimDown()
end

function PreviewActiveSkillService:PreviewScopeSenityCheck(scopeParam)
  local scopeType = scopeParam:GetScopeType()
  if scopeType == SkillScopeType.EmptyRandGrid or scopeType == SkillScopeType.RandomRectAndCount or scopeType == SkillScopeType.RandomGrids or scopeType == SkillScopeType.RandomGridsAndTypeSize or scopeType == SkillScopeType.MultiRandomRange or scopeType == SkillScopeType.RandomPosEmptyOrTrap or scopeType == SkillScopeType.RandomGridsByPieceType or scopeType == SkillScopeType.RandomGridsInRangeByPieceType then
    return false, string.format("cannot preview randomized scope: %s", tostring(scopeType))
  end
  return true
end

function PreviewActiveSkillService:CalcScopeResult(scopeParam, casterEntity)
  local isSenitySafe, errorMsg = self:PreviewScopeSenityCheck(scopeParam)
  if not isSenitySafe then
    Log.exception(self._className, errorMsg)
    return
  end
  local casterPos = casterEntity:GridLocation():CenterNoOffset()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeResult = utilScopeSvc:CalcSKillPreviewScopeResult(scopeParam, casterPos, casterEntity)
  return scopeResult
end

function PreviewActiveSkillService:AllPieceDoConvert(type)
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local pieceTable = env:GetAllPieceType()
  local trapServiceRender = self._world:GetService("TrapRender")
  for x, columnDic in pairs(pieceTable) do
    for y, curGridType in pairs(columnDic) do
      local curGridPos = Vector2(x, y)
      local func = self._pieceAnimFunc[type]
      if func then
        func(self._pieceService, curGridPos, curGridType)
      end
    end
  end
end

function PreviewActiveSkillService:DoAnim(brightGridList, brightType)
  local brightFunc = self._pieceAnimFunc[brightType]
  local trapServiceRender = self._world:GetService("TrapRender")
  for _, pos in pairs(brightGridList) do
    if brightFunc then
      brightFunc(self._pieceService, pos)
    end
  end
end

function PreviewActiveSkillService:DoConvert(brightGridList, brightType, otherGirdType)
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local pieceTable = env:GetAllPieceType()
  local brightFunc = self._pieceAnimFunc[brightType]
  local otherFunc = self._pieceAnimFunc[otherGirdType]
  local trapServiceRender = self._world:GetService("TrapRender")
  if otherFunc then
    for x, columnDic in pairs(pieceTable) do
      for y, curGridType in pairs(columnDic) do
        local curGridPos = Vector2(x, y)
        local isBright = table.Vector2Include(brightGridList, curGridPos)
        if isBright then
          if brightFunc then
            brightFunc(self._pieceService, curGridPos)
          end
        elseif otherFunc then
          otherFunc(self._pieceService, curGridPos)
        end
      end
    end
  else
    self:DoAnim(brightGridList, brightType)
  end
end

function PreviewActiveSkillService:CreatePreviewContext(skillPreviewConfigData, casterEntity, pickUpPos, scopePosList)
  local previewContext = SkillPreviewContext:New(self._world, casterEntity)
  previewContext:SetConfigData(skillPreviewConfigData)
  local scopeParam = skillPreviewConfigData:GetPreviewScopeParam()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeResult
  if scopePosList then
    previewContext:SetScopeResult(scopePosList)
    scopeResult = SkillScopeResult:New(SkillScopeType.CenterPos, scopePosList[1], scopePosList, scopePosList)
  else
    scopeResult = previewActiveSkillService:CalcScopeResult(scopeParam, casterEntity)
    previewContext:SetScopeResult(scopeResult:GetAttackRange())
    local scopeResultCenterPos = scopeResult:GetCenterPos()
    if scopeResultCenterPos then
      previewContext:SetScopeCenterPos(scopeResultCenterPos)
    end
  end
  previewContext:SetPickUpPos(pickUpPos)
  local targetIDList = utilScopeSvc:SelectSkillTarget(casterEntity, scopeParam:GetScopeTargetType(), scopeResult, nil, scopeParam:GetScopeTargetTypeParam())
  for i = 1, #targetIDList do
    local e = self._world:GetEntityByID(targetIDList[i])
    if e:HasTeam() then
      e = e:GetTeamLeaderPetEntity()
      targetIDList[i] = e:GetID()
    end
  end
  previewContext:SetTargetEntityIDList(targetIDList)
  local effectList = skillPreviewConfigData:GetPreviewEffectList()
  local previewEffectCalcService = self._world:GetService("PreviewCalcEffect")
  for _, v in pairs(effectList) do
    local effectParam = previewEffectCalcService:CreateSkillEffectParam(v.effectType, v)
    previewContext:SetEffectParam(v.effectType, effectParam)
  end
  previewContext:SetEffectList(skillPreviewConfigData:GetPreviewEffectList())
  previewContext:SetPreviewIndex(self:GetPreviewIndex())
  return previewContext
end

function PreviewActiveSkillService:DoPreviewInstruction(TT, instructionSet, casterEntity, previewContext)
  local insIndex = 1
  local insSetCount = table.count(instructionSet)
  while 0 < insIndex and insIndex <= insSetCount do
    local instruction = instructionSet[insIndex]
    local needBreak = instruction:DoInstruction(TT, casterEntity, previewContext)
    if needBreak then
      break
    end
    insIndex = insIndex + 1
  end
end

function PreviewActiveSkillService:DoConvertElement(TT, targetGridPosArray, targetElementType, actorEntity, blockedPieces, createConvertGrid)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local previewConvertElementCmpt = actorEntity:PreviewConvertElement()
  if not previewConvertElementCmpt then
    actorEntity:AddPreviewConvertElement()
    previewConvertElementCmpt = actorEntity:PreviewConvertElement()
  end
  local pieceService = self._world:GetService("Piece")
  local utilData = self._world:GetService("UtilData")
  local trapServiceRender = self._world:GetService("TrapRender")
  local needRecreateList = {}
  for _, gridPos in ipairs(targetGridPosArray) do
    local originalElementType = utilData:FindPieceElement(gridPos)
    previewConvertElementCmpt:AddTempConvertElement(gridPos, originalElementType)
    local entity = pieceService:FindPieceEntity(gridPos)
    if createConvertGrid then
      entity = self:_ReplaceGridRes(targetElementType, gridPos)
    end
    table.insert(needRecreateList, {
      entity = entity,
      pos = gridPos,
      color = targetElementType
    })
  end
  local oldPreviewIndex = self:GetPreviewIndex()
  YIELD(TT)
  local newPreviewIndex = self:GetPreviewIndex()
  if oldPreviewIndex ~= newPreviewIndex then
    if createConvertGrid then
      for _, v in ipairs(needRecreateList) do
        pieceService:DestroyPieceEntity(v.entity)
      end
    end
    Log.fatal("preview active skill failed ")
    return
  end
  for i, v in ipairs(needRecreateList) do
    if createConvertGrid then
      local sourceEntity = pieceService:FindPieceEntity(v.pos)
      pieceService:DestroyPieceEntity(sourceEntity)
      v.entity:SetLocationHeight(0)
      renderBoardCmpt:SetGridRenderEntityData(v.pos, v.entity)
    end
    pieceService:SetPieceAnimColor(v.pos, v.color)
  end
  if blockedPieces then
    for _, gridPos in ipairs(blockedPieces) do
      local es = env:GetEntitiesAtPos(gridPos, function(e)
        return e:TrapRender() and e:TrapRender():GetTrapRender_IsLockedGrid()
      end)
      local lockGridTrap = es[1]
      if lockGridTrap then
        local go = lockGridTrap:View():GetGameObject()
        local u3dAnimCmpt = go:GetComponent(typeof(UnityEngine.Animation))
        if lockGridTrap:TrapID():GetTrapID() == BattleConst.LockGridTrapID then
          u3dAnimCmpt:Play("eff_2000521_lock_red01")
        else
          u3dAnimCmpt:Play("eff_2000521_lock_red")
        end
      end
    end
  end
end

function PreviewActiveSkillService:_ReplaceGridRes(elementType, gridPos, anim)
  local boardServiceR = self._world:GetService("BoardRender")
  local pieceSvc = self._world:GetService("Piece")
  local sEntity = self._world:GetService("RenderEntity")
  local gridEntity = sEntity:CreateRenderEntity(EntityConfigIDRender.Grid)
  pieceSvc:SetPieceEntityPieceType(gridEntity, elementType)
  gridEntity:SetGridPosition(gridPos)
  gridEntity:SetLocation(gridPos)
  if not anim then
    pieceSvc:SetPieceAnimDark(gridPos)
  else
    pieceSvc:SetPieceAnimation(gridPos, anim)
  end
  Log.debug("_ReplaceGridRes gridPos=", Vector2.Pos2Index(gridPos), " pieceType=", elementType)
  return gridEntity
end

function PreviewActiveSkillService:_CreatePickUpArrow(pos, dir, forceShow, centerPos)
  local arrowPos = pos + centerPos
  if not forceShow then
    local utilDataSvc = self._world:GetService("UtilData")
    if not utilDataSvc:IsValidPiecePos(arrowPos) then
      return
    end
  end
  local sEntity = self._world:GetService("RenderEntity")
  local pieceService = self._world:GetService("Piece")
  local arrowEntity = sEntity:CreateRenderEntity(EntityConfigIDRender.PickUpArrow)
  arrowEntity:SetLocation(arrowPos, dir)
  pieceService:SetEffectEntityParentWithPiecePos(arrowEntity, arrowPos)
  return arrowEntity
end

function PreviewActiveSkillService:ShowPickUpArrowByType(type, forceShow, centerPos)
  local dirIndex
  if type == ShowArrowType.LeftAndRight then
    dirIndex = {3, 7}
  elseif type == ShowArrowType.UpAndDown then
    dirIndex = {1, 5}
  elseif type == ShowArrowType.Four then
    dirIndex = {
      1,
      3,
      5,
      7
    }
  end
  self:ShowPickUpArrow(dirIndex, forceShow, centerPos)
end

function PreviewActiveSkillService:ShowDynamicPickUpArrow(dirIndexs, forceShow, centerPos)
  self:ShowPickUpArrow(dirIndexs, forceShow, centerPos)
end

function PreviewActiveSkillService:ShowFourPickUpArrow(forceShow, centerPos)
  self:ShowPickUpArrow({
    1,
    3,
    5,
    7
  }, forceShow, centerPos)
end

function PreviewActiveSkillService:ShowEightPickUpArrow(forceShow, centerPos)
  self:ShowPickUpArrow({
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8
  }, forceShow, centerPos)
end

PreviewActiveSkillService.__DirectionalVector = {
  [1] = Vector2.up,
  [2] = Vector2.New(1, 1),
  [3] = Vector2.right,
  [4] = Vector2.New(1, -1),
  [5] = Vector2.down,
  [6] = Vector2.New(-1, -1),
  [7] = Vector2.left,
  [8] = Vector2.New(-1, 1)
}

function PreviewActiveSkillService:ShowPickUpArrow(tDirectionIndex, forceShow, centerPos)
  for _, dirIndex in ipairs(tDirectionIndex) do
    local v2 = PreviewActiveSkillService.__DirectionalVector[dirIndex]
    self:_CreatePickUpArrow(v2, v2, forceShow, centerPos)
  end
end

function PreviewActiveSkillService:DestroyPickUpArrow()
  local arrowEntities = self._world:GetGroup(self._world.BW_WEMatchers.PickUpArrow):GetEntities()
  for _, e in ipairs(arrowEntities) do
    self._world:DestroyEntity(e)
  end
end

function PreviewActiveSkillService:PickUpInvalidGridCancelPreview(activeSkillID, petPstID)
  if self:_GetCurState() == GameStateID.PreviewActiveSkill then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.PickUPInvalidGridCancelActiveSkill)
    GameGlobal.TaskManager():CoreGameStartTask(self.CancelActiveSkillCast, self, activeSkillID, petPstID, true)
  end
end

function PreviewActiveSkillService:CancelActiveSkillCast(TT, activeSkillID, petPstID, nocmd)
  local playSkillService = self._world:GetService("PlaySkill")
  local nTaskID = self:PlaySkillView_Preview(self._world, activeSkillID, petPstID, false)
  self:TT_StopPreviewActiveSkill(TT, false, false, activeSkillID, petPstID)
  self:ClearPreviewLinkLine(activeSkillID, petPstID)
  while not playSkillService:IsTaskFinished(nTaskID) do
    YIELD(TT)
  end
  local pieceService = self._world:GetService("Piece")
  pieceService:RefreshPieceAnim()
  local teamEntity = self._world:Player():GetPreviewTeamEntity()
  playSkillService:ShowPlayerEntity(teamEntity)
  if not nocmd then
    self:_ClearAllPickUpComponent(petPstID)
    self._world:EventDispatcher():Dispatch(GameEventType.PickUpActiveSkillTargetFinish, 1)
  end
end

function PreviewActiveSkillService:ClearPreviewLinkLine(activeSkillID, petPstID)
  if not activeSkillID or not petPstID then
    return
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local petEntityId = utilDataSvc:GetEntityIDByPstID(petPstID)
  local petEntity = self._world:GetEntityByID(petEntityId)
  local skillCfgData = self._configService:GetSkillConfigData(activeSkillID, petEntity)
  if not skillCfgData then
    return
  end
  local pickUpType = skillCfgData:GetSkillPickType()
  if pickUpType == SkillPickUpType.LinkLine or pickUpType == SkillPickUpType.LinkLineSP or pickUpType == SkillPickUpType.Moye then
    self._world:EventDispatcher():Dispatch(GameEventType.CancelChainPath)
    local inputCmpt = self._world:Input()
    inputCmpt:SetPreviewActiveSkill(false)
    local renderBattleStatCmpt = self._world:RenderBattleStat()
    renderBattleStatCmpt:SetPet1702361ActiveSkillPreviewState(false)
  end
end

function PreviewActiveSkillService:_ClearAllPickUpComponent(petPstID)
  local utilDataSvc = self._world:GetService("UtilData")
  local casterPetEntityID = utilDataSvc:GetEntityIDByPstID(petPstID)
  if casterPetEntityID < 0 then
    Log.fatal("caster entity id invalid")
    return
  end
  local petEntity = self._world:GetEntityByID(casterPetEntityID)
  petEntity:RemovePreviewPickUpComponent()
end

function PreviewActiveSkillService:TT_StopPreviewActiveSkill(TT, isSwitch, bShowPlayerEntity, activeSkillID, petPstID)
  if isSwitch ~= true then
    self:StopDarkScreenImmediately()
  end
  local svc = self._world:GetService("RenderEntity")
  svc:DestroyGhost()
  local utilDataSvc = self._world:GetService("UtilData")
  local petEntityId = utilDataSvc:GetEntityByPstID(petPstID)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID, petEntityId)
  local previewParam = skillConfigData:GetSkillPreviewParam()
  local taskID = GameGlobal.TaskManager():CoreGameStartTask(self.DoCancelPreviewInstruction, self, activeSkillID, petPstID)
  local paramType = 0
  if previewParam and type(previewParam) == "table" then
    paramType = previewParam.type or 0
  end
  if paramType == 3 then
    while not TaskHelper:GetInstance():IsTaskFinished(taskID) do
      YIELD(TT)
    end
  end
  if bShowPlayerEntity then
    local playSkillService = self._world:GetService("PlaySkill")
    local teamEntity = self._world:Player():GetPreviewTeamEntity()
    playSkillService:ShowPlayerEntity(teamEntity)
  end
  self:_DestroyPickUpArrow()
  local flashEnemyEntities = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID):GetEntities()
  if self._world:MatchType() == MatchType.MT_BlackFist then
    flashEnemyEntities = self._world:GetGroup(self._world.BW_WEMatchers.Pet):GetEntities()
  end
  for _, v in ipairs(flashEnemyEntities) do
    local comp = v:MaterialAnimationComponent()
    if comp then
      comp:StopLayer(MaterialAnimLayer.SkillPreview)
    end
  end
  self:ResetPreview()
  self:_ClearPreviewActiveSkill(isSwitch)
end

function PreviewActiveSkillService:_StopPreviewActiveSkill(isSwitch, bShowPlayerEntity, activeSkillID, petPstID)
  if isSwitch ~= true then
    self:StopDarkScreenImmediately()
  end
  local svc = self._world:GetService("RenderEntity")
  svc:DestroyGhost()
  GameGlobal.TaskManager():CoreGameStartTask(self.DoCancelPreviewInstruction, self, activeSkillID, petPstID)
  if bShowPlayerEntity then
    local playSkillService = self._world:GetService("PlaySkill")
    local teamEntity = self._world:Player():GetPreviewTeamEntity()
    playSkillService:ShowPlayerEntity(teamEntity)
  end
  self:_DestroyPickUpArrow()
  local flashEnemyEntities = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID):GetEntities()
  if self._world:MatchType() == MatchType.MT_BlackFist then
    flashEnemyEntities = self._world:GetGroup(self._world.BW_WEMatchers.Pet):GetEntities()
  end
  for _, v in ipairs(flashEnemyEntities) do
    local comp = v:MaterialAnimationComponent()
    if comp then
      comp:StopLayer(MaterialAnimLayer.SkillPreview)
    end
  end
  self:ResetPreview()
  self:_ClearPreviewActiveSkill(isSwitch)
end

function PreviewActiveSkillService:_DestroyPickUpArrow()
  local arrowEntities = self._world:GetGroup(self._world.BW_WEMatchers.PickUpArrow):GetEntities()
  for _, e in ipairs(arrowEntities) do
    self._world:DestroyEntity(e)
  end
end

function PreviewActiveSkillService:_ClearPreviewActiveSkill(isSwitch, isCast)
  local group = self._world:GetGroup(self._world.BW_WEMatchers.PreviewActiveSkill)
  local targetEntity
  for _, entity in ipairs(group:GetEntities()) do
    targetEntity = entity
    entity:RemovePreviewActiveSkill()
  end
  self:StopAllPreviewActiveSkillEffect(isSwitch, isCast)
  local worldPickUpCmpt = self._world:PickUp()
  worldPickUpCmpt:ResetPickUpData()
end

function PreviewActiveSkillService:DoCancelPreviewInstruction(TT, activeSkillID, petPstID)
  if not activeSkillID or not petPstID then
    return
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local petEntityId = utilDataSvc:GetEntityIDByPstID(petPstID)
  local petEntity = self._world:GetEntityByID(petEntityId)
  if not petEntity then
    local renderBoardEntity = self._world:GetRenderBoardEntity()
    local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
    local entityID = pickUpTargetCmpt:GetEntityID()
    petEntity = self._world:GetEntityByID(entityID)
  end
  local taskIDList = {}
  local skillConfigData = self._configService:GetSkillConfigData(activeSkillID, petEntity)
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  for _, v in ipairs(skillConfigData._previewParamList) do
    if v:GetPreviewType() == SkillPreviewType.Instruction then
      local instructionParam = v
      for _, skillPreviewConfigData in pairs(instructionParam._previewList) do
        local instructionSet = skillPreviewConfigData:GetCancelPreviewInstructionSet()
        if instructionSet then
          local previewContext = previewActiveSkillService:CreatePreviewContext(skillPreviewConfigData, petEntity)
          local taskID = GameGlobal.TaskManager():CoreGameStartTask(previewActiveSkillService.DoPreviewInstruction, previewActiveSkillService, instructionSet, petEntity, previewContext)
          table.insert(taskIDList, taskID)
        end
      end
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function PreviewActiveSkillService:_ShowSkillTips(skillConfigData)
  local skillName = skillConfigData:GetSkillName()
  local skillDesc = skillConfigData:GetSkillDesc()
  local previewEntity = self._world:GetPreviewEntity()
  local renderStatCmpt = previewEntity:RenderState()
  local skillTipsEntityID = renderStatCmpt:GetSkillTipsEntityID()
  local skillTipsEntity
  if skillTipsEntityID == -1 then
    local sEntity = self._world:GetService("RenderEntity")
    skillTipsEntity = sEntity:CreateRenderEntity(EntityConfigIDRender.SkillTips)
    skillTipsEntity:SetOwnerWorld(self._world)
    skillTipsEntityID = skillTipsEntity:GetID()
    renderStatCmpt:SetSkillTipsEntityID(skillTipsEntityID)
  else
    skillTipsEntity = self._world:GetEntityByID(skillTipsEntityID)
  end
  skillTipsEntity:SetViewVisible(true)
  Log.debug("Preview SetViewVisible True EntityID:", skillTipsEntityID)
  local skillTips = skillTipsEntity:SkillTips()
  skillTipsEntity:ReplaceSkillTips(skillName, skillDesc)
  Log.debug("[Preview] 预览怪物技能： 技能标签<" .. skillConfigData:GetSkillName() .. ">")
end

function PreviewActiveSkillService:HideSkillTips()
  local previewEntity = self._world:GetPreviewEntity()
  local renderStatCmpt = previewEntity:RenderState()
  local skillTipsEntityID = renderStatCmpt:GetSkillTipsEntityID()
  if skillTipsEntityID ~= -1 then
    local skillTipsEntity = self._world:GetEntityByID(skillTipsEntityID)
    skillTipsEntity:SetViewVisible(false)
  end
end

function PreviewActiveSkillService:_ShowDescTips(trapName, trapDesc)
  local previewEntity = self._world:GetPreviewEntity()
  local renderStatCmpt = previewEntity:RenderState()
  local skillTipsEntityID = renderStatCmpt:GetSkillTipsEntityID()
  local skillTipsEntity
  if skillTipsEntityID == -1 then
    local sEntity = self._world:GetService("RenderEntity")
    skillTipsEntity = sEntity:CreateRenderEntity(EntityConfigIDRender.SkillTips)
    skillTipsEntity:SetOwnerWorld(self._world)
    skillTipsEntityID = skillTipsEntity:GetID()
    renderStatCmpt:SetSkillTipsEntityID(skillTipsEntityID)
  else
    skillTipsEntity = self._world:GetEntityByID(skillTipsEntityID)
  end
  skillTipsEntity:SetViewVisible(true)
  Log.debug("Preview SetViewVisible True EntityID:", skillTipsEntityID)
  skillTipsEntity:ReplaceSkillTips(trapName, trapDesc)
  local skillTips = skillTipsEntity:SkillTips()
  skillTips:SetTrapDesc(true)
end

function PreviewActiveSkillService:GetChianAttackPetIds()
  local pets = {}
  local skillIds = {}
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local chainAtkResCmpt = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.ChainAttack)
  local petRoundTeam = renderBoardEntity:RenderRoundTeam():GetRoundTeam()
  local chainPath = renderBoardEntity:RenderChainPath():GetRenderChainPath()
  if not chainPath then
    return pets, skillIds
  end
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local chainCount, superGridNum = utilCalcSvc:GetChainDamageRateAtIndex(chainPath, #chainPath)
  local utilData = self._world:GetService("UtilData")
  if petRoundTeam and table.count(petRoundTeam) > 0 then
    for _, eId in ipairs(petRoundTeam) do
      local e = self._world:GetEntityByID(eId)
      local chainCountFix = e:RenderAttributes():GetAttribute("ChainSkillReleaseFix") or 0
      local chainCountMul = e:RenderAttributes():GetAttribute("ChainSkillReleaseMul") or 0
      local chainExtraFix = utilData:GetEntityBuffValue(e, "ChangeExtraChainSkillReleaseFixForSkill")
      local finalChainCount = math.ceil((chainCount + chainCountFix) * (1 + chainCountMul))
      local chainSkillID = utilData:GetChainSkillByChainCount(e, finalChainCount, chainExtraFix)
      if chainSkillID and 0 < chainSkillID then
        table.insert(pets, eId)
        table.insert(skillIds, chainSkillID)
      end
    end
  end
  return pets, skillIds
end

function PreviewActiveSkillService:StartPreviewFocusEffect()
  local cMainCamera = self._world:MainCamera()
  cMainCamera:EnableDarkCamera(true)
  local targetAlpha = BattleConst.ActiveSkillDarkAlpha
  cMainCamera:SetHudBgAlpha(targetAlpha)
end

function PreviewActiveSkillService:StopPreviewChainSkill(TT)
  local sPreviewActiveSkill = self._world:GetService("PreviewActiveSkill")
  local sPlaySkill = self._world:GetService("PlaySkill")
  sPreviewActiveSkill:StopDarkScreenImmediately()
  local svc = self._world:GetService("RenderEntity")
  svc:DestroyGhost()
  local teamEntity = self._world:Player():GetPreviewTeamEntity()
  sPlaySkill:ShowPlayerEntity(teamEntity)
  local flashEnemyEntities = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID):GetEntities()
  for _, v in ipairs(flashEnemyEntities) do
    local cMaterialAnimationComponent = v:MaterialAnimationComponent()
    if cMaterialAnimationComponent then
      cMaterialAnimationComponent:StopLayer(MaterialAnimLayer.SkillPreview)
    end
  end
  local casterEntity = teamEntity:GetTeamLeaderPetEntity()
  local skillPreviewParamInstruction = SkillPreviewParamInstruction:New({})
  local instructionSet = skillPreviewParamInstruction:_ParseInstructionSet(BattleConst.DimensionPreviewInstructionSetIdFinish)
  if instructionSet then
    local previewContext = SkillPreviewContext:New(self._world, casterEntity)
    sPreviewActiveSkill:DoPreviewInstruction(TT, instructionSet, casterEntity, previewContext)
  end
  sPreviewActiveSkill:ResetPreview()
  self._world:EventDispatcher():Dispatch(GameEventType.UpdateBuffLayerActiveSkillEnergyPreview, {shutdown = true})
end

function PreviewActiveSkillService:ClearChainPreviewData()
  local previewEntity = self._world:GetPreviewEntity()
  previewEntity:ReplacePreviewChainSkill()
end

function PreviewActiveSkillService:UpdateUI(pickUpNum, mustPickUpNum, previewPickUpComponent)
  local leftPickUpNumber = pickUpNum - previewPickUpComponent:GetAllValidPickUpGridPosCount()
  local pickUpCount = previewPickUpComponent:GetAllValidPickUpGridPosCount()
  if leftPickUpNumber < 0 then
    Log.fatal("leftPickUpNumber <=0 number:", leftPickUpNumber)
    leftPickUpNumber = 0
  end
  self._world:EventDispatcher():Dispatch(GameEventType.RefreshPickUpNum, leftPickUpNumber)
  if mustPickUpNum then
    if pickUpCount == mustPickUpNum then
      self._world:EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, true)
      return
    end
  elseif pickUpCount ~= 0 then
    self._world:EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, true)
    return
  end
  self._world:EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, false)
end

function PreviewActiveSkillService:_DoPickUpInstruction(TT, type, skillConfigData, casterEntity, pickUpGirdPos)
  local taskIDList = {}
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  for i, v in ipairs(skillConfigData._previewParamList) do
    if v:GetPreviewType() == SkillPreviewType.Instruction then
      local instructionParam = v
      for _, skillPreviewConfigData in ipairs(instructionParam._previewList) do
        local instructionSet = self:_GetInstructSet(type, skillPreviewConfigData)
        if instructionSet then
          local previewContext = self:_GetPreviewContext(type, skillPreviewConfigData, casterEntity, skillPreviewConfigData:GetID(), pickUpGirdPos)
          local taskID = GameGlobal.TaskManager():CoreGameStartTask(previewActiveSkillService.DoPreviewInstruction, previewActiveSkillService, instructionSet, casterEntity, previewContext)
          table.insert(taskIDList, taskID)
        end
      end
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function PreviewActiveSkillService:_GetPreviewContext(type, skillPreviewConfigData, casterEntity, id, pickUpGridPos)
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  local context = previewPickUpComponent:GetPreviewContext(id)
  if not context then
    if type == PickUpInstructionType.Invalid then
      context = self:CreatePreviewContext(skillPreviewConfigData, casterEntity, pickUpGridPos, {pickUpGridPos})
    else
      context = self:CreatePreviewContext(skillPreviewConfigData, casterEntity, pickUpGridPos)
    end
  end
  return context
end

function PreviewActiveSkillService:_GetInstructSet(type, skillPreviewConfigData)
  if type == PickUpInstructionType.Repeat then
    return skillPreviewConfigData:GetOnSelectCancelInstructionSet()
  end
  if type == PickUpInstructionType.Invalid then
    return skillPreviewConfigData:GetOnSelectInvalidInstructionSet()
  end
  if type == PickUpInstructionType.Valid then
    return skillPreviewConfigData:GetOnSelectValidInstructionSet()
  end
  if type == PickUpInstructionType.Empty then
    return skillPreviewConfigData:GetOnSelectEmptyInstructionSet()
  end
  return nil
end

function PreviewActiveSkillService:PlaySkillView_Preview(world, nSkillID, petPstId, bStart)
  bStart = bStart or false
  local utilDataSvc = world:GetService("UtilData")
  local petEntityId = utilDataSvc:GetEntityIDByPstID(petPstId)
  local petEntity = world:GetEntityByID(petEntityId)
  local taskManager = GameGlobal.TaskManager()
  local nTaskID = taskManager:CoreGameStartTask(self._PlayActiveSkillPreviewAction, self, world, nSkillID, petEntity, bStart)
  return nTaskID
end

function PreviewActiveSkillService:_PlayActiveSkillPreviewAction(TT, world, nSkillID, entityCaster, bStart)
  if nil == entityCaster then
    return
  end
  local configService = world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(nSkillID, entityCaster)
  local previewParam = skillConfigData:GetSkillPreviewParam()
  local paramType = 0
  if previewParam and type(previewParam) == "table" then
    paramType = previewParam.type or 0
  end
  if 1 == paramType then
    local nWorkViewID = 0
    if bStart then
      nWorkViewID = previewParam[1]
    else
      nWorkViewID = previewParam[2]
    end
    local skillPhaseArray = skillConfigData:ParseViewID(nWorkViewID)
    if 0 < table.count(skillPhaseArray) then
      local waitTaskID = self:StartSkillRoutine(entityCaster, skillPhaseArray, nSkillID)
      while not self:IsTaskFinished(waitTaskID) do
        YIELD(TT)
      end
    end
  else
    local animTrigger
    if bStart then
      animTrigger = "AtkUltPreview"
    else
      animTrigger = "AtkUltPreviewCancel"
    end
    self:PlayCasterPreviewAnim(entityCaster, bStart, animTrigger)
  end
end

function PreviewActiveSkillService:ResetCasterPreviewAnimTrigger(casterEntity, isPreview)
  local csGo = casterEntity:View().ViewWrapper.GameObject
  local csTransformRoot = csGo.transform:Find("Root")
  if not csTransformRoot then
    return
  end
  local csAnimator = csTransformRoot:GetComponent("Animator")
  if not csAnimator then
    return
  end
  local resetTrigger
  if isPreview then
    resetTrigger = "AtkUltPreviewCancel"
  else
    resetTrigger = "AtkUltPreview"
  end
  csAnimator:ResetTrigger(resetTrigger)
end

function PreviewActiveSkillService:PlayCasterPreviewAnim(casterEntity, bStart, animTrigger)
  casterEntity:SetAnimatorControllerTriggers({animTrigger})
  self:ResetCasterPreviewAnimTrigger(casterEntity, bStart)
end

function PreviewActiveSkillService:StartSkillRoutine(entityCaster, skillPhaseArray, nSkillID)
  return self._world:GetService("PlaySkill"):StartSkillRoutine(entityCaster, skillPhaseArray, nSkillID)
end

function PreviewActiveSkillService:IsTaskFinished(waitTaskID)
  return self._world:GetService("PlaySkill"):IsTaskFinished(waitTaskID)
end

function PreviewActiveSkillService:CommonSkillPreview(TT, casterEntity, skillID, previewSetID)
  local taskIDList = {}
  local skillConfigData = self._configService:GetSkillConfigData(skillID, casterEntity)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local skillPreviewParamInstruction = SkillPreviewParamInstruction:New({})
  local instructionSetID = previewSetID
  if not instructionSetID then
    Log.exception("SkillID:", skillID, "PreviewType :", previewSetID, "Invalid ")
    return
  end
  local instructionSet = skillPreviewParamInstruction:_ParseInstructionSet(instructionSetID)
  local previewContext = SkillPreviewContext:New(self._world, casterEntity)
  local skillEffectArray = skillConfigData:GetSkillSourceEffectTable()
  previewContext:SetEffectList(skillEffectArray)
  local targetType = skillConfigData:GetSkillTargetType()
  local targetTypeParam = skillConfigData:GetSkillTargetTypeParam()
  local scopeParam = SkillPreviewScopeParam:New({
    TargetType = targetType,
    ScopeType = skillConfigData:GetSkillScopeType(),
    ScopeCenterType = skillConfigData:GetSkillScopeCenterType(),
    TargetTypeParam = targetTypeParam
  })
  scopeParam:SetScopeParamData(skillConfigData:GetSkillScopeParam())
  local scopeResult = utilScopeSvc:CalcScopeResult(scopeParam, casterEntity)
  previewContext:SetScopeResult(scopeResult:GetAttackRange())
  previewContext:SetScopeType(scopeResult:GetScopeType())
  previewContext:SetScopeCenterPos(scopeResult:GetCenterPos())
  local targetIDList = utilScopeSvc:SelectSkillTarget(casterEntity, targetType, scopeResult, skillID, targetTypeParam)
  previewContext:SetTargetEntityIDList(targetIDList)
  local previewIndex = self:GetPreviewIndex()
  previewContext:SetPreviewIndex(previewIndex)
  if instructionSet then
    local taskID = GameGlobal.TaskManager():CoreGameStartTask(previewActiveSkillService.DoPreviewInstruction, previewActiveSkillService, instructionSet, casterEntity, previewContext)
    table.insert(taskIDList, taskID)
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    local curPreviewIndex = self:GetPreviewIndex()
    if curPreviewIndex ~= previewIndex then
    end
    YIELD(TT)
  end
end

function PreviewActiveSkillService:PlayTransportPreview(TT, casterEntity, result)
  if not casterEntity:HasPreviewConvertElement() then
    casterEntity:AddPreviewConvertElement()
  end
  local previewConvertElementCmpt = casterEntity:PreviewConvertElement()
  local pieceDataList = result:GetPieceDataList()
  local pieceSvc = self._world:GetService("Piece")
  local utilDataSvc = self._world:GetService("UtilData")
  local trapServiceRender = self._world:GetService("TrapRender")
  local posList = {}
  for _, data in ipairs(pieceDataList) do
    trapServiceRender:OnTakeOutTrapFormPiece(data:GetPiecePos())
    table.insert(posList, data:GetPiecePos())
    local sourcePieceEntity = pieceSvc:FindPieceEntity(data:GetPiecePos())
    sourcePieceEntity:SetLocationHeight(1000)
    local entity = self:_ReplaceGridRes(data:GetPieceType(), data:GetPiecePos(), "Normal")
    entity:SetLocationHeight(0)
    pieceSvc:SetPieceEntityAnimNormal(entity)
    if not utilDataSvc:IsValidPiecePos(data:GetNextPos()) then
      pieceSvc:SetPieceShowRange(entity, data:GetPiecePos())
    end
    local dis = Vector2.Distance(data:GetNextPos(), data:GetPiecePos())
    entity:AddGridMove(BattleConst.PreviewConveySpeed * dis, data:GetNextPos(), data:GetPiecePos())
    previewConvertElementCmpt:AddPreviewTransportEntity(entity, sourcePieceEntity)
  end
  local targetID, targetPos, targetNextPos = result:GetTargetData()
  if targetID then
    local targetEntity = self._world:GetEntityByID(targetID)
    local entitySvc = self._world:GetService("RenderEntity")
    local ghostEntity = entitySvc:CreateGhost(targetPos, targetEntity)
    if utilDataSvc:IsBlockMoveWithTrapWall(targetPos, targetNextPos, targetEntity) == false then
      ghostEntity:AddGridMove(BattleConst.PreviewConveySpeed, targetNextPos, targetPos)
    end
  end
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local transportTrapPosList = env:SetTransportTrapPosList(posList)
end

function PreviewActiveSkillService:PreviewRevertTransportTrap()
  local trapServiceRender = self._world:GetService("TrapRender")
  local pieceSvc = self._world:GetService("Piece")
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local transportTrapPosList = env:GetTransportTrapPosList()
  if transportTrapPosList and table.count(transportTrapPosList) > 0 then
    for _, pos in ipairs(transportTrapPosList) do
      pieceSvc:ResetPieceEffectRender(pos)
      trapServiceRender:OnGiveBackTrapToPiece(pos)
    end
  end
  env:SetTransportTrapPosList({})
end

function PreviewActiveSkillService:RevertAllTransportGrid()
  local boardService = self._world:GetService("BoardRender")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local pieceService = self._world:GetService("Piece")
  local convertElementGroup = self._world:GetGroup(self._world.BW_WEMatchers.PreviewConvertElement)
  for _, actorEntity in ipairs(convertElementGroup:GetEntities()) do
    local previewConvertElementCmpt = actorEntity:PreviewConvertElement()
    if previewConvertElementCmpt then
      local transportEntityList, sourceEntityList = previewConvertElementCmpt:GetPreviewTransportEntityList()
      for i, entityID in ipairs(transportEntityList) do
        local entity = self._world:GetEntityByID(entityID)
        pieceService:SetPieceEntityAnimDark(entity)
        pieceService:RevertPieceShowRange(entity)
        pieceService:DestroyPieceEntity(entity)
      end
      for i, entityID in ipairs(sourceEntityList) do
        local entity = self._world:GetEntityByID(entityID)
        if entity then
          entity:SetLocationHeight(0)
          pieceService:SetPieceEntityAnimDark(entity)
        end
      end
      previewConvertElementCmpt:ClearPreviewTransportEntity()
    end
  end
  self:PreviewRevertTransportTrap()
end

function PreviewActiveSkillService:CancelAllTransportGrid()
  local boardService = self._world:GetService("BoardRender")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local pieceService = self._world:GetService("Piece")
  local convertElementGroup = self._world:GetGroup(self._world.BW_WEMatchers.PreviewConvertElement)
  for _, actorEntity in ipairs(convertElementGroup:GetEntities()) do
    local previewConvertElementCmpt = actorEntity:PreviewConvertElement()
    if previewConvertElementCmpt then
      local transportEntityList, sourceEntityList = previewConvertElementCmpt:GetPreviewTransportEntityList()
      for i, entityID in ipairs(transportEntityList) do
        local entity = self._world:GetEntityByID(entityID)
        pieceService:SetPieceEntityAnimNormal(entity)
        pieceService:RevertPieceShowRange(entity)
        pieceService:DestroyPieceEntity(entity)
      end
      for i, entityID in ipairs(sourceEntityList) do
        local entity = self._world:GetEntityByID(entityID)
        if entity then
          entity:SetLocationHeight(0)
          pieceService:SetPieceEntityAnimNormal(entity)
        end
      end
      previewConvertElementCmpt:ClearPreviewTransportEntity()
    end
  end
  self:PreviewRevertTransportTrap()
end

function PreviewActiveSkillService:PlayPickUpGridTogether(TT, dataArray, actorEntity, blockedPieces)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local previewConvertElementCmpt = actorEntity:PreviewConvertElement()
  if not previewConvertElementCmpt then
    actorEntity:AddPreviewConvertElement()
    previewConvertElementCmpt = actorEntity:PreviewConvertElement()
  end
  local pieceService = self._world:GetService("Piece")
  local utilData = self._world:GetService("UtilData")
  local trapServiceRender = self._world:GetService("TrapRender")
  local needRecreateList = {}
  for _, data in ipairs(dataArray) do
    local gridPos = data:GetGridPos()
    local originalElementType = utilData:FindPieceElement(gridPos)
    if originalElementType ~= PieceType.None then
      previewConvertElementCmpt:AddTempConvertElement(gridPos, originalElementType)
      local entity = pieceService:FindPieceEntity(gridPos)
      table.insert(needRecreateList, {
        entity = entity,
        pos = gridPos,
        color = data:GetGridType()
      })
    end
  end
  local oldPreviewIndex = self:GetPreviewIndex()
  YIELD(TT)
  local newPreviewIndex = self:GetPreviewIndex()
  if oldPreviewIndex ~= newPreviewIndex then
    Log.fatal("preview active skill failed ")
    return
  end
  for i, v in ipairs(needRecreateList) do
    pieceService:SetPieceAnimColor(v.pos, v.color)
  end
  if blockedPieces then
    for _, gridPos in ipairs(blockedPieces) do
      local es = env:GetEntitiesAtPos(gridPos, function(e)
        return e:TrapRender() and e:TrapRender():GetTrapRender_IsLockedGrid()
      end)
      local lockGridTrap = es[1]
      if lockGridTrap then
        local go = lockGridTrap:View():GetGameObject()
        local u3dAnimCmpt = go:GetComponent(typeof(UnityEngine.Animation))
        if lockGridTrap:TrapID():GetTrapID() == BattleConst.LockGridTrapID then
          u3dAnimCmpt:Play("eff_2000521_lock_red01")
        else
          u3dAnimCmpt:Play("eff_2000521_lock_red")
        end
      end
    end
  end
end

function PreviewActiveSkillService:PlaySkillView_PlayPickUI(world, nSkillID, petPstId, bStart)
  bStart = bStart or false
  local utilDataSvc = world:GetService("UtilData")
  local petEntityId = utilDataSvc:GetEntityIDByPstID(petPstId)
  local petEntity = world:GetEntityByID(petEntityId)
  local taskManager = GameGlobal.TaskManager()
  local nTaskID = taskManager:CoreGameStartTask(self._PlayPickUIPreviewAction, self, nSkillID, petEntity)
  return nTaskID
end

function PreviewActiveSkillService:PlaySkillView_PlayPreviewInstSet(nSkillID, petPstId, instType)
  local utilDataSvc = self._world:GetService("UtilData")
  local petEntityId = utilDataSvc:GetEntityIDByPstID(petPstId)
  local petEntity = self._world:GetEntityByID(petEntityId)
  local taskManager = GameGlobal.TaskManager()
  local nTaskID = taskManager:CoreGameStartTask(self._PlayPickUIPreviewAction, self, nSkillID, petEntity, instType)
  return nTaskID
end

function PreviewActiveSkillService:_PlayPickUIPreviewAction(TT, nSkillID, entityCaster, instType)
  instType = instType or PickUpInstructionType.Empty
  local taskIDList = {}
  local skillConfigData = self._configService:GetSkillConfigData(nSkillID, entityCaster)
  for _, v in ipairs(skillConfigData._previewParamList) do
    if v:GetPreviewType() == SkillPreviewType.Instruction then
      local instructionParam = v
      for _, skillPreviewConfigData in pairs(instructionParam._previewList) do
        local instructionSet = self:_GetInstructSet(instType, skillPreviewConfigData)
        if instructionSet then
          local previewContext = self:CreatePreviewContext(skillPreviewConfigData, entityCaster, {})
          previewContext:SetPreviewActiveSkillID(nSkillID)
          local taskID = GameGlobal.TaskManager():CoreGameStartTask(self.DoPreviewInstruction, self, instructionSet, entityCaster, previewContext)
          table.insert(taskIDList, taskID)
        end
      end
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function PreviewActiveSkillService:GetPet1702361Entity(casterEntity, previewContext)
  local utilDataSvc = self._world:GetService("UtilData")
  local skillID = previewContext:GetPreviewActiveSkillID()
  return utilDataSvc:GetPet1702361Entity(casterEntity, skillID)
end
