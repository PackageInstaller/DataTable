local bs_107903 = class("bs_107903", LuaSkillBase)
local base = LuaSkillBase
bs_107903.config = {
  buffid = 107906,
  effectId_cast = 107911,
  effectId_hit = 107913,
  effectId_screen = 9,
  effectId_show = 107912,
  HurtConfigID = 2,
  audioIdStart = 107911,
  audioIdMovie = 107912,
  audioIdEnd = 107913
}

function bs_107903:ctor()
end

function bs_107903:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_107903_1", 1, self.BeforeEndBattle)
end

function bs_107903:PlaySkill(data, selectTargetCoord, selectRoles)
  local time = self.arglist[1]
  self:CallCasterWait(time)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffid, 1, time, true)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast, self)
  self:OnBlink()
  LuaSkillCtrl:SetRoleVisible(self.caster, false)
  self.loopAtker = LuaSkillCtrl:StartTimer(self, self.arglist[2], function()
    self:OnLoopAtk()
  end, nil, -1, self.arglist[2])
  LuaSkillCtrl:ShowCameraEffectFunctionWithPriority(self.config.effectId_screen, 150)
  self.shower = LuaSkillCtrl:StartTimer(nil, time, function()
    if self.loopAtker ~= nil then
      self.loopAtker:Stop()
      self.loopAtker = nil
    end
    if self.caster:GetBuffTier(self.config.buffid) > 0 then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffid, 1)
    end
    self:OnBlink()
    LuaSkillCtrl:SetRoleVisible(self.caster, true)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_show, self)
    LuaSkillCtrl:CloseCameraEffectFunctionWithoutId(self.config.effectId_screen)
    self:CancleCasterWait()
  end, nil, 0, 0)
end

function bs_107903:OnBlink()
  local target
  local targets = LuaSkillCtrl:CallTargetSelect(self, 7, 10)
  for i = 0, targets.Count - 1 do
    local role = targets[i].targetRole
    if not LuaSkillCtrl:IsObstacle(role) then
      target = role
      break
    end
  end
  if target == nil then
    return
  end
  local Grid = LuaSkillCtrl:CallFindEmptyGridNearest(target)
  if Grid == nil then
    return
  end
  LuaSkillCtrl:SetRolePos(Grid, self.caster)
end

function bs_107903:OnLoopAtk()
  local target
  local targets = LuaSkillCtrl:CallTargetSelect(self, 7, 10)
  for i = 0, targets.Count - 1 do
    local role = targets[i].targetRole
    if not LuaSkillCtrl:IsObstacle(role) then
      target = role
      break
    end
  end
  if target == nil then
    return
  end
  LuaSkillCtrl:CallEffect(target, self.config.effectId_hit, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
    self.arglist[3]
  })
  skillResult:EndResult()
end

function bs_107903:BeforeEndBattle()
  LuaSkillCtrl:SetRoleVisible(self.caster, true)
  LuaSkillCtrl:CloseCameraEffectFunctionWithoutId(self.config.effectId_screen)
end

function bs_107903:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_107903:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_107903:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_107903:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_107903:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_107903:LuaDispose()
  base.LuaDispose(self)
end

return bs_107903
