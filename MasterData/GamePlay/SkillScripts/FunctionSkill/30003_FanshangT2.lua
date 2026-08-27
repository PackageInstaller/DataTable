local bs_30003 = class("bs_30003", LuaSkillBase)
local base = LuaSkillBase
bs_30003.config = {
  realDamageConfig = {
    hit_formula = 0,
    def_formula = 0,
    basehurt_formula = 502,
    minhurt_formula = 9994,
    crit_formula = 0,
    crithur_ratio = 0,
    correct_formula = 9989,
    lifesteal_formula = 1001,
    spell_lifesteal_formula = 1002,
    returndamage_formula = 1000,
    hurt_type = 2
  },
  effectId1 = 10890,
  effectId2 = 10889
}

function bs_30003:ctor()
end

function bs_30003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_30003_2", 10, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_30003_3", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_30003:OnAfterBattleStart()
  self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, self, -1)
  self.damage = 0
end

function bs_30003:OnArriveAction()
  self:PlayChipEffect()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local target = self.caster.recordTable.lastAttackRole
  if target == nil or target.hp <= 0 then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
    if targetlist.Count < 1 then
      self.damage = 0
      return
    end
    target = targetlist[0].targetRole
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.realDamageConfig, {
    self.damage
  }, nil, true)
  skillResult:EndResult()
  LuaSkillCtrl:CallEffect(target, self.config.effectId2, self)
  self.damage = 0
end

function bs_30003:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and not isMiss and not isTriggerSet then
    self.damage = self.damage + hurt
  end
end

function bs_30003:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

return bs_30003
