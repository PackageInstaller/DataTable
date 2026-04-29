_class("BuffLogicAddPoison", BuffLogicBase)
BuffLogicAddPoison = BuffLogicAddPoison

function BuffLogicAddPoison:Constructor(buffInstance, logicParam)
  self._damagePercent = logicParam.damagePercent
  self._triggerBuffEffect = logicParam.triggerBuffEffect
end

function BuffLogicAddPoison:DoLogic()
  local e = self._buffInstance:Entity()
  local attrCmpt = e:Attributes()
  local maxHp = attrCmpt:CalcMaxHp()
  if maxHp <= 0 then
    return
  end
  local turn = e:BuffComponent():GetBuffValue("PoisonTurn")
  local round = self._world:BattleStat():GetLevelTotalRoundCount()
  if turn == round and self._triggerBuffEffect == nil then
    return
  end
  e:BuffComponent():SetBuffValue("PoisonTurn", round)
  local attrCmpt = e:Attributes()
  local curHP = attrCmpt:GetCurrentHP()
  local layer = self._buffInstance:GetLayerCount()
  if self._triggerBuffEffect then
    layer = self._buffLogicService:GetBuffLayer(e, self._triggerBuffEffect)
  end
  if layer == 0 then
    return
  end
  local casterEntity = self:GetCasterEntity()
  if casterEntity:EntityType() == nil then
    casterEntity = e
  end
  local blsvc = self._world:GetService("BuffLogic")
  Log.debug("Buff AddPoison, beforeCalcDmg,entityID: ", e:GetID())
  local damageParam = {
    percent = self._damagePercent,
    layer = layer,
    formulaID = 15
  }
  if blsvc:IsEnableSpecialDotFormula(casterEntity, e) then
    local cfgParam = blsvc:GetSpecialDotFormulaParamByID(FormulaNumberType.PoisonDamage)
    if cfgParam then
      damageParam.percent = cfgParam.percent
      damageParam.formulaID = cfgParam.formulaID
    end
  end
  local damageInfo = blsvc:DoBuffDamage(self._buffInstance:BuffID(), casterEntity, e, damageParam)
  if damageInfo:GetDamageType() == DamageType.Real then
    damageInfo:SetDamageType(DamageType.Poison)
  end
  local calcDamageSvc = self._world:GetService("CalcDamage")
  local recoverDamageInfos = {}
  if e:HasMonsterID() then
    local teamEntity = self._world:Player():GetLocalTeamEntity()
    local buffForbidCure = teamEntity:Attributes():GetAttribute("BuffForbidCure")
    if not buffForbidCure then
      local es = teamEntity:Team():GetTeamPetEntities()
      for i, petEntity in ipairs(es) do
        local poisonVampire = petEntity:BuffComponent():GetBuffValue("PoisonVampire") or 0
        local vampireVal = math.floor(damageInfo:GetDamageValue() * poisonVampire)
        if 0 < vampireVal then
          local recoverDamageInfo = DamageInfo:New(vampireVal, DamageType.Recover)
          recoverDamageInfo:SetTargetEntityID(petEntity:GetID())
          calcDamageSvc:AddTargetHP(petEntity:GetID(), recoverDamageInfo)
          table.insert(recoverDamageInfos, recoverDamageInfo)
        end
      end
    end
  end
  local buffResult = BuffResultAddPoison:New(damageInfo, recoverDamageInfos)
  return buffResult
end
