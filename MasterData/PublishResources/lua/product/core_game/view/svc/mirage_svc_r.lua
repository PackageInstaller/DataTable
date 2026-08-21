_class("MirageServiceRender", BaseService)
MirageServiceRender = MirageServiceRender

function MirageServiceRender:DoMirageShowTraps(TT, eTraps)
  local taskIDList = {}
  if eTraps and table.count(eTraps) > 0 then
    local trapServiceRender = self._world:GetService("TrapRender")
    local taskID = GameGlobal.TaskManager():CoreGameStartTask(trapServiceRender.ShowTraps, trapServiceRender, eTraps)
    table.insert(taskIDList, taskID)
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function MirageServiceRender:DoMiragePlayTrapSkill(TT, eTraps)
  local playSkillService = self._world:GetService("PlaySkill")
  local taskIDList = {}
  if eTraps and table.count(eTraps) > 0 then
    for _, e in ipairs(eTraps) do
      local trapRenderCmpt = e:TrapRender()
      local skillID = trapRenderCmpt:GetMoveSkillID()
      if skillID and 0 < skillID then
        local taskId = playSkillService:PlaySkillView(e, skillID)
        if taskId then
          table.insert(taskIDList, taskId)
        end
      end
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function MirageServiceRender:DoMiragePlayTrapWarningSkill(TT, eTraps)
  local playSkillService = self._world:GetService("PlaySkill")
  local taskIDList = {}
  if eTraps and table.count(eTraps) > 0 then
    for _, e in ipairs(eTraps) do
      local trapRenderCmpt = e:TrapRender()
      local skillID = trapRenderCmpt:GetWarningSkillID()
      if skillID and 0 < skillID then
        local taskId = playSkillService:PlaySkillView(e, skillID)
        if taskId then
          table.insert(taskIDList, taskId)
        end
      end
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function MirageServiceRender:DoMiragePlayTrapDieSkill(TT, eTraps)
  local playSkillService = self._world:GetService("PlaySkill")
  local taskIDList = {}
  if eTraps and table.count(eTraps) > 0 then
    for _, e in ipairs(eTraps) do
      local trapRenderCmpt = e:TrapRender()
      local skillID = trapRenderCmpt:GetDieSkillID()
      if skillID and 0 < skillID then
        local taskId = playSkillService:PlaySkillView(e, skillID)
        if taskId then
          table.insert(taskIDList, taskId)
        end
      end
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function MirageServiceRender:DoMiragePlayBossReturn(TT, bossEntity)
  local playSkillService = self._world:GetService("PlaySkill")
  local taskIDList = {}
  if bossEntity then
    local utilDataSvc = self._world:GetService("UtilData")
    local skillID = utilDataSvc:GetMonsterBackSkill(bossEntity)
    if skillID and 0 < skillID then
      local taskId = playSkillService:PlaySkillView(bossEntity, skillID)
      if taskId then
        table.insert(taskIDList, taskId)
      end
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function MirageServiceRender:DoMirageClearWarningArea()
  local group = self._world:GetGroup(self._world.BW_WEMatchers.DamageWarningAreaElement)
  local pubListEntity = group:GetEntities()
  local listEntity = {}
  for _, entity in ipairs(pubListEntity) do
    local cmpt = entity:DamageWarningAreaElement()
    if cmpt:GetOwnerEntityID() and cmpt:GetOwnerEntityID() ~= 0 then
      table.insert(listEntity, entity)
    end
  end
  local entityPoolSvcR = self._world:GetService("EntityPool")
  for i = 1, #listEntity do
    local entityWork = listEntity[i]
    local cmpt = entityWork:DamageWarningAreaElement()
    local entityConfigID = cmpt:GetEntityConfigID()
    if entityConfigID then
      entityPoolSvcR:DestroyCacheEntity(entityWork, entityConfigID)
    else
      entityPoolSvcR:DestroyCacheEntity(entityWork, EntityConfigIDRender.WarningArea)
    end
    cmpt:ClearOwnerEntityID()
  end
end

function MirageServiceRender:DoMiragePlayTeamMove(TT)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local mirageMoveResult = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.MirageMove)
  local walkRes = mirageMoveResult:GetWalkResult()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local boardServiceRender = self._world:GetService("BoardRender")
  local pieceSvc = self._world:GetService("Piece")
  self:StartMoveAnimation(teamEntity, true)
  boardServiceRender:RefreshPiece(teamEntity, true, true)
  local walkPos = walkRes:GetWalkPos()
  local curPos = boardServiceRender:GetRealEntityGridPos(teamEntity)
  teamEntity:AddGridMove(BattleConst.MoveSpeed, walkPos, curPos)
  local walkDir = walkPos - curPos
  teamEntity:SetDirection(walkDir)
  while teamEntity:HasGridMove() do
    YIELD(TT)
  end
  local oldColor = walkRes:GetOldPosColor()
  local gridEntityOld = boardServiceRender:ReCreateGridEntity(oldColor, curPos, false, true)
  pieceSvc:SetPieceEntityAnimNormal(gridEntityOld)
  pieceSvc:SetPieceEntityBirth(gridEntityOld)
  local newColor = walkRes:GetNewPosColor()
  local gridEntity = boardServiceRender:ReCreateGridEntity(newColor, walkPos, false, true)
  pieceSvc:SetPieceEntityAnimNormal(gridEntity)
  pieceSvc:SetPieceEntityBirth(gridEntity)
  self:_PlayArrivePos(TT, teamEntity, walkRes)
  self:StartMoveAnimation(teamEntity, false)
  boardServiceRender:RefreshPiece(teamEntity, false, true)
end

function MirageServiceRender:StartMoveAnimation(targetEntity, isMove)
  local curVal = targetEntity:GetAnimatorControllerBoolsData("Move")
  if curVal ~= isMove then
    targetEntity:SetAnimatorControllerBools({Move = isMove})
  end
end

function MirageServiceRender:_PlayArrivePos(TT, monsterEntity, walkRes)
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
end

function MirageServiceRender:ClearMiragePick()
  local piece_service = self._world:GetService("Piece")
  piece_service:SetAllPieceDark()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local utilData = self._world:GetService("UtilData")
  local roundGrids = utilData:GetRoundGrid(teamEntity:GetGridPosition())
  for _, gridPos in ipairs(roundGrids) do
    piece_service:SetPieceAnimNormal(gridPos)
  end
  self._world:EventDispatcher():Dispatch(GameEventType.RefreshMiragePickUpGrid, false)
end

function MirageServiceRender:SetMirageStepVisible(show)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local hpComponent = teamEntity:HP()
  if not hpComponent then
    return
  end
  local sliderEntityId = hpComponent:GetHPSliderEntityID()
  local sliderEntity = self._world:GetEntityByID(sliderEntityId)
  if not sliderEntity then
    return
  end
  local gameObj = sliderEntity:View():GetGameObject()
  local uiView = gameObj:GetComponent("UIView")
  local mirageRoot = uiView:GetGameObject("mirageRoot")
  if mirageRoot then
    mirageRoot:SetActive(show)
  end
end

function MirageServiceRender:RefreshMirageStepNum(stepNum)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local hpComponent = teamEntity:HP()
  if not hpComponent then
    return
  end
  local sliderEntityId = hpComponent:GetHPSliderEntityID()
  local sliderEntity = self._world:GetEntityByID(sliderEntityId)
  if not sliderEntity then
    return
  end
  local gameObj = sliderEntity:View():GetGameObject()
  local uiView = gameObj:GetComponent("UIView")
  local txtMirageStep = uiView:GetUIComponent("UILocalizationText", "txtMirageStep")
  txtMirageStep:SetText(tostring(stepNum))
end

function MirageServiceRender:GetMirageAutoFightPickUpPos()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local utilData = self._world:GetService("UtilData")
  local roundGrids = utilData:GetRoundGrid(teamEntity:GetGridPosition())
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local mirageWarningResult = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.MirageWarning)
  local warningPosList = mirageWarningResult:GetWarningPosList()
  local roundGridPosList = {}
  for _, grid in ipairs(roundGrids) do
    local pos = Vector2(grid.x, grid.y)
    if not table.icontains(warningPosList, pos) and utilData:IsValidPiecePos(pos) and not utilData:IsPosBlock(pos, BlockFlag.LinkLine) then
      table.insert(roundGridPosList, pos)
    end
  end
  if table.count(roundGridPosList) > 0 then
    local randomSvc = self._world:GetService("RandomRender")
    local n = randomSvc:RenderRand(1, table.count(roundGridPosList))
    if roundGridPosList[n] then
      return roundGridPosList[n]
    end
  end
  return Vector2.zero
end
