local bs_106703 = class("bs_106703", LuaSkillBase)
local base = LuaSkillBase
bs_106703.config = {
  effectId_start = 106709,
  effectId_hit = 106710,
  buffId = 3011,
  audioIdStart = 106708,
  audioIdMovie = 106709,
  audioIdEnd = 106710,
  actionId_start = 1005,
  movieEndRoleActionId = 1006,
  HurtConfigId = 30,
  buffId_tr = 106702
}

function bs_106703:ctor()
end

function bs_106703:InitSkill(isMidwaySkill)
end

function bs_106703:PlaySkill(data, selectTargetCoord, selectRoles, SelectRolesType)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(23)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute), SelectRolesType)
  if selectTargetCoord ~= nil then
    local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    self.caster:LookAtTarget(inputTarget)
    LuaSkillCtrl:CallEffect(inputTarget, self.config.effectId_start, self)
  end
end

function bs_106703:CallSelectExecute(role)
  if role ~= nil and role.belongNum ~= self.caster.belongNum then
    LuaSkillCtrl:StartTimer(self, 5, BindCallback(self, self.CallSingleHurtEffect, role))
  end
end

function bs_106703:CallSingleHurtEffect(role)
  if self.caster ~= nil and self.caster.hp > 0 then
    LuaSkillCtrl:CallEffect(role, self.config.effectId_hit, self, self.SkillEventFunc1, nil, 1)
  end
end

function bs_106703:SkillEventFunc1(effect, eventId, target)
  if eventId == eBattleEffectEvent.Create and self.caster ~= nil and self.caster.hp > 0 then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target.targetRole)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigId, {
      self.caster.recordTable["106701_break"],
      self.arglist[1]
    }, false)
    skillResult:EndResult()
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId_tr, self.arglist[2], 1)
  end
end

function bs_106703:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_106703:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_start)
end

function bs_106703:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_106703:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_106703:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106703
