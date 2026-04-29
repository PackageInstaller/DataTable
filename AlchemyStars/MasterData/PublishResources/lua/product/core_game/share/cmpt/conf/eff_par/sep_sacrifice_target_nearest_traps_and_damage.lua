require("skill_damage_effect_param")
_class("SkillEffectSacrificeTargetNearestTrapsAndDamageParam", SkillEffectParamBase)
SkillEffectSacrificeTargetNearestTrapsAndDamageParam = SkillEffectSacrificeTargetNearestTrapsAndDamageParam

function SkillEffectSacrificeTargetNearestTrapsAndDamageParam:Constructor(t)
  self._checkTrapIDList = t.checkTrapIDList
  self._basePercent = t.basePercent
  self._addValue = t.addValue
  self._formulaID = t.formulaID
  self._trapLimit = t.trapLimit or -1
  self._mainBasePercent = t.mainBasePercent
  self._mainAddValue = t.mainAddValue
  self._mainFormulaID = t.mainFormulaID
end

function SkillEffectSacrificeTargetNearestTrapsAndDamageParam:GetEffectType()
  return SkillEffectType.SacrificeTargetNearestTrapsAndDamage
end

function SkillEffectSacrificeTargetNearestTrapsAndDamageParam:GetBasePercent()
  return self._basePercent
end

function SkillEffectSacrificeTargetNearestTrapsAndDamageParam:GetAddValue()
  return self._addValue
end

function SkillEffectSacrificeTargetNearestTrapsAndDamageParam:GetCheckTrapIDList()
  return self._checkTrapIDList
end

function SkillEffectSacrificeTargetNearestTrapsAndDamageParam:GetSacrificeFormulaID()
  return self._formulaID
end

function SkillEffectSacrificeTargetNearestTrapsAndDamageParam:GetTrapLimit()
  return self._trapLimit
end

function SkillEffectSacrificeTargetNearestTrapsAndDamageParam:GetMainBasePercent()
  return self._mainBasePercent
end

function SkillEffectSacrificeTargetNearestTrapsAndDamageParam:GetMainAddValue()
  return self._mainAddValue
end

function SkillEffectSacrificeTargetNearestTrapsAndDamageParam:GetMainFormulaID()
  return self._mainFormulaID
end
