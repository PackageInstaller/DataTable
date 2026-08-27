local bs_20016 = class("bs_20016", LuaSkillBase)
local base = LuaSkillBase
bs_20016.config = {
  formula = 10106,
  effectId = 10865,
  buffFeature_wudi = 2
}

function bs_20016:ctor()
end

function bs_20016:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_20016_2", 1, self.OnSetDeadHurt, nil, nil, nil, eBattleRoleBelong.enemy)
  self.caster.recordTable.time_limit_20016 = 1
end

function bs_20016:OnSetDeadHurt(context)
  if context.target.belongNum == 2 and context.hurt >= context.target.hp and self.caster.recordTable.time_limit_20016 > 0 then
    local buffTier = LuaSkillCtrl:RoleContainsBuffFeature(context.target, self.config.buffFeature_wudi)
    if buffTier == false then
      self.caster.recordTable.time_limit_20016 = 0
      local healNum = context.target.maxHp * self.arglist[1] // 1000
      LuaSkillCtrl:CallHeal(healNum, self, context.target, true, context.target)
      LuaSkillCtrl:CallEffect(context.target, self.config.effectId, self)
    end
  end
end

function bs_20016:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20016
