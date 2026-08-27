local bs_7021 = class("bs_7021", LuaSkillBase)
local base = LuaSkillBase
bs_7021.config = {
  hurt_config = {returndamage_formula = 1053}
}

function bs_7021:ctor()
end

function bs_7021:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_7021_1", 997, self.OnSetHurt, nil, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_7021_2", 10, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.HurtResultStart, "bs_7021_1", 2, self.OnHurtResultStart)
end

function bs_7021:OnAfterBattleStart()
  self.mhp = self.caster.maxHp * self.arglist[1] // 1000
  self.hp = self.caster.hp * self.arglist[1] // 1000
  self.caster:AddRoleProperty(eHeroAttr.maxHp, -self.mhp, eHeroAttrType.Extra)
  LuaSkillCtrl:RemoveLife(self.hp, self, self.caster, true, nil, true, true)
end

function bs_7021:OnSetHurt(context)
  context.hurt = self.arglist[2]
end

function bs_7021:OnHurtResultStart(skill, context)
  if context.target.return_damage > 0 then
    context.new_config = self.config.hurt_config
    setmetatable(context.new_config, {
      __index = context.config
    })
  end
end

function bs_7021:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_7021
