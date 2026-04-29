_class("CutsceneServiceRender", BaseService)
CutsceneServiceRender = CutsceneServiceRender

function CutsceneServiceRender:Constructor(world)
  self._originalSkyBoxColor = nil
end

function CutsceneServiceRender:SetOriginalSkyBoxColor(color)
  self._originalSkyBoxColor = color
end

function CutsceneServiceRender:GetOriginalSkyBoxColor()
  return self._originalSkyBoxColor
end

function CutsceneServiceRender:ResetSkyBoxColor()
  if self._originalSkyBoxColor then
    UnityEngine.RenderSettings.skybox:SetColor("_Tint", self._originalSkyBoxColor)
  end
end

function CutsceneServiceRender:PlayRealTimeCutscene(TT, type)
  local cfgService = self._configService
  local levelConfigData = cfgService:GetLevelConfigData()
  local cutsceneParam = levelConfigData:GetLevelCutsceneParam()
  for k, v in pairs(cutsceneParam) do
    if v:GetType() == type then
      local cutsceneDirector = CutsceneDirector:New(self._world)
      cutsceneDirector:DoPlayCutscenePhase(TT, v:GetID())
      Log.debug("Play Cutscene ID ", v:GetID(), "Type:", type)
    end
  end
end

function CutsceneServiceRender:ReviewCutscene(TT, levelID)
  local levelRawData = Cfg.cfg_level[levelID]
  if not levelRawData or not levelRawData.Cutscene then
    return
  end
  local cutsceneID = -1
  for _, cutsceneRawData in pairs(levelRawData.Cutscene) do
    cutsceneID = cutsceneRawData.CutsceneID
  end
  local cutsceneDirector = CutsceneDirector:New(self._world)
  cutsceneDirector:DoPlayCutscenePhase(TT, cutsceneID)
end

function CutsceneServiceRender:GetCutsceneRenderGridPosition(entity)
  local boardServiceRender = self._world:GetService("BoardRender")
  local targetGridPos
  local monster_body_area_cmpt = entity:BodyArea()
  local monster_body_area = {}
  if monster_body_area_cmpt then
    monster_body_area = monster_body_area_cmpt:GetArea()
  end
  if 1 < #monster_body_area then
    local renderPosition = entity:Location().Position
    targetGridPos = boardServiceRender:BoardRenderPos2FloatGridPos_New(renderPosition)
    local offset = Vector2(0, 0)
    if #monster_body_area == 4 then
      offset = Vector2(0.5, 0.5)
    elseif #monster_body_area == 9 then
      offset = Vector2(1, 1)
    end
    targetGridPos = targetGridPos - offset
    targetGridPos = Vector2(math.floor(targetGridPos.x), math.floor(targetGridPos.y))
  else
    local renderPosition = entity:Location().Position
    targetGridPos = boardServiceRender:BoardRenderPos2GridPos(renderPosition)
  end
  return targetGridPos
end

function CutsceneServiceRender:PlayCutsceneCreateMonster(TT, monsterID, monsterClassID, name, pos, dir, turnToPlayer)
  local sEntity = self._world:GetService("RenderEntity")
  local cutsceneMonsterEntity = sEntity:CreateRenderEntity(EntityConfigIDRender.CutsceneMonster)
  local monsterConfigData = self._configService:GetMonsterConfigData()
  local monsterResPath, areaArray
  if monsterClassID then
    local monsterClassConfigData = Cfg.cfg_monster_class[monsterClassID]
    monsterResPath = monsterClassConfigData.ResPath
    areaArray = monsterConfigData:ExplainMonsterArea(monsterClassConfigData.Area)
  end
  if monsterID then
    monsterResPath = monsterConfigData:GetMonsterResPath(monsterID)
    areaArray = monsterConfigData:GetMonsterArea(monsterID)
  end
  cutsceneMonsterEntity:ReplaceAsset(NativeUnityPrefabAsset:New(monsterResPath, true))
  cutsceneMonsterEntity:ReplaceBodyArea(areaArray)
  local blocks = self:_GetCutsceneBlockPos()
  local playerEntity = self._world:Player():GetLocalTeamEntity()
  local playerPos = self:GetCutsceneRenderGridPosition(playerEntity)
  local listReturn = self:_CalcScopeSquareRing(playerPos, {
    Vector2(0, 0)
  }, 9, 2)
  local gridPos = self:_GetCutsceneCreateMonsterPos(pos, areaArray, blocks, listReturn)
  local monster_body_area_cmpt = cutsceneMonsterEntity:BodyArea()
  local monster_body_area = {}
  if monster_body_area_cmpt then
    monster_body_area = monster_body_area_cmpt:GetArea()
  end
  local offset = Vector2(0, 0)
  if #monster_body_area == 4 then
    offset = Vector2(0.5, 0.5)
  elseif #monster_body_area == 9 then
    offset = Vector2(1, 1)
  end
  gridPos = gridPos + offset
  if turnToPlayer == 1 then
    dir = playerPos - gridPos
  end
  cutsceneMonsterEntity:SetLocation(gridPos, dir)
  cutsceneMonsterEntity:AddCutsceneMonster()
  local cutsceneMonsterComponent = cutsceneMonsterEntity:CutsceneMonster()
  cutsceneMonsterComponent:SetCutsceneMonsterName(name)
end

function CutsceneServiceRender:_GetCutsceneBlockPos()
  local blocks = {}
  local gapTiles = BattleConst.GapTiles
  local gapTilesPosList = {}
  for i, p in ipairs(gapTiles) do
    local gridPos = Vector2(p[1], p[2])
    table.insert(blocks, gridPos)
  end
  for _, entity in ipairs(self:GetCutsceneMonsterGroupEntity()) do
    local bodyArea = entity:BodyArea():GetArea()
    local gridPos = self:GetCutsceneRenderGridPosition(entity)
    for _, area in ipairs(bodyArea) do
      local bodyPos = area + gridPos
      table.insert(blocks, bodyPos)
    end
  end
  local playerEntity = self._world:Player():GetLocalTeamEntity()
  local playerPos = self:GetCutsceneRenderGridPosition(playerEntity)
  table.insert(blocks, playerPos)
  return blocks
end

function CutsceneServiceRender:GetCutsceneMonsterGroupEntity()
  local entityList = {}
  local group = self._world:GetGroup(self._world.BW_WEMatchers.CutsceneMonster)
  for _, entity in ipairs(group:GetEntities()) do
    local cutsceneMonsterComponent = entity:CutsceneMonster()
    if not cutsceneMonsterComponent:GetHadPlayDead() then
      table.insert(entityList, entity)
    end
  end
  return entityList
end

function CutsceneServiceRender:_GetCutsceneCreateMonsterPos(pos, bodyArea, blocks, attackRange)
  local canCutsceneCreate = true
  for _, area in ipairs(bodyArea) do
    local bodyPos = Vector2(area.x + pos.x, area.y + pos.y)
    if table.icontains(blocks, bodyPos) then
      canCutsceneCreate = false
    end
  end
  if canCutsceneCreate then
    return pos
  else
    table.insert(blocks, pos)
    table.removev(attackRange, pos)
    local randomIndex = Mathf.Random(1, table.count(attackRange))
    local posRandom = attackRange[randomIndex]
    local posNew = self:_GetCutsceneCreateMonsterPos(posRandom, bodyArea, blocks, attackRange)
    return posNew
  end
end

function CutsceneServiceRender:PlayCutsceneMonsterDead(TT, monsterEntity, monsterDeadType)
  local cutsceneMonsterComponent = monsterEntity:CutsceneMonster()
  cutsceneMonsterComponent:SetHadPlayDead(true)
  local deadTriggerParam = "Death"
  monsterEntity:SetAnimatorControllerTriggers({deadTriggerParam})
  if monsterDeadType and monsterDeadType ~= DeathShowType.None then
    local deathEffectID
    if monsterDeadType == DeathShowType.DissolveLight then
      monsterEntity:NewPlayDeadLight()
      deathEffectID = BattleConst.MonsterDeadEffectLight
    elseif monsterDeadType == DeathShowType.DissolveDark then
      monsterEntity:NewPlayDeadDark()
      deathEffectID = BattleConst.MonsterDeadEffectDark
    else
      deathEffectID = monsterDeadType
    end
    if deathEffectID then
      local effectService = self._world:GetService("Effect")
      if type(deathEffectID) == "number" then
        deathEffectID = {deathEffectID}
      end
      for i, effID in ipairs(deathEffectID) do
        local effectEntity = effectService:CreateEffect(effID, monsterEntity)
      end
    end
  end
end

function CutsceneServiceRender:_CalcScopeSquareRing(casterPos, bodyArea, ringCount, ringCountRemove)
  local listTotalData = ComputeScopeRange.ComputeRange_SquareRing(casterPos, #bodyArea, ringCount)
  local listTotalDataRemove = {}
  if ringCountRemove and 0 < ringCountRemove then
    listTotalDataRemove = ComputeScopeRange.ComputeRange_SquareRing(casterPos, #bodyArea, ringCountRemove)
  end
  local listAttackData = {}
  for key, value in ipairs(listTotalData) do
    local isValidGrid = self:isValidGrid(value)
    if isValidGrid and not table.intable(listTotalDataRemove, value) then
      listAttackData[#listAttackData + 1] = value
    end
  end
  return listAttackData
end

function CutsceneServiceRender:PlayCutsceneMonsterMoveToPlayer(TT, monsterName, moveGridCount, moveSpeed)
  local waitTaskList = {}
  local moveMonsterEntityList = {}
  for _, entity in ipairs(self:GetCutsceneMonsterGroupEntity()) do
    local cutsceneMonsterComponent = entity:CutsceneMonster()
    if cutsceneMonsterComponent:GetCutsceneMonsterName() == monsterName then
      table.insert(moveMonsterEntityList, entity)
    end
  end
  for i = 1, moveGridCount do
    for _, entity in ipairs(moveMonsterEntityList) do
      self.m_entityOwn = entity
      local posWalk = self:_CalcMovePos(entity)
      if posWalk ~= nil then
        local posSelf = self:GetCutsceneRenderGridPosition(entity)
        local cutsceneMonsterComponent = entity:CutsceneMonster()
        cutsceneMonsterComponent:SetLastMovePos(posSelf)
        local taskID = GameGlobal.TaskManager():CoreGameStartTask(self._DoWalk, self, entity, {posWalk}, moveSpeed)
        if 0 < taskID then
          waitTaskList[#waitTaskList + 1] = taskID
        end
      end
    end
    if 0 < #waitTaskList then
      while not TaskHelper:GetInstance():IsAllTaskFinished(waitTaskList) do
        YIELD(TT)
      end
    end
  end
end

function CutsceneServiceRender:_DoWalk(TT, monsterEntity, walkResultList, moveSpeed)
  local boardServiceRender = self._world:GetService("BoardRender")
  local hasWalkPoint = false
  if 0 < #walkResultList then
    hasWalkPoint = true
  end
  if hasWalkPoint then
    self:StartMoveAnimation(monsterEntity, true)
  end
  for _, resultPos in ipairs(walkResultList) do
    local curPos = boardServiceRender:GetRealEntityGridPos(monsterEntity)
    local walkPos = resultPos
    local bodyAreaCmpt = monsterEntity:BodyArea()
    local areaCount = bodyAreaCmpt:GetAreaCount()
    if areaCount == 4 then
      walkPos = Vector2(walkPos.x + 0.5, walkPos.y + 0.5)
    end
    local walkDir = walkPos - curPos
    monsterEntity:AddGridMove(moveSpeed, walkPos, curPos)
    monsterEntity:SetDirection(walkDir)
    Log.debug("[PlayAI]Entity:", monsterEntity:GetID(), ",CurPos:", curPos, " WalkTo,", walkPos)
    while monsterEntity:HasGridMove() do
      YIELD(TT)
    end
  end
  if hasWalkPoint then
    self:StartMoveAnimation(monsterEntity, false)
  end
end

function CutsceneServiceRender:StartMoveAnimation(targetEntity, isMove)
  local curVal = targetEntity:GetAnimatorControllerBoolsData("Move")
  if curVal ~= isMove then
    targetEntity:SetAnimatorControllerBools({Move = isMove})
  end
end

function CutsceneServiceRender:_CalcMovePos(entityWork)
  local posSelf = self:GetCutsceneRenderGridPosition(entityWork)
  local posTarget = self:FindNewTargetPos(entityWork)
  if posSelf == posTarget then
    return nil
  end
  local nWalkTotal = 1
  local posWalkList = self:ComputeWalkRange(posSelf, nWalkTotal, true)
  local posWalk = self:FindNewWalkPos(posWalkList, posTarget, posSelf)
  if posWalk and posWalk == posSelf then
    return nil
  end
  return posWalk
end

function CutsceneServiceRender:FindNewTargetPos(entityWork)
  local selfPos = self:GetCutsceneRenderGridPosition(entityWork)
  local selfBodyArea = entityWork:BodyArea():GetArea()
  local playerEntity = self._world:Player():GetLocalTeamEntity()
  local playerPos = self:GetCutsceneRenderGridPosition(playerEntity)
  local workCenter = playerPos
  local listReturn = self:_CalcScopeSquareRing(workCenter, {
    Vector2(0, 0)
  }, 1, 0)
  self.m_nextPosList = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByNear)
  self.m_nextPosList:AllowDuplicate()
  self.m_nextPosList:Clear()
  for i = 1, #listReturn do
    local posWork = listReturn[i]
    if self:IsPosAccessible(posWork) then
      AINewNode.InsertSortedArray(self.m_nextPosList, selfPos, posWork, i)
    end
  end
  local posReturn = self:FindPosValid(self.m_nextPosList, playerPos)
  return posReturn
end

function CutsceneServiceRender:FindPosValid(planPosList, defPos)
  if nil == planPosList or planPosList:Size() <= 0 then
    return defPos
  end
  local posSelf = defPos
  local posReturn = posSelf
  local nPosCount = planPosList:Size()
  for i = 1, nPosCount do
    local posWork = planPosList:GetAt(i)
    local bAccessible = self:IsPosAccessible(posWork.data)
    if true == bAccessible then
      posReturn = posWork.data
      break
    end
  end
  return posReturn
end

function CutsceneServiceRender:ComputeWalkRange(centerPos, nWalkStep, bFilter)
  bFilter = bFilter or false
  local cbFilter
  if bFilter then
    cbFilter = Callback:New(1, self.IsPosAccessible, self)
  end
  return ComputeScopeRange.ComputeRange_WalkMathPos(centerPos, 1, nWalkStep, cbFilter)
end

function CutsceneServiceRender:IsPosAccessible(pos)
  local coverList = self:GetCoverAreaList(pos)
  local wordPos = self:GetCutsceneRenderGridPosition(self.m_entityOwn)
  local coverListSelf = self:GetCoverAreaList(wordPos)
  local blocks = self:_GetCutsceneBlockPos()
  for i = 1, #coverList do
    local posWork = coverList[i]
    if not table.icontains(coverListSelf, posWork) and table.icontains(blocks, posWork) then
      return false
    end
  end
  return true
end

function CutsceneServiceRender:GetCoverAreaList(pos)
  local posList = {}
  if self.m_entityOwn then
    posList = self.m_entityOwn:GetCoverAreaList(pos)
  end
  return posList
end

function CutsceneServiceRender:FindNewWalkPos(walkRange, posCenter, posDef)
  return self:FindPosByNearCenter(walkRange, posCenter, posDef, 1)
end

function CutsceneServiceRender:FindPosByNearCenter(listPlanPos, posCenter, posDef, nCheckStep)
  if nil == listPlanPos or table.count(listPlanPos) <= 0 then
    return posDef
  end
  local listWalk = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByNear)
  listWalk:AllowDuplicate()
  local cutsceneMonsterComponent = self.m_entityOwn:CutsceneMonster()
  local lastMovePos = cutsceneMonsterComponent:GetLastMovePos()
  for i = 1, #listPlanPos do
    local posData = listPlanPos[i]
    local posWalk = posData:GetPos()
    if posWalk ~= posDef and (nil == nCheckStep or nCheckStep == posData:GetStep()) and posWalk ~= lastMovePos then
      AINewNode.InsertSortedArray(listWalk, posCenter, posWalk, i)
    else
    end
  end
  return self:FindPosValid(listWalk, posDef)
end

function CutsceneServiceRender:PlayCutsceneHitbackPlayer(TT, dis, dir, speed)
  local playerEntity = self._world:Player():GetLocalTeamEntity()
  local playerPos = self:GetCutsceneRenderGridPosition(playerEntity)
  local blocks = self:_GetCutsceneBlockPos()
  local boardServiceRender = self._world:GetService("BoardRender")
  local gapTiles = BattleConst.GapTiles
  local gapTilesPosList = {}
  for i, p in ipairs(gapTiles) do
    local gridPos = Vector2(p[1], p[2])
    table.insert(gapTilesPosList, gridPos)
  end
  local targetPos = playerPos
  for i = 1, dis do
    local hitBackPos = playerPos + Vector2(dir.x * i, dir.y * i)
    if not (not table.icontains(blocks, hitBackPos) and self:isValidGrid(hitBackPos)) or table.icontains(gapTilesPosList, hitBackPos) then
      break
    end
    targetPos = hitBackPos
  end
  playerEntity:AddHitback(playerPos, speed, targetPos, dir)
  while playerEntity:HasHitback() and not playerEntity:Hitback():IsHitbackEnd() do
    YIELD(TT)
  end
end

function CutsceneServiceRender:isValidGrid(pos)
  local isValid = pos.x >= 1 and 1 <= pos.y and pos.x <= BattleConst.DefaultMaxX and pos.y <= BattleConst.DefaultMaxY
  return isValid
end
