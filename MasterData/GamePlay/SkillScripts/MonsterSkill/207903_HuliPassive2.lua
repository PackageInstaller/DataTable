local bs_207903 = class("bs_207903", LuaSkillBase)
local base = LuaSkillBase
bs_207903.config = {
  buffId_csbuff = 207901,
  effectId_trail = 207904,
  time_heal = 4
}

function bs_207903:ctor()
end

function bs_207903:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_207903_10", 1, self.OnRoleDie)
end

function bs_207903:OnRoleDie(killer, role)
  if role.belongNum == self.caster.belongNum then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_trail, self, nil, role)
  end
  LuaSkillCtrl:StartTimer(nil, self.config.time_heal, function()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_csbuff, 1)
  end)
end

function bs_207903:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_207903
