AutoTestBuffLogicTable = {
  ["眩晕"] = "ATBuffStun",
  ["恐惧"] = "ATBuffSCared",
  ["睡眠"] = "ATBuffSleep",
  ["灼烧"] = "ATBuffBurn",
  ["中毒"] = "ATBuffPoision",
  ["流血"] = "ATBuffBleed",
  ["麻痹"] = "ATBuffBenumb",
  ["免控"] = "ATBuffImmuneControll",
  ["致盲"] = "ATBuffAddMiss",
  ["闪避"] = "ATBuffAddDodge",
  ["无敌"] = "ATBuffInvincible",
  ["锁血"] = "ATBuffLockHP",
  ["禁疗"] = "ATBuffForbidAddHP",
  ["诅咒"] = "ATBuffSealed",
  ["层数盾"] = "ATBuffLayerShield",
  ["血条盾"] = "ATBuffBloodShield",
  ["免疫普攻"] = "ATBuffImmuneNormal",
  ["免疫技能"] = "ATBuffImmnueSkill",
  ["二次连锁"] = "ATBuffDoubleChain"
}
AutoTestBuffLogicCheckTable = {
  ATBuffStun = function(notify, entity, world)
    return entity:BuffComponent():HasFlag(BuffFlags.SkipTurn)
  end,
  ATBuffSCared = function(notify, entity, world)
    return entity:BuffComponent():HasBuffEffect(BuffEffectType.Fear)
  end,
  ATBuffSleep = function(notify, entity, world)
    return entity:BuffComponent():HasBuffEffect(BuffEffectType.Sleep)
  end,
  ATBuffBurn = function(notify, entity, world)
    return entity:BuffComponent():HasBuffEffect(BuffEffectType.Burn)
  end,
  ATBuffPoision = function(notify, entity, world)
    return entity:BuffComponent():HasBuffEffect(BuffEffectType.Poison)
  end,
  ATBuffBleed = function(notify, entity, world)
    return entity:BuffComponent():HasBuffEffect(BuffEffectType.Bleed)
  end,
  ATBuffBenumb = function(notify, entity, world)
    return entity:BuffComponent():HasFlag(BuffFlags.Benumb)
  end,
  ATBuffImmuneControll = function(notify, entity, world)
    return entity:BuffComponent():HasBuffEffect(BuffEffectType.ControlImmunized)
  end,
  ATBuffSealed = function(notify, entity, world)
    return entity:BuffComponent():HasFlag(BuffFlags.SealedCurse)
  end,
  ATBuffAddMiss = function(notify, entity, world)
    local buffValue = entity:BuffComponent():GetBuffValue("Miss")
    return buffValue and 0 < buffValue
  end,
  ATBuffAddDodge = function(notify, entity, world)
    local buffValue = entity:BuffComponent():GetBuffValue("Evade")
    return buffValue and 0 < buffValue
  end,
  ATBuffInvincible = function(notify, entity, world)
    return entity:BuffComponent():HasBuffEffect(BuffEffectType.Invincible)
  end,
  ATBuffLockHP = function(notify, entity, world)
    local svc = world:GetService("BuffLogic")
    return svc:CheckEntityLockHP(entity)
  end,
  ATBuffForbidAddHP = function(notify, entity, world)
    if entity:HasPetPstID() then
      entity = entity:Pet():GetOwnerTeamEntity()
    end
    return entity:Attributes():GetAttribute("BuffForbidCure") == 1
  end,
  ATBuffLayerShield = function(notify, entity, world)
    return entity:BuffComponent():HasBuffEffect(BuffEffectType.LayerShield)
  end,
  ATBuffBloodShield = function(notify, entity, world)
    return entity:BuffComponent():HasBuffEffect(BuffEffectType.HealthShield)
  end,
  ATBuffImmuneNormal = function(notify, entity, world)
    return entity:BuffComponent():HasBuffEffect(BuffEffectType.AttackImmuned)
  end,
  ATBuffImmnueSkill = function(notify, entity, world)
    return entity:BuffComponent():HasBuffEffect(BuffEffectType.SkillImmuned)
  end,
  ATBuffDoubleChain = function(notify, entity, world)
    return entity:BuffComponent():HasBuffEffect(BuffEffectType.doubleChain)
  end
}
_class("CheckBuffLogic_Test", AutoTestCheckPointBase)
CheckBuffLogic_Test = CheckBuffLogic_Test

function CheckBuffLogic_Test:BeforeCheck()
  local logic = self._args.logic .. "_Before"
  local f = AutoTestBuffLogicCheckTable[logic]
  if f then
    self._before = f(self._entity, self._world)
  end
end

function CheckBuffLogic_Test:Check(notify)
  local logic = self._args.logic
  local exist = self._args.exist
  local f = AutoTestBuffLogicCheckTable[logic]
  if f then
    local ret = f(notify, self._entity, self._world, self._before)
    if ret then
      return exist
    end
  end
  return not exist
end
