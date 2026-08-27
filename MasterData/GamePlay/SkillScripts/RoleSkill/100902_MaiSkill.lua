local bs_100902 = class("bs_100902", LuaSkillBase)
local base = LuaSkillBase
bs_100902.config = {
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
  buffId_blind = 3012,
  buffId_cdreduce = 100905,
  effectId_hit = 100907,
  weaponLv = 0
}

function bs_100902:ctor()
end

function bs_100902:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.effect = {}
  self.time = 1
  self.hitboxtime = 0
end

function bs_100902:PlaySkill(data)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
end

function bs_100902:OnAttackTrigger()
  local gridTemp = LuaSkillCtrl:CallFindGridMostRolesArounded(2)
  if gridTemp == nil then
    return
  end
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
      self:OnSkillDamageEnd()
    end)
    self.time = self.time + 1
  end
end

function bs_100902:OnEnter(collider, index, entity)
  self.hitboxtime = self.hitboxtime + 1
  if entity.intensity ~= 0 then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_blind, 1, self.arglist[2])
    if 2 <= self.config.weaponLv then
      LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_cdreduce, 1)
    end
  end
end

function bs_100902:OnExite(collider, entity)
  self.hitboxtime = self.hitboxtime - 1
  if self.hitboxtime == 0 and 0 < entity:GetBuffTier(self.config.buffId_cdreduce) then
    LuaSkillCtrl:DispelBuff(entity, self.config.buffId_cdreduce)
  end
end

function bs_100902:OnCollisionStay(Collider, role)
  if LuaSkillCtrl.battleCtrl.frame == self.colliDetectTime then
    self._callHurt(role)
    self.colliDetectTime = LuaSkillCtrl.battleCtrl.frame
  elseif LuaSkillCtrl.battleCtrl.frame - self.colliDetectTime >= 14 then
    self.colliDetectTime = LuaSkillCtrl.battleCtrl.frame + 1
  end
end

function bs_100902:CallHurt(effect, target)
  if target ~= nil and effect ~= nil then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_hit, self)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.arglist[1]
    })
    skillResult:EndResult()
  end
end

function bs_100902:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_100902:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

return bs_100902
