local bs_301 = class("bs_301", LuaSkillBase)
local base = LuaSkillBase
bs_301.config = {
  hurt_config = {
    def_formula = 9996,
    basehurt_formula = 10031,
    minhurt_formula = 9994,
    correct_formula = 9989
  },
  buffId1 = 130,
  buffId2 = 66,
  buffId3 = 131,
  buffId4 = 132,
  effectId1 = 10128,
  effectId2 = 10129,
  effectId3 = 10130
}

function bs_301:ctor()
end

function bs_301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_301:PlaySkill(data)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 32, 10)
  if targetList.Count == 0 then
    return
  end
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self.caster:LookAtTarget(targetList[0].targetRole)
  self:CallCasterWait(30)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, targetList[0].targetRole, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 20, attackTrigger)
end

function bs_301:OnAttackTrigger(target, data)
  local Effect_301 = LuaSkillCtrl:CallEffect(target, self.config.effectId2, self, nil, nil, 1, true)
  local roadTrigger = BindCallback(self, self.CallBack, target)
  local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 40, 3, eColliderInfluenceType.Enemy, roadTrigger, nil, nil, Effect_301, false, true, nil)
  self.caster.recordTable["301_effect_bj"] = LuaSkillCtrl:CallEffect(target, self.config.effectId3, self)
end

function bs_301:CallBack(target, collider, index, entity)
  LuaSkillCtrl:CallEffect(entity, self.config.effectId1, self)
  LuaSkillCtrl:CallBuff(self, entity, self.config.buffId1, 1, 10)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config)
  skillResult:EndResult()
  if entity == target then
    LuaSkillCtrl:StartTimer(self, 10, function()
      LuaSkillCtrl:CallBuff(self, entity, self.config.buffId2, 1, self.arglist[2])
    end, self, 0, 0)
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId3, 1, self.arglist[2] + self.arglist[3] + 10)
    if 0 <= self.arglist[4] then
      LuaSkillCtrl:CallBuff(self, entity, self.config.buffId4, 1, self.arglist[2] + self.arglist[3] + 10)
    end
  end
  if entity == target and self.caster.recordTable["301_effect_bj"] ~= nil then
    self.caster.recordTable["301_effect_bj"]:Die()
    self.caster.recordTable["301_effect_bj"] = nil
  end
end

function bs_301:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_301
