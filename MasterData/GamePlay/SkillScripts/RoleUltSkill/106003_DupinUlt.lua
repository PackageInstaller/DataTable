local bs_106003 = class("bs_106003", LuaSkillBase)
local base = LuaSkillBase
bs_106003.config = {
  effectId_new = 106015,
  effectId_attack = 106016,
  effectId_hit = 106013,
  effectId_hit2 = 106013,
  effectId_nil = 104110,
  hurtConfigId = 3,
  HurtConfigID = 19,
  heal_resultId = 6,
  buffId_1 = 106005,
  buffId_2 = 106003,
  buffId_3 = 106004,
  buffId_dodge = 3023,
  buffId_3024 = 3024,
  skill_time = 38,
  start_time = 8,
  actionId = 1043,
  action_speed = 1,
  audioIdStart = 106008,
  audioIdMovie = 106009,
  audioIdEnd = 106010
}

function bs_106003:ctor()
end

function bs_106003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_106003:PlaySkill(data, selectTargetCoord, selectRoles)
  self:CallCasterWait(20)
  if selectRoles.Count ~= 0 and selectRoles[0] ~= nil and 0 < selectRoles[0].hp then
    LuaSkillCtrl:CallBuff(self, selectRoles[0], self.config.buffId_1, 1, self.arglist[1])
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_2, 1, self.arglist[1])
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_dodge, 1, self.arglist[1])
  local allFriendRoles = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  local count = allFriendRoles.Count
  if count <= 0 then
    return
  end
  for i = 0, count - 1 do
    if allFriendRoles[i] ~= self.caster then
      LuaSkillCtrl:CallBuff(self, allFriendRoles[i], self.config.buffId_2, 1, self.arglist[1])
      LuaSkillCtrl:CallBuff(self, allFriendRoles[i], self.config.buffId_dodge, 1, self.arglist[1])
    end
  end
  LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
    if self.caster ~= nil and self.caster.hp > 0 and selectRoles.Count ~= 0 and selectRoles[0] ~= nil and 0 < selectRoles[0].hp then
      LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, self.config.start_time, true)
      self:CallCasterWait(self.config.skill_time)
      self.caster:LookAtTarget(selectRoles[0])
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, selectRoles[0])
      LuaSkillCtrl:StartTimer(nil, self.config.start_time, attackTrigger, self)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_3024, 1, self.config.start_time, true)
      LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId, self.config.action_speed)
      if LuaSkillCtrl:GetRoleGridsDistance(self.caster, selectRoles[0]) == 1 then
        LuaSkillCtrl:CallEffect(selectRoles[0], self.config.effectId_attack, self)
      end
    end
  end)
end

function bs_106003:OnAttackTrigger(target)
  if LuaSkillCtrl:GetRoleGridsDistance(self.caster, target) == 1 then
    LuaSkillCtrl:CallEffect(target, self.config.effectId_hit, self)
    self:realHurt(target)
  else
    local cusEffect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_nil, self)
    cusEffect.lsObject.localPosition = self.caster.lsObject.localPosition
    local collisionTrigger = BindCallback(self, self.OnCollision, target)
    LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 15, 7, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, nil, true, true)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_new, self)
  end
end

function bs_106003:OnCollision(target, collider, index, entity)
  if entity == target then
    self:realHurt(target)
  end
end

function bs_106003:realHurt(target)
  if target ~= nil and target.hp > 0 then
    local hurt = self.arglist[2]
    if 0 < self.caster:GetBuffTier(self.config.buffId_3) then
      hurt = hurt + self.arglist[3] * self.caster:GetBuffTier(self.config.buffId_3)
    end
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_3, 0)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_hit2, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfigId, {hurt})
    skillResult:EndResult()
  end
end

function bs_106003:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1.5)
end

function bs_106003:PlayUltEffect(data, selectTargetCoord, selectRoles)
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_106003:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_106003:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_106003:OnCasterDie()
  base.OnCasterDie(self)
  if self.Remove ~= nil then
    self.Remove:Stop()
    self.Remove = nil
  end
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_106003:LuaDispose()
  base.LuaDispose(self)
  if self.Remove ~= nil then
    self.Remove:Stop()
    self.Remove = nil
  end
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_106003
