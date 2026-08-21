_class("SkillRandAttackCalculator", Object)
SkillRandAttackCalculator = SkillRandAttackCalculator

function SkillRandAttackCalculator:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
  self._skillLogicService = self._world:GetService("SkillLogic")
  self._skillEffectCalcService = self._world:GetService("SkillEffectCalc")
  self._mathService = self._world:GetService("Math")
end

function SkillRandAttackCalculator:DoRandAttack(skillID, casterEntity, skillEffectParam)
  local workEffectParam = skillEffectParam
  local posCaster = casterEntity:GridLocation().Position
  if not casterEntity:HasAttributes() then
    casterEntity:AddAttributes()
  end
  local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local skillResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  local listTargetHp = {}
  local listAlive = {}
  local listDeath = {}
  for k, res in ipairs(skillResultArray) do
    local targetEntityID = res:GetTargetID()
    if 0 < targetEntityID then
      local nCurHp = listTargetHp[targetEntityID]
      if nil == nCurHp then
        local targetEntity = self._world:GetEntityByID(targetEntityID)
        local nCurHp = targetEntity:Attributes():GetCurrentHP()
        listTargetHp[targetEntityID] = nCurHp
        if 0 < nCurHp then
          listAlive[#listAlive + 1] = targetEntity
        elseif targetEntity:HasMonsterID() then
          listDeath[#listDeath + 1] = targetEntity
          sMonsterShowLogic:AddMonsterDeadMark(targetEntity)
        end
      end
    end
  end
  local svcCalcDamage = self._world:GetService("CalcDamage")
  local randomSvc = self._world:GetService("RandomLogic")
  local soulCount = casterEntity:BuffComponent():GetBuffValue("SoulCount") or 0
  local nNewSoulCount = soulCount
  nNewSoulCount = math.min(nNewSoulCount, workEffectParam:GetMaxTimes())
  nNewSoulCount = math.max(nNewSoulCount, workEffectParam:GetMinTimes())
  local nAttackTimes = nNewSoulCount
  local listRandAttackData = {}
  if 0 < #listAlive then
    local formulaService = self._world:GetService("Formula")
    local skillLogicService = self._world:GetService("SkillLogic")
    local triggerSvc = self._world:GetService("Trigger")
    local battleStatCmpt = self._world:BattleStat()
    local attackPos = casterEntity:GridLocation():GetGridPos()
    for i = 1, nAttackTimes do
      local nRand = randomSvc:LogicRand(1, #listAlive)
      local targetEntity = listAlive[nRand]
      if targetEntity then
        local targetPos = targetEntity:GridLocation():GetGridPos()
        local nt = NTRandAttackBegin:New(casterEntity, targetEntity, attackPos, targetPos)
        triggerSvc:Notify(nt)
        local damageInfo = svcCalcDamage:DoCalcDamage(casterEntity, targetEntity, {
          percent = workEffectParam:GetPercent(),
          skillID = skillID,
          formulaID = workEffectParam:GetFormulaID(),
          skillEffectType = SkillEffectType.RandAttack
        })
        local defenderData = SkillEffectResult_RandAttackData:New(targetEntity:GetID(), damageInfo)
        listRandAttackData[#listRandAttackData + 1] = defenderData
        if targetEntity:HasMonsterID() then
          local curHP = targetEntity:Attributes():GetCurrentHP()
          if curHP <= 0 then
            sMonsterShowLogic:AddMonsterDeadMark(targetEntity)
          end
        end
        local nt = NTRandAttackEnd:New(casterEntity, targetEntity, attackPos, targetPos)
        triggerSvc:Notify(nt)
      end
    end
  end
  local skillResult = self:_GenerateResult(nAttackTimes, listRandAttackData, listDeath, listAlive)
  skillEffectResultContainer:AddEffectResult(skillResult, true)
  return skillResult
end

function SkillRandAttackCalculator:_EntityList2IDList(entityList)
  local t = {}
  for _, e in ipairs(entityList) do
    table.insert(t, e:GetID())
  end
  return t
end

function SkillRandAttackCalculator:_GenerateResult(nAttackTimes, listRandAttackData, listDeath, listAlive)
  local listDeathID = {}
  local listDeathPos = {}
  for _, entity in ipairs(listDeath) do
    table.insert(listDeathID, entity:GetID())
    table.insert(listDeathPos, entity:GetGridPosition())
  end
  local listAliveID = self:_EntityList2IDList(listAlive)
  return SkillEffectResult_RandAttack:New(nAttackTimes, listRandAttackData, listDeathID, listDeathPos, listAliveID)
end
