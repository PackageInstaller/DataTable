local bs_4008 = class("bs_4008", LuaSkillBase)
local base = LuaSkillBase
bs_4008.config = {buffId_1005 = 40081}

function bs_4008:ctor()
end

function bs_4008:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_200402_10", 1, self.OnRoleDie)
end

function bs_4008:OnRoleDie(killer, role)
  if killer == self.caster and role.belongNum == 2 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1005, 1, nil, true)
  end
end

function bs_4008:LuaDispose()
  base.LuaDispose(self)
end

function bs_4008:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4008
