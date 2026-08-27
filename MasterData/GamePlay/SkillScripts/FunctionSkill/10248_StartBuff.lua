local bs_10248 = class("bs_10248", LuaSkillBase)
local base = LuaSkillBase
bs_10248.config = {
  buffId = 1088,
  damageFormular = 10011,
  heal_config = {
    baseheal_formula = 10089,
    heal_number = 0,
    correct_formula = 9990
  },
  effectId = 10634
}

function bs_10248:ctor()
end

function bs_10248:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_10248_1", 1, self.OnAfterBattleStart)
end

function bs_10248:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 30, 10)
  if targetlist.Count < 1 then
    return
  end
  local targetRole = targetlist[0].targetRole
  local number = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.damageFormular, self.caster, targetRole, self)
  LuaSkillCtrl:CallHeal(number, self, targetRole, true)
  LuaSkillCtrl:CallBuffRepeated(self, targetRole, self.config.buffId, self.arglist[2], 90, false, false, self.OnBuffExecute)
  self:PlayChipEffect()
end

function bs_10248:OnBuffExecute(buff, targetRole)
  LuaSkillCtrl:CallEffect(targetRole, self.config.effectId, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, nil, true, true)
  skillResult:EndResult()
end

function bs_10248:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10248
