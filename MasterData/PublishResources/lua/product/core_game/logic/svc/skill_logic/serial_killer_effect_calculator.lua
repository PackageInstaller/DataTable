_class("SerialKillerEffectCalculator", Object)
SerialKillerEffectCalculator = SerialKillerEffectCalculator

function SerialKillerEffectCalculator:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
  self._skillLogicService = self._world:GetService("SkillLogic")
  self._skillEffectCalcService = self._world:GetService("SkillEffectCalc")
end

function SerialKillerEffectCalculator:DoSerialKillerCalc(casterEntity, skillEffectParam)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local targetIDs = scopeResult:GetTargetIDs()
  local result = self:_CalcSkillSerialKillerEffect(casterEntity:GetID(), targetIDs, skillEffectParam, skillID)
  local count = table.count(result:GetKilledArray())
  for index, res in ipairs(result:GetKilledArray()) do
    local damageInfo = res:GetDamageInfo(1)
    damageInfo:SetAttackerEntityID(casterEntity:GetID())
    skillEffectResultContainer:AddEffectResult(res)
    local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
    local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
    for _, e in ipairs(monsterGroup:GetEntities()) do
      sMonsterShowLogic:AddMonsterDeadMark(e)
    end
    local battleService = self._world:GetService("Battle")
    if battleService:IsFinalAttack() and index == count then
      skillEffectResultContainer:SetFinalAttack(true)
      break
    end
  end
  return result
end

function SerialKillerEffectCalculator:_CalcSkillSerialKillerEffect(casterEntityID, nearestEntityIDs, skillEffectParam, skillID)
  local param = skillEffectParam
  local percent = param:GetPercent()
  local firstMultiple = param:GetMultiple()
  local damageFormulaID = param:GetFormulaID()
  local killCount = param:GetKillCount()
  local formulaService = self._world:GetService("Formula")
  local attacker = self._world:GetEntityByID(casterEntityID)
  local res = SkillSerialKillerResult:New()
  local extraAttackCount, addPiecePosList = self:_CalExtraAttackCount(param, attacker)
  res:SetAddPiecePosList(addPiecePosList)
  killCount = killCount + extraAttackCount
  local hasDamage = 0
  local curDefendEntity, curDefendEntityId
  local deadDefnderIdList = {}
  local defenderIdList = {}
  local damageList = {}
  for k, defenderEntityID in ipairs(nearestEntityIDs) do
    local defender = self._world:GetEntityByID(defenderEntityID)
    local curHp = defender:Attributes():GetCurrentHP()
    if 0 < curHp then
      defenderIdList[#defenderIdList + 1] = defenderEntityID
    end
  end
  local gameFsmCmpt = self._world:GameFSM()
  local gameFsmStateID = gameFsmCmpt:CurStateID()
  local randomSvc = self._world:GetService("RandomLogic")
  local battleStatCmpt = self._world:BattleStat()
  if gameFsmStateID ~= GameStateID.PreviewActiveSkill then
    local mathService = self._world:GetService("Math")
    local svcCalcDamage = self._world:GetService("CalcDamage")
    for i = 1, killCount do
      if not curDefendEntity then
        if #defenderIdList <= 0 then
          if #deadDefnderIdList <= 0 then
            break
          end
          local randomIndex = randomSvc:LogicRand(1, #deadDefnderIdList)
          local defenderId = deadDefnderIdList[randomIndex]
          curDefendEntity = self._world:GetEntityByID(defenderId)
          curDefendEntityId = defenderId
        else
          local randomIndex = randomSvc:LogicRand(1, #defenderIdList)
          local defenderId = defenderIdList[randomIndex]
          curDefendEntity = self._world:GetEntityByID(defenderId)
          curDefendEntityId = defenderId
        end
      end
      local tmpPercent = percent
      if not damageList[curDefendEntityId] then
        tmpPercent = tmpPercent * firstMultiple
      end
      local effectCalcService = self._world:GetService("SkillEffectCalc")
      effectCalcService:NotifyDamageBegin(attacker, curDefendEntity, attacker:GetGridPosition(), curDefendEntity:GetGridPosition(), skillID)
      local _damageParam = SkillDamageEffectParam:New(param)
      _damageParam._pureDamage = param:GetPureDamage()
      _damageParam._percent = tmpPercent
      _damageParam._formulaID = damageFormulaID
      _damageParam.percent = tmpPercent
      _damageParam.skillID = skillID
      _damageParam.formulaID = damageFormulaID
      _damageParam.attackPos = attacker:GetGridPosition()
      local damageInfo = svcCalcDamage:DoCalcDamage(attacker, curDefendEntity, _damageParam)
      effectCalcService:NotifyDamageEnd(attacker, curDefendEntity, attacker:GetGridPosition(), curDefendEntity:GetGridPosition(), skillID, damageInfo, SkillEffectType.SerialKiller, i)
      if not damageList[curDefendEntityId] then
        local damageSaveData = {}
        damageSaveData.id = curDefendEntityId
        damageSaveData.damage = 0
        damageList[curDefendEntityId] = damageSaveData
      end
      local curDamageSaveData = damageList[curDefendEntityId]
      curDamageSaveData.damage = curDamageSaveData.damage + damageInfo:GetDamageValue()
      local damageResult = SkillDamageEffectResult:New(curDefendEntity:GetGridPosition(), curDefendEntityId, damageInfo:GetDamageValue(), {damageInfo})
      res:AddOneKilled(damageResult)
      if 0 >= curDefendEntity:Attributes():GetCurrentHP() then
        for i = 1, #defenderIdList do
          if defenderIdList[i] == curDefendEntityId then
            table.remove(defenderIdList, i)
            break
          end
        end
        local isFind = false
        for i = 1, #deadDefnderIdList do
          if deadDefnderIdList[i] == curDefendEntityId then
            isFind = true
            break
          end
        end
        if not isFind then
          table.insert(deadDefnderIdList, curDefendEntityId)
        end
      end
      curDefendEntity = nil
      curDefendEntityId = nil
    end
  end
  return res
end

function SerialKillerEffectCalculator:_CalExtraAttackCount(param, attacker)
  local serialScopeType = param:GetSerialScopeType()
  local radius = param:GetRadius()
  local posCaster = attacker:GetGridPosition()
  local casterBodyArea = attacker:BodyArea():GetArea()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local scopeResult = scopeCalculator:ComputeScopeRange(serialScopeType, {
    [1] = radius,
    [2] = 0
  }, posCaster, casterBodyArea)
  local board = self._world:GetBoardEntity():Board()
  local extraAttackCount = 0
  local boardService = self._world:GetService("BoardRender")
  local pieceType = param:GetPieceType()
  local addPiecePosList = {}
  if scopeResult then
    local array = scopeResult:GetAttackRange()
    for _, v in ipairs(array) do
      local pt = board:GetPieceType(v)
      if pt == pieceType then
        extraAttackCount = extraAttackCount + 1
        table.insert(addPiecePosList, v)
      end
    end
  end
  local onPieceAddAttackCount = param:GetOnePieceAddAttackCount()
  extraAttackCount = extraAttackCount * onPieceAddAttackCount
  return extraAttackCount, addPiecePosList
end
