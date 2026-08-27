local bs_213301 = class("bs_213301", LuaSkillBase)
local base = LuaSkillBase
bs_213301.config = {
  buff_boom = 213202,
  buff_damres = 213303,
  buff_damres_de = 213304,
  buff_stun = 1
}

function bs_213301:ctor()
end

function bs_213301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_213301_1", 1, self.OnAfterBattleStart)
  self:AddAfterAddBuffTrigger("bs_213301_2", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, self.config.buff_boom)
end

function bs_213301:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_damres, 1)
end

function bs_213301:OnAfterAddBuff(target, context)
  if self.caster:GetBuffTier(self.config.buff_boom) >= self.arglist[2] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_damres_de, 1, self.arglist[4])
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_stun, 1, self.arglist[4])
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_boom, self.arglist[2])
  end
end

function bs_213301:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_213301
