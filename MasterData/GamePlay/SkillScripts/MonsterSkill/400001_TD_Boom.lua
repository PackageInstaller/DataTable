local bs_400001 = class("bs_400001", LuaSkillBase)
local base = LuaSkillBase
bs_400001.config = {
  abandonMoveBuff = 1223,
  countDownDuration = 75,
  latestAtkEffect = 12006,
  BoomEffectTime = 12007,
  BoomEffectTime2 = 12022,
  BoomEffect = 12005,
  startCD = 45
}

function bs_400001:ctor()
end

function bs_400001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.countDownEffect = nil
  self.boomTimer = LuaSkillCtrl:StartTimer(nil, self.config.startCD, self.startBoom, self)
end

function bs_400001:startBoom()
  if self.boomTimer ~= nil then
    self.boomTimer:Stop()
    self.boomTimer = nil
  end
  if self.caster == nil or self.caster.hp <= 0 then
    return
  end
  local TargetCampRole = self.caster:GetRoleMoveFollowTarget()
  if TargetCampRole ~= nil and self.caster ~= nil then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.abandonMoveBuff, 1, self.config.countDownDuration + 15, true)
    local collisionTrigger = BindCallback(self, self.KillAllMonsterAndDamageToCamp, TargetCampRole)
    LuaSkillCtrl:CallEffect(self.caster, self.config.BoomEffectTime, self)
    LuaSkillCtrl:StartTimer(nil, self.config.countDownDuration, collisionTrigger)
    if self.countDownEffect == nil then
      self.time = 1
      LuaSkillCtrl:StartTimer(self, 15, function()
        if self.time >= 5 then
          self.countDownEffect:Die()
          self.countDownEffect = nil
          return
        end
        if self.time == 1 then
          self.countDownEffect = LuaSkillCtrl:CallEffect(self.caster, self.config.BoomEffectTime2, self)
        else
          self.countDownEffect = LuaSkillCtrl:CallEffect(self.caster, self.config.BoomEffectTime, self)
        end
        if not LuaSkillCtrl.IsInVerify then
          self.countDownEffect:SetCountValue(self.time)
        end
        self.time = self.time + 1
      end, self, 4)
    end
  end
end

function bs_400001:KillAllMonsterAndDamageToCamp(TargetCampRole)
  if self.caster ~= nil and self.caster.hp > 0 then
    LuaSkillCtrl:CallEffectWithArgAndSpeedOverride(TargetCampRole, self.config.latestAtkEffect, self, self.caster, 1, false, false, self.EffectEventTrigger)
  end
end

function bs_400001:EffectEventTrigger(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local targetRole = target.targetRole
    if targetRole ~= nil and targetRole.hp > 0 then
      LuaSkillCtrl:RemoveLife(targetRole.maxHp // 8 + 1, self, target, true, nil, true, true)
    end
    if 0 < self.caster.hp then
      LuaSkillCtrl:CallEffect(self.caster, self.config.BoomEffect, self)
      LuaSkillCtrl:RemoveLife(self.caster.hp + 1, self, self.caster, true, nil, true, true)
    end
  end
end

function bs_400001:OnCasterDie()
  if self.countDownEffect ~= nil then
    self.countDownEffect:Die()
    self.countDownEffect = nil
  end
  if self.boomTimer ~= nil then
    self.boomTimer:Stop()
    self.boomTimer = nil
  end
  base.OnCasterDie(self)
end

function bs_400001:LuaDispose()
  base.LuaDispose(self)
  self.countDownEffect = nil
end

return bs_400001
