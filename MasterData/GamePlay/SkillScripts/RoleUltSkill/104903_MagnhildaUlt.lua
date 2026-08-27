local bs_104903 = class("bs_104903", LuaSkillBase)
local base = LuaSkillBase
bs_104903.config = {
  buffId_passive = 104901,
  attackTime = 4,
  effectId_attack = 104914,
  effectId_hit = 104920,
  hurtConfigId = 2,
  actionId_end = 1006,
  audioIdStart = 104911,
  audioIdMovie = 104912,
  audioId_hit = 104914,
  audioId_bigHit = 104916
}

function bs_104903:ctor()
end

function bs_104903:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104903:PlaySkill(data, selectTargetCoord, selectRoles)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  if selectRoles == nil or selectRoles.Count <= 0 then
    return
  end
  local role = selectRoles[0]
  if role ~= nil and role.belongNum ~= self.caster.belongNum then
    local numTime = 4
    local Times = 0
    self.up = 1
    if 0 < self.caster:GetBuffTier(self.config.buffId_passive) then
      local tier = self.caster:GetBuffTier(self.config.buffId_passive)
      self.up = self.up + tier
    end
    local waitTime = 4 * numTime + 20
    self:CallCasterWait(waitTime)
    self.caster:LookAtTarget(role)
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_passive, 0)
    local effect = LuaSkillCtrl:CallEffect(role, self.config.effectId_attack, self)
    LuaSkillCtrl:StartTimer(nil, self.config.attackTime * numTime + 3, function()
      if effect ~= nil then
        effect:Die()
        effect = nil
      end
    end)
    LuaSkillCtrl:StartTimer(nil, self.config.attackTime, function()
      if role ~= nil and role.hp > 0 and self.caster ~= nil and 0 < self.caster.hp then
        Times = Times + 1
        if Times == 5 then
          LuaSkillCtrl:StartTimer(nil, 5, function()
            if role ~= nil and role.hp > 0 and self.caster ~= nil and 0 < self.caster.hp then
              LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_hit, self, nil, role)
              local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
              LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfigId, {
                self.arglist[1] * self.up
              })
              skillResult:EndResult()
              LuaSkillCtrl:PlayAuSource(role, self.config.audioId_hit)
            end
          end)
        else
          LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_hit, self, nil, role)
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfigId, {
            self.arglist[1]
          })
          skillResult:EndResult()
          LuaSkillCtrl:PlayAuSource(role, self.config.audioId_bigHit)
        end
      else
        if self.caster ~= nil and 0 < self.caster.hp then
          LuaSkillCtrl:CallBreakAllSkill(self.caster)
        end
        if effect ~= nil then
          effect:Die()
          effect = nil
        end
      end
    end, self, numTime, self.config.attackTime - 1)
  end
end

function bs_104903:SkillEventFunc(effect, eventId, target)
  if not (target ~= nil and target.targetRole.hp > 0) or eventId == eBattleEffectEvent.Trigger then
  end
end

function bs_104903:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_104903:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

function bs_104903:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_104903:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_104903:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104903
