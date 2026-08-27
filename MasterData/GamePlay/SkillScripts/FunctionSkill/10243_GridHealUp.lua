local bs_10243 = class("bs_10243", LuaSkillBase)
local base = LuaSkillBase
bs_10243.config = {
  heal_config = {
    baseheal_formula = 10118,
    heal_number = 0,
    correct_formula = 9990
  }
}

function bs_10243:ctor()
end

function bs_10243:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_10243_1", 1, self.OnAfterBattleStart)
end

function bs_10243:OnAfterBattleStart()
  LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.RealPlaySkill, self, -1)
end

function bs_10243:RealPlaySkill()
  if LuaSkillCtrl:GetRoleEfcGrid(self.caster) ~= 0 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config)
    skillResult:EndResult()
  end
end

function bs_10243:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10243
