local bs_91012 = class("bs_91012", LuaSkillBase)
local base = LuaSkillBase
bs_91012.config = {buffId = 2010, buffTier = 5}

function bs_91012:ctor()
end

function bs_91012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_91012_10", 1, self.OnRoleDie)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_91012_1", 1, self.OnAfterBattleStart)
end

function bs_91012:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
end

function bs_91012:OnRoleDie(killer, role)
  if killer == self.caster and role.belongNum ~= 0 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 1)
  end
end

function bs_91012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_91012
