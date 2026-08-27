local bs_1033012 = class("bs_1033012", LuaSkillBase)
local base = LuaSkillBase
bs_1033012.config = {buffId_att = 10330401, buffId_int = 10330501}

function bs_1033012:ctor()
end

function bs_1033012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_1033012_10", 1, self.OnRoleDie)
  self.record = {}
end

function bs_1033012:OnRoleDie(killer, role)
  if role.belongNum ~= self.caster.belongNum and role.intensity ~= 0 and killer.belongNum == self.caster.belongNum then
    local pow_tier = role.pow * self.arglist[1] // 1000
    local int_tier = role.skill_intensity * self.arglist[1] // 1000
    if 0 < killer:GetBuffTier(self.config.buffId_att) or 0 < killer:GetBuffTier(self.config.buffId_int) then
      LuaSkillCtrl:DispelBuff(killer, self.config.buffId_att, 0, true)
      LuaSkillCtrl:DispelBuff(killer, self.config.buffId_int, 0, true)
    end
    if 0 < pow_tier then
      LuaSkillCtrl:CallBuff(self, killer, self.config.buffId_att, pow_tier, nil, true)
    end
    if 0 < int_tier then
      LuaSkillCtrl:CallBuff(self, killer, self.config.buffId_int, int_tier, nil, true)
    end
  end
end

function bs_1033012:LuaDispose()
  base.LuaDispose(self)
end

function bs_1033012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1033012
