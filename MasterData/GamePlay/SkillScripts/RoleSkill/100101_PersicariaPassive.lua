local bs_100101 = class("bs_100101", LuaSkillBase)
local base = LuaSkillBase
bs_100101.config = {
  effectId_line = 100103,
  effectId_PassHit = 100104,
  buffId_live = 3009,
  nanaka_buffId = 102603,
  heal_config = {baseheal_formula = 3021},
  selectId = 20,
  selectRange = 10
}

function bs_100101:ctor()
end

function bs_100101:InitSkill(isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_100101_1", 950, self.OnSetDeadHurt, nil, nil, nil, self.caster.belongNum, nil, 1)
end

function bs_100101:OnSetDeadHurt(context)
  local NoDeath = LuaSkillCtrl:RoleContainsBuffFeature(context.target, eBuffFeatureType.NoDeath)
  if self:IsReadyToTake() and context.target.belongNum == self.caster.belongNum and context.target.roleType == 1 and context.target ~= context.sender and context.target:GetBuffTier(self.config.nanaka_buffId) <= 0 and NoDeath == false then
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_live, 1, 1, true)
    LuaSkillCtrl:CallEffect(context.target, self.config.effectId_line, self)
    LuaSkillCtrl:CallEffect(context.target, self.config.effectId_PassHit, self)
    LuaSkillCtrl:StartTimer(nil, 1, function()
      if context.target == nil or context.target.hp <= 0 then
        return
      end
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target)
      LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
        self.arglist[1]
      }, false, false)
      skillResult:EndResult()
    end)
    self:OnSkillTake()
  end
end

function bs_100101:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100101
