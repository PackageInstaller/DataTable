local bs_105903 = class("bs_105903", LuaSkillBase)
local base = LuaSkillBase
bs_105903.config = {
  effectId_cast = 105911,
  effectId_trail = 105912,
  effectId_trail1 = 105913,
  HurtConfigID = 19,
  heal_resultId = 6,
  audioIdStart = 105913,
  audioIdMovie = 105914,
  audioIdEnd = 105915
}

function bs_105903:ctor()
end

function bs_105903:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddHurtResultEndTrigger("bs_105903", 30, self.OnHurtResultEnd, self.caster, nil, eBattleRoleBelong.player)
  self.skillState = nil
end

function bs_105903:PlaySkill(data)
  self:CallCasterWait(20)
  self.skillState = true
  local soulNum = self.arglist[1] + self.caster.recordTable.Soul_Num - 1
  LuaSkillCtrl:CallRoleAction(self.caster, 1006, 1)
  self.Remove = LuaSkillCtrl:StartTimer(nil, 3, function()
    self:Shoot()
  end, self, soulNum, 3)
  if self.timer == nil then
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], function()
      self.skillState = nil
    end, self)
  else
    self.timer:Stop()
    self.timer = nil
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], function()
      self.skillState = nil
    end, self)
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast, self)
end

function bs_105903:Shoot()
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 1) then
    target = last_target
  else
    local tempTarget = LuaSkillCtrl:CallTargetSelect(self, 19, 10)
    if 0 < tempTarget.Count then
      target = tempTarget[0].targetRole
    end
  end
  LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId_trail, self, self.caster, nil, nil, self.SoulAttack)
end

function bs_105903:SoulAttack(effect, eventId, target)
  if effect.dataId == self.config.effectId_trail and eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
      self.arglist[3]
    })
    skillResult:EndResult()
  end
end

function bs_105903:OnHurtResultEnd(skill, targetRole, hurtValue)
  if skill.maker == self.caster and skill.dataId == 105903 and self.skillState == true then
    LuaSkillCtrl:CallEffectWithArgOverride(skill.maker, self.config.effectId_trail1, self, targetRole, false, false, self.SoulHeal, hurtValue)
  end
end

function bs_105903:SoulHeal(hurtValue, effect, eventId, target)
  if effect.dataId == self.config.effectId_trail1 and eventId == eBattleEffectEvent.Trigger then
    if 0 < hurtValue then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
      LuaSkillCtrl:HealResultWithConfig(self, skillResult, self.config.heal_resultId, {
        self.arglist[4] // 1000 * hurtValue
      })
      skillResult:EndResult()
    end
    if self.skillState == true then
      self:Shoot()
    end
  end
end

function bs_105903:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1.5)
end

function bs_105903:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_105903:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_105903:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_105903:OnCasterDie()
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

function bs_105903:LuaDispose()
  base.LuaDispose(self)
end

return bs_105903
