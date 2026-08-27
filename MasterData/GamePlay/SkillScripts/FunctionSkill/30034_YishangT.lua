local bs_30034 = class("bs_30034", LuaSkillBase)
local base = LuaSkillBase
bs_30034.config = {
  effectId = 10900,
  effectId2 = 10901,
  buffId = 1059,
  aoe_config = {
    effect_shape = 2,
    aoe_select_code = 5,
    aoe_range = 1
  },
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10088,
    minhurt_formula = 9994,
    crit_formula = 0
  }
}

function bs_30034:ctor()
end

function bs_30034:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_30034_3", 3, self.OnAfterPlaySkill)
  self:AddAfterHurtTrigger("bs_30034_2", 20, self.OnAfterHurt, self.caster)
  self.caster.recordTable["30034_attackflag"] = false
end

function bs_30034:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if skill.maker == self.caster and skill.isCommonAttack and self.caster.recordTable["30034_attackflag"] and not isTriggerSet then
    local loopTime = self.arglist[1]
    local loopJiange = self.arglist[3] // self.arglist[1]
    local arriveCallBack = BindCallback(self, self.OnArriveAction, target)
    local arriveCallBack1 = BindCallback(self, self.OnArriveAction1, target)
    if self.effect == nil then
      self.effect = LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
    end
    if self.timer == nil then
      self.timer = LuaSkillCtrl:StartTimer(nil, loopJiange, arriveCallBack, self, loopTime - 1, loopJiange)
    end
    LuaSkillCtrl:StartTimer(nil, self.arglist[3], arriveCallBack1, self)
    self.caster.recordTable["30034_attackflag"] = false
  end
end

function bs_30034:OnArriveAction1(role)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  LuaSkillCtrl:CallEffect(role, self.config.effectId2, self)
end

function bs_30034:OnArriveAction(role)
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role, self.config.aoe_config)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
  skillResult:EndResult()
end

function bs_30034:OnAfterPlaySkill(skill, role)
  if self.caster.recordTable["104502_active"] == false then
    return
  end
  if skill.maker == self.caster and not skill.isCommonAttack then
    self.caster.recordTable["30034_attackflag"] = true
  end
end

function bs_30034:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30034
