_class("BuffLogicChangeSkillFinalByHPDiff", BuffLogicBase)
BuffLogicChangeSkillFinalByHPDiff = BuffLogicChangeSkillFinalByHPDiff

function BuffLogicChangeSkillFinalByHPDiff:Constructor(buffInstance, logicParam)
  self._maxValue = logicParam.maxValue
  self._a = logicParam.a
  self._b = logicParam.b
  self._effectList = logicParam.effectList
end

function BuffLogicChangeSkillFinalByHPDiff:DoLogic(notify)
  self._buffInstance._effectList = self._effectList
  local attackEntity = notify:GetAttackerEntity()
  local targetEntity = notify:GetDefenderEntity()
  local battleSvc = self._world:GetService("Battle")
  local atkHP, atkMaxHP = battleSvc:GetCasterHP(attackEntity)
  local defHP, defMaxHP = battleSvc:GetCasterHP(targetEntity)
  local atkHPPer = atkHP / atkMaxHP
  local defHPPer = defHP / defMaxHP
  local hpPerDiff = math.abs(atkHPPer - defHPPer)
  local value = math.min(self._maxValue, self._a * hpPerDiff + self._b)
  if targetEntity:MonsterID() and targetEntity:MonsterID():IsWorldBoss() then
    value = self._maxValue
  end
  Log.info("BuffLogicChangeSkillFinalByHPDiff:DoLogic value = ", value, " HpDiff=", hpPerDiff, " atkHPPer=", atkHPPer, " defHPPer=", defHPPer, "a =", self._a, " b=", self._b, " max=", self._maxValue)
  for _, paramType in ipairs(self._effectList) do
    self._buffLogicService:ChangeSkillFinalParam(self._entity, self:GetBuffSeq(), paramType, value)
  end
end

_class("BuffLogicRevertSkillFinalByHPDiff", BuffLogicBase)
BuffLogicRevertSkillFinalByHPDiff = BuffLogicRevertSkillFinalByHPDiff

function BuffLogicRevertSkillFinalByHPDiff:DoLogic()
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveSkillFinalParam(self._entity, self:GetBuffSeq(), paramType)
  end
end
