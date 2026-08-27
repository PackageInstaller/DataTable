local bs_305801 = class("bs_305801", LuaSkillBase)
local base = LuaSkillBase
bs_305801.config = {
  effectId_xb = 105801,
  hurtConfig = 13,
  buffIdys = 105801,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 2
  }
}

function bs_305801:ctor()
end

function bs_305801:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_305803_2", 1, self.OnRoleDie)
  self.caster.recordTable["305801_Roll"] = self.arglist[1]
  self.caster.recordTable["305801_arg2"] = self.arglist[2]
  self.caster.recordTable["305801_arg3"] = self.arglist[3]
end

function bs_305801:OnRoleDie(killer, role)
  if (killer == self.caster or role:GetBuffTier(self.config.buffIdys) >= 1) and role.belongNum ~= self.caster.belongNum and role.hp == 0 and role ~= nil and role.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:CallEffect(role, self.config.effectId_xb, self)
    LuaSkillCtrl:StartTimer(nil, 12, function()
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role, self.config.aoe_config)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
        self.arglist[4]
      })
      skillResult:EndResult()
    end)
  end
end

function bs_305801:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_305801
