require("auto_fight_service")

function AutoFightService:_AutoMovePath(TT)
  if self._world:MatchType(GetMatchTypeType.NoLinkLine) == MatchType.MT_PopStarPro then
    return self:_AutoPopGrid(TT)
  end
  local tmpSpeed
  if HelperProxy:GetInstance():GetGameTimeScale() > BattleConst.TimeSpeedList[BattleConst.Speed2Index] then
    Log.info("AutoFight SetTimeSpeed ", BattleConst.TimeSpeedList[BattleConst.Speed2Index], " ")
    tmpSpeed = HelperProxy:GetInstance():GetGameTimeScale()
    HelperProxy:GetInstance():SetGameTimeScale(BattleConst.TimeSpeedList[BattleConst.Speed2Index])
  end
  self._lastConvertColor = 0
  self._randPieceColor = false
  self._lastCastSkillPetIds = {}
  local env = self._env
  local teamEntity = env.TeamEntity
  local chainPath, pieceType = self:GetAutoChainPath(TT, teamEntity)
  if not chainPath or table.count(chainPath) == 0 then
    Log.info("[AutoFightService:_AutoMovePath] not chainPath or table.count(chainPath) == 0.   set chainPath = {teamEntity:GetGridPosition()}")
    chainPath = {
      teamEntity:GetGridPosition()
    }
    pieceType = 0
  end
  if self._world:RunAtServer() then
    local cmd = MovePathDoneCommand:New()
    cmd.EntityID = teamEntity:GetID()
    cmd:SetChainPath(chainPath)
    cmd:SetElementType(pieceType)
    teamEntity:ReceiveCommand(cmd)
    return
  end
  local canMoveArrowService = self._world:GetService("CanMoveArrow")
  if canMoveArrowService then
    canMoveArrowService:ShowCanMoveArrow(false)
  end
  if #chainPath == 1 then
    self:ClearChainPathGhost()
    local cmd = MovePathDoneCommand:New()
    cmd:SetChainPath(chainPath)
    cmd:SetElementType(PieceType.None)
    self._world:Player():SendCommand(cmd)
    local gameFsmCmpt = self._world:GameFSM()
    while gameFsmCmpt:CurStateID() == GameStateID.WaitInput do
      YIELD(TT, 100)
    end
    if tmpSpeed then
      Log.fatal("AutoFight ResumeSpeed")
      HelperProxy:GetInstance():SetGameTimeScale(tmpSpeed)
    end
    return
  end
  local previewEntity = self._world:GetPreviewEntity()
  local linklineService = self._world:GetService("LinkLine")
  linklineService:ShowBoardPieceMap()
  local leaderId = teamEntity:Team():GetTeamLeaderEntityID()
  local linkageRenderService = self._world:GetService("LinkageRender")
  local showPath = {}
  for _, pos in ipairs(chainPath) do
    table.insert(showPath, pos)
    linklineService:_OnPieceInsertIntoChain(showPath)
    previewEntity:ReplacePreviewChainPath(showPath, pieceType, PieceType.None)
    linkageRenderService:ShowLinkageInfo(showPath, pieceType)
    linkageRenderService:ShowChainSkillIcon(leaderId)
    YIELD(TT, 100)
  end
  if previewEntity then
    local previewChainPathCmpt = previewEntity:PreviewChainPath()
    if previewChainPathCmpt then
      previewChainPathCmpt:SetLinkLineState(false)
    end
  end
  local isLocal = self._world:GetGameTurn() == GameTurnType.LocalPlayerTurn
  self._world:EventDispatcher():Dispatch(GameEventType.FlushPetChainSkillItem, isLocal, #chainPath, pieceType)
  linklineService:ShowChainPathCancelArea(false)
  local pieceService = self._world:GetService("Piece")
  local boardService = self._world:GetService("BoardLogic")
  pieceService:RefreshPieceAnim()
  self:ClearChainPathGhost()
  local cmd = MovePathDoneCommand:New()
  cmd:SetChainPath(chainPath)
  cmd:SetElementType(pieceType)
  self._world:Player():SendCommand(cmd)
  local linkageRenderService = self._world:GetService("LinkageRender")
  linkageRenderService:ClearLinkRender()
  if tmpSpeed then
    Log.info("AutoFight ResumeSpeed")
    HelperProxy:GetInstance():SetGameTimeScale(tmpSpeed)
  end
  local gameFsmCmpt = self._world:GameFSM()
  while gameFsmCmpt:CurStateID() == GameStateID.WaitInput do
    YIELD(TT, 100)
  end
end

function AutoFightService:ClearChainPathGhost()
  local syncMoveServiceRender = self._world:GetService("SyncMoveRender")
  if syncMoveServiceRender then
    syncMoveServiceRender:ClearPreview()
  end
end

function AutoFightService:GetAutoChainPath(TT, teamEntity)
  if not self._env or not self._autoMoving then
    self:_BuildMoveEnv(teamEntity)
  end
  local env = self._env
  if env.MVP then
    return table.unpack(env.MVP)
  end
  if env.LevelPolicy == LevelPosPolicy.GotoExitPos and env.ExitPos then
    self:_MoveToExit(TT)
  elseif env.LevelPolicy == LevelPosPolicy.GotoTrapPos and env.UnlockPos then
    self:_MoveToUnlockPos(TT)
  else
    self:_CalcMVP2(TT)
  end
  if not env.MVP then
    Log.debug("自动连线无路可走，原地爆炸。")
    env.MVP = {
      {
        env.PlayerPos
      },
      PieceType.None,
      1
    }
  end
  return table.unpack(env.MVP)
end

function AutoFightService:_CalcMVP(TT)
  local t1 = os.clock()
  self:_CalcAllMovePath()
  local t2 = os.clock()
  local env = self._env
  Log.debug("[AutoFight] _CalcAllMovePath() path count=", #env.ChainPaths, " use time =", (t2 - t1) * 1000)
  if #env.ChainPaths == 0 then
    return
  end
  t1 = os.clock()
  local startTime = t1
  local deltaTime = 0
  local maxEvalue = 0
  local maxEvalueNormal = 0
  local maxEvalueChain = 0
  local MVP = {}
  for i = 1, #env.ChainPaths do
    local chainPath = env.ChainPaths[i][1]
    local pieceType = env.ChainPaths[i][2]
    local _maxEvalueNormal = env.ChainPaths[i][3]
    local _maxChainCnt = #chainPath
    local _maxChainAttCnt = self:_CalcChainAttackCount(chainPath[_maxChainCnt], _maxChainCnt, pieceType)
    local _maxEvalueChain = _maxChainAttCnt * BattleConst.AutoFightChainAttackValue
    local _maxEvalue = _maxEvalueNormal + _maxEvalueChain
    deltaTime = os.clock() - startTime
    if TT and deltaTime > BattleConst.LogicYieldTime then
      YIELD(TT)
      Log.debug("[AutoFight] calcMVP path i=", i, " use time=", deltaTime * 1000)
      deltaTime = 0
      startTime = os.clock()
    end
    local len = #chainPath - math.min(#chainPath // 2, 5)
    for n = #chainPath - 1, len, -1 do
      local chainAttCnt = self:_CalcChainAttackCount(chainPath[n], n, pieceType)
      local evalChain = chainAttCnt * BattleConst.AutoFightChainAttackValue
      local evalNormal = self:_CalcChainPathValue(chainPath, n, pieceType, env)
      local evalue = evalNormal + evalChain
      if _maxEvalue < evalue then
        _maxEvalue = evalue
        _maxEvalueChain = evalChain
        _maxEvalueNormal = evalNormal
        _maxChainCnt = n
      end
      deltaTime = os.clock() - startTime
      if TT and deltaTime > BattleConst.LogicYieldTime then
        YIELD(TT)
        Log.debug("[AutoFight] calcMVP path i=", i, " use time=", deltaTime * 1000)
        deltaTime = 0
        startTime = os.clock()
      end
    end
    if 0 < _maxChainCnt then
      for i = _maxChainCnt + 1, #chainPath do
        chainPath[i] = nil
      end
    end
    if maxEvalue < _maxEvalue then
      maxEvalue = _maxEvalue
      maxEvalueChain = _maxEvalueChain
      maxEvalueNormal = _maxEvalueNormal
      MVP = {
        chainPath,
        pieceType,
        maxEvalue
      }
      if TT and DEBUG_AUTO_FIGHT then
        self:ShowLinkLine(TT, chainPath, pieceType)
      end
    end
  end
  env.MVP = MVP
  local baseValue = self:_CalcChainPathBaseValue(MVP[1], MVP[2])
  if baseValue >= MVP[3] then
    self:_MoveToMonster()
    maxEvalueNormal = 1
    maxEvalueChain = 0
  end
  self._world:EventDispatcher():Dispatch(GameEventType.RefreshMVPText, string.format("V[%d]=N[%d]+C[%d]", maxEvalue, maxEvalueNormal, maxEvalueChain))
  local st = {}
  for i, pos in ipairs(env.MVP[1]) do
    st[#st + 1] = Vector2.Pos2Index(pos)
  end
  local s = table.concat(st, " ")
  t2 = os.clock()
  Log.debug("[AutoFight] calcMVP use time=", (t2 - t1) * 1000, " chainPath=[", s, "] pieceType=", env.MVP[2], " evalue=", env.MVP[3])
end

function AutoFightService:_CalcMVP2(TT)
  local t1 = os.clock()
  self:_CalcAllMovePath(TT)
  local t2 = os.clock()
  local env = self._env
  Log.debug("[AutoFight] _CalcAllMovePath() path count=", #env.ChainPaths, " use time =", (t2 - t1) * 1000)
  if #env.ChainPaths == 0 then
    return
  end
  local MVP = env.ChainPaths[1]
  env.MVP = MVP
  local baseValue = self:_CalcChainPathBaseValue(MVP[1], MVP[2])
  if baseValue >= MVP[3] then
    self:_MoveToMonster()
  end
  local st = {}
  for i, pos in ipairs(env.MVP[1]) do
    st[#st + 1] = Vector2.Pos2Index(pos)
  end
  local s = table.concat(st, " ")
  local usetime = os.clock() - t2
  Log.debug("[AutoFight] calcMVP2  chainPath=[", s, "] pieceType=", MVP[2], " evalue=", MVP[3], " use time=", usetime)
  self._world:EventDispatcher():Dispatch(GameEventType.RefreshMVPText, "MVP=" .. MVP[3])
end

function AutoFightService:_CalcAllMovePath(TT)
  local startPosIndex = self:_Pos2Index(self._env.PlayerPos)
  local chainPathIdx = {startPosIndex}
  local depth = 100
  if self._env.Benumb then
    depth = 1
  end
  depth = self:CalcMaxMoveStep(depth)
  self._env.ThinkStartTime = os.clock()
  self:_NextMove(TT, chainPathIdx, PieceType.Any, depth)
end

function AutoFightService:_NextMove(TT, chainPathIdx, prevPieceType, depth)
  local env = self._env
  if depth == 0 then
    return
  end
  local startPosIdx = chainPathIdx[#chainPathIdx]
  local ct = env.ConnectMap[startPosIdx]
  if not ct then
    return
  end
  if 1 < #chainPathIdx and env.DimensionDoorPos[startPosIdx] then
    return
  end
  local utilData = self._world:GetService("UtilData")
  if 1 < #chainPathIdx then
    local startPieceType = env.BoardPosPieces[startPosIdx]
    if #chainPathIdx == 2 then
      local mapForFirstChainPath = utilData:GetMapForFirstChainPath()
      if mapForFirstChainPath then
        startPieceType = mapForFirstChainPath
      end
    end
    if prevPieceType == PieceType.Any then
      prevPieceType = startPieceType
    end
  end
  if table.icontains(env.PrismPos, startPosIdx) and 1 < #chainPathIdx then
    local prevPosIdx = chainPathIdx[#chainPathIdx - 1]
    self:_DoPrismChange(startPosIdx, prevPosIdx)
  end
  for i = 1, 8 do
    if startPosIdx ~= chainPathIdx[#chainPathIdx] then
      return
    end
    local posIdx = ct[i]
    if posIdx then
      local posPieceType = env.BoardPosPieces[posIdx]
      local isFirstStepUseMapPiece = false
      if #chainPathIdx == 1 then
        local mapForFirstChainPath = utilData:GetMapForFirstChainPath()
        if mapForFirstChainPath then
          posPieceType = mapForFirstChainPath
          isFirstStepUseMapPiece = true
        end
      end
      local canMatchMapPieceType = false
      if not isFirstStepUseMapPiece then
        local mapPieceType = env.MapByPosition[posIdx]
        if mapPieceType and (mapPieceType == PieceType.Any or self:CanMatchPieceType(mapPieceType, prevPieceType)) then
          canMatchMapPieceType = true
          posPieceType = prevPieceType
        end
      end
      local isBlockMoveWithTrapWall = utilData:IsPosBlockMoveForTrapWallPosIndex(startPosIdx, posIdx)
      if (self:CanMatchPieceType(posPieceType, prevPieceType) or canMatchMapPieceType) and not table.icontains(chainPathIdx, posIdx) and isBlockMoveWithTrapWall == false then
        chainPathIdx[#chainPathIdx + 1] = posIdx
        env.forward = true
        if posPieceType == PieceType.Any then
          posPieceType = prevPieceType
        end
        self:_NextMove(TT, chainPathIdx, posPieceType, depth - 1)
        if env.forward and 1 < #chainPathIdx then
          env.forward = false
          local chainPath = {}
          for n = 1, #chainPathIdx do
            chainPath[#chainPath + 1] = self:_Index2Pos(chainPathIdx[n])
          end
          local pathPieceType = posPieceType
          for i = #chainPath, 1, -1 do
            local calcBlockChainPos = chainPath[i]
            if not utilData:IsPosBlockLinkLineForChainChainEnd(calcBlockChainPos) then
              break
            end
            self:_PopChainPath(chainPathIdx)
            chainPath[i] = nil
          end
          local val = self:_CalcChainPathValue(chainPath, #chainPath, pathPieceType, env)
          self:_InsertChainPath(chainPath, pathPieceType, val)
          if DEBUG_AUTO_FIGHT then
            self:ShowLinkLine(TT, chainPath, pathPieceType)
          end
          env.maxlen = #chainPathIdx
          env.cutlen = self:_CalcChainPathComplexityLen(chainPathIdx)
          local useTime = os.clock() - env.ThinkStartTime
          if TT and useTime > BattleConst.LogicYieldTime then
            YIELD(TT)
            env.ThinkStartTime = os.clock()
          end
        end
        if startPosIdx == chainPathIdx[#chainPathIdx - 1] then
          self:_PopChainPath(chainPathIdx)
        end
        if env.maxlen - #chainPathIdx == 4 then
          for n = #chainPathIdx, env.cutlen, -1 do
            self:_PopChainPath(chainPathIdx)
          end
        end
      end
    end
  end
end

function AutoFightService:_PopChainPath(chainPathIdx)
  local len = #chainPathIdx
  if table.icontains(self._env.PrismPos, chainPathIdx[len]) then
    local prevPosIdx = chainPathIdx[len - 1]
    self:_UndoPrismChange(chainPathIdx[len], prevPosIdx)
  end
  chainPathIdx[len] = nil
end

function AutoFightService:_InsertChainPath(chainPath, pieceType, val)
  local env = self._env
  local checklen = #chainPath - math.min(#chainPath // 2, 5)
  local maxChainCnt = #chainPath
  for n = #chainPath - 1, checklen, -1 do
    local evalue = self:_CalcChainPathValue(chainPath, n, pieceType, env)
    if val < evalue then
      val = evalue
      maxChainCnt = n
    end
  end
  if 0 < maxChainCnt then
    for i = maxChainCnt + 1, #chainPath do
      chainPath[i] = nil
    end
  end
  local utilData = self._world:GetService("UtilData")
  for i = #chainPath, 1, -1 do
    local calcBlockChainPos = chainPath[i]
    if not utilData:IsPosBlockLinkLineForChainChainEnd(calcBlockChainPos) then
      break
    end
    chainPath[i] = nil
  end
  local doInsert = false
  for idx, result in ipairs(env.ChainPaths) do
    if val > result[3] then
      table.insert(env.ChainPaths, idx, {
        chainPath,
        pieceType,
        val
      })
      doInsert = true
      break
    end
  end
  if not doInsert and #env.ChainPaths < BattleConst.AutoFightPathCountCut then
    table.insert(env.ChainPaths, {
      chainPath,
      pieceType,
      val
    })
  end
  if doInsert and #env.ChainPaths > BattleConst.AutoFightPathCountCut then
    env.ChainPaths[#env.ChainPaths] = nil
  end
end

function AutoFightService:_CalcChainPathComplexityLen(chainPathIdx)
  if self._env.HighConnectRateCutLen > 0 then
    return self._env.HighConnectRateCutLen
  end
  local m = BattleConst.AutoFightMoveEnhanced and 2 or 1
  local cc = 1
  local len = #chainPathIdx
  for i, idx in ipairs(chainPathIdx) do
    cc = cc * table.count(self._env.ConnectMap[idx])
    if cc > BattleConst.AutoFightPathComplexity[m] then
      len = i - 1
      break
    end
  end
  return len
end

function AutoFightService:_CalcChainPathValue(chainPath, len, pieceType, env)
  local utilData = self._world:GetService("UtilData")
  local superChainCount = utilData:GetCurrentTeamSuperChainCount()
  local val = 0
  local petCnt = 1
  local moveEntities = env.PieceTypeMovePets[pieceType]
  if moveEntities then
    petCnt = #moveEntities
  end
  local trapPosVal = 0
  for i, pos in ipairs(chainPath) do
    if len < i then
      break
    end
    local posIdx = self:_Pos2Index(pos)
    local posVal = env.BoardPosEvalue[posIdx]
    if not posVal then
      Log.info("[AutoFight] error _CalcChainPathValue posVal nil , pos: ", pos.x, " ", pos.y, " posIdx:", posIdx)
    end
    if posVal then
      val = val + posVal
    end
    if env.BoardPosCanAttack[posIdx] then
      local chainParam = math.min(i, BattleConst.SuperChainCount)
      local attackVal = BattleConst.AutoFightNormalAttackPosValue * (1 + BattleConst.AutoFightNormalAttackChainParam * chainParam)
      val = val + attackVal
    end
    local posVal = env.TrapPosEvalue[posIdx]
    if posVal then
      trapPosVal = trapPosVal + posVal
    end
    local posInfo = env.ElementBuffPos[posIdx]
    if posInfo and posInfo[pieceType] then
      val = val + posInfo[pieceType]
    end
  end
  val = val * petCnt + trapPosVal
  if len > superChainCount then
    val = val + BattleConst.AutoFightSuperChainAddPathValue
  end
  local chainAttackCnt = self:_CalcChainAttackCount2(chainPath[len], len, pieceType)
  local chainParam = math.min(len, BattleConst.SuperChainCount)
  val = val + chainAttackCnt * BattleConst.AutoFightChainAttackValue * (1 + BattleConst.AutoFightChainAttackChainParam * chainParam)
  if val <= 0 then
    val = 1
  end
  return val
end

function AutoFightService:_CalcChainPathBaseValue(chainPath, pieceType)
  local env = self._env
  local petCnt = 1
  local moveEntities = env.PieceTypeMovePets[pieceType]
  if moveEntities then
    petCnt = #moveEntities
  end
  local val = #chainPath * BattleConst.AutoFightNoAttackPosValue * petCnt
  return val
end

function AutoFightService:_CalcMoveEntities(pieceType)
  local teamEntity = self._env.TeamEntity
  local leaderId = teamEntity:Team():GetTeamLeaderEntityID()
  local moveEntities = {}
  for _, e in ipairs(teamEntity:Team():GetTeamPetEntities()) do
    local elementCmpt = e:Element()
    local primaryType = elementCmpt:GetPrimaryType()
    local sencondardType = elementCmpt:GetSecondaryType()
    local primaryMatch = self:CanMatchPieceType(primaryType, pieceType)
    local secondaryMatch = self:CanMatchPieceType(sencondardType, pieceType)
    if e:GetID() == leaderId or primaryMatch or secondaryMatch then
      moveEntities[#moveEntities + 1] = e
    end
  end
  return moveEntities
end

function AutoFightService:_CalcChainAttackCount(skillPos, chainCount, pieceType)
  local skillEntities = self._env.PieceTypeMovePets[pieceType]
  if skillEntities == nil or #skillEntities == 0 then
    return 0
  end
  local t1 = os.clock()
  local configSvc = self._configService
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local targetSelector = self._world:GetSkillScopeTargetSelector()
  local buffLogicSvc = self._world:GetService("BuffLogic")
  local affixService = self._world:GetService("Affix")
  if affixService:HasAddChainPathNum() then
    chainCount = affixService:ProcessAddChainPathNum(chainCount)
  end
  local utilData = self._world:GetService("UtilData")
  local attackCnt = 0
  for _, e in ipairs(skillEntities) do
    local chainCountFix = e:Attributes():GetAttribute("ChainSkillReleaseFix")
    local finalChainCount = chainCount + chainCountFix
    local chainExtraFix = utilData:GetEntityBuffValue(e, "ChangeExtraChainSkillReleaseFixForSkill")
    local skillInfoCmpt = e:SkillInfo()
    local chainSkillID = utilData:GetChainSkillByChainCount(e, finalChainCount, chainExtraFix)
    if 0 < chainSkillID then
      local skillConfigData = configSvc:GetSkillConfigData(chainSkillID)
      skillConfigData = utilData:ProcessChianSkillConfig(skillConfigData, e)
      local skillTargetType = skillConfigData:GetSkillTargetType()
      local scopeResult = utilScopeSvc:CalcSkillScope(skillConfigData, skillPos, e)
      utilScopeSvc:ExpandMaxChainSkillScope(e, chainSkillID, scopeResult, skillPos)
      local targetEntityIDArray = targetSelector:DoSelectSkillTarget(e, skillTargetType, scopeResult, chainSkillID)
      local hitCnt = 0
      for _, targetID in ipairs(targetEntityIDArray) do
        local targetEntity = self._world:GetEntityByID(targetID)
        if targetEntity and targetEntity:HasBuff() and buffLogicSvc:CheckCanBeMagicAttack(e, targetEntity) then
          hitCnt = hitCnt + 1
        end
      end
      attackCnt = attackCnt + hitCnt
    end
  end
  local t2 = os.clock()
  Log.debug("[AutoFight] _CalcChainAttackCount() pos=", Vector2.Pos2Index(skillPos), " use time=", (t2 - t1) * 1000)
  return attackCnt
end

function AutoFightService:_CalcChainAttackCount2(skillPos, chainCount, pieceType)
  local chainSkillAttackOffset = self._env.ChainSkillAttackOffset
  local chainSkillAttackCount = self._env.ChainSkillAttackCount
  local skillEntities = self._env.PieceTypeMovePets[pieceType]
  if skillEntities == nil or #skillEntities == 0 or skillPos == nil then
    return 0
  end
  local skillPosIdx = self:_Pos2Index(skillPos)
  local t1 = os.clock()
  local configSvc = self._configService
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local targetSelector = self._world:GetSkillScopeTargetSelector()
  local buffLogicSvc = self._world:GetService("BuffLogic")
  local utilData = self._world:GetService("UtilData")
  local affixService = self._world:GetService("Affix")
  if affixService:HasAddChainPathNum() then
    chainCount = affixService:ProcessAddChainPathNum(chainCount)
  end
  local attackCnt = 0
  for _, e in ipairs(skillEntities) do
    local chainCountFix = e:Attributes():GetAttribute("ChainSkillReleaseFix")
    local finalChainCount = chainCount + chainCountFix
    local skillInfoCmpt = e:SkillInfo()
    local chainExtraFix = utilData:GetEntityBuffValue(e, "ChangeExtraChainSkillReleaseFixForSkill")
    local chainSkillID = utilData:GetChainSkillByChainCount(e, finalChainCount, chainExtraFix)
    if 0 < chainSkillID then
      local hitCnt = 0
      local cache = chainSkillAttackCount[chainSkillID]
      if cache and cache[skillPosIdx] then
        hitCnt = cache[skillPosIdx]
      else
        local offset = chainSkillAttackOffset[chainSkillID]
        local range = {}
        if not offset then
          offset = {}
          local skillConfigData = configSvc:GetSkillConfigData(chainSkillID)
          skillConfigData = utilData:ProcessChianSkillConfig(skillConfigData, e)
          local chainSkillTag = skillConfigData:GetAutoFightChainSkillTag()
          if chainSkillTag == 1 then
            local scopeResult = utilScopeSvc:CalcSkillScope(skillConfigData, skillPos, e)
            utilScopeSvc:ExpandMaxChainSkillScope(e, chainSkillID, scopeResult, skillPos)
            range = scopeResult:GetAttackRange()
            for _, pos in ipairs(range) do
              offset[#offset + 1] = pos - skillPos
            end
          end
          chainSkillAttackOffset[chainSkillID] = offset
          chainSkillAttackCount[chainSkillID] = {}
        else
          for _, diff in ipairs(offset) do
            range[#range + 1] = skillPos + diff
          end
        end
        for i, pos in ipairs(range) do
          local monster = self._env.MonsterDict[self:_Pos2Index(pos)]
          if monster and buffLogicSvc:CheckCanBeMagicAttack(e, monster) then
            hitCnt = hitCnt + 1
          end
        end
        chainSkillAttackCount[chainSkillID][skillPosIdx] = hitCnt
      end
      attackCnt = attackCnt + hitCnt
    end
  end
  local t2 = os.clock()
  return attackCnt
end

function AutoFightService:ShowLinkLine(TT, chainPath, pieceType)
  local linkageRenderService = self._world:GetService("LinkageRender")
  linkageRenderService:ClearLinkRender()
  linkageRenderService:DestroyAllLinkedNum()
  linkageRenderService:DestroyAllLinkLine()
  linkageRenderService:DestroyLinkedGridEffect()
  local chain_path = chainPath
  for i, v in ipairs(chain_path) do
    if i ~= 1 then
      local dir = chain_path[i - 1] - chain_path[i]
      linkageRenderService:CreateLineRender(chain_path[i - 1], chain_path[i], i, v, dir, pieceType)
    end
  end
  linkageRenderService:ShowLinkageInfo(chainPath, pieceType)
  YIELD(TT, 1000)
end

function AutoFightService:_MoveToExit(TT)
  local startPosIndex = self:_Pos2Index(self._env.PlayerPos)
  local exitPosIndex = self:_Pos2Index(self._env.ExitPos)
  local endPosIdx = self:_FindPosIndexNeareastExit(exitPosIndex, startPosIndex)
  local pieceType = self._env.BoardPosPieces[endPosIdx]
  if endPosIdx == startPosIndex then
    return
  end
  local chainPathIdx = {endPosIdx}
  local ret = self:_FindPosTraceBackToStart(chainPathIdx, startPosIndex, pieceType)
  if chainPathIdx[1] ~= startPosIndex then
    return
  end
  local utilData = self._world:GetService("UtilData")
  local mapForFirstChainPath = utilData:GetMapForFirstChainPath()
  local chainPath = {}
  pieceType = PieceType.Any
  local log = ""
  for i, posIdx in ipairs(chainPathIdx) do
    local piece = self._env.BoardPosPieces[posIdx]
    if mapForFirstChainPath and i == 2 then
      piece = mapForFirstChainPath
    end
    if piece ~= PieceType.None and pieceType == PieceType.Any then
      pieceType = piece
    else
    end
    if piece ~= PieceType.None and piece ~= PieceType.Any and pieceType ~= PieceType.Any and piece ~= pieceType or self._env.Benumb and 1 < i or 1 < i and self._env.DimensionDoorPos[posIdx] then
      break
    end
    table.insert(chainPath, self:_Index2Pos(posIdx))
    log = log .. posIdx .. " "
  end
  self._env.MVP = {
    chainPath,
    pieceType,
    1
  }
  Log.debug("[AutoFight] MoveToExit path=", log, " pieceType=", pieceType)
end

function AutoFightService:_FindPosIndexNeareastExit(exitPosIndex, startPosIndex)
  if self._env.ConnectMap[exitPosIndex] then
    return exitPosIndex
  end
  local boardService = self._world:GetService("BoardLogic")
  local ringMax = boardService:GetCurBoardRingMax()
  for i, off in ipairs(ringMax) do
    local posIdx = self:_PosIndexAddOffset(exitPosIndex, off)
    if posIdx ~= startPosIndex and self._env.ConnectMap[posIdx] then
      return posIdx
    end
  end
  return startPosIndex
end

function AutoFightService:_FindPosTraceBackToStart(chainPathIdx, startPosIdx, pieceType)
  local posIdx = chainPathIdx[1]
  local ct = self._env.ConnectMap[posIdx]
  for i = 1, 8 do
    local nextPosIdx = ct[i]
    if nextPosIdx == startPosIdx then
      table.insert(chainPathIdx, 1, startPosIdx)
      return true
    end
    local nextPieceType = self._env.BoardPosPieces[nextPosIdx]
    if nextPosIdx and not table.icontains(chainPathIdx, nextPosIdx) and self:CanMatchPieceType(pieceType, nextPieceType) then
      table.insert(chainPathIdx, 1, nextPosIdx)
      if pieceType == PieceType.Any then
        pieceType = nextPieceType
      end
      local ret = self:_FindPosTraceBackToStart(chainPathIdx, startPosIdx, pieceType)
      if ret then
        return true
      else
        table.remove(chainPathIdx, 1)
      end
    end
  end
  return false
end

function AutoFightService:_MoveToUnlockPos(TT)
  local startPosIndex = self:_Pos2Index(self._env.PlayerPos)
  local unlockPos = self._env.UnlockPos
  local exitPosIndex = 0
  local nearDistance = 200
  for i, posIdx in ipairs(unlockPos) do
    local dis = self:_PosIndexDistance(posIdx, startPosIndex)
    if nearDistance > dis then
      exitPosIndex = posIdx
      nearDistance = dis
    end
  end
  local endPosIdx = self:_FindPosIndexNeareastExit(exitPosIndex, startPosIndex)
  local pieceType = self._env.BoardPosPieces[endPosIdx]
  if endPosIdx == startPosIndex then
    return
  end
  local utilData = self._world:GetService("UtilData")
  local mapForFirstChainPath = utilData:GetMapForFirstChainPath()
  local chainPathIdx = {endPosIdx}
  local ret = self:_FindPosTraceBackToStart(chainPathIdx, startPosIndex, pieceType)
  Log.debug("[AutoFight] _MoveToUnlockPos trace back path:", table.concat(chainPathIdx, " "))
  if chainPathIdx[1] ~= startPosIndex then
    return
  end
  local chainPath = {}
  pieceType = PieceType.Any
  local log = ""
  for i, posIdx in ipairs(chainPathIdx) do
    local piece = self._env.BoardPosPieces[posIdx]
    if mapForFirstChainPath and i == 2 then
      piece = mapForFirstChainPath
    end
    if piece ~= PieceType.None and pieceType == PieceType.Any then
      pieceType = piece
    else
    end
    if piece ~= PieceType.None and piece ~= PieceType.Any and pieceType ~= PieceType.Any and piece ~= pieceType or self._env.Benumb and 1 < i or 1 < i and self._env.DimensionDoorPos[posIdx] then
      break
    end
    table.insert(chainPath, self:_Index2Pos(posIdx))
    log = log .. posIdx .. " "
  end
  self._env.MVP = {
    chainPath,
    pieceType,
    1
  }
  Log.debug("[AutoFight] _MoveToUnlockPos path=", log)
end

function AutoFightService:_MoveToMonster()
  local startPosIndex = self:_Pos2Index(self._env.PlayerPos)
  local exitPosIndex = 0
  local nearDistance = 200
  if 0 < #self._env.BossPos then
    for i, posIdx in ipairs(self._env.BossPos) do
      local dis = self:_PosIndexDistance(posIdx, startPosIndex)
      if nearDistance > dis then
        exitPosIndex = posIdx
        nearDistance = dis
      end
    end
  else
    for i, posIdx in ipairs(self._env.MonsterPos) do
      local dis = self:_PosIndexDistance(posIdx, startPosIndex)
      if nearDistance > dis then
        exitPosIndex = posIdx
        nearDistance = dis
      end
    end
  end
  if exitPosIndex == 0 then
    return
  end
  local endPosIdx = self:_FindPosIndexNeareastExit(exitPosIndex, startPosIndex)
  local pieceType = self._env.BoardPosPieces[endPosIdx]
  if endPosIdx == startPosIndex then
    return
  end
  local chainPathIdx = {endPosIdx}
  local ret = self:_FindPosTraceBackToStart(chainPathIdx, startPosIndex, pieceType)
  if chainPathIdx[1] ~= startPosIndex then
    return
  end
  local utilData = self._world:GetService("UtilData")
  local mapForFirstChainPath = utilData:GetMapForFirstChainPath()
  local chainPath = {}
  pieceType = PieceType.Any
  local log = ""
  for i, posIdx in ipairs(chainPathIdx) do
    local piece = self._env.BoardPosPieces[posIdx]
    if mapForFirstChainPath and i == 2 then
      piece = mapForFirstChainPath
    end
    if piece ~= PieceType.None and pieceType == PieceType.Any then
      pieceType = piece
    else
    end
    if piece ~= PieceType.None and piece ~= PieceType.Any and pieceType ~= PieceType.Any and piece ~= pieceType or self._env.Benumb and 1 < i or 1 < i and self._env.DimensionDoorPos[posIdx] then
      break
    end
    table.insert(chainPath, self:_Index2Pos(posIdx))
    log = log .. posIdx .. " "
  end
  self._env.MVP = {
    chainPath,
    pieceType,
    1
  }
  Log.debug("[AutoFight] _MoveToMonster path=", log)
end

function AutoFightService:CanMatchPieceType(t1, t2)
  if self._world:LinkLineType() == ELinkLineType.ELLT_LINE_NoElementCostStep then
    return true
  else
    return CanMatchPieceType(t1, t2)
  end
end

function AutoFightService:CalcMaxMoveStep(defaultStep)
  local maxStep = defaultStep
  if self._world:LinkLineType() == ELinkLineType.ELLT_LINE_NoElementCostStep then
    local lsvcFeature = self._world:GetService("FeatureLogic")
    if lsvcFeature:HasFeatureType(FeatureType.StepPoint) then
      local autoMoveLimit = 9
      local curStep = lsvcFeature:GetCurStepPoint()
      if curStep then
        maxStep = curStep
        maxStep = math.min(maxStep, autoMoveLimit)
      end
    else
      maxStep = 9
      local teamEntity = self._env.TeamEntity
      if teamEntity then
        local buffCmpt = teamEntity:BuffComponent()
        if buffCmpt then
          local buffSetPoint = buffCmpt:GetBuffValue("NoFeatureStepPoint")
          if buffSetPoint then
            maxStep = buffSetPoint
          end
        end
      end
    end
  end
  return maxStep
end
