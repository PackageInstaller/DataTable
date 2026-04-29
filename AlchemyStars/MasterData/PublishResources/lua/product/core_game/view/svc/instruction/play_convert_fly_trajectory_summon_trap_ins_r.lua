require("play_grid_range_convert_ins_r")
_class("PlayConvertFlyTrajectorySummonTrapInstruction", BaseInstruction)
PlayConvertFlyTrajectorySummonTrapInstruction = PlayConvertFlyTrajectorySummonTrapInstruction

function PlayConvertFlyTrajectorySummonTrapInstruction:Constructor(paramList)
  self._flyEffectID = tonumber(paramList.flyEffectID)
  self._spawnRadiusMin = tonumber(paramList.spawnRadiusMin)
  self._spawnRadiusMax = tonumber(paramList.spawnRadiusMax)
  self._offsetPosX = tonumber(paramList.offsetPosX) or 0
  self._offsetPosY = tonumber(paramList.offsetPosY) or 0
  self._offsetPosZ = tonumber(paramList.offsetPosZ) or 0
  self._offsetPos = Vector3(self._offsetPosX, self._offsetPosY, self._offsetPosZ)
  self._fireTimeMin = tonumber(paramList.fireTimeMin)
  self._fireTimeMax = tonumber(paramList.fireTimeMax)
  self._flyTime = tonumber(paramList.flyTime)
  self._flyRandomDis = tonumber(paramList.flyRandomDis)
  self._flyRandomPointCount = tonumber(paramList.flyRandomPointCount)
  self._targetHitOffsetMin = tonumber(paramList.targetHitOffsetMin)
  self._targetHitOffsetMax = tonumber(paramList.targetHitOffsetMax)
  self._fireEffectID = tonumber(paramList.fireEffectID)
  self._disableRoot = paramList.disableRoot
  self._destroyBulletDelay = tonumber(paramList.destroyBulletDelay)
  self._convertEffectID = tonumber(paramList.convertEffectID)
  self._summonTrap = tonumber(paramList.summonTrap)
  self._needLookAt = tonumber(paramList.needLookAt)
  self._firstPosX = tonumber(paramList.firstPosX)
  self._firstPosY = tonumber(paramList.firstPosY)
  self._firstPosZ = tonumber(paramList.firstPosZ)
  if self._firstPosX then
    self._firstPos = Vector3(self._firstPosX, self._firstPosY, self._firstPosZ)
  end
  self._firstPosRandom = tonumber(paramList.firstPosRandom)
  self._hitSoundID = tonumber(paramList.hitSoundID)
end

function PlayConvertFlyTrajectorySummonTrapInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  self._world = world
  self._casterEntity = casterEntity
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local convertResult = skillEffectResultContainer:GetEffectResultByArrayAll(SkillEffectType.ConvertGridElement)
  if not convertResult then
    return
  end
  local trapResultArray = skillEffectResultContainer:GetEffectResultByArrayAll(SkillEffectType.SummonTrap)
  local castPos = casterEntity:GetRenderGridPosition()
  local effectService = world:GetService("Effect")
  local boardServiceRender = world:GetService("BoardRender")
  local timeService = world:GetService("Time")
  local startTime = timeService:GetCurrentTimeMs()
  self.playEffectDataList = {}
  for _, result in ipairs(convertResult) do
    local gridPosArray = result:GetTargetGridArray()
    local targetGridType = result:GetTargetElementType()
    for i, gridPos in ipairs(gridPosArray) do
      local posWork = castPos
      if self._spawnRadiusMin then
        local pos1 = UnityEngine.Random.insideUnitCircle * self._spawnRadiusMin
        local pos2 = pos1.normalized * (self._spawnRadiusMax + pos1.magnitude)
        posWork = castPos + pos2
      else
        local casterEntityTransform = casterEntity:View():GetGameObject().transform
        posWork = casterEntityTransform:TransformPoint(self._offsetPos)
      end
      local eftEntity = effectService:CreatePositionEffect(self._flyEffectID, posWork)
      local go = eftEntity:View():GetGameObject()
      if self._disableRoot then
        local disableTransform = go.transform:Find(self._disableRoot)
        if disableTransform then
          disableTransform.gameObject:SetActive(true)
        end
      end
      go.gameObject:SetActive(false)
      local targetTransform = boardServiceRender:GridPos2RenderPos(gridPos)
      local targetHitOffset = math.random(self._targetHitOffsetMin * 1000, self._targetHitOffsetMax * 1000) / 1000
      local targetPos = targetTransform + UnityEngine.Random.onUnitSphere * targetHitOffset
      targetPos = Vector3(targetPos.x, math.max(0, targetPos.y), targetPos.z)
      local fireTime = math.random(self._fireTimeMin, self._fireTimeMax)
      local fireStartTime = fireTime + startTime
      local playEffectData = PlaySkillFlotageTrajectoryData:New(eftEntity, nil, targetPos, fireStartTime)
      if self._summonTrap == 1 and trapResultArray and trapResultArray[i] then
        local result = trapResultArray[i]
        local summonTrapID = result:GetTrapID()
        playEffectData:SetSummonTrapID(result:GetTrapID())
        playEffectData:SetSummonTrapPos(result:GetPos())
        playEffectData:SetSummonTrapEntityIDList(result:GetTrapIDList())
      end
      playEffectData:SetConvertPieceType(targetGridType)
      playEffectData:SetConvertPos(gridPos)
      self.playEffectDataList[eftEntity:GetID()] = playEffectData
    end
  end
  while 0 < table.count(self.playEffectDataList) do
    local curTime = timeService:GetCurrentTimeMs()
    for _, v in pairs(self.playEffectDataList) do
      if v.stage == 1 and curTime <= v.fireStartTime then
        v.stage = 2
        self:_OnPlayBezier(TT, v)
      end
    end
    YIELD(TT)
  end
  YIELD(TT)
end

function PlayConvertFlyTrajectorySummonTrapInstruction:_OnPlayBezier(TT, playEffectData)
  local effectEntity = playEffectData.effectEntity
  local go = effectEntity:View():GetGameObject()
  go.gameObject:SetActive(true)
  local effectService = self._world:GetService("Effect")
  if self._fireEffectID and self._fireEffectID > 0 then
    local hitEffect = effectService:CreateWorldPositionEffect(self._fireEffectID, go.transform.position)
  end
  local path = {}
  table.insert(path, go.transform.position)
  if self._firstPos then
    local posRandom = Vector3(0, 0, 0)
    if self._firstPosRandom then
      posRandom = Vector3(math.random(-self._firstPosRandom * 1000, self._firstPosRandom * 1000) / 1000, math.random(-self._firstPosRandom * 1000, self._firstPosRandom * 1000) / 1000, math.random(-self._firstPosRandom * 1000, self._firstPosRandom * 1000) / 1000)
    end
    local pathFirstPos = go.transform.position + self._firstPos + posRandom
    table.insert(path, pathFirstPos)
  end
  local lastPos = path[#path]
  for i = 1, self._flyRandomPointCount do
    local pos = lastPos + Vector3(math.random(-self._flyRandomDis, self._flyRandomDis), math.random(-5, 5) / 10, math.random(-self._flyRandomDis, self._flyRandomDis))
    if pos.y < 0.8 then
      pos = Vector3(pos.x, 0.8, pos.z)
    end
    table.insert(path, pos)
    lastPos = pos
  end
  table.insert(path, playEffectData.targetPos)
  local pathBezier = {}
  for i = 0, 1, 0.01 do
    table.insert(pathBezier, self:_BezierMethod(i, path))
  end
  table.insert(pathBezier, playEffectData.targetPos)
  local curve = DG.Tweening.Ease.Linear
  local animationCurveHolder = go.gameObject:GetComponent(typeof(AnimationCurveHolder))
  if animationCurveHolder then
    local curveList = animationCurveHolder.acurveList
    if curveList and 0 < curveList.Length then
      curve = curveList[0]
    end
  end
  local flyTime = self._flyTime
  if self._needLookAt == 1 then
    local newPathBezier = {}
    for i = 1, table.count(pathBezier) do
      if i % 3 == 0 then
        table.insert(newPathBezier, pathBezier[i])
      end
    end
    go.transform:LookAt(newPathBezier[2])
    YIELD(TT)
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      local tweenTime = flyTime / table.count(newPathBezier)
      for i = 1, table.count(newPathBezier) - 1 do
        local nextPos = newPathBezier[i + 1]
        go.transform:LookAt(nextPos)
        go.transform:DOMove(nextPos, tweenTime * 0.001)
        YIELD(TT, tweenTime)
      end
      self:_OnPlayHit(TT, playEffectData)
    end)
  else
    go.transform:DOLocalPath(pathBezier, flyTime / 1000, DG.Tweening.PathType.CatmullRom, DG.Tweening.PathMode.Full3D):SetEase(curve)
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      YIELD(TT, flyTime)
      self:_OnPlayHit(TT, playEffectData)
    end)
  end
end

function PlayConvertFlyTrajectorySummonTrapInstruction:_OnPlayHit(TT, playEffectData)
  local effectEntity = playEffectData.effectEntity
  local go = effectEntity:View():GetGameObject()
  local effectPos = go.transform.position
  if self._disableRoot then
    local disableTransform = go.transform:Find(self._disableRoot)
    if disableTransform then
      disableTransform.gameObject:SetActive(false)
    end
  end
  local effectService = self._world:GetService("Effect")
  local skillEffectResultContainer = self._casterEntity:SkillRoutine():GetResultContainer()
  local summonTrapID = playEffectData:GetSummonTrapID()
  local summonTrapPos = playEffectData:GetSummonTrapPos()
  local summonTrapEntityIDList = playEffectData:GetSummonTrapEntityIDList()
  if summonTrapID then
    for i, summonTrapEntityID in ipairs(summonTrapEntityIDList) do
      local trapEntity = self._world:GetEntityByID(summonTrapEntityID)
      if trapEntity then
        trapEntity:SetPosition(summonTrapPos)
        local trapServiceRender = self._world:GetService("TrapRender")
        trapServiceRender:CreateSingleTrapRender(TT, trapEntity, true)
        if self._convertEffectID and self._convertEffectID > 0 then
          effectService:CreateWorldPositionDirectionEffect(self._convertEffectID, summonTrapPos)
        end
        if trapEntity:View() then
          local trapObj = trapEntity:View():GetGameObject()
          if trapObj then
            trapObj.transform.localEulerAngles = Vector3(0, go.transform.localEulerAngles.y, 0)
          end
        end
      end
    end
  end
  local pieceService = self._world:GetService("Piece")
  local convertPieceType = playEffectData:GetConvertPieceType()
  local convertPos = playEffectData:GetConvertPos()
  if convertPos then
    local nOldGridType = PieceType.None
    local gridEntity = pieceService:FindPieceEntity(convertPos)
    local pieceCmpt = gridEntity:Piece()
    nOldGridType = pieceCmpt:GetPieceType()
    local tConvertInfo = {}
    local convertInfo = NTGridConvert_ConvertInfo:New(convertPos, nOldGridType, convertPieceType)
    table.insert(tConvertInfo, convertInfo)
    local boardServiceR = self._world:GetService("BoardRender")
    local newGridEntity = boardServiceR:ReCreateGridEntity(convertPieceType, convertPos)
    if newGridEntity then
      pieceService:SetPieceEntityAnimNormal(newGridEntity)
    end
    if self._convertEffectID then
      effectService:CreateWorldPositionEffect(self._convertEffectID, convertPos)
    end
    local svcPlayBuff = self._world:GetService("PlayBuff")
    local nt = NTGridConvert:New(self._casterEntity, tConvertInfo)
    nt:SetConvertEffectType(SkillEffectType.ConvertGridElement)
    svcPlayBuff:PlayBuffView(TT, nt)
  end
  if self._hitSoundID and 0 < self._hitSoundID then
    AudioHelperController.PlayInnerGameSfx(self._hitSoundID)
  end
  YIELD(TT, self._destroyBulletDelay)
  self._world:DestroyEntity(effectEntity)
  self.playEffectDataList[playEffectData.effectEntity:GetID()] = nil
end

function PlayConvertFlyTrajectorySummonTrapInstruction:_BezierMethod(t, foceList)
  if table.count(foceList) < 2 then
    return foceList[1]
  end
  local temp = {}
  for i = 1, table.count(foceList) - 1 do
    local proportion = Vector3((1 - t) * foceList[i].x + t * foceList[i + 1].x, (1 - t) * foceList[i].y + t * foceList[i + 1].y, (1 - t) * foceList[i].z + t * foceList[i + 1].z)
    table.insert(temp, proportion)
  end
  return self:_BezierMethod(t, temp)
end

function PlayConvertFlyTrajectorySummonTrapInstruction:GetCacheResource()
  local t = {}
  if self._flyEffectID and self._flyEffectID > 0 and Cfg.cfg_effect[self._flyEffectID] then
    table.insert(t, {
      Cfg.cfg_effect[self._flyEffectID].ResPath,
      1
    })
  end
  if self._convertEffectID and 0 < self._convertEffectID and Cfg.cfg_effect[self._convertEffectID] then
    table.insert(t, {
      Cfg.cfg_effect[self._convertEffectID].ResPath,
      1
    })
  end
  return t
end
