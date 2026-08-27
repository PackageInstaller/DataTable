local bs_92090 = class("bs_92090", LuaSkillBase)
local base = LuaSkillBase
bs_92090.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10076,
    crit_formula = 0
  },
  effectIdAttack = 10254,
  buffId1 = 1203,
  buffId2 = 2079,
  buffId3 = 1121
}

function bs_92090:ctor()
end

function bs_92090:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_92090_3", 1, self.OnAfterHurt, nil, nil, nil, self.caster.belongNum)
end

function bs_92090:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.belongNum == self.caster.belongNum and isMiss and self.caster == target then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, self.arglist[1], false)
    if target.attackRange == 1 then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId3, 1, self.arglist[1], false)
    else
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, self.arglist[1], false)
    end
  end
end

function bs_92090:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92090
