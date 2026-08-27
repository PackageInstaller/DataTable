local bs_4010417 = class("bs_4010417", LuaSkillBase)
local base = LuaSkillBase
bs_4010417.config = {buffId = 2073}

function bs_4010417:ctor()
end

function bs_4010417:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_4010417_1", 10, self.OnRoleDie, self.caster)
end

function bs_4010417:OnRoleDie(killer, role)
  if role.roleType ~= eBattleRoleType.character then
    return
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, false)
end

function bs_4010417:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010417
