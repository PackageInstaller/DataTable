_class("BuffLogicAddRebeccaPoison", BuffLogicBase)
BuffLogicAddRebeccaPoison = BuffLogicAddRebeccaPoison

function BuffLogicAddRebeccaPoison:Constructor(buffInstance, logicParam)
  self._damagePercent = logicParam.damagePercent
  self._normalFormulaID = logicParam.normalFormulaID
  self._specialFormulaID = logicParam.specialFormulaID
  self._specialBuffEffect = logicParam.specialBuffEffect
  self._ignoreRound = logicParam.ignoreRound
  self._checkCfgLayer = logicParam.checkCfgLayer
end

function BuffLogicAddRebeccaPoison:DoLogic()
  local e = self._buffInstance:Entity()
  local attrCmpt = e:Attributes()
  local maxHp = attrCmpt:CalcMaxHp()
  if maxHp <= 0 then
    return
  end
  local buffCmpt = e:BuffComponent()
  if not buffCmpt then
    return
  end
  local casterID = buffCmpt:GetRebeccaPoisonCasterID()
  local caster = self._world:GetEntityByID(casterID)
  if not caster then
    return
  end
  if self._ignoreRound then
  else
    local turn = buffCmpt:GetBuffValue("RebeccaPoisonTurn")
    local round = self._world:BattleStat():GetLevelTotalRoundCount()
    if turn == round then
      return
    end
    buffCmpt:SetBuffValue("RebeccaPoisonTurn", round)
  end
  local buffLogicService = self._world:GetService("BuffLogic")
  local layer = self._buffInstance:GetLayerCount()
  if self._checkCfgLayer then
    layer = buffLogicService:GetBuffLayer(e, self._checkCfgLayer)
  end
  local buffLogicSvc = self._world:GetService("BuffLogic")
  local useFormulaID = self._normalFormulaID
  if self._specialBuffEffect and buffCmpt:HasBuffEffect(self._specialBuffEffect) then
    useFormulaID = self._specialFormulaID
  end
  local damageInfo = buffLogicSvc:DoBuffDamage(self._buffInstance:BuffID(), caster, e, {
    percent = self._damagePercent * layer,
    layer = layer,
    formulaID = useFormulaID
  })
  if damageInfo:GetDamageType() == DamageType.Real then
    damageInfo:SetDamageType(DamageType.Poison)
  end
  local buffResult = BuffResultAddPoison:New(damageInfo)
  return buffResult
end
