_class("SkillEffectCalc_AddBuffByPickupBuffLayer", Object)
SkillEffectCalc_AddBuffByPickupBuffLayer = SkillEffectCalc_AddBuffByPickupBuffLayer

function SkillEffectCalc_AddBuffByPickupBuffLayer:Constructor(world)
  self._world = world
end

function SkillEffectCalc_AddBuffByPickupBuffLayer:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillID = skillEffectCalcParam:GetSkillID()
  local attackRange = skillEffectCalcParam:GetSkillRange()
  local casterEntityID = skillEffectCalcParam:GetCasterEntityID()
  local param = skillEffectCalcParam.skillEffectParam
  local buffID = 0
  local trapIDList = param:GetTrapIDList()
  local checkBuffEffectType = param:GetCheckBuffEffectType()
  local pickUpPos = attackRange[1]
  local boardCmpt = self._world:GetBoardEntity():Board()
  local traps = boardCmpt:GetPieceEntities(pickUpPos, function(e)
    local isOwner = false
    if e:HasSummoner() then
      local summonEntityID = e:Summoner():GetSummonerEntityID()
      local summonEntity = e:GetSummonerEntity()
      if summonEntity and summonEntity:HasSuperEntity() and summonEntity:GetSuperEntity() then
        summonEntityID = summonEntity:GetSuperEntity():GetID()
      end
      if summonEntityID == casterEntityID then
        isOwner = true
      end
    else
      isOwner = true
    end
    return isOwner and e:HasTrap() and table.icontains(trapIDList, e:TrapID():GetTrapID()) and not e:HasDeadMark()
  end)
  if 0 < #traps then
    local pickUpTrap = traps[1]
    local buffLogicService = self._world:GetService("BuffLogic")
    local layer = buffLogicService:GetBuffLayer(pickUpTrap, checkBuffEffectType)
    buffID = param:GetAddBuffIDByLayer(layer)
  else
    return
  end
  local buffLogicService = self._world:GetService("BuffLogic")
  local triggerSvc = self._world:GetService("Trigger")
  local buffResult = SkillBuffEffectResult:New(casterEntityID)
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  local cfgNewBuff = Cfg.cfg_buff[buffID]
  if cfgNewBuff then
    local nt = NTEachAddBuffStart:New(skillID, casterEntity, casterEntity, attackRange)
    triggerSvc:Notify(nt)
    local buff = buffLogicService:AddBuff(buffID, casterEntity, {casterEntity = casterEntity})
    local seqID
    if buff then
      seqID = buff:BuffSeq()
      buffResult:AddBuffResult(seqID)
    end
    triggerSvc:Notify(NTEachAddBuffEnd:New(skillID, casterEntity, casterEntity, attackRange, buffID, seqID))
  end
  return {buffResult}
end
