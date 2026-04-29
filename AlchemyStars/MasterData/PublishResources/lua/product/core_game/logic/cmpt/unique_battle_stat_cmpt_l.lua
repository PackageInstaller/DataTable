_class("BattleStatComponent", Object)
BattleStatComponent = BattleStatComponent

function BattleStatComponent:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
  self._curWaveIndex = 1
  self._totalWaveCount = 0
  self._isSuperChain = false
  self._isAuroraTime = false
  self._isReEnterAuroraTime = false
  self._pieceRefreshCount = 0
  self._levelLeftRoundCount = 0
  self._levelInitRound = 0
  self._levelTotalRoundCount = 1
  self._levelSupplementRoundCount = 0
  self._curWaveInitRound = 0
  self._curWaveTotalRoundCount = 1
  self._curWaveLeftRoundCount = 0
  self._curWavePunishmentRoundCount = 0
  self._superChainCount = 0
  self._activeSkillCount = 0
  self._chainSkillCount = 0
  self._colorSkillCount = 0
  self._oneActiveSkillKillCount = 0
  self._oneChainMaxNormalAttack = 0
  self._oneChainKillCount = 0
  self._oneMatchMaxNum = {
    one_match_num = 0,
    element_type = PieceType.None
  }
  self._totalMatchNum = 0
  self._totalElementMatchNum = {}
  self._totalElementMatchNum[ElementType.ElementType_Blue] = 0
  self._totalElementMatchNum[ElementType.ElementType_Red] = 0
  self._totalElementMatchNum[ElementType.ElementType_Green] = 0
  self._totalElementMatchNum[ElementType.ElementType_Yellow] = 0
  self._curWaveDeadMonsterIDArray = {}
  self._curWaveDeadMonsterParam = {}
  self._totalDeadMonsterIDArray = {}
  self._killBossCount = 0
  self._playerBeHitCount = 0
  self._curWaveHasDeadRefreshMonsterState = false
  self._isLastWave = false
  self._matchResult = {}
  self._star3Progress = {}
  self._collectDropNum = 0
  self._dropRoleAssetList = {}
  self._dropRoleAssetNoDoubleList = {}
  self._totalDropAssets = {}
  self._battleLevelResult = false
  self._battleWaveResult = false
  self._curChainIndex = 1
  self._totalChainNum = 0
  self._deadMonsterShowBannerList = {}
  self._battleResult = nil
  self._lastDoActiveSkillRound = {}
  self._petDoActiveSkillRecord = {}
  self._takeAttackTimesByTrap = {}
  self._takeAttackDamageByTrap = {}
  self._smashTrapCount = {}
  self._AssignWaveResult = false
  self._curWaveAllMonsterDeadTimes = 0
  self._everAutoFight = 0
  self._autoFight = false
  self._auroraTimeCount = 0
  self._changeTeamLeaderNum = 0
  self._passiveChangeTeamLeaderNum = 0
  self.m_listSummonMonsterID = {}
  self.m_nAutoSummon_Index = 0
  self.m_nAutoSummon_TeamIndex = 0
  self.m_listAutoSummon = SortedArray:New(Algorithm.COMPARE_CUSTOM, BattleStatComponent._LessComparerByRefreshID)
  self.m_listAutoSummon:AllowDuplicate()
  self.m_nAutoSummonLevel = 0
  self._triggerDimensionFlag = TriggerDimensionFlag.None
  self._normalAttackKillCount = 0
  self._firstDeadPetEntity = nil
  self._deadPetList = {}
  self._damageIndex = 0
  self._exChangeBuffMap = {}
  self._roundCount = 0
  self._waitInputCount = 0
  self._handleShumolHPUI = 0
  self._firstWaveMonsterIDList = {}
  self._firstWaveTrapIDList = {}
  self._roundBeginPlayerPos = Vector2.zero
  self._passWaveList = {}
  self._monsterBeHitDamageValue = {}
  self._lastAntiTriggerEntityID = 0
  self._mazeAddLight = 0
  self._lastActiveSkillID = 0
  self._lastActiveSkillCasterID = 0
  self._waveEnterRound = {}
  self._curWaveDeadMonsterBuffTable = {}
  self._totalDeadMonsterBuffTable = {}
  self._collectDropNumItemIDDic = {}
  self._playerSkillHitCount = {}
  self._chessDeadPlayerPawnCount = 0
  self._chessDeadPlayerPawnIDChecker = {}
  self._curRoundDoActiveSkillTimes = {}
  self._isPunishmentRoundExecuted = {}
  self._deadMarkAddCount = 0
  self._monsterEscapeNum = 0
  self._pushCommandIndex = 0
  self._isCastChainByDimensionDoor = false
  self._waveRelicIDDic = {}
  self._wavePartnerDic = {}
  self._relicGroupInvalidIDDic = {}
  self._waveOptionalPartnerListDic = {}
  self._wavePartnerAbandonedList = {}
  self._waveRelicIDList = {}
  self._wavePartnerIDList = {}
  self._waveWaitApplyRelicID = 0
  self._waveWaitApplyRelicIsOpening = false
  self._waveWaitApplyPartnerID = 0
  self._allLocalTeamScanTrapIDInMatch = {}
  self._trapIDBySummonCasterEntityID = {}
  self._combinedConditionRecords = {}
  self._mainWorldBossID = nil
  self._createMonsterClassIDRecord = {}
  self._createMonsterIDRecord = {}
  self._monsterKilledRecordData = {}
  self._monsterKilledCount = 0
  self._monsterMoveGroupID = 0
end

function BattleStatComponent:GeneMonsterMoveGroupID()
  self._monsterMoveGroupID = self._monsterMoveGroupID + 1
  return self._monsterMoveGroupID
end

function BattleStatComponent:AddMonsterClassIDCreate(monsterClassID)
  if monsterClassID then
    self._createMonsterClassIDRecord[monsterClassID] = (self._createMonsterClassIDRecord[monsterClassID] or 0) + 1
  end
end

function BattleStatComponent:GetMonsterClassIDCount(monsterClassID)
  return self._createMonsterClassIDRecord[monsterClassID] or 0
end

function BattleStatComponent:AddMonsterIDCreate(monsterID)
  if monsterID then
    self._createMonsterIDRecord[monsterID] = (self._createMonsterIDRecord[monsterID] or 0) + 1
  end
end

function BattleStatComponent:GetMonsterIDCount(monsterID)
  return self._createMonsterIDRecord[monsterID] or 0
end

function BattleStatComponent:SetCastChainByDimensionDoorState(state)
  self._isCastChainByDimensionDoor = state
end

function BattleStatComponent:IsCastChainByDimensionDoor()
  return self._isCastChainByDimensionDoor
end

function BattleStatComponent:ClearCastChainByDimensionDoorState()
  self._isCastChainByDimensionDoor = false
end

function BattleStatComponent:IsPunishmentRoundExecuted(punishmentRoundCount)
  return self._isPunishmentRoundExecuted[punishmentRoundCount]
end

function BattleStatComponent:MarkPunishmentRoundExecuted(punishmentRoundCount)
  self._isPunishmentRoundExecuted[punishmentRoundCount] = true
end

function BattleStatComponent:FetchNewDeadMarkAddCount()
  self._deadMarkAddCount = self._deadMarkAddCount + 1
  return self._deadMarkAddCount
end

function BattleStatComponent:AddPlayerSkillHitCount(skillID)
  if not skillID then
    return
  end
  if not self._playerSkillHitCount[skillID] then
    self._playerSkillHitCount[skillID] = 0
  end
  self._playerSkillHitCount[skillID] = self._playerSkillHitCount[skillID] + 1
end

function BattleStatComponent:GetPlayerSkillHitCount(skillID)
  return self._playerSkillHitCount[skillID] or 0
end

function BattleStatComponent:SetChessDeadPlayerPawnCount(t)
  for _, id in ipairs(t) do
    self._chessDeadPlayerPawnIDChecker[id] = true
  end
  local v = 0
  for id, _ in pairs(self._chessDeadPlayerPawnIDChecker) do
    v = v + 1
  end
  self._chessDeadPlayerPawnCount = v
end

function BattleStatComponent:GetChessDeadPlayerPawnCount()
  return self._chessDeadPlayerPawnCount
end

function BattleStatComponent:SetHandleShumolHPUI(val)
  self._handleShumolHPUI = val
end

function BattleStatComponent:GetHandleShumolHPUI()
  return self._handleShumolHPUI
end

function BattleStatComponent:IncWaitInputCount()
  self._waitInputCount = self._waitInputCount + 1
end

function BattleStatComponent:GetWaitInputCount()
  return self._waitInputCount
end

function BattleStatComponent:IncGameRoundCount()
  self._roundCount = self._roundCount + 1
  return self._roundCount
end

function BattleStatComponent:GetGameRoundCount()
  return self._roundCount
end

function BattleStatComponent:GetDamageIndex()
  self._damageIndex = self._damageIndex + 1
  return self._damageIndex
end

function BattleStatComponent:IncPushCommandIndex()
  self._pushCommandIndex = self._pushCommandIndex + 1
  return self._pushCommandIndex
end

function BattleStatComponent:GetPushCommandIndex()
  return self._pushCommandIndex
end

function BattleStatComponent._LessComparerByRefreshID(dataA, dataB)
  local nCompare = dataB.m_nRefreshID - dataA.m_nRefreshID
  return nCompare
end

function BattleStatComponent:Destructor()
end

function BattleStatComponent:Initialize()
end

function BattleStatComponent:SetFirstDeadPetEntity(pet)
  self._firstDeadPetEntity = pet
end

function BattleStatComponent:GetFirstDeadPetEntity()
  return self._firstDeadPetEntity
end

function BattleStatComponent:SetTotalWaveCount(waveCount)
  self._totalWaveCount = waveCount
end

function BattleStatComponent:GetTotalWaveCount()
  return self._totalWaveCount
end

function BattleStatComponent:IsCurWaveHasDeadRefreshMonster()
  return self._curWaveHasDeadRefreshMonsterState
end

function BattleStatComponent:SetCurWaveHasDeadRefreshMonsterState(state)
  self._curWaveHasDeadRefreshMonsterState = state
end

function BattleStatComponent:AddDeadMonsterID(monsterID)
  local monsterDeadParam = MonsterDeadParam:New(monsterID, self:GetCurWaveIndex(), self:GetCurWaveTotalRoundCount())
  table.insert(self._curWaveDeadMonsterIDArray, monsterID)
  table.insert(self._curWaveDeadMonsterParam, monsterDeadParam)
  table.insert(self._totalDeadMonsterIDArray, monsterDeadParam)
  local cfg = self._world:GetService("Config")
  local isBoss = cfg:GetMonsterConfigData():IsBoss(monsterID)
  if isBoss then
    self._killBossCount = self._killBossCount + 1
    Log.notice("BattleStatComponent:AddDeadMonsterID() - Boss count=", self._killBossCount)
  end
end

function BattleStatComponent:IsMonsterHasDead(monsterID)
  for _, v in ipairs(self._totalDeadMonsterIDArray) do
    if v:GetMonsterID() == monsterID then
      return true
    end
  end
  return false
end

function BattleStatComponent:GetCurWaveDeadMonsterIDList()
  return self._curWaveDeadMonsterIDArray
end

function BattleStatComponent:GetCurWaveDeadMonsterParam()
  return self._curWaveDeadMonsterParam
end

function BattleStatComponent:GetTotalDeadMonsterIDList()
  return self._totalDeadMonsterIDArray
end

function BattleStatComponent:_ClearCurWaveDeadMonsterIDList()
  self._curWaveDeadMonsterIDArray = {}
end

function BattleStatComponent:_ClearCurWaveDeadMonsterParam()
  self._curWaveDeadMonsterParam = {}
end

function BattleStatComponent:GetCurWaveIndex()
  return self._curWaveIndex
end

function BattleStatComponent:GetCurWaveRound()
  return self._curWaveLeftRoundCount
end

function BattleStatComponent:SetLevelRound(roundCount)
  self._levelInitRound = roundCount
  self._levelLeftRoundCount = roundCount
end

function BattleStatComponent:InitLevelRound(roundCount)
  self:SetLevelRound(roundCount)
  self._levelTotalRoundCount = 1
end

function BattleStatComponent:GetMazeAddLight()
  return self._mazeAddLight
end

function BattleStatComponent:MazeAddLight(value)
  self._mazeAddLight = self._mazeAddLight + value
end

function BattleStatComponent:InitCurWaveAllMonsterDeadTimes()
  self._curWaveAllMonsterDeadTimes = 0
end

function BattleStatComponent:AddCurWaveAllmonsterDeadTimes()
  self._curWaveAllMonsterDeadTimes = self._curWaveAllMonsterDeadTimes + 1
end

function BattleStatComponent:GetCurWaveAllMonsterDeadTimes()
  return self._curWaveAllMonsterDeadTimes
end

function BattleStatComponent:InitCurWaveRound(roundCount)
  self:SetCurWaveRound(roundCount)
  self._curWaveTotalRoundCount = 1
  self._curWavePunishmentRoundCount = 0
end

function BattleStatComponent:GetLevelTotalRoundCount()
  return self._levelTotalRoundCount
end

function BattleStatComponent:GetLevelLeftRoundCount()
  return self._levelLeftRoundCount
end

function BattleStatComponent:IsFirstRound()
  return self._levelTotalRoundCount == 1
end

function BattleStatComponent:GetPieceRefreshCount()
  return self._pieceRefreshCount
end

function BattleStatComponent:AddPieceRefreshCount(cnt)
  self._pieceRefreshCount = self._pieceRefreshCount + cnt
end

function BattleStatComponent:GetLevelSupplementRoundCount()
  return self._levelSupplementRoundCount
end

function BattleStatComponent:SetLevelSupplementRoundCount(roundCount)
  self._levelSupplementRoundCount = roundCount
end

function BattleStatComponent:SetCurWaveRound(roundCount)
  self._curWaveLeftRoundCount = roundCount
  self._curWaveInitRound = roundCount
end

function BattleStatComponent:SubLevelRound(count)
  self._levelTotalRoundCount = self._levelTotalRoundCount + 1
  if self._levelLeftRoundCount ~= 0 then
    if count <= self._levelLeftRoundCount then
      self._levelLeftRoundCount = self._levelLeftRoundCount - count
    else
      Log.fatal("left_trun_count: " .. self._levelLeftRoundCount .. "not enough to sub:；" .. count)
    end
  end
end

function BattleStatComponent:SubCurWaveRound(count)
  self._curWaveTotalRoundCount = self._curWaveTotalRoundCount + 1
  if self._curWaveLeftRoundCount ~= 0 then
    if count <= self._curWaveLeftRoundCount then
      self._curWaveLeftRoundCount = self._curWaveLeftRoundCount - count
    else
      Log.fatal("left_trun_count: " .. self._curWaveLeftRoundCount .. "not enough to sub:；" .. count)
    end
  end
  if self._curWaveLeftRoundCount == 0 then
    self._curWavePunishmentRoundCount = self._curWavePunishmentRoundCount + 1
  end
  if self._world:MatchType() == MatchType.MT_Maze then
    local mazeService = self._world:GetService("Maze")
    mazeService:UseLight()
  end
  if self._world:MatchType() == MatchType.MT_SeasonMaze then
    local seasonMazeService = self._world:GetService("SeasonMaze")
    seasonMazeService:UseMs()
  end
  self:SubLevelRound(count)
  return self._curWaveLeftRoundCount
end

function BattleStatComponent:GetCurWavePunishmentRoundCount()
  return self._curWavePunishmentRoundCount
end

function BattleStatComponent:GetCurWaveTotalRoundCount()
  return self._curWaveTotalRoundCount
end

function BattleStatComponent:SetCurWaveTotalRoundCount(cnt)
  self._curWaveTotalRoundCount = cnt
end

function BattleStatComponent:SubCurWaveRoundByEffect(count)
  if self._curWaveLeftRoundCount ~= 0 then
    if count <= self._curWaveLeftRoundCount then
      self._curWaveLeftRoundCount = self._curWaveLeftRoundCount - count
    else
      Log.warn("left_trun_count: " .. self._curWaveLeftRoundCount .. "not enough to sub:；" .. count)
    end
  end
  if self._world:MatchType() == MatchType.MT_Maze then
    Log.exception(self._className, "通过逻辑效果扣除额外当前回合数的逻辑不能用在秘境规则内，请对过需求后实现这一分支。")
    return self._curWaveLeftRoundCount
  end
  if self._levelLeftRoundCount ~= 0 then
    if count <= self._levelLeftRoundCount then
      self._levelLeftRoundCount = self._levelLeftRoundCount - count
    else
      Log.warn("left_trun_count: " .. self._levelLeftRoundCount .. "not enough to sub:；" .. count)
    end
  end
  return self._curWaveLeftRoundCount
end

function BattleStatComponent:MoveToNextWave()
  self._curWaveIndex = self._curWaveIndex + 1
  self:_ClearCurWaveDeadMonsterIDList()
  self:_ClearCurWaveDeadMonsterParam()
  self:SetCurWaveHasDeadRefreshMonsterState(false)
  self._waveEnterRound[self._curWaveIndex] = self._curWaveLeftRoundCount
end

function BattleStatComponent:GetCurChainIndex()
  return self._curChainIndex
end

function BattleStatComponent:AddChainIndex()
  self._curChainIndex = self._curChainIndex + 1
end

function BattleStatComponent:ResetChainIndex()
  self._curChainIndex = 1
end

function BattleStatComponent:MoveToNextRound(roundCount)
  if not roundCount then
    return self:SubCurWaveRound(1)
  else
    return self:SubCurWaveRound(roundCount)
  end
end

function BattleStatComponent:GetLeftBlood()
  local heroEntity = self._world:Player():GetLocalTeamEntity()
  if heroEntity == nil then
    return 0
  end
  local attrCmpt = heroEntity:Attributes()
  local hp = attrCmpt:GetCurrentHP()
  local maxhp = attrCmpt:CalcMaxHp()
  local blood = hp / maxhp
  return blood
end

function BattleStatComponent:IsFullBlood()
  local heroEntity = self._world:Player():GetLocalTeamEntity()
  if heroEntity == nil then
    return 0
  end
  local attrCmpt = heroEntity:Attributes()
  local hp = attrCmpt:GetCurrentHP()
  local maxhp = attrCmpt:CalcMaxHp()
  return hp == maxhp
end

function BattleStatComponent:GetPlayerHP()
  local heroEntity = self._world:Player():GetLocalTeamEntity()
  if heroEntity == nil then
    return 0
  end
  local attrCmpt = heroEntity:Attributes()
  local hp = attrCmpt:GetCurrentHP()
  return hp
end

function BattleStatComponent:GetSuperChainCount()
  return self._superChainCount
end

function BattleStatComponent:GetActiveSkillCount()
  return self._activeSkillCount
end

function BattleStatComponent:GetChainSkillCount()
  return self._chainSkillCount
end

function BattleStatComponent:GetColorSkillCount()
  return self._colorSkillCount
end

function BattleStatComponent:GetKillBossCount()
  return self._killBossCount
end

function BattleStatComponent:GetKillMonsterCount()
  return #self._totalDeadMonsterIDArray
end

function BattleStatComponent:GetOneMatchMaxNum()
  return self._oneMatchMaxNum.one_match_num
end

function BattleStatComponent:GetOneMatchMaxNumType()
  return self._oneMatchMaxNum.element_type
end

function BattleStatComponent:GetTotalMatchNum()
  return self._totalMatchNum
end

function BattleStatComponent:GetElementMatchNum()
  return self._totalElementMatchNum
end

function BattleStatComponent:GetOneActiveSkillKillCount()
  return self._oneActiveSkillKillCount
end

function BattleStatComponent:GetOneChainKillCount()
  return self._oneChainKillCount
end

function BattleStatComponent:GetOneChainNormalAttackCount()
  return self._oneChainMaxNormalAttack
end

function BattleStatComponent:AddSuperChainCount(teamEntity)
  if not self:_IsLocalTeam(teamEntity) then
    return
  end
  self._superChainCount = self._superChainCount + 1
end

function BattleStatComponent:AddAuroraTimeCount()
  if self._isAuroraTime then
    self._auroraTimeCount = self._auroraTimeCount + 1
  end
end

function BattleStatComponent:GetAuroraTimeCount()
  return self._auroraTimeCount
end

function BattleStatComponent:SetRoundSuperChain(spc)
  self._isSuperChain = spc
end

function BattleStatComponent:IsRoundSuperChain()
  return self._isSuperChain
end

function BattleStatComponent:SetRoundChainPath(chainPath)
  self._chainPath = chainPath
end

function BattleStatComponent:GetRoundChainPath()
  return self._chainPath
end

function BattleStatComponent:SetRoundAuroraTime(value)
  self._isAuroraTime = value
  if value then
    self._world:GetDataLogger():AddDataLog("OnAuroraStart")
  else
    self._world:GetDataLogger():AddDataLog("OnAuroraEnd")
  end
end

function BattleStatComponent:IsRoundAuroraTime()
  return self._isAuroraTime
end

function BattleStatComponent:SetReEnterAuroraTime(value)
  self._isReEnterAuroraTime = value
end

function BattleStatComponent:IsReEnterAuroraTime()
  return self._isReEnterAuroraTime
end

function BattleStatComponent:AddActiveSkillCount(teamEntity)
  if not self:_IsLocalTeam(teamEntity) then
    return
  end
  self._activeSkillCount = self._activeSkillCount + 1
end

function BattleStatComponent:AddChainSkillCount(teamEntity, addCount)
  if not self:_IsLocalTeam(teamEntity) then
    return
  end
  self._chainSkillCount = self._chainSkillCount + addCount
end

function BattleStatComponent:AddColorSkillCount(teamEntity)
  if not self:_IsLocalTeam(teamEntity) then
    return
  end
  self._colorSkillCount = self._colorSkillCount + 1
end

function BattleStatComponent:StatisticsColorSkillCount(teamEntity, skillEffectType)
  if skillEffectType == SkillEffectType.ConvertGridElement or skillEffectType == SkillEffectType.ManualConvert or skillEffectType == SkillEffectType.ResetGridElement or skillEffectType == SkillEffectType.PullAround or skillEffectType == SkillEffectType.Teleport or skillEffectType == SkillEffectType.HitBack then
    self:AddColorSkillCount(teamEntity)
    return true
  end
  return false
end

function BattleStatComponent:SetOneActiveSkillKillCount(teamEntity, cnt)
  if not self:_IsLocalTeam(teamEntity) then
    return
  end
  if cnt > self._oneActiveSkillKillCount then
    self._oneActiveSkillKillCount = cnt
  end
end

function BattleStatComponent:SetOneChainKillCount(teamEntity, cnt)
  if not self:_IsLocalTeam(teamEntity) then
    return
  end
  if cnt > self._oneChainKillCount then
    self._oneChainKillCount = cnt
  end
end

function BattleStatComponent:SetOneChainMaxNormalAttack(teamEntity, cnt)
  if not self:_IsLocalTeam(teamEntity) then
    return
  end
  if cnt > self._oneChainMaxNormalAttack then
    self._oneChainMaxNormalAttack = cnt
  end
end

function BattleStatComponent:AddTakeAttackTimesByTrap(trapId, cnt)
  if not self._takeAttackTimesByTrap[trapId] then
    self._takeAttackTimesByTrap[trapId] = cnt
  else
    self._takeAttackTimesByTrap[trapId] = self._takeAttackTimesByTrap[trapId] + cnt
  end
end

function BattleStatComponent:GetTakeAttackTimesByTrap()
  return self._takeAttackTimesByTrap
end

function BattleStatComponent:AddTakeAttackDamageByTrap(trapId, damage)
  if not self._takeAttackDamageByTrap[trapId] then
    self._takeAttackDamageByTrap[trapId] = damage
  else
    self._takeAttackDamageByTrap[trapId] = self._takeAttackDamageByTrap[trapId] + damage
  end
end

function BattleStatComponent:GetTakeAttackDamageByTrap()
  return self._takeAttackDamageByTrap
end

function BattleStatComponent:AddSmashTrapCount(trapId, count)
  if not self._smashTrapCount[trapId] then
    self._smashTrapCount[trapId] = count
  else
    self._smashTrapCount[trapId] = self._smashTrapCount[trapId] + count
  end
end

function BattleStatComponent:GetSmashTrapCount()
  return self._smashTrapCount
end

function BattleStatComponent:SetOneMatchMaxNum(teamEntity, elementType, matchNum)
  if not self:_IsLocalTeam(teamEntity) then
    return
  end
  local curElementNum = self._totalElementMatchNum[elementType]
  if not curElementNum then
    Log.fatal("格子颜色" .. elementType .. "的连线统计信息未初始化！")
    return
  end
  if matchNum > self._oneMatchMaxNum.one_match_num then
    self._oneMatchMaxNum.one_match_num = matchNum
    self._oneMatchMaxNum.element_type = elementType
  end
  self._totalMatchNum = self._totalMatchNum + matchNum
  self._totalElementMatchNum[elementType] = curElementNum + matchNum
end

function BattleStatComponent:IsLastWave()
  local levelConfigData = self._configService:GetLevelConfigData()
  local maxWaveCount = levelConfigData:GetWaveCount()
  if maxWaveCount <= self._curWaveIndex then
    return true
  end
  return false
end

function BattleStatComponent:SetAssignWaveResult(bRefreshSpecialWave)
  if bRefreshSpecialWave == self._AssignWaveResult then
    return
  end
  if bRefreshSpecialWave == true then
    self._AssignWaveResult = true
  else
    self._AssignWaveResult = false
  end
end

function BattleStatComponent:AssignWaveResult()
  return self._AssignWaveResult
end

function BattleStatComponent:SetBonusMatchResult(matchResult)
  self._matchResult = matchResult
  self._world:EventDispatcher():Dispatch(GameEventType.ShowGuideCondition, self._matchResult)
end

function BattleStatComponent:Set3StarProgress(progressResult)
  self._star3Progress = progressResult
end

function BattleStatComponent:UpdateA3StarProgress(keyId, value)
  if keyId == nil then
    return
  end
  self._star3Progress[keyId] = value
  return
end

function BattleStatComponent:Get3StarProgress(conditionId)
  if conditionId == nil then
    Log.fatal("未找到三星条件进度 id：", conditionId)
    return ""
  end
  local retStr = self._star3Progress[conditionId]
  if retStr == nil then
    Log.fatal("此时尚未结算三星进度")
    return ""
  end
  return retStr
end

function BattleStatComponent:GetBonusMatchResult()
  return self._matchResult
end

function BattleStatComponent:IsRealZeroRound()
  if self:GetCurWaveRound() == 0 and self:GetCurWavePunishmentRoundCount() == 1 then
    return true
  end
  return false
end

function BattleStatComponent:LevelCompleteLimitAllRoundCount()
  local curLevelData = self._configService:GetLevelConfigData()
  local completeType = curLevelData:GetLevelCompleteConditionType()
  if CompleteConditionType.RoundCountLimit == completeType then
    local curRound = curLevelData:GetLevelRoundCount()
    local conditionParam = curLevelData:GetLevelCompleteConditionParams()[1]
    local configRound = conditionParam[1]
    return curRound == configRound
  elseif CompleteConditionType.AssignWaveAndRandomNextWave == completeType then
    return self:AssignWaveResult()
  elseif CompleteConditionType.RoundCountLimitAndCheckMonsterEscape == completeType then
    local curRound = curLevelData:GetLevelRoundCount()
    local conditionParam = curLevelData:GetLevelCompleteConditionParams()[1]
    local configRound = conditionParam[1]
    return curRound == configRound
  elseif CompleteConditionType.CombinedCompleteCondition == completeType then
    local curWaveIndex = self:GetCurWaveIndex()
    local cfgWave = curLevelData:GetWaveConfig(curWaveIndex)
    local combinedCompleteConditionArgs = cfgWave:GetCombinedCompleteConditionArguments()
    local typeA = combinedCompleteConditionArgs.conditionA
    local typeB = combinedCompleteConditionArgs.conditionB
    local paramA = combinedCompleteConditionArgs.conditionParamA
    local paramB = combinedCompleteConditionArgs.conditionParamB
    if typeA == CompleteConditionType.RoundCountLimit then
      local curRound = curLevelData:GetLevelRoundCount()
      return curRound == paramA[1][1]
    elseif typeA == CompleteConditionType.AssignWaveAndRandomNextWave then
      return self:AssignWaveResult()
    end
    if typeB == CompleteConditionType.RoundCountLimit then
      local curRound = curLevelData:GetLevelRoundCount()
      return curRound == paramB[1][1]
    elseif typeB == CompleteConditionType.AssignWaveAndRandomNextWave then
      return self:AssignWaveResult()
    end
  elseif CompleteConditionType.KillMoreThanPetMonster == completeType then
    local battleStatCmpt = self._world:BattleStat()
    local levelRoundCount = battleStatCmpt:GetLevelLeftRoundCount()
    return levelRoundCount == 0
  end
  return false
end

function BattleStatComponent:HasNextWave()
  local curWaveNum = self:GetCurWaveIndex()
  local levelConfigData = self._configService:GetLevelConfigData()
  local maxWaveCount = levelConfigData:GetWaveCount()
  if curWaveNum < maxWaveCount then
    return true
  end
  return false
end

function BattleStatComponent:AddTotalDropAssets(assetID, count)
  local asset = self._totalDropAssets[assetID]
  if not asset then
    asset = RoleAsset:New()
    asset.assetid = assetID
    asset.count = count
  else
    asset.count = asset.count + count
  end
  self._totalDropAssets[assetID] = asset
end

function BattleStatComponent:GetTotalDropAssets()
  return self._totalDropAssets
end

function BattleStatComponent:AddDropRoleAsset(assetid, count)
  self:AddTotalDropAssets(assetid, count)
  for k, v in ipairs(self._dropRoleAssetList) do
    if v.assetid == assetid then
      v.count = count + v.count
      return
    end
  end
  local asset = RoleAsset:New()
  asset.assetid = assetid
  asset.count = count
  table.insert(self._dropRoleAssetList, asset)
end

function BattleStatComponent:GetDropRoleAsset(assetID)
  if not assetID then
    return self._dropRoleAssetList
  end
  for k, v in ipairs(self._dropRoleAssetList) do
    if v.assetid == assetID then
      return v.count
    end
  end
  return 0
end

function BattleStatComponent:GetArchivedDrops()
  local drops = {}
  drops.noDoubleList = self._dropRoleAssetNoDoubleList
  drops.assetList = self._dropRoleAssetList
  drops.totalList = self._totalDropAssets
  return drops
end

function BattleStatComponent:SetArchivedDrops(drops)
  if not drops then
    return
  end
  self._dropRoleAssetList = drops.assetList
  self._dropRoleAssetNoDoubleList = drops.noDoubleList
  self._totalDropAssets = drops.totalList
end

function BattleStatComponent:AddDropRoleAssetNoDouble(assetid, count)
  self:AddTotalDropAssets(assetid, count)
  for k, v in ipairs(self._dropRoleAssetNoDoubleList) do
    if v.assetid == assetid then
      v.count = count + v.count
      return
    end
  end
  local asset = RoleAsset:New()
  asset.assetid = assetid
  asset.count = count
  table.insert(self._dropRoleAssetNoDoubleList, asset)
end

function BattleStatComponent:GetDropRoleAssetNoDouble(assetID)
  if not assetID then
    return self._dropRoleAssetNoDoubleList
  end
  for k, v in ipairs(self._dropRoleAssetNoDoubleList) do
    if v.assetid == assetID then
      return v.count
    end
  end
  return 0
end

function BattleStatComponent:CollectDrop(dropItemID)
  dropItemID = dropItemID or -1
  if not self._collectDropNumItemIDDic[dropItemID] then
    self._collectDropNumItemIDDic[dropItemID] = 0
  end
  self._collectDropNumItemIDDic[dropItemID] = self._collectDropNumItemIDDic[dropItemID] + 1
  self._collectDropNum = self._collectDropNum + 1
  return self._collectDropNum
end

function BattleStatComponent:GetDropCollectNum()
  return self._collectDropNum
end

function BattleStatComponent:GetDropCollectNumByItemID(itemID)
  itemID = itemID or -1
  return self._collectDropNumItemIDDic[itemID] or 0
end

function BattleStatComponent:SetDropCollectNum(num)
  self._collectDropNum = num
end

function BattleStatComponent:SetBattleLevelResult(battleLevelResult)
  self._battleLevelResult = battleLevelResult
end

function BattleStatComponent:GetBattleLevelResult()
  return self._battleLevelResult
end

function BattleStatComponent:SetBattleWaveResult(battleWaveResult)
  self._battleWaveResult = battleWaveResult
  self._passWaveList[self:GetCurWaveIndex()] = battleWaveResult
end

function BattleStatComponent:GetBattleWaveResult()
  return self._battleWaveResult
end

function BattleStatComponent:IsMonsterShowBannerCurWave(monsterID)
  local wave = self:GetCurWaveIndex()
  if not self._deadMonsterShowBannerList[wave] then
    return false
  else
    local deadList = self._deadMonsterShowBannerList[wave]
    return table.icontains(deadList, monsterID)
  end
end

function BattleStatComponent:AddDeadMonsterShowBanner(monsterID)
  local wave = self:GetCurWaveIndex()
  if not self._deadMonsterShowBannerList[wave] then
    self._deadMonsterShowBannerList[wave] = {}
  end
  table.insert(self._deadMonsterShowBannerList[wave], monsterID)
end

function BattleStatComponent:GetCurWaveRoundNum()
  return self._curWaveTotalRoundCount
end

function BattleStatComponent:SetBattleMatchResult(matchResult)
  self._battleResult = matchResult
end

function BattleStatComponent:GetBattleMatchResult()
  return self._battleResult
end

function BattleStatComponent:GetAutoFight()
  return self._autoFight
end

function BattleStatComponent:SetAutoFight(autoFight)
  self._autoFight = autoFight or false
  self:SetEverAutoFight()
  if not autoFight then
    self._world:GetDataLogger():AddDataLog("OnCancelAutoFight")
  end
end

function BattleStatComponent:GetEverAutoFight()
  return self._everAutoFight
end

function BattleStatComponent:SetEverAutoFight()
  self._everAutoFight = 1
end

function BattleStatComponent:GetLastDoActiveSkillRound(petPstID, extraSkillIndex)
  local recordSkillIndex = extraSkillIndex or 0
  if not self._lastDoActiveSkillRound[petPstID] then
    return
  end
  return self._lastDoActiveSkillRound[petPstID][recordSkillIndex]
end

function BattleStatComponent:SetLastDoActiveSkillRound(petPstID, round, extraSkillIndex)
  local recordSkillIndex = extraSkillIndex or 0
  if not self._lastDoActiveSkillRound[petPstID] then
    self._lastDoActiveSkillRound[petPstID] = {}
  end
  self._lastDoActiveSkillRound[petPstID][recordSkillIndex] = round
end

function BattleStatComponent:GetCurRoundDoActiveSkillTimes(petPstID)
  return self._curRoundDoActiveSkillTimes[petPstID] or 0
end

function BattleStatComponent:RecordCurRoundDoActiveSkillTimes(petPstID)
  if self._curRoundDoActiveSkillTimes[petPstID] then
    local curTimes = self._curRoundDoActiveSkillTimes[petPstID]
    self._curRoundDoActiveSkillTimes[petPstID] = curTimes + 1
  else
    self._curRoundDoActiveSkillTimes[petPstID] = 1
  end
end

function BattleStatComponent:ClearCurRoundDoActiveSkillTimes()
  self._curRoundDoActiveSkillTimes = {}
end

function BattleStatComponent:GetPetDoActiveSkillRecord(petPstID, round)
  if not self._petDoActiveSkillRecord[petPstID] then
    return {}
  end
  return self._petDoActiveSkillRecord[petPstID][round]
end

function BattleStatComponent:SetPetDoActiveSkillRecord(petPstID, round, skillID)
  if not self._petDoActiveSkillRecord[petPstID] then
    self._petDoActiveSkillRecord[petPstID] = {}
  end
  if not self._petDoActiveSkillRecord[petPstID][round] then
    self._petDoActiveSkillRecord[petPstID][round] = {}
  end
  table.insert(self._petDoActiveSkillRecord[petPstID][round], skillID)
end

function BattleStatComponent:GuideShowStarTime(missionId)
  if missionId and 0 < missionId then
    if not self.starTimeLimitMissionId then
      self.starTimeLimitMissionId = Cfg.cfg_guide_const.guide_star_time_limit_mission.IntValue
    end
    return missionId > self.starTimeLimitMissionId
  else
    return true
  end
end

function BattleStatComponent:GetAutoSummonIndex()
  return self.m_nAutoSummon_Index
end

function BattleStatComponent:SetAutoSommonIndex(nIndex)
  self.m_nAutoSummon_Index = nIndex
end

function BattleStatComponent:GetAutoSummonMonsterList()
  return self.m_listSummonMonsterID
end

function BattleStatComponent:GetAutoSummonList()
  return self.m_listAutoSummon
end

function BattleStatComponent:GetAutoSummonLevel()
  return self.m_nAutoSummonLevel
end

function BattleStatComponent:SetAutoSummonLevel(nLevel)
  self.m_nAutoSummonLevel = nLevel
end

function BattleStatComponent:AddTotalChainNum()
  self._totalChainNum = self._totalChainNum + 1
end

function BattleStatComponent:GetTotalChainNum()
  return self._totalChainNum
end

_class("MSummonRefresh", Object)
MSummonRefresh = MSummonRefresh

function MSummonRefresh:Constructor(nRefreshID)
  self.m_nSummonIndex = 0
  self.m_nLevelID = self:_FindLevelID(nRefreshID)
  self.m_nRefreshID = nRefreshID
  self.m_nRefreshID_Monster = 0
  self.m_cfgRefreshMonster = nil
  self.m_nRefreshID_Trap = 0
  self.m_cfgRefreshTrap = nil
  self.m_stLevelName = ""
  self.m_nAutoAttack = nil
end

function MSummonRefresh:_FindLevelID(nRefreshID)
  local listLevelConfig = Cfg.cfg_level()
  for nLevelID, cfgLevel in pairs(listLevelConfig) do
    for key, nWaveID in ipairs(cfgLevel.MonsterWave) do
      if nWaveID == nRefreshID then
        return nLevelID
      end
    end
  end
end

function BattleStatComponent:_InitRefreshMonster(nRefreshID)
  local cfgRefreshMonster = Cfg.cfg_refresh_monster[nRefreshID]
  if cfgRefreshMonster then
    local levelMonsterRefreshParam = LevelMonsterRefreshParam:New(self._world)
    local listID = levelMonsterRefreshParam:ParseMonsterRefreshParam(cfgRefreshMonster)
    return levelMonsterRefreshParam
  end
  return nil
end

function BattleStatComponent:_InitRefreshTrap(nRefreshID)
  local cfgRefreshMonster = Cfg.cfg_refresh_trap[nRefreshID]
  if cfgRefreshMonster then
    local levelMonsterRefreshParam = LevelMonsterRefreshParam:New(self._world)
    local listSummon = levelMonsterRefreshParam:ParseTrapRefreshParam(cfgRefreshMonster)
    return levelMonsterRefreshParam
  end
  return nil
end

function BattleStatComponent:InitAutoSommonList(nMaxCount)
  local cfgService = self._world:GetService("Config")
  self.m_listAutoSummon:Clear()
  local cfgRefresh = Cfg.cfg_refresh()
  for key, value in pairs(cfgRefresh) do
    local nAutoSummon = value.AutoSummon
    if nAutoSummon and 0 < nAutoSummon then
      local listRefresh_Monster = value.TrapRefreshIDList
      local listRefresh_Trap = value.MonsterRefreshIDList
      local nMaxCount = math.max(table.count(listRefresh_Monster), table.count(listRefresh_Trap))
      for i = 1, nMaxCount do
        local refreshData = MSummonRefresh:New(key)
        refreshData.m_stLevelName = value.desc
        refreshData.m_nAutoAttack = value.AutoAttack or 0
        local nRefreshID_Monster = listRefresh_Monster[i]
        if nRefreshID_Monster then
          refreshData.m_nRefreshID_Monster = nRefreshID_Monster
          refreshData.m_cfgRefreshMonster = self:_InitRefreshMonster(nRefreshID_Monster)
        end
        local nRefreshID_Trap = listRefresh_Trap[i]
        if nRefreshID_Trap then
          refreshData.m_nRefreshID_Trap = nRefreshID_Trap
          refreshData.m_cfgRefreshTrap = self:_InitRefreshTrap(nRefreshID_Trap)
        end
        refreshData.m_nSummonIndex = table.count(self.m_listAutoSummon)
        self.m_listAutoSummon:Insert(refreshData)
      end
    end
  end
end

function BattleStatComponent:GetAutoSommonTeam()
  return self.m_nAutoSummon_TeamIndex
end

function BattleStatComponent:SetAutoSommonTeam(nIndex)
  self.m_nAutoSummon_TeamIndex = nIndex
end

function BattleStatComponent:GetTriggerDimensionFlag()
  return self._triggerDimensionFlag
end

function BattleStatComponent:SetTriggerDimensionFlag(flag)
  self._triggerDimensionFlag = flag
end

TriggerDimensionFlag = {
  None = 0,
  ChainAttack = 1,
  WaitInput = 2,
  RoundResult = 3
}

function BattleStatComponent:SetNormalAttackKillCount(count)
  self._normalAttackKillCount = count
end

function BattleStatComponent:GetNormalAttackKillCount()
  return self._normalAttackKillCount
end

function BattleStatComponent:GetTeamLeaderChangeNum()
  return self._changeTeamLeaderNum
end

function BattleStatComponent:AddTeamLeaderChangeNum()
  self._changeTeamLeaderNum = self._changeTeamLeaderNum + 1
end

function BattleStatComponent:GetPassiveTeamLeaderChangeNum()
  return self._passiveChangeTeamLeaderNum
end

function BattleStatComponent:AddPassiveTeamLeaderChangeNum()
  self._passiveChangeTeamLeaderNum = self._passiveChangeTeamLeaderNum + 1
end

function BattleStatComponent:SaveProtectTrap(trapId, pos, dir)
  if not self._protectTrap then
    self._protectTrap = {}
  end
  self._protectTrap[#self._protectTrap + 1] = {
    trapID = trapId,
    pos = pos,
    dir = dir
  }
end

function BattleStatComponent:GetSavedProtectTrap()
  return self._protectTrap
end

function BattleStatComponent:AddBuffIntensifyParam(intensifyParam)
  for _, param in ipairs(intensifyParam) do
    if not self._exChangeBuffMap[param.BuffID] then
      self._exChangeBuffMap[param.BuffID] = param
    else
      Log.fatal("Already Has Buff ExchangeConfig BuffID:", param.BuffID, "Trace:", Log.traceback())
    end
  end
end

function BattleStatComponent:GetBuffIntensifyParam(buffID)
  if self._exChangeBuffMap[buffID] then
    return self._exChangeBuffMap[buffID]
  end
end

function BattleStatComponent:AddBuffEquipRefineParam(intensifyParam)
  for _, param in ipairs(intensifyParam) do
    self._exChangeBuffMap[param.BuffID] = param
  end
end

function BattleStatComponent:AddPlayerBeHitCount(cnt)
  self._playerBeHitCount = self._playerBeHitCount + cnt
end

function BattleStatComponent:GetPlayerBeHitCount()
  return self._playerBeHitCount
end

function BattleStatComponent:SetHeroLastAttackMonster(t)
  self._heroLastAttackMonster = t
end

function BattleStatComponent:GetHeroLastAttackMonster()
  return self._heroLastAttackMonster
end

function BattleStatComponent:SetFirstWaveMonsterIDList(monsterEntityList)
  for _, entity in ipairs(monsterEntityList) do
    table.insert(self._firstWaveMonsterIDList, entity:GetID())
  end
end

function BattleStatComponent:GetFirstWaveMonsterIDList()
  return self._firstWaveMonsterIDList
end

function BattleStatComponent:SetFirstWaveTrapIDList(trapEntityList)
  for i, entity in ipairs(trapEntityList) do
    table.insert(self._firstWaveTrapIDList, entity:GetID())
  end
end

function BattleStatComponent:GetFirstWaveTrapIDList()
  return self._firstWaveTrapIDList
end

function BattleStatComponent:SetRoundBeginPlayerPos(pos)
  self._roundBeginPlayerPos = pos
end

function BattleStatComponent:GetRoundBeginPlayerPos()
  return self._roundBeginPlayerPos
end

function BattleStatComponent:IsWavePass(waveIndex)
  if waveIndex <= self._curWaveIndex then
    local waveResult = self._passWaveList[waveIndex]
    if not waveResult then
      Log.fatal("[SyncLog],type:", BattleFailedType.WavePassInvalid, " info:", "wave: ", waveIndex, " NotPass")
    end
    return waveResult
  end
  return false
end

function BattleStatComponent:AddMonsterBeHitDamageValue(entityID, value, skillID)
  if value > BattleConst.SingleDamageMaxValue then
    if EDITOR then
      Log.exception("[SyncLog],type:", BattleFailedType.SingleDamageTooLarge, " SingleDamageValue:", value, " SkillID:", skillID)
    else
      Log.fatal("[SyncLog],type:", BattleFailedType.SingleDamageTooLarge, " SingleDamageValue:", value, " SkillID:", skillID)
    end
    value = 0
  end
  if not self._monsterBeHitDamageValue[entityID] then
    self._monsterBeHitDamageValue[entityID] = 0
  end
  self._monsterBeHitDamageValue[entityID] = self._monsterBeHitDamageValue[entityID] + value
end

function BattleStatComponent:SubMonsterBeHitDamageValue(entityID, value)
  if not self._monsterBeHitDamageValue[entityID] then
    self._monsterBeHitDamageValue[entityID] = 0
  end
  self._monsterBeHitDamageValue[entityID] = self._monsterBeHitDamageValue[entityID] - value
end

function BattleStatComponent:GetTotalMonsterBeHitDamageValue()
  local totalDamage = 0
  for k, damage in pairs(self._monsterBeHitDamageValue) do
    totalDamage = damage + totalDamage
  end
  return totalDamage
end

function BattleStatComponent:GetMainWorldBossBeHitDamageValue()
  local mainWorldBossID = self:GetMainWorldBossID()
  if mainWorldBossID then
    local dmg = self:GetMonsterBeHitDamageValue(mainWorldBossID)
    return dmg
  else
    return 0
  end
end

function BattleStatComponent:GetMonsterBeHitDamageValue(entityID)
  local totalDamage = self._monsterBeHitDamageValue[entityID]
  return totalDamage or 0
end

function BattleStatComponent:SetLastAntiTriggerEntityID(id)
  self._lastAntiTriggerEntityID = id
end

function BattleStatComponent:GetLastAntiTriggerEntityID()
  return self._lastAntiTriggerEntityID
end

function BattleStatComponent:GetLastActiveSkillID()
  return self._lastActiveSkillID
end

function BattleStatComponent:SetLastActiveSkillID(activeSkillID)
  self._lastActiveSkillID = activeSkillID
end

function BattleStatComponent:GetLastActiveSkillCasterID()
  return self._lastActiveSkillCasterID
end

function BattleStatComponent:SetLastActiveSkillCasterID(casterID)
  self._lastActiveSkillCasterID = casterID
end

function BattleStatComponent:GetCurWaveEnterRound()
  return self._waveEnterRound[self._curWaveIndex]
end

function BattleStatComponent:GetCurWaveTotalRound()
  return self._curWaveLeftRoundCount - self._waveEnterRound[self._curWaveIndex]
end

function BattleStatComponent:AddDeadMonsterBuffInfo(entity)
  local cBuff = entity:BuffComponent()
  local tBuffInstance = cBuff:GetBuffArray()
  local tBuffID = {}
  for _, ins in ipairs(tBuffInstance) do
    if not ins:IsUnload() then
      table.insert(tBuffID, ins:BuffID())
    end
  end
  local monsterID = entity:MonsterID():GetMonsterID()
  local buffInfo = {
    entityID = entity:GetID(),
    buffIDs = tBuffID
  }
  if not self._curWaveDeadMonsterBuffTable[monsterID] then
    self._curWaveDeadMonsterBuffTable[monsterID] = {}
  end
  table.insert(self._curWaveDeadMonsterBuffTable, buffInfo)
  if not self._totalDeadMonsterBuffTable[monsterID] then
    self._totalDeadMonsterBuffTable[monsterID] = {}
  end
  table.insert(self._totalDeadMonsterBuffTable[monsterID], buffInfo)
end

function BattleStatComponent:GetTotalDeadMonsterBuffInfo()
  return self._totalDeadMonsterBuffTable
end

function BattleStatComponent:SetWaveChooseRelic(waveIndex, relicID)
  if not self._waveRelicIDDic[waveIndex] then
    self._waveRelicIDDic[waveIndex] = relicID
    table.insert(self._waveRelicIDList, relicID)
  else
    Log.error("MiniMaze 波次圣物已设置完毕")
  end
end

function BattleStatComponent:SetChooseRelic(relicID)
  table.insert(self._waveRelicIDList, relicID)
end

function BattleStatComponent:GetWaveChooseRelic(waveIndex)
  return self._waveRelicIDDic[waveIndex] or 0
end

function BattleStatComponent:GetAllMiniMazeRelicList()
  local relicIDArray = table.cloneconf(self._waveRelicIDList)
  return relicIDArray
end

function BattleStatComponent:SetWaveChoosePartner(waveIndex, partner)
  if not self._wavePartnerDic[waveIndex] then
    self._wavePartnerDic[waveIndex] = partner
    table.insert(self._wavePartnerIDList, partner)
  else
    Log.error("MiniMaze 波次伙伴已设置完毕")
  end
end

function BattleStatComponent:GetWaveChoosePartner(waveIndex)
  return self._wavePartnerDic[waveIndex] or 0
end

function BattleStatComponent:GetAllMiniMazePartnerList()
  local array = table.cloneconf(self._wavePartnerIDList)
  return array
end

function BattleStatComponent:SetWaveOptionalPartnerIDList(waveIndex, partnerIDList)
  if not self._waveOptionalPartnerListDic[waveIndex] then
    self._waveOptionalPartnerListDic[waveIndex] = partnerIDList
  else
  end
end

function BattleStatComponent:GetWaveOptionalPartnerIDList(waveIndex)
  return self._waveOptionalPartnerListDic[waveIndex]
end

function BattleStatComponent:SetInvalidRelicIDList(groupID, relicIDList)
  if not self._relicGroupInvalidIDDic[groupID] then
    self._relicGroupInvalidIDDic[groupID] = {}
  end
  table.appendArray(self._relicGroupInvalidIDDic[groupID], relicIDList)
end

function BattleStatComponent:GetInvalidRelicIDList(groupID)
  local invalidArray = self._relicGroupInvalidIDDic[groupID]
  local cloneArray = table.cloneconf(invalidArray)
  return cloneArray
end

function BattleStatComponent:AddAbandonedPartnerIDList(partnerIDList)
  for _, partnerID in ipairs(partnerIDList) do
    table.insert(self._wavePartnerAbandonedList, partnerID)
  end
end

function BattleStatComponent:GetAbandonedPartnerIDList()
  return self._wavePartnerAbandonedList
end

function BattleStatComponent:SetWaveWaitApplyAward(relicID, isOpening, partnerID)
  self._waveWaitApplyRelicID = relicID
  self._waveWaitApplyRelicIsOpening = isOpening
  self._waveWaitApplyPartnerID = partnerID
end

function BattleStatComponent:GetWaveWaitApplyAward()
  return self._waveWaitApplyRelicID, self._waveWaitApplyRelicIsOpening, self._waveWaitApplyPartnerID
end

function BattleStatComponent:ClearWaveWaitApplyAward()
  self._waveWaitApplyRelicID = 0
  self._waveWaitApplyRelicIsOpening = false
  self._waveWaitApplyPartnerID = 0
end

function BattleStatComponent:AddScanTrapIDInMatch(id)
  if not table.icontains(self._allLocalTeamScanTrapIDInMatch, id) then
    table.insert(self._allLocalTeamScanTrapIDInMatch, id)
  end
end

function BattleStatComponent:GetAllScanTrapIDInMatch()
  return self._allLocalTeamScanTrapIDInMatch
end

function BattleStatComponent:AddTrapIDByCasterEntityID(trapID, casterEntityID)
  if not self._trapIDBySummonCasterEntityID[casterEntityID] then
    self._trapIDBySummonCasterEntityID[casterEntityID] = {}
  end
  if not table.icontains(self._trapIDBySummonCasterEntityID[casterEntityID], trapID) then
    table.insert(self._trapIDBySummonCasterEntityID[casterEntityID], trapID)
  end
end

function BattleStatComponent:IsTrapSummonedByCasterBefore(trapID, casterEntityID)
  if not self._trapIDBySummonCasterEntityID[casterEntityID] then
    return false
  end
  return table.icontains(self._trapIDBySummonCasterEntityID[casterEntityID], trapID)
end

function BattleStatComponent:_IsLocalTeam(teamEntity)
  local localTeamEntity = self._world:Player():GetLocalTeamEntity()
  if localTeamEntity and teamEntity and localTeamEntity:GetID() ~= teamEntity:GetID() then
    return false
  end
  return true
end

function BattleStatComponent:GetMonsterEscapeNum()
  return self._monsterEscapeNum
end

function BattleStatComponent:AddMonsterEscapeNum(count)
  local addNum = count or 1
  self._monsterEscapeNum = self._monsterEscapeNum + 1
end

function BattleStatComponent:AppendCombinedConditionRecord(resultA, resultB)
  table.insert(self._combinedConditionRecords, {resultA = resultA, resultB = resultB})
end

function BattleStatComponent:GetCombinedConditionRecord()
  return self._combinedConditionRecords
end

function BattleStatComponent:GetMainWorldBossID()
  return self._mainWorldBossID
end

function BattleStatComponent:SetMainWorldBossID(id)
  self._mainWorldBossID = id
end

_class("AffixSkillDamageRecordData", Object)
AffixSkillDamageRecordData = AffixSkillDamageRecordData

function AffixSkillDamageRecordData:Constructor(casterEntityID, skillID)
  self.casterEntityID = casterEntityID
  self.skillID = skillID
  self.targetList = {}
end

function BattleStatComponent:EnableAffixUseSkillDamageRecord()
  self._enablenAffixUseSkillDamageRecord = true
  self:AffixClearAllSkillDamageRecord()
end

function BattleStatComponent:DisableAffixUseSkillDamageRecord()
  self._enablenAffixUseSkillDamageRecord = false
  self:AffixClearAllSkillDamageRecord()
end

function BattleStatComponent:AffixBeginSkillDamageRecord(casterEntityID, skillID)
  if not self._enablenAffixUseSkillDamageRecord then
    return
  end
  local curData = AffixSkillDamageRecordData:New(casterEntityID, skillID)
  table.insert(self._affixUseSkillDamageRecords, curData)
  self._curRecordData = curData
  table.insert(self._useRecordList, 1, self._curRecordData)
end

function BattleStatComponent:AffixEndSkillDamageRecord(casterEntityID, skillID)
  if not self._enablenAffixUseSkillDamageRecord then
    return
  end
  table.remove(self._useRecordList, 1)
  if #self._useRecordList > 0 then
    self._curRecordData = self._useRecordList[#self._useRecordList]
  else
    self._curRecordData = nil
  end
end

function BattleStatComponent:AffixRecordSkillDamage(casterEntityID, skillID, defenderID)
  if not self._enablenAffixUseSkillDamageRecord then
    return
  end
  if self._curRecordData and self._curRecordData.casterEntityID == casterEntityID and self._curRecordData.skillID == skillID then
    if not self._curRecordData.targetList then
      self._curRecordData.targetList = {}
    end
    if self._curRecordData.targetList[defenderID] then
      self._curRecordData.targetList[defenderID] = self._curRecordData.targetList[defenderID] + 1
    else
      self._curRecordData.targetList[defenderID] = 1
    end
  end
end

function BattleStatComponent:AffixGetSkillDamageTargetCount(casterEntityID, skillID)
  if not self._enablenAffixUseSkillDamageRecord then
    return -1
  end
  if self._affixUseSkillDamageRecords then
    for index, value in ipairs(self._affixUseSkillDamageRecords) do
      if value.casterEntityID == casterEntityID and value.skillID == skillID then
        if value.targetList then
          local count = table.count(value.targetList)
          return count
        else
          return 0
        end
      end
    end
  end
  return -1
end

function BattleStatComponent:AffixRemoveSkillDamageRecord(casterEntityID, skillID)
  if not self._enablenAffixUseSkillDamageRecord then
    return
  end
  local restRecords = {}
  if self._affixUseSkillDamageRecords then
    for index, value in ipairs(self._affixUseSkillDamageRecords) do
      if value.casterEntityID == casterEntityID and value.skillID == skillID then
      else
        table.insert(restRecords, value)
      end
    end
    self._affixUseSkillDamageRecords = restRecords
  end
end

function BattleStatComponent:AffixEndSkillDamageRecordAndGetCount(casterEntityID, skillID)
  local count = self:AffixGetSkillDamageTargetCount(casterEntityID, skillID)
  self:AffixRemoveSkillDamageRecord(casterEntityID, skillID)
  return count
end

function BattleStatComponent:AffixClearAllSkillDamageRecord()
  if not self._enablenAffixUseSkillDamageRecord then
    return
  end
  self._affixUseSkillDamageRecords = {}
  self._useRecordList = {}
  self._curRecordData = nil
end

function BattleStatComponent:AddMonsterKilledRecordData(casterID, defenderID)
  local defenderEntity = self._world:GetEntityByID(defenderID)
  if not defenderEntity:HasMonsterID() then
    return
  end
  local casterEntity = self._world:GetEntityByID(casterID)
  local petTemplateID = -1
  local monsterID = -1
  if casterEntity then
    if casterEntity:HasSummoner() and casterEntity:GetSummonerEntity() then
      casterEntity = casterEntity:GetSummonerEntity()
    end
    if casterEntity:HasSuperEntity() and casterEntity:GetSuperEntity() then
      casterEntity = casterEntity:GetSuperEntity()
    end
    if casterEntity:HasPetPstID() then
      petTemplateID = casterEntity:PetPstID():GetTemplateID()
    end
    if casterEntity:HasMonsterID() then
      monsterID = casterEntity:MonsterID():GetMonsterID()
    end
  end
  self._monsterKilledCount = self._monsterKilledCount + 1
  if petTemplateID ~= -1 then
    if not self._monsterKilledRecordData[petTemplateID] then
      self._monsterKilledRecordData[petTemplateID] = {}
    end
    table.insert(self._monsterKilledRecordData[petTemplateID], {entityID = defenderID, petTemplateID = petTemplateID})
  elseif monsterID ~= -1 then
    if not self._monsterKilledRecordData[monsterID] then
      self._monsterKilledRecordData[monsterID] = {}
    end
    table.insert(self._monsterKilledRecordData[monsterID], {entityID = defenderID, monsterID = monsterID})
  end
end

function BattleStatComponent:GetMonsterKilledCount()
  return self._monsterKilledCount
end

function BattleStatComponent:GetMonsterKilledCountByMonsterID(monsterID)
  local curMonsterKillData = self._monsterKilledRecordData[monsterID]
  if not curMonsterKillData then
    return 0
  end
  return table.count(curMonsterKillData)
end

function BattleStatComponent:GetMonsterKilledCountByMonsterByPet()
  local monsterKillCount = 0
  for index, monsterKilledRecordData in ipairs(self._monsterKilledRecordData) do
    for _, value in ipairs(monsterKilledRecordData) do
      if value.petTemplateID then
        monsterKillCount = monsterKillCount + 1
      end
    end
  end
  return monsterKillCount
end

function BattleStatComponent:SetActiveSkillLinkLineState(state, casterEntityID, skillID)
  self._isActiveSkillLinkLine = state
  self._activeSkillLinkLineCasterEntityID = casterEntityID
  self._activeSkillLinkLineSkillID = skillID
end

function BattleStatComponent:GetActiveSkillLinkLineSkillID()
  return self._activeSkillLinkLineSkillID
end

function BattleStatComponent:GetActiveSkillLinkLineCasterEntityID()
  return self._activeSkillLinkLineCasterEntityID
end

function BattleStatComponent:IsActiveSkillLinkLine()
  return self._isActiveSkillLinkLine
end

function BattleStatComponent:SetLogicActiveSkillLinkLineTeamPos(pos, dir)
  self._activeSkillLinkLineTeamLogicPos = pos
  self._activeSkillLinkLineTeamLogicDir = dir
end

function BattleStatComponent:GetLogicActiveSkillLinkLineTeamPos()
  return self._activeSkillLinkLineTeamLogicPos, self._activeSkillLinkLineTeamLogicDir
end

function BattleStatComponent:SetRenderActiveSkillLinkLineTeamPos(pos, dir)
  self._activeSkillLinkLineTeamRenderPos = pos
  self._activeSkillLinkLineTeamRenderDir = dir
end

function BattleStatComponent:GetRenderActiveSkillLinkLineTeamPos()
  return self._activeSkillLinkLineTeamRenderPos, self._activeSkillLinkLineTeamRenderDir
end

function MainWorld:BattleStat()
  if EDITOR and CHECK_RENDER_ACCESS_LOGIC then
    local debugInfo = debug.getinfo(2, "S")
    local filePath = debugInfo.short_src
    local renderIndex = string.find(filePath, "_r.lua")
    if renderIndex ~= nil then
      Log.exception("render file :", filePath, " call BattleStat() ", Log.traceback())
      return nil
    end
  end
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.BattleStat)
end

function MainWorld:HasBattleStat()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.BattleStat) ~= nil
end

function MainWorld:AddBattleStat()
  local index = self.BW_UniqueComponentsEnum.BattleStat
  local component = BattleStatComponent:New(self)
  component:Initialize()
  self:SetUniqueComponent(index, component)
end

function MainWorld:RemoveBattleStat()
  if self:HasBattleStat() then
    self:SetUniqueComponent(self.BW_UniqueComponentsEnum.BattleStat, nil)
  end
end
