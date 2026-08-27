local bs_1031072 = class("bs_1031072", LuaSkillBase)
local base = LuaSkillBase
bs_1031072.config = {
  buffId_26 = 26,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 10152,
    crit_formula = 0,
    crithur_ratio = 0
  }
}

function bs_1031072:ctor()
end

function bs_1031072:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_1031072_3", 1, self.OnAfterHurt, self.caster)
end

function bs_1031072:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and self.caster ~= nil and skill.isCommonAttack == true then
    LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_bird, self, false, true, self.SkillEventFunc, self.caster)
  end
end

function bs_1031072:SkillEventFunc(sender, effect, eventId, target)
  if sender == nil or eventId ~= eBattleEffectEvent.Trigger or sender.recordTable == nil then
    return
  end
  local cskill = sender.recordTable.caster_cskill
  local skill_int = sender.recordTable.skill_int
  local arg = sender.recordTable.Atk_arg
  if cskill == nil or skill_int == nil or arg == nil then
    return
  end
  local hurt = LuaSkillCtrl:CallFormulaNumber(10160, target.targetRole, target.targetRole, skill_int, arg)
  LuaSkillCtrl:RemoveLifeWithCSkill(hurt, cskill, target.targetRole, true, nil, true, true)
  LuaSkillCtrl:PlayAuHit(self, target)
end

function bs_1031072:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1031072
