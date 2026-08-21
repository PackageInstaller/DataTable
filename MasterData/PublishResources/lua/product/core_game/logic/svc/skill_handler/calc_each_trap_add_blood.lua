_class("SkillEffectCalc_EachTrapAddBlood", Object)
SkillEffectCalc_EachTrapAddBlood = SkillEffectCalc_EachTrapAddBlood

function SkillEffectCalc_EachTrapAddBlood:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_EachTrapAddBlood:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local result = self:_CalculateSingleTarget(skillEffectCalcParam, targetID)
    if result then
      table.insert(results, result)
    end
  end
  return results
end

function SkillEffectCalc_EachTrapAddBlood:_CalculateSingleTarget(skillEffectCalcParam, defenderEntityID)
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local entityDefender = self._world:GetEntityByID(defenderEntityID)
  if entityDefender == nil then
    Log.fatal("CalculationForeachTarget defender is null ", defenderEntityID)
    return
  end
  local utilSvc = self._world:GetService("UtilData")
  local posTarget = entityDefender:GridLocation():GetGridPos()
  local skillResult = SkillEffectResultEachTrapAddBlood:New()
  if entityDefender:HasPetPstID() or entityDefender:HasTeam() then
    local teamEntity = entityDefender
    if entityDefender:HasPet() then
      teamEntity = entityDefender:Pet():GetOwnerTeamEntity()
    end
    if teamEntity:Attributes():GetAttribute("BuffForbidCure") then
      skillResult:SetAddData(defenderEntityID, 0)
      return skillResult
    end
  end
  local skillEffectParam = skillEffectCalcParam.skillEffectParam
  local tarTrapId = skillEffectParam:GetTrapId()
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local trapCount = 0
  local array = skillEffectCalcParam.skillRange
  if array then
    for _, pos in ipairs(array) do
      local traps = utilSvc:GetTrapsAtPos(pos)
      if traps and 0 < #traps then
        for __, trap in ipairs(traps) do
          if trap:Trap():GetTrapID() == tarTrapId then
            trapCount = trapCount + 1
          end
        end
      end
    end
  end
  local nAddData = 0
  local addParam = casterEntity:Attributes():CalcMaxHp()
  local oneTrapAddValue = skillEffectParam:GetOneTrapAddValue()
  local baseAddValue = skillEffectParam:GetBaseAddValue()
  if trapCount == 0 then
    baseAddValue = 0
  end
  nAddData = nAddData + addParam * (baseAddValue + oneTrapAddValue * trapCount)
  local rate = entityDefender:Attributes():GetAttribute("AddBloodRate") or 0
  nAddData = nAddData * (1 + rate)
  nAddData = math.floor(nAddData)
  local logger = self._world:GetMatchLogger()
  logger:AddBloodLog(casterEntity:GetID(), {
    key = "CalcAddBlood",
    desc = "技能加血 攻击者[attacker] 被击者[defender] 加血量[blood]=(血量上限[MaxHP]*(基础加血量[damagePercent]+(每个机关加血量[skillIncreaseParam]*机关数[trapCount])))*(1+回血系数[rate])",
    attacker = casterEntity:GetID(),
    defender = defenderEntityID,
    MaxHP = addParam,
    blood = nAddData,
    skillIncreaseParam = oneTrapAddValue,
    trapCount = trapCount,
    rate = rate,
    damagePercent = baseAddValue
  })
  skillResult:SetAddData(defenderEntityID, nAddData)
  return skillResult
end
