_class("SkillEffectCalc_SummonScanTrap", SkillEffectCalc_Base)
SkillEffectCalc_SummonScanTrap = SkillEffectCalc_SummonScanTrap

function SkillEffectCalc_SummonScanTrap:DoSkillEffectCalculator(skillEffectCalcParam)
  local cLogicFeature = self._world:GetBoardEntity():LogicFeature()
  local trapID = cLogicFeature:GetScanTrapID()
  if not trapID or trapID == 0 then
    return
  end
  local cfgTrapScan = Cfg.cfg_trap_scan[trapID]
  if not cfgTrapScan then
    Log.exception("SummonScanTrap: invalid trap id: ", tostring(trapID))
    return
  end
  local results = {}
  local trapServiceLogic = self._world:GetService("TrapLogic")
  for _, gridPos in ipairs(skillEffectCalcParam:GetSkillRange()) do
    if trapServiceLogic:CanSummonTrapOnPos(gridPos, trapID, BlockFlag.None) then
      local result = self:_DoSummonProcess(trapID, gridPos, skillEffectCalcParam)
      if result then
        table.insert(results, result)
      end
    end
  end
  return results
end

function SkillEffectCalc_SummonScanTrap:_DoSummonProcess(trapID, gridPos, skillEffectCalcParam)
  local cfgTrapScan = Cfg.cfg_trap_scan[trapID]
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local casterEntityID = skillEffectCalcParam:GetCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  local skillID = skillEffectCalcParam:GetSkillID()
  local tDestroyTrapInfo = {}
  local tAddBuffResults = {}
  if cfgTrapScan.GlobalMaxCount and cfgTrapScan.GlobalMaxCount > 0 then
    tDestroyTrapInfo = self:DestroyTrapOutOfLimit(cfgTrapScan, casterEntity)
  end
  local summonResult = SkillSummonTrapEffectResult:New(trapID, gridPos)
  local trapEntity = trapServiceLogic:CreateTrap(trapID, gridPos, Vector2(0, 1), true, nil, casterEntity)
  if not trapEntity then
    return
  end
  if table.icontains(BattleConst.AkexiyaScanTrap_MeantimeLimitID, trapID) then
    local cBattleFlag = self._world:BattleFlags()
    local t = cBattleFlag:GetSummonMeantimeLimitEntityID(trapID)
    table.insert(t, trapEntity:GetID())
    cBattleFlag:SetSummonMeantimeLimitEntityID(trapID, t)
  end
  local petTemplateID = cfgTrapScan.PetID
  if petTemplateID then
    local eLocalTeam = self._world:Player():GetLocalTeamEntity()
    local cTeam = eLocalTeam:Team()
    local petEntities = cTeam:GetTeamPetEntities()
    for _, e in ipairs(petEntities) do
      local tid = e:PetPstID():GetTemplateID()
      if tid == petTemplateID then
        local attack = e:Attributes():GetAttack()
        trapEntity:BuffComponent():SetBuffValue("GuestAttack", attack)
      end
    end
  end
  if cfgTrapScan.Buff and 0 < #cfgTrapScan.Buff then
    local addBuffCalc = SkillEffectCalc_AddBuff:New(self._world)
    for _, buffID in ipairs(cfgTrapScan.Buff) do
      local addBuffParam = SkillAddBuffEffectParam:New({prob = 1, buffID = buffID})
      local addBuffResult = addBuffCalc:DoSkillEffectCalculator(SkillEffectCalcParam:New(casterEntity:GetID(), {
        trapEntity:GetID()
      }, addBuffParam, skillID, {gridPos}, gridPos, gridPos))
      if addBuffResult then
        table.appendArray(tAddBuffResults, addBuffResult)
      end
    end
  end
  local result = SkillEffectResult_SummonScanTrap:New(trapEntity:GetID(), tDestroyTrapInfo, tAddBuffResults)
  return result
end

function SkillEffectCalc_SummonScanTrap:DestroyTrapOutOfLimit(cfgTrapScan, casterEntity, count)
  count = count or 1
  local trapID = cfgTrapScan.ID
  local trapEntities = {}
  local globalTrapEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.Trap)
  for _, e in ipairs(globalTrapEntities) do
    if not e:HasDeadMark() and e:TrapID():GetTrapID() == trapID then
      table.insert(trapEntities, e)
    end
  end
  if #trapEntities + count < cfgTrapScan.GlobalMaxCount then
    return {}
  end
  table.sort(trapEntities, function(a, b)
    return a:GetID() < b:GetID()
  end)
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local skillLogicSvc = self._world:GetService("SkillLogic")
  local r = {}
  for i = 1, count do
    if #trapEntities == 0 then
      break
    end
    local e = table.remove(trapEntities, 1)
    local info = {
      entityID = e:GetID()
    }
    local cTrap = e:Trap()
    local skillID = cTrap:GetDisappearSkillID()
    if skillID and 0 < skillID then
      skillLogicSvc:CalcSkillEffect(e, skillID)
      local skillResultContainer = e:SkillContext():GetResultContainer()
      info.replacingSkillContainer = skillResultContainer
      info.skillID = skillID
    end
    e:Attributes():Modify("HP", 0)
    trapServiceLogic:AddTrapDeadMark(e)
    table.insert(r, info)
  end
  return r
end
