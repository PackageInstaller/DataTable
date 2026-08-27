local bs_1009022 = class("bs_1009022", LuaSkillBase)
local base = LuaSkillBase
bs_1009022.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    crithur_ratio = 0
  },
  effectIdTornado2 = 100906,
  effetcIdTornadoRadius = 100,
  skill_time = 28,
  start_time = 12,
  actionId = 1002,
  action_speed = 1,
  effectId_start = 100905,
  buffId_blind = 301201,
  effectId_hit = 100907
}

function bs_1009022:ctor()
end

function bs_1009022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.effect = {}
  self.time = 1
end

function bs_1009022:PlaySkill(data)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
end

function bs_1009022:OnAttackTrigger()
  local gridTemp = LuaSkillCtrl:CallFindGridMostRolesArounded(1)
  local gridTarget = LuaSkillCtrl:GetTargetWithGrid(gridTemp.x, gridTemp.y)
  if gridTarget ~= nil then
    local time = self.time
    self.effect[time] = LuaSkillCtrl:CallEffect(gridTarget, self.config.effectIdTornado2, self, nil, nil, nil, false)
    self._callHurt = BindCallback(self, self.CallHurt, self.effect[time])
    local _onCollision = BindCallback(self, self.OnCollisionStay)
    local _onEnter = BindCallback(self, self.OnEnter)
    local _onExite = BindCallback(self, self.OnExite)
    LuaSkillCtrl:CallAddCircleColliderForEffect(self.effect[time], self.config.effetcIdTornadoRadius, eColliderInfluenceType.Enemy, _onCollision, _onEnter, _onExite)
    self.colliDetectTime = LuaSkillCtrl.battleCtrl.frame
    LuaSkillCtrl:StartTimer(nil, self.arglist[2], function()
      if self.effect ~= nil and self.effect[time] ~= nil then
        self.effect[time]:Die()
        self.effect[time] = nil
      end
    end)
    self.time = self.time + 1
  end
end

function bs_1009022:OnEnter(collider, index, entity)
  if entity.intensity ~= 0 then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_blind, 1, self.arglist[2])
  end
end

function bs_1009022:OnExite(collider, entity)
end

function bs_1009022:OnCollisionStay(Collider, role)
  if LuaSkillCtrl.battleCtrl.frame == self.colliDetectTime then
    self._callHurt(role)
    self.colliDetectTime = LuaSkillCtrl.battleCtrl.frame
  elseif LuaSkillCtrl.battleCtrl.frame - self.colliDetectTime >= 14 then
    self.colliDetectTime = LuaSkillCtrl.battleCtrl.frame + 1
  end
end

function bs_1009022:CallHurt(effect, target)
  if target ~= nil and effect ~= nil then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_hit, self)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.arglist[1]
    })
    skillResult:EndResult()
  end
end

function bs_1009022:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_1009022:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

return bs_1009022
