_class("SkillEffectCalc_SummonTrapOrHealByTrapBuffLayer", SkillEffectCalc_Base)
SkillEffectCalc_SummonTrapOrHealByTrapBuffLayer = SkillEffectCalc_SummonTrapOrHealByTrapBuffLayer

function SkillEffectCalc_SummonTrapOrHealByTrapBuffLayer:DoSkillEffectCalculator(skillEffectCalcParam)
  local param = skillEffectCalcParam.skillEffectParam
  local pos = skillEffectCalcParam.skillRange[1]
  local utilData = self._world:GetService("UtilData")
  local tTrapEntities = utilData:GetAllTrapEntitiesAtPosByTrapID(pos, param:GetTrapID())
  local trapEntity
  for _, trap in ipairs(tTrapEntities) do
    if not trap:HasDeadMark() then
      trapEntity = trap
      break
    end
  end
  if not trapEntity then
    return self:_DoSingleSummonTrap(skillEffectCalcParam)
  else
    return self:_DoHealByTrapBuffLayer(skillEffectCalcParam, trapEntity)
  end
end

function SkillEffectCalc_SummonTrapOrHealByTrapBuffLayer:_DoSingleSummonTrap(skillEffectCalcParam)
  local param = skillEffectCalcParam.skillEffectParam
  local pos = skillEffectCalcParam.skillRange[1]
  local trapID = param:GetTrapID()
  local summonMultipleTrapParam = SkillEffectSummonMultipleTrapParam:New({trapID = trapID, ignoreBlock = 1})
  local summonMultipleTrapCalc = SkillEffectCalc_SummonMultipleTrap:New(self._world)
  local summonMultipleTrapCalcParam = SkillEffectCalcParam:New(skillEffectCalcParam.casterEntityID, {-1}, summonMultipleTrapParam, skillEffectCalcParam.skillID, skillEffectCalcParam.skillRange, skillEffectCalcParam.attackPos, skillEffectCalcParam.gridPos, skillEffectCalcParam.centerPos, skillEffectCalcParam.wholeRange)
  local tResults = summonMultipleTrapCalc:DoSkillEffectCalculator(summonMultipleTrapCalcParam)
  return tResults
end

function SkillEffectCalc_SummonTrapOrHealByTrapBuffLayer:_DoHealByTrapBuffLayer(skillEffectCalcParam, selectedTrapEntity)
  local param = skillEffectCalcParam.skillEffectParam
  local buffEffectType = param:GetLayerBuffEffectType()
  local cBuff = selectedTrapEntity:BuffComponent()
  if not cBuff then
    return
  end
  local blsvc = self._world:GetService("BuffLogic")
  local curLayerMark = blsvc:GetBuffLayer(selectedTrapEntity, buffEffectType)
  local tResults = {}
  local entityCaster = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local entityHealed = entityCaster
  if entityHealed:HasPet() then
    entityHealed = entityCaster:Pet():GetOwnerTeamEntity()
  end
  if entityHealed and entityHealed:HasTeamDeadMark() then
    return
  end
  if entityHealed and entityHealed:Attributes():GetAttribute("BuffForbidCure") then
    return
  end
  local percentList = param:GetPercentList()
  local percent = percentList[curLayerMark + 1]
  if not percent then
    Log.error("HealByTrapBuffLayer: no percent found for layer=", curLayerMark)
    return
  end
  local cAttributes = entityCaster:Attributes()
  local casterAttack = cAttributes:GetAttack()
  local val = casterAttack * percent
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local rate = 0
  if val ~= 0 then
    rate = casterEntity:Attributes():GetAttribute("AddBloodRate") or 0
    rate = rate + (entityHealed:Attributes():GetAttribute("AddBloodRate") or 0)
    val = val * (1 + rate)
  end
  val = math.floor(val)
  local logger = self._world:GetMatchLogger()
  logger:AddBloodLog(casterEntity:GetID(), {
    key = "CalcAddBlood",
    desc = "技能加血 攻击者[attacker] 被击者[defender] 施法者攻击力[atk] 加血量[blood] 回血加成系数[rate]",
    attacker = casterEntity:GetID(),
    defender = skillEffectCalcParam.casterEntityID,
    blood = val,
    rate = rate,
    atk = casterAttack
  })
  local result = SkillEffectResult_AddBlood:New(AddBlood_Type.Attribute, percent, skillEffectCalcParam.gridPos, param:GetSkillEffectDamageStageIndex())
  result:SetAddData(entityHealed:GetID(), val)
  table.insert(tResults, result)
  local destroyTrapParam = SkillEffectDestroyTrapParam:New({
    trapID = {
      param:GetTrapID()
    }
  })
  local destroyTrapCalc = SkillEffectCalc_DestroyTrap:New(self._world)
  local destroyTrapCalcParam = SkillEffectCalcParam:New(skillEffectCalcParam.casterEntityID, {
    selectedTrapEntity:GetID()
  }, destroyTrapParam, skillEffectCalcParam.skillID, skillEffectCalcParam.skillRange, skillEffectCalcParam.attackPos, skillEffectCalcParam.gridPos, skillEffectCalcParam.centerPos, skillEffectCalcParam.wholeRange)
  local tDestroyResults = destroyTrapCalc:DoSkillEffectCalculator(destroyTrapCalcParam)
  if tDestroyResults then
    table.appendArray(tResults, tDestroyResults)
  end
  return tResults
end
