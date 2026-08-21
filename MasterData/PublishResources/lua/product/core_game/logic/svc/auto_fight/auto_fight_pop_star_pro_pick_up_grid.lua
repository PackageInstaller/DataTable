require("auto_fight_service")

function AutoFightService:_AutoPopGrid(TT)
  local tmpSpeed
  if HelperProxy:GetInstance():GetGameTimeScale() > BattleConst.TimeSpeedList[BattleConst.Speed2Index] then
    Log.fatal("AutoFight SetTimeSpeed ", BattleConst.TimeSpeedList[BattleConst.Speed2Index], " ")
    tmpSpeed = HelperProxy:GetInstance():GetGameTimeScale()
    HelperProxy:GetInstance():SetGameTimeScale(BattleConst.TimeSpeedList[BattleConst.Speed2Index])
  end
  self._lastConvertColor = 0
  self._randPieceColor = false
  self._lastCastSkillPetIds = {}
  local env = self._env
  local teamEntity = env.TeamEntity
  local pickUpGrid, connectPieces = self:_GetAutoPickUpData(TT, teamEntity)
  if self._world:RunAtServer() then
    local cmd = PopStarPickUpCommand:New()
    cmd.EntityID = teamEntity:GetID()
    cmd:SetCmdPickUpPos(pickUpGrid)
    cmd:SetCmdConnectPieces(connectPieces)
    teamEntity:ReceiveCommand(cmd)
    return
  end
  local boardSvcR = self._world:GetService("BoardRender")
  local renderPos = boardSvcR:GridPos2RenderPos(pickUpGrid)
  local popStarPickUpCmpt = self._world:PopStarPickUp()
  popStarPickUpCmpt:SetPopStarClickPos(renderPos)
  local component = self._world:GetUniqueComponent(self._world.BW_UniqueComponentsEnum.PopStarPickUp)
  self._world:SetUniqueComponent(self._world.BW_UniqueComponentsEnum.PopStarPickUp, component)
  YIELD(TT, 200)
  popStarPickUpCmpt:SetPopStarClickPos(renderPos)
  local component = self._world:GetUniqueComponent(self._world.BW_UniqueComponentsEnum.PopStarPickUp)
  self._world:SetUniqueComponent(self._world.BW_UniqueComponentsEnum.PopStarPickUp, component)
  YIELD(TT, 200)
  if tmpSpeed then
    Log.fatal("AutoFight ResumeSpeed")
    HelperProxy:GetInstance():SetGameTimeScale(tmpSpeed)
  end
  local gameFsmCmpt = self._world:GameFSM()
  while gameFsmCmpt:CurStateID() == GameStateID.WaitInput do
    YIELD(TT, 100)
  end
end

function AutoFightService:_GetAutoPickUpData(TT, teamEntity)
  if not self._envPickUp or not self._autoMoving then
    self:_BuildPopStarProPickUpEnv(teamEntity)
  end
  local env = self._envPickUp
  for key, value in pairs(env.BoardPosCanPick) do
    if value then
      local pos = env.Index2Pos[key]
      self:_CalcPosPickUpValue(pos)
    end
  end
  if env.Mvp then
    return env.Mvp[1], self:_GetConnectPieces(env.Mvp[1])
  end
  return env.PlayerPos, self:_GetConnectPieces(env.PlayerPos)
end

function AutoFightService:_CalcPosPickUpValue(pos)
  local utilDataSvc = self:GetService("UtilData")
  local pieceType = utilDataSvc:GetPieceType(pos)
  local connectPieces = self:_GetConnectPieces(pos)
  local chainPath = {pos}
  if utilDataSvc:CanCastChainSkill(self._envPickUp.TeamEntity, pos, connectPieces) then
    table.appendArray(chainPath, connectPieces)
  end
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local chainRate = utilCalcSvc:GetChainDamageRateAtIndex(chainPath, #chainPath)
  local chainAttackVal = self:_CalcChainAttackVal(pos, chainRate, pieceType)
  local monsterVal = 0
  local posIndex = self:_Pos2Index(pos)
  local beAttackCnt = self._envPickUp.MonsterAttackPos[posIndex]
  if beAttackCnt then
    monsterVal = beAttackCnt * PopStarConst.MonsterAttackParam
  end
  local posVal = chainAttackVal - monsterVal
  if self._envPickUp.Mvp then
    if posVal > self._envPickUp.Mvp[2] then
      self._envPickUp.Mvp = {pos, posVal}
    end
  else
    self._envPickUp.Mvp = {pos, posVal}
  end
end

function AutoFightService:_GetConnectPieces(gridPos)
  local popStarLSvc = self._world:GetService("PopStarProLogic")
  return popStarLSvc:CalculatePopStarConnectPieces(gridPos)
end

function AutoFightService:_GetCanPickUpPosList(monsterEntity)
  local boardService = self._world:GetService("BoardLogic")
  local ringMax = boardService:GetCurBoardMaxLen()
  local utilDataSvc = self._world:GetService("UtilData")
  local resPosList = {}
  for ringNum = 1, ringMax do
    local squareRingPosList = self:GetPosListAroundBodyArea(monsterEntity, ringNum)
    if squareRingPosList and 0 < #squareRingPosList then
      for _, pos in ipairs(squareRingPosList) do
        if utilDataSvc:IsHaveEntity(pos, EnumTargetEntity.Pet) or not utilDataSvc:IsPosBlock(pos, BlockFlag.LinkLine) then
          table.insert(resPosList, pos)
        end
      end
    end
    if 0 < #resPosList then
      return resPosList
    end
  end
  return resPosList
end

function AutoFightService:_CalcChainAttackVal(skillPos, chainCount, pieceType)
  local outPetEntities = self._envPickUp.PieceTypeOutPets[pieceType]
  if outPetEntities == nil or #outPetEntities == 0 then
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
  local chainAttackVal = 0
  for _, value in ipairs(outPetEntities) do
    local e = value.petEntity
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
      local targetEntityIDArray = targetSelector:DoSelectSkillTarget(e, skillTargetType, scopeResult, chainSkillID)
      local hitCnt = 0
      for _, targetID in ipairs(targetEntityIDArray) do
        local targetEntity = self._world:GetEntityByID(targetID)
        if targetEntity and targetEntity:HasBuff() and buffLogicSvc:CheckCanBeMagicAttack(e, targetEntity) then
          hitCnt = hitCnt + 1
        end
      end
      local petVal = 0
      if value.priMatch and value.secMatch then
        petVal = PopStarConst.PrimaryParam
      elseif value.priMatch then
        petVal = PopStarConst.PrimaryParam
      elseif value.secMatch then
        petVal = PopStarConst.SecondaryParam
      end
      chainAttackVal = chainAttackVal + petVal * hitCnt
    end
  end
  local t2 = os.clock()
  Log.debug("[AutoFight] _CalcChainAttackCount() pos=", Vector2.Pos2Index(skillPos), " use time=", (t2 - t1) * 1000)
  return chainAttackVal
end
