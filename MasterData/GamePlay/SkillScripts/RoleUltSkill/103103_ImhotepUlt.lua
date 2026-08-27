local bs_103103 = class("bs_103103", LuaSkillBase)
local base = LuaSkillBase
bs_103103.config = {
  buff_sleep = 103101,
  buff_strong = 103102,
  buff_heal = 103103,
  heal_config = {baseheal_formula = 3022},
  buffFeature_stun = 7,
  audioIdStart = 103105,
  audioIdMovie = 103106,
  audioIdEnd = 103107
}
bs_103103.AbandonTakeFeature = {
  eBuffFeatureType.Stun,
  eBuffFeatureType.KnockOff
}

function bs_103103:ctor()
end

function bs_103103:InitSkill(isMidwaySkill)
  self:AddBuffDieTrigger("bs_103103_1", 10, self.OnBuffDie, nil, nil, self.config.buff_sleep)
end

function bs_103103:PlayUltMovie(moveSelectTarget, selectTargetCoord, selectRoles)
  if not self:IsConsumeSkill() then
    return base.PlayUltMovie(self, moveSelectTarget, selectTargetCoord, selectRoles)
  end
  if not self:Check(selectRoles) then
    return true
  end
  return base.PlayUltMovie(self, moveSelectTarget, selectTargetCoord, selectRoles)
end

function bs_103103:PlaySkill(data, selectTargetCoord, selectRoles)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
  self.caster:LookAtTarget(inputTarget)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_103103:CallSelectExecute(role)
  if role ~= nil and role.belongNum == self.caster.belongNum then
    LuaSkillCtrl:CallBuff(self, role, self.config.buff_sleep, 1, self.arglist[3], false)
    LuaSkillCtrl:CallBuffRepeated(self, role, self.config.buff_heal, 1, self.arglist[3], false, false, self.OnBuffExecute)
  end
end

function bs_103103:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.buff_sleep then
    LuaSkillCtrl:CallBuff(self, target, self.config.buff_strong, 1, self.arglist[2], false)
  end
end

function bs_103103:OnBuffExecute(buff, targetRole)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
    self.arglist[4]
  })
  skillResult:EndResult()
end

function bs_103103:PlayUltEffect(data, selectTargetCoord, selectRoles)
  if not self:Check(selectRoles) then
    return true
  end
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_103103:Check(selectRoles)
  if selectRoles == nil or selectRoles.Count <= 0 then
    return false
  end
  return self:CheckManualSkillTakeAvailable(selectRoles[0])
end

function bs_103103:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

function bs_103103:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_103103:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_103103:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103103
