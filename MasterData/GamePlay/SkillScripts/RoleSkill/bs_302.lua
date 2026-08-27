local bs_302 = class("bs_302", LuaSkillBase)
local base = LuaSkillBase
bs_302.config = {
  hurt_config1 = {
    def_formula = 9996,
    basehurt_formula = 10031,
    minhurt_formula = 9994,
    correct_formula = 9989
  },
  hurt_config2 = {
    def_formula = 9996,
    basehurt_formula = 10032,
    minhurt_formula = 9994,
    correct_formula = 9989
  },
  effectId1 = 10131,
  effectId2 = 10132,
  buffId = 134
}

function bs_302:ctor()
end

function bs_302:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_302_1", 1, self.OnAfterHurt, nil, nil, nil, nil, nil, nil, 302)
end

function bs_302:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if hurt >= target.hp and skill.dataId == 302 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_302:PlaySkill(data)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 10)
  if targetList.Count == 0 then
    return
  end
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self.caster:LookAtTarget(targetList[0].targetRole)
  self:CallCasterWait(30)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, targetList[0].targetRole, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 20, attackTrigger)
end

function bs_302:OnAttackTrigger(target, date)
  local Effect_302_1 = LuaSkillCtrl:CallEffect(target, self.config.effectId1, self, nil, nil, 1, true)
  self.hurtIndex = 0
  local collisionTrigger = BindCallback(self, self.OnCollision1)
  self.__onOver = BindCallback(self, self.OnOver)
  local ariveFunc = BindCallback(self, self.self.OnEmissionArrive)
  local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 40, 8, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, Effect_302_1, true, false, ariveFunc)
end

function bs_302:OnCollision1(collider, index, entity)
  LuaSkillCtrl:CallEffect(entity, self.config.effectId2, self)
  if self.hurtIndex == 0 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config1)
    skillResult:EndResult()
  elseif self.hurtIndex == 1 then
    local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
    skillResult1:HurtResult(self.config.hurt_config2)
    skillResult1:EndResult()
  end
end

function bs_302:OnEmissionArrive(skillEmission)
  self.hurtIndex = self.hurtIndex + 1
  LuaSkillCtrl:CallRestartEmit(self, skillEmission, 8, self.caster, true, true, self.__onOver)
end

function bs_302:OnOver()
  self.hurtIndex = 0
end

function bs_302:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_302
