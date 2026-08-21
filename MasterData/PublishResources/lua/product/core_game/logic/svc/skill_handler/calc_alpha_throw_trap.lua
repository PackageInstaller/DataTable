_class("SkillEffectCalc_AlphaThrowTrap", Object)
SkillEffectCalc_AlphaThrowTrap = SkillEffectCalc_AlphaThrowTrap

function SkillEffectCalc_AlphaThrowTrap:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
  self._rideSvc = self._world:GetService("RideLogic")
end

function SkillEffectCalc_AlphaThrowTrap:DoSkillEffectCalculator(skillEffectCalcParam)
  local trapEntityIDs, trapMountID, monsterMountID = self:CalcTrapAndMonster(skillEffectCalcParam)
  if #trapEntityIDs == 0 and not monsterMountID then
    return
  end
  local damageRes = self:CalcDamageResult(skillEffectCalcParam, trapEntityIDs, monsterMountID)
  if trapMountID then
    self._rideSvc:RemoveRide(skillEffectCalcParam.casterEntityID, trapMountID)
  end
  if monsterMountID then
  end
  local result = SkillEffectAlphaThrowTrapResult:New(trapEntityIDs, trapMountID, monsterMountID, damageRes)
  return result
end

function SkillEffectCalc_AlphaThrowTrap:CalcTrapAndMonster(skillEffectCalcParam)
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local mountEntityID
  if casterEntity:HasRide() then
    local rideCmpt = casterEntity:Ride()
    mountEntityID = rideCmpt:GetMountID()
  end
  local effectParam = skillEffectCalcParam.skillEffectParam
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local centerPos = teamEntity:GetGridPosition()
  local bodyArea = teamEntity:BodyArea():GetArea()
  local boardSvc = self._world:GetService("BoardLogic")
  local maxLen = boardSvc:GetCurBoardMaxLen()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillCalc = utilScopeSvc:GetSkillScopeCalc()
  local scopeRes = skillCalc:ComputeScopeRange(SkillScopeType.Cross, {maxLen}, centerPos, bodyArea)
  local posList = scopeRes:GetAttackRange()
  local trapMountID
  local trapID = effectParam:GetTrapID()
  local trapEntityIDs = {}
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for _, trapEntity in ipairs(trapGroup:GetEntities()) do
    if not trapEntity:HasDeadMark() and trapEntity:TrapID():GetTrapID() == trapID and table.icontains(posList, trapEntity:GetGridPosition()) then
      local trapEntityID = trapEntity:GetID()
      table.insert(trapEntityIDs, trapEntityID)
      if mountEntityID == trapEntityID then
        trapMountID = trapEntityID
      end
    end
  end
  local monsterMountID
  if not trapMountID then
    local monsterClassID = effectParam:GetMonsterClassID()
    local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
    for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
      if monsterClassID == monsterEntity:MonsterID():GetMonsterClassID() and mountEntityID == monsterEntity:GetID() then
        local bodyArea = monsterEntity:BodyArea():GetArea()
        local pos = monsterEntity:GetGridPosition()
        for _, bodyPos in ipairs(bodyArea) do
          local curPos = pos + bodyPos
          if table.icontains(posList, curPos) then
            monsterMountID = mountEntityID
            break
          end
        end
      end
    end
  end
  return trapEntityIDs, trapMountID, monsterMountID
end

function SkillEffectCalc_AlphaThrowTrap:CalcDamageResult(skillEffectCalcParam, trapEntityIDs, monsterMountID)
  local param = skillEffectCalcParam.skillEffectParam
  local basePercent = param:GetBasePercent()
  local afterPercent = param:GetAfterPercent()
  local curFormulaID = param:GetFormulaID()
  if curFormulaID == nil then
    curFormulaID = 2
  end
  local attackCount = #trapEntityIDs
  if monsterMountID then
    attackCount = attackCount + 1
  end
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local defenderEntity = self._world:Player():GetLocalTeamEntity()
  local defenderPos = defenderEntity:GetGridPosition()
  local percentList = {basePercent}
  local curPercent = basePercent * afterPercent
  for i = 2, attackCount do
    table.insert(percentList, curPercent)
  end
  local skillDamageParam = SkillDamageEffectParam:New({
    percent = percentList,
    formulaID = curFormulaID,
    damageStageIndex = 1
  })
  local nTotalDamage, listDamageInfo = self._skillEffectService:ComputeSkillDamage(casterEntity, casterEntity:GetGridPosition(), defenderEntity, defenderPos, skillEffectCalcParam.skillID, skillDamageParam, SkillEffectType.AlphaThrowTrap, 1)
  local damageRes = self._skillEffectService:NewSkillDamageEffectResult(defenderPos, defenderEntity:GetID(), nTotalDamage, listDamageInfo)
  return damageRes
end

function SkillEffectCalc_AlphaThrowTrap:CalcAddBuffResult(skillEffectCalcParam)
  local skillID = skillEffectCalcParam:GetSkillID()
  local attackRange = skillEffectCalcParam:GetSkillRange()
  local param = skillEffectCalcParam.skillEffectParam
  local buffID = param:GetBuffID()
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local defenderEntity = self._world:Player():GetLocalTeamEntity()
  local buffLogicService = self._world:GetService("BuffLogic")
  local triggerSvc = self._world:GetService("Trigger")
  local buffResult = SkillBuffEffectResult:New(defenderEntity:GetID())
  local cfgNewBuff = Cfg.cfg_buff[buffID]
  if cfgNewBuff then
    triggerSvc:Notify(NTEachAddBuffStart:New(skillID, casterEntity, defenderEntity, attackRange))
    local buff = buffLogicService:AddBuff(buffID, defenderEntity, {casterEntity = casterEntity})
    local seqID
    if buff then
      seqID = buff:BuffSeq()
      buffResult:AddBuffResult(seqID)
    end
    triggerSvc:Notify(NTEachAddBuffEnd:New(skillID, casterEntity, defenderEntity, attackRange, buffID, seqID))
  end
  return buffResult
end
