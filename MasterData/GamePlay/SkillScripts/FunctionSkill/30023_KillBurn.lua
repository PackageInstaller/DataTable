local bs_30023 = class("bs_30023", LuaSkillBase)
local base = LuaSkillBase
bs_30023.config = {buffId = 1179, buffTier = 1}

function bs_30023:ctor()
end

function bs_30023:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_30023_10", 1, self.OnRoleDie)
end

function bs_30023:OnRoleDie(killer, role)
  if killer == self.caster and role.belongNum ~= 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, self.arglist[2], true)
  end
end

function bs_30023:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30023
