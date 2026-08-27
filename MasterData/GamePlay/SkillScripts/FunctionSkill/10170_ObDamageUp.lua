local bs_10170 = class("bs_10170", LuaSkillBase)
local base = LuaSkillBase
bs_10170.config = {buffId = 1205, buffTier = 1}

function bs_10170:ctor()
end

function bs_10170:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10170_2", 1, self.OnSetHurt, self.caster, nil, nil, eBattleRoleBelong.neutral)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10170_1", 2, self.OnRoleDie)
end

function bs_10170:OnSetHurt(context)
  if context.sender == self.caster and context.target.belongNum == 0 and context.target.intensity == 0 then
    context.hurtNumber:Add(context.target.maxHp)
  end
end

function bs_10170:OnRoleDie(killer, role)
  if role.intensity == 0 and role.belongNum == 0 and killer == self.caster then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
  end
end

function bs_10170:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10170
