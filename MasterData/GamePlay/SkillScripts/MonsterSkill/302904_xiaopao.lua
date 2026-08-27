local bs_302904 = class("bs_302904", LuaSkillBase)
local base = LuaSkillBase
bs_302904.config = {
  timeDelay = 30,
  hurt_config = 14,
  effectId = 12090
}

function bs_302904:ctor()
end

function bs_302904:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.config.timeDelay, arriveCallBack, nil, -1, self.config.timeDelay)
end

function bs_302904:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 7, 10)
  if targetlist.Count < 1 then
    return
  end
  local target = targetlist[0].targetRole
  if target == nil then
    return
  end
  self.caster:LookAtTarget(target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  local collisionTrigger = BindCallback(self, self.OnCollision, target)
  LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 15, 10, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, nil, true, true, nil, nil)
end

function bs_302904:OnCollision(target, collider, index, entity)
  if self.caster == nil or self.caster.hp <= 0 then
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurt_config, {
    self.arglist[1]
  }, true, true)
  skillResult:EndResult()
end

function bs_302904:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_302904
