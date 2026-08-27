local bs_4001219 = class("bs_4001219", LuaSkillBase)
local base = LuaSkillBase
bs_4001219.config = {
  effectId_line = 100103,
  effectId_PassHit = 100104,
  effectId = 10813,
  buffId_live = 3009,
  nanaka_buffId = 102603,
  real_Config = {
    hit_formula = 0,
    basehurt_formula = 502,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0,
    hurt_type = 2
  },
  selectId = 20,
  selectRange = 10
}

function bs_4001219:ctor()
end

function bs_4001219:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_4001219_1", 1, self.OnSetDeadHurt, nil, nil, nil, self.caster.belongNum)
  self.Times = 0
end

function bs_4001219:OnSetDeadHurt(context)
  local flag = false
  local summonList = LuaSkillCtrl:CallTargetSelect(self, 73, 10)
  local NoDeath = LuaSkillCtrl:RoleContainsBuffFeature(context.target, eBuffFeatureType.NoDeath)
  if self.Times == 0 and context.target.belongNum == self.caster.belongNum and context.target.roleType == 1 and context.target ~= context.sender and 0 >= context.target:GetBuffTier(self.config.nanaka_buffId) and NoDeath == false and 0 < summonList.Count then
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_live, 1, 1, true)
    LuaSkillCtrl:CallEffect(context.target, self.config.effectId, self)
    LuaSkillCtrl:StartTimer(nil, 1, function()
      if context.target == nil or context.target.hp <= 0 then
        return
      end
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target)
      LuaSkillCtrl:HealResultWithConfig(self, skillResult, 6, {
        context.hurt
      }, true, true)
      skillResult:EndResult()
    end)
    self.Times = 1
    flag = true
  end
  if flag == true and summonList.Count > 0 then
    for i = 0, summonList.Count - 1 do
      local damageResult = LuaSkillCtrl:CallSkillResultNoEffect(self, summonList[i].targetRole)
      local damage = context.hurt // summonList.Count
      if damage <= 0 then
        damage = 1
      end
      LuaSkillCtrl:RemoveLife(damage, self, summonList[i].targetRole, nil, nil, true, true, eHurtType.RealDmg, true)
    end
  end
end

function bs_4001219:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001219
