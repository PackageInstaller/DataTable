_class("SkillEffectCalc_EachGridAddBlood", Object)
SkillEffectCalc_EachGridAddBlood = SkillEffectCalc_EachGridAddBlood

function SkillEffectCalc_EachGridAddBlood:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_EachGridAddBlood:DoSkillEffectCalculator(skillEffectCalcParam)
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

function SkillEffectCalc_EachGridAddBlood:_CalculateSingleTarget(skillEffectCalcParam, defenderEntityID)
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local entityDefender = self._world:GetEntityByID(defenderEntityID)
  if entityDefender == nil then
    Log.fatal("CalculationForeachTarget defender is null ", defenderEntityID)
    return
  end
  local posTarget = entityDefender:GridLocation():GetGridPos()
  local skillResult = SkillEffectResultEachGridAddBlood:New(skillEffectCalcParam.skillEffectParam:GetBaseAddType(), skillEffectCalcParam.skillEffectParam:GetBaseAddValue(), posTarget)
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
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local pieceCount = 0
  if scopeResult then
    local array = scopeResult:GetAttackRange()
    if array then
      pieceCount = table.count(array)
    end
  end
  local nAddData = 0
  local pstId = casterEntity:PetPstID():GetPstID()
  local petData = self._world:GetPetData(pstId)
  local attackVal = casterEntity:Attributes():GetAttack()
  local baseAddType = skillEffectCalcParam.skillEffectParam:GetBaseAddType()
  local baseAddValue = skillEffectCalcParam.skillEffectParam:GetBaseAddValue()
  if AddBlood_Type.Percent == baseAddType then
    nAddData = nAddData + attackVal * baseAddValue
  elseif AddBlood_Type.AbsData == baseAddType then
    nAddData = nAddData + baseAddValue
  end
  local onePieceAddType = skillEffectCalcParam.skillEffectParam:GetOnePieceAddType()
  local onePieceAddValue = skillEffectCalcParam.skillEffectParam:GetOnePieceAddValue()
  if AddBlood_Type.Percent == onePieceAddType then
    nAddData = nAddData + attackVal * onePieceAddValue * pieceCount
  elseif AddBlood_Type.AbsData == onePieceAddType then
    nAddData = nAddData + onePieceAddValue * pieceCount
  end
  local enhanceParam = skillEffectCalcParam.skillEffectParam:GetEnhanceGridRecoverValue()
  local enhanceCount = 0
  if enhanceParam and scopeResult then
    local array = scopeResult:GetAttackRange()
    if array and 0 < #array and 0 < enhanceParam then
      local recover = attackVal * enhanceParam
      local utilSvc = self._world:GetService("UtilData")
      for _, pos in ipairs(array) do
        local traps = utilSvc:GetTrapsAtPos(pos)
        if traps and 0 < #traps then
          for __, trap in ipairs(traps) do
            if trap:Trap():GetTrapEffectType() ~= TrapEffectType.EnhancePiece then
              enhanceCount = enhanceCount + 1
            end
          end
        end
      end
      nAddData = nAddData + enhanceCount * recover
    end
  end
  local rate = entityDefender:Attributes():GetAttribute("AddBloodRate") or 0
  nAddData = nAddData * (1 + rate)
  nAddData = math.floor(nAddData)
  local logger = self._world:GetMatchLogger()
  logger:AddBloodLog(casterEntity:GetID(), {
    key = "CalcAddBlood",
    desc = "技能加血 攻击者[attacker] 被击者[defender] 加血类型[addtype] 加血量[blood]=(攻击力[attack]*基础加血量[baseAdd]+攻击力[attack]*一格加血量[gridAdd]*格子数[piececnt]+攻击力[attack]*强化加血系数[enhanceAdd]*强化格子数[enhanceCount])*(1+回血系数[rate])",
    attacker = casterEntity:GetID(),
    defender = defenderEntityID,
    baseAdd = baseAddValue,
    attack = attackVal,
    blood = nAddData,
    gridAdd = onePieceAddValue,
    piececnt = pieceCount,
    enhanceAdd = enhanceParam or 0,
    enhanceCount = enhanceCount,
    rate = rate,
    addtype = GetEnumKey("AddBlood_Type", onePieceAddType)
  })
  skillResult:SetAddData(defenderEntityID, nAddData)
  return skillResult
end
