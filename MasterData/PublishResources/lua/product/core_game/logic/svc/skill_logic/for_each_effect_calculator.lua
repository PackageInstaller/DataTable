_class("ForEachEffectCalculator", Object)
ForEachEffectCalculator = ForEachEffectCalculator

function ForEachEffectCalculator:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
  self._skillEffectCalcService = self._world:GetService("SkillEffectCalc")
  self._skillLogicService = self._world:GetService("SkillLogic")
  self._serialKillerEffect = SerialKillerEffectCalculator:New(world)
  self._randAttackCalculator = SkillRandAttackCalculator:New(world)
  self._highFrequencyDamageCalculator = HighFrequencyDamageCalculator:New(world)
  self._highFrequencyDamage2Calculator = HighFrequencyDamage2Calculator:New(world)
  self._forceMovementCalculator = ForceMovementCalculator:New(world)
  self._gridPurifyCalculator = GridPurifyCalculator:New(world)
  self._degressiveDirectionalDamageCalculator = DegressiveDirectionalDamageCalculator:New(world)
  self._damageByReflectDistance = DamageByReflectDistanceCalculator:New(world)
  self._changePetTeamOrderCalculator = ChangePetTeamOrderCalculator:New(world)
  self._swapPetTeamOrderCalculator = SwapPetTeamOrderCalculator:New(world)
  self._shuffleTeamOrderCalculator = ShuffleTeamOrderCalculator:New(world)
  self._decreaseSanByScopeCalc = DecreaseSanByScopeCalculator:New(world)
  self._singleGridFullDamageCalculator = SingleGridFullDamageCalculator:New(world)
  self._damageCanRepeatCalculator = SkillEffectCalc_DamageCanRepeat:New(world)
  self._randomCountDamageSameHalfCalculator = RandomCountDamageSameHalfCalculator:New(world)
  self._nightKingTeleportPathDamageCalculator = NightKingTeleportPathDamageCalculator:New(world)
  self._tankRushPerGridCalculator = SkillEffectCalc_TankRushPerGrid:New(world)
  self._generalEffectCalculator = GeneralEffectCalculator:New(world)
  self._skillEffectLogicExecutor = SkillEffectLogicExecutor:New(world)
end

function ForEachEffectCalculator:DoSkillEffectCalculate(casterEntity)
  local detailLogger = self._world:GetDetailMatchLogger()
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local skillConfigData = self._configService:GetSkillConfigData(skillID, casterEntity)
  skillID = skillConfigData:GetID()
  local scopeFilterParam = skillConfigData:GetScopeFilterParam()
  local svcCfgDeco = self._world:GetService("ConfigDecoration")
  local skillEffectArray = svcCfgDeco:GetLatestEffectParamArray(casterEntity:GetID(), skillID)
  if GameGlobal and GameGlobal.GetModule and GameGlobal.GetModule(SkillPerfModule):IsPerfCoreGame() and casterEntity:HasPetPstID() then
    GameGlobal.GetModule(SkillPerfModule):AddCalcSkill(casterEntity:PetPstID():GetTemplateID(), skillID)
  end
  for index, v in ipairs(skillEffectArray) do
    local skillEffectParam = v
    local skillEffectType = skillEffectParam:GetEffectType()
    local effectScopeFilterParam = skillEffectParam:GetScopeFilterParam()
    local finalScopeFilterParam = effectScopeFilterParam:IsDefault() and scopeFilterParam or effectScopeFilterParam
    Log.info("CalcSkill ID=", skillID, " EffectType=", skillEffectType)
    detailLogger:BeginCalcSkillEffect("ForEachTargetCalculator", index, skillEffectParam)
    if skillEffectType == SkillEffectType.SerialKiller then
      local result = self._serialKillerEffect:DoSerialKillerCalc(casterEntity, skillEffectParam)
      self._skillEffectLogicExecutor:ApplySkillEffect(casterEntity, skillEffectParam, {result})
    elseif skillEffectType == SkillEffectType.RandAttack then
      local result = self._randAttackCalculator:DoRandAttack(skillID, casterEntity, skillEffectParam)
      self._skillEffectLogicExecutor:ApplySkillEffect(casterEntity, skillEffectParam, {result})
    elseif skillEffectType == SkillEffectType.HighFrequencyDamage then
      local result = self._highFrequencyDamageCalculator:Calculate(casterEntity, skillEffectParam)
      self._skillEffectLogicExecutor:ApplySkillEffect(casterEntity, skillEffectParam, {result})
    elseif skillEffectType == SkillEffectType.HighFrequencyDamage2 then
      local result = self._highFrequencyDamage2Calculator:Calculate(casterEntity, skillEffectParam)
      self._skillEffectLogicExecutor:ApplySkillEffect(casterEntity, skillEffectParam, {result})
    elseif skillEffectType == SkillEffectType.ForceMovement then
      self._forceMovementCalculator:Calculate(casterEntity, skillEffectParam)
    elseif skillEffectType == SkillEffectType.GridPurify then
      self._gridPurifyCalculator:Calculate(casterEntity, skillEffectParam)
    elseif skillEffectType == SkillEffectType.DegressiveDirectionalDamage then
      local tResults = self._degressiveDirectionalDamageCalculator:Calculate(casterEntity, skillEffectParam)
      self._skillEffectLogicExecutor:ApplySkillEffect(casterEntity, skillEffectParam, tResults)
    elseif skillEffectType == SkillEffectType.DamageReflectDistance then
      local tResults = self._damageByReflectDistance:Calculate(casterEntity, skillEffectParam)
      self._skillEffectLogicExecutor:ApplySkillEffect(casterEntity, skillEffectParam, tResults)
    elseif skillEffectType == SkillEffectType.ChangePetTeamOrder then
      local results = self._changePetTeamOrderCalculator:Calculate(casterEntity, skillEffectParam)
      self._skillEffectLogicExecutor:ApplySkillEffect(casterEntity, skillEffectParam, results)
    elseif skillEffectType == SkillEffectType.ShufflePetTeamOrder then
      self._shuffleTeamOrderCalculator:Calculate(casterEntity, skillEffectParam)
    elseif skillEffectType == SkillEffectType.SwapPetTeamOrder then
      local results = self._swapPetTeamOrderCalculator:Calculate(casterEntity, skillEffectParam)
      self._skillEffectLogicExecutor:ApplySkillEffect(casterEntity, skillEffectParam, results)
    elseif skillEffectType == SkillEffectType.DecreaseSanByScope then
      local results = self._decreaseSanByScopeCalc:Calculate(casterEntity, skillEffectParam, finalScopeFilterParam)
      self._skillEffectLogicExecutor:ApplySkillEffect(casterEntity, skillEffectParam, results)
    elseif skillEffectType == SkillEffectType.SingleGridFullDamage then
      local results = self._singleGridFullDamageCalculator:Calculate(casterEntity, skillEffectParam, finalScopeFilterParam, skillID)
      self._skillEffectLogicExecutor:ApplySkillEffect(casterEntity, skillEffectParam, results)
    elseif skillEffectType == SkillEffectType.DamageTargetCanRepeat then
      local results = self._damageCanRepeatCalculator:CalculateEffect(casterEntity, skillEffectParam, skillID)
      self._skillEffectLogicExecutor:ApplySkillEffect(casterEntity, skillEffectParam, results)
    elseif skillEffectType == SkillEffectType.RandomCountDamageSameHalf then
      local results = self._randomCountDamageSameHalfCalculator:Calculate(casterEntity, skillEffectParam, skillID)
      self._skillEffectLogicExecutor:ApplySkillEffect(casterEntity, skillEffectParam, results)
    elseif skillEffectType == SkillEffectType.NightKingTeleportPathDamage then
      local results = self._nightKingTeleportPathDamageCalculator:Calculate(casterEntity, skillEffectParam, skillID)
      self._skillEffectLogicExecutor:ApplySkillEffect(casterEntity, skillEffectParam, results)
    else
      local resultArray = self._generalEffectCalculator:DoGeneralEffectCalc(casterEntity, skillEffectParam, finalScopeFilterParam)
      self._skillEffectLogicExecutor:ApplySkillEffect(casterEntity, skillEffectParam, resultArray)
    end
    detailLogger:EndCalcSkillEffect("ForEachTargetCalculator", index, skillEffectParam)
  end
  self:_BattleStat_SkillHitPlayer(casterEntity, skillID)
end

local statSkillEffectType = {
  SkillEffectType.Damage,
  SkillEffectType.HitBack,
  SkillEffectType.AddBuff
}

function ForEachEffectCalculator:_BattleStat_SkillHitPlayer(casterEntity, skillID)
  local container = casterEntity:SkillContext():GetResultContainer()
  for _, effectType in ipairs(statSkillEffectType) do
    local tResult = container:GetEffectResultByArrayAll(effectType)
    if tResult then
      for __, result in ipairs(tResult) do
        local e = self:_GetDefenderFromSkillResult(result)
        if e and self:_IsEntityPlayer(e) then
          self._world:BattleStat():AddPlayerSkillHitCount(skillID)
          return
        end
      end
    end
  end
end

function ForEachEffectCalculator:_IsEntityPlayer(e)
  local eLocalTeam = self._world:Player():GetLocalTeamEntity()
  if e:HasTeam() then
    if eLocalTeam:GetID() == e:GetID() then
      return true
    end
  elseif e:HasPet() then
    local eTeam = e:Pet():GetOwnerTeamEntity()
    if eTeam:GetID() == eLocalTeam:GetID() then
      return true
    end
  end
  return false
end

function ForEachEffectCalculator:_GetDefenderFromSkillResult(result)
  if SkillDamageEffectResult:IsInstanceOfType(result) then
    local eid = result:GetTargetID()
    if not eid or eid <= 0 then
      return
    end
    return self._world:GetEntityByID(result:GetTargetID())
  elseif SkillHitBackEffectResult:IsInstanceOfType(result) then
    local eid = result:GetTargetID()
    if not eid or eid <= 0 then
      return
    end
    return self._world:GetEntityByID(result:GetTargetID())
  elseif SkillBuffEffectResult:IsInstanceOfType(result) then
    local eid = result:GetEntityID()
    if not eid or eid <= 0 then
      return
    end
    return self._world:GetEntityByID(result:GetTargetID())
  end
end
