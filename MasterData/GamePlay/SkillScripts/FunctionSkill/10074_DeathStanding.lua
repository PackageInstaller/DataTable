local bs_10074 = class("bs_10074", LuaSkillBase)
local base = LuaSkillBase
bs_10074.config = {buffId = 1141, buffTier = 1}

function bs_10074:ctor()
end

function bs_10074:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10074_1", 1, self.OnRoleDie)
end

function bs_10074:OnRoleDie(killer, role)
  self:PlayChipEffect()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
end

function bs_10074:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10074
