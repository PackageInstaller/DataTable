local bs_91013 = class("bs_91013", LuaSkillBase)
local base = LuaSkillBase
bs_91013.config = {buffId = 2011}

function bs_91013:ctor()
end

function bs_91013:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_91013_11", 1, self.OnRoleDie)
end

function bs_91013:OnRoleDie(killer, role, killSkill)
  if killer == self.caster and role.belongNum == 2 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_91013:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_91013
