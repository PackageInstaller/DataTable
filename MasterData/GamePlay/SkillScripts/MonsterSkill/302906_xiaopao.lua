local bs_302906 = class("bs_302906", LuaSkillBase)
local base = LuaSkillBase
bs_302906.config = {
  configId = 5,
  effectId = 12091,
  buffId = 2147
}

function bs_302906:ctor()
end

function bs_302906:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, nil, -1, self.config.timeDelay)
  local arriveCallBack1 = BindCallback(self, self.OnArriveAction1)
  self.timer2 = LuaSkillCtrl:StartTimer(nil, self.arglist[3], arriveCallBack1, nil, -1)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  self.maxRole = nil
  LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3(1.3, 1.3, 1.3), 0.2)
end

function bs_302906:OnArriveAction1()
  if self.timer2 ~= nil and self.timer2:IsOver() then
    self.timer2 = nil
  end
  LuaSkillCtrl:RemoveLife(self.caster.maxHp * 2, self, self.caster, true, nil, false, true, 2, true)
end

function bs_302906:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetlist.Count < 1 then
    return
  end
  local target = targetlist[0]
  if target == nil then
    return
  end
  self.caster:LookAtTarget(target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  local collisionTrigger = BindCallback(self, self.OnCollision, target)
  LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 15, 10, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, nil, true, true, nil, nil)
end

function bs_302906:OnCollision(target, collider, index, entity)
  if self.caster == nil or self.caster.hp <= 0 then
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
    self.caster.skill_intensity * self.arglist[2] // 1000
  }, true, true)
  skillResult:EndResult()
end

function bs_302906:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  if self.timer2 ~= nil then
    self.timer2:Stop()
    self.timer2 = nil
  end
end

function bs_302906:LuaDispose()
  base.LuaDispose(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  if self.timer2 ~= nil then
    self.timer2:Stop()
    self.timer2 = nil
  end
end

return bs_302906
