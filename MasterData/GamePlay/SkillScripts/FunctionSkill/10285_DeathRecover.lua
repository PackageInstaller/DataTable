local bs_10285 = class("bs_10285", LuaSkillBase)
local base = LuaSkillBase
bs_10285.config = {
  effectId = 10865,
  buffId_live = 3009,
  nanaka_buffId = 102603,
  heal_config = {
    baseheal_formula = 501,
    heal_number = 0,
    correct_formula = 9990
  }
}

function bs_10285:ctor()
end

function bs_10285:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_10285_2", 1, self.OnSetDeadHurt)
  self.caster.recordTable.time_limit_10285 = 1
end

function bs_10285:OnSetDeadHurt(context)
  if context.target == self.caster and context.hurt >= context.target.hp and self.caster.recordTable.time_limit_10285 > 0 and 0 >= context.target:GetBuffTier(self.config.nanaka_buffId) then
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_live, 1, 1, true)
    self.caster.recordTable.time_limit_10285 = 0
    LuaSkillCtrl:StartTimer(nil, 1, function()
      if context.target == nil or context.target.hp <= 0 then
        return
      end
      local healNum = context.target.maxHp * self.arglist[1] // 1000
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
      LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {healNum}, true, true)
      skillResult:EndResult()
      LuaSkillCtrl:CallEffect(context.target, self.config.effectId, self)
    end)
  end
end

function bs_10285:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10285
