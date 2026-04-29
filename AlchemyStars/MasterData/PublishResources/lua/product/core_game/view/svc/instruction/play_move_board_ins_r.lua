require("base_ins_r")
_class("PlayMoveBoardInstruction", BaseInstruction)
PlayMoveBoardInstruction = PlayMoveBoardInstruction

function PlayMoveBoardInstruction:Constructor(paramList)
  self._sceneRoot1 = paramList.sceneRoot1
  self._sceneRoot2 = paramList.sceneRoot2
  self._times = tonumber(paramList.times) or 1
  self._dirX = tonumber(paramList.dirX) or 0
  self._dirY = tonumber(paramList.dirY) or 0
  self._dir = Vector2(self._dirX, self._dirY)
end

function PlayMoveBoardInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.MoveBoard)
  if resultArray == nil then
    Log.fatal("PlayMoveBoardInstruction, result is nil.")
    return
  end
  local playSkillInstructionService = world:GetService("PlaySkillInstruction")
  local pieceService = world:GetService("Piece")
  local boardServiceRender = world:GetService("BoardRender")
  local trapSvc = world:GetService("TrapRender")
  local playBuffService = world:GetService("PlayBuff")
  local renderEntityService = world:GetService("RenderEntity")
  local renderBoardEntity = world:GetRenderBoardEntity()
  local renderBoardComponent = renderBoardEntity:RenderBoard()
  local createGridEntityList = {}
  for moveIndex, v in ipairs(resultArray) do
    local arrPiece = {}
    local arrMonster = {}
    local allEntity = {}
    local arrMovers = {}
    local entityResult = v:GetMoveBoardEntities()
    local pieceResult = v:GetMoveBoardPieceResult()
    local moveBoardPieceResultCutIn = v:GetMoveBoardPieceResultCutIn()
    local prismResult = v:GetMoveBoardPrisms()
    local convertResult = v:GetConvertColors()
    local trapResult = v:GetTrapSkillResults()
    local trapDestoryList = v:GetTrapDestroyList()
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
    for i, r in ipairs(moveBoardPieceResultCutIn) do
      local oldPos, newPos, pieceType = r[1], r[2], r[3]
      local newGridEntity = boardServiceRender:CreateGridEntity(pieceType, oldPos)
      if newGridEntity then
        local t = {
          newGridEntity,
          oldPos,
          newPos
        }
        allEntity[#allEntity + 1] = t
        arrPiece[#arrPiece + 1] = t
        createGridEntityList[#createGridEntityList + 1] = newGridEntity
        playBuffService:_SendNTGridConvertRender(TT, oldPos, pieceType, SkillEffectType.MoveBoard)
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
    for i, v in ipairs(allEntity) do
      local e = v[1]
      local posTarget = v[3]
      local gridPos = boardServiceRender:GetRealEntityGridPos(e)
      e:RemoveGridMove()
      local canMoving = self:OnCheckCanMoving(world, e)
      if canMoving then
        e:AddGridMove(BattleConst.ConveySpeed, posTarget, gridPos)
      end
      if e:HasTeam() then
        local entityList = e:Team():GetTeamPetEntities()
        for k, entity in pairs(entityList) do
          entity:RemoveGridMove()
          local petGridMove = entity:AddGridMove(BattleConst.ConveySpeed, posTarget, gridPos)
        end
      elseif e:MonsterID() then
        renderEntityService:DestroyMonsterAreaOutLineEntity(e)
        local pos = gridPos - e:GridLocation():GetGridOffset()
        local bodyArea = e:BodyArea():GetArea()
        for _, area in ipairs(bodyArea) do
          local workPos = area + pos
          local curPieceAnim = pieceService:GetPieceAnimation(workPos)
          if curPieceAnim == "Down" then
            pieceService:SetPieceAnimUp(workPos)
          end
        end
      elseif e:HasTrapID() then
        if e:HasTrapRoundInfoRender() then
          if e:TrapRoundInfoRender():GetHeadShowType() == TrapHeadShowType.HeadShowRound then
            local boardSvc = world:GetService("BoardRender")
            local newRenderPos = boardSvc:GridPos2RenderPos(posTarget)
            local render = e:TrapRoundInfoRender()
            local round_entity_id = render:GetRoundInfoEntityID()
            local round_entity = world:GetEntityByID(round_entity_id)
            local ownerObj = e:View().ViewWrapper.GameObject
            local renderSvcR = world:GetService("RenderEntity")
            local owner_entity_render_pos = renderSvcR:_CalcGridHUDWorldPos(ownerObj.transform.position + Vector3(self._dir.x, 0, self._dir.y) + render:GetOffset())
            local go = round_entity:View().ViewWrapper.GameObject
            local owner_foot_pos = owner_entity_render_pos
            go.transform:DOMove(owner_foot_pos, 1 / BattleConst.ConveySpeed)
          else
            local eid = e:TrapRoundInfoRender():GetRoundInfoEntityID()
            if eid then
              local eff = world:GetEntityByID(eid)
              eff:RemoveGridMove()
              eff:AddGridMove(BattleConst.ConveySpeed, posTarget, gridPos)
            end
          end
        end
        local cEffectHolder = e:EffectHolder()
        if cEffectHolder then
          local effectList = cEffectHolder:GetIdleEffect()
          if 0 < table.count(effectList) then
            for i, eff in ipairs(effectList) do
              local effectEntity = world:GetEntityByID(eff)
              local effCtrl = effectEntity:EffectController()
              if effectEntity and effectEntity:HasView() and not effCtrl:GetFollowMove() then
                local curGridPos = boardServiceRender:GetRealEntityGridPos(effectEntity)
                local newGridPos = curGridPos + Vector2(self._dir.x, self._dir.y)
                effectEntity:RemoveGridMove()
                effectEntity:AddGridMove(BattleConst.ConveySpeed, newGridPos, curGridPos)
              end
            end
          end
        end
      end
    end
    if self._sceneRoot1 and self._sceneRoot2 and moveIndex == 1 then
      local sceneRoot1 = UnityEngine.GameObject.Find(self._sceneRoot1)
      local sceneRoot2 = UnityEngine.GameObject.Find(self._sceneRoot2)
      local moveTime = 1 / BattleConst.ConveySpeed * self._times
      local sceneRootDistance = math.abs(sceneRoot1.transform.position.z - sceneRoot2.transform.position.z)
      local offsetPos = Vector3(self._dir.x * self._times, 0, self._dir.y * self._times)
      local targetPos1 = sceneRoot1.transform.position + offsetPos
      local dotween1 = sceneRoot1.transform:DOMove(targetPos1, moveTime, false):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
        if sceneRoot1.transform.position.z >= sceneRootDistance then
          sceneRoot1.transform.position = sceneRoot1.transform.position - Vector3(0, 0, sceneRootDistance * 2)
        end
      end)
      local targetPos2 = sceneRoot2.transform.position + offsetPos
      local dotween2 = sceneRoot2.transform:DOMove(targetPos2, moveTime, false):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
        if sceneRoot2.transform.position.z >= sceneRootDistance then
          sceneRoot2.transform.position = sceneRoot2.transform.position - Vector3(0, 0, sceneRootDistance * 2)
        end
      end)
    end
    local gezi_wangge = UnityEngine.GameObject.Find("gezi_wangge")
    if gezi_wangge then
      local wanggePos = gezi_wangge.transform.position
      local dotween = gezi_wangge.transform:DOMove(wanggePos + Vector3(self._dir.x, 0, self._dir.y), 1 / BattleConst.ConveySpeed, false):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
        gezi_wangge.transform.position = wanggePos
      end)
    end
    while self:IsMoving(allEntity) do
      YIELD(TT)
    end
    if self._sceneRoot1 then
    end
    for _, t in ipairs(arrPiece) do
      local e = t[1]
      local oldPos = t[2]
      local newPos = t[3]
      local gridLocationCmp = e:GridLocation()
      if gridLocationCmp then
        e:SetGridPosition(oldPos)
        e:SetLocation(oldPos, e:GetGridDirection())
      end
    end
    for i, v in ipairs(allEntity) do
      local e = v[1]
      local posTarget = v[3]
      trapSvc:OnCheckTrapViewSetPieceExtraLayer(e, posTarget)
    end
    for _, gridEntity in ipairs(createGridEntityList) do
      world:DestroyEntity(gridEntity)
    end
    for _, v in ipairs(arrMovers) do
      playBuffService:PlayBuffView(TT, NTTransportEachMoveEnd:New(v[1], v[2], v[3]))
    end
    local notRefreshPrism = true
    for _, v in ipairs(convertResult) do
      local pos = v[1]
      local elementType = v[3]
      playSkillInstructionService:GridConvert(TT, casterEntity, pos, 0, elementType, notRefreshPrism)
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
    local donotPlayDie = true
    for _, entityID in ipairs(trapDestoryList) do
      local entity = world:GetEntityByID(entityID)
      trapSvc:PlayTrapDieSkill(TT, {entity}, donotPlayDie)
    end
    for _, v in pairs(prismResult) do
      local oldPos = v[1]
      pieceService:SetPieceRenderEffect(oldPos, PieceEffectType.Normal)
      local newPos = v[2]
      local pieceEffectType = v[4]
      if newPos then
        pieceService:SetPieceRenderEffect(newPos, pieceEffectType)
      end
    end
  end
  YIELD(TT)
  pieceService:RefreshPieceAnim()
  pieceService:RefreshMonsterAreaOutLine(TT)
end

function PlayMoveBoardInstruction:OnCheckCanMoving(world, e)
  if e:HasTrapID() then
    local trapSvc = world:GetService("TrapRender")
    local isPieceExtraLayerTrap = trapSvc:IsPieceExtraLayerTrap(e)
    if isPieceExtraLayerTrap == true then
      return false
    end
  end
  return true
end

function PlayMoveBoardInstruction:IsMoving(es)
  for _, t in ipairs(es) do
    local e = t[1]
    if e:HasGridMove() then
      return true
    end
  end
end
