local bs_27038 = class("bs_27038", LuaSkillBase)
local base = LuaSkillBase
bs_27038.config = {buff = 2301}

function bs_27038:ctor()
end

function bs_27038:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_27038", 1, self.OnRoleDie)
end

function bs_27038:OnRoleDie(killer, role)
  if role == self.caster and role.belongNum == eBattleRoleBelong.neutral then
    return
  end
  LuaSkillCtrl:CallHeal(self.caster.maxHp * self.arglist[1] // 1000, self, self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff, 1)
end

function bs_27038:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_27038
