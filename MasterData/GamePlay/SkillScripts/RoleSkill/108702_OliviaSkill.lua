local bs_108702 = class("bs_108702", LuaSkillBase)
local base = LuaSkillBase
bs_108702.config = {
  HurtConfigID = 25,
  extra_skill = 108708,
  effect_1 = 108706,
  effect_2 = 108707,
  effect_3 = 108712,
  skill_time = 1500,
  start_time_0 = 6,
  action_start = 1008,
  action_loop = 1007,
  action_end = 1009,
  buff_1 = 108703,
  buff_2 = 108704,
  buff_3 = 108705
}

function bs_108702:ctor()
end

function bs_108702:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  LuaSkillCtrl:AddExtraAddSkill(self.config.extra_skill, self.level)
  local skillCasterEntity = LuaSkillCtrl:GetPlayerRoleEntity()
  skillCasterEntity.recordTable.OliviaSkillArg5 = self.arglist[5]
  skillCasterEntity.recordTable.OliviaSkillArg6 = self.arglist[6]
  skillCasterEntity.recordTable.OliviaSkillArg7 = self.arglist[7]
  skillCasterEntity.recordTable.OliviaSkillArg8 = self.arglist[8]
  skillCasterEntity.recordTable.OliviaSkillArg9 = self.arglist[9]
  skillCasterEntity.recordTable.OliviaSkillArg10 = self.arglist[10]
  self.skillMode = false
  self.isRelease = false
end

function bs_108702:PlaySkill(data)
  if self.caster.recordTable.lastAttackRole ~= nil and self.caster.recordTable.lastAttackRole.hp > 0 then
    self.targetRole = self.caster.recordTable.lastAttackRole
  else
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 19, 20)
    if targetList ~= nil and 0 < targetList.Count then
      self.targetRole = targetList[0].targetRole
    else
      return
    end
  end
  self.lock = false
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self.caster:LookAtTarget(self.targetRole)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_2, 1)
  self:StopSkillTimer()
  self:PlayerAnimation()
end

function bs_108702:PlayerAnimation()
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.action_start, self.config.action_speed)
  LuaSkillCtrl:StartTimer(self, self.config.start_time_0, function()
    self.skillMode = true
    self:AddTrigger(eSkillTriggerType.OnSelfAttrChanged, "bs_108702_01", 1, self.OnCasterAttributeChange)
    self:UpCrit()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.action_loop, self.config.action_speed)
    self.effect1 = LuaSkillCtrl:CallEffect(self.targetRole, self.config.effect_1, self)
    self.effect2 = LuaSkillCtrl:CallEffect(self.caster, self.config.effect_3, self)
  end, nil)
end

function bs_108702:UpCrit()
  self.cirtTimer = LuaSkillCtrl:StartTimer(self, 3, function()
    if not self:CheckAvaliable() then
      self:OnSkillEnd()
      LuaSkillCtrl:CallResetCDNumForRole(self.caster, 90)
      return
    end
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_1, 1, nil, true)
    self.caster:LookAtTarget(self.targetRole)
  end, nil, -1)
end

function bs_108702:OnCasterAttributeChange()
  if self.caster.crit >= 1000 and self.skillMode and self.targetRole ~= nil then
    self:DoRealSkill()
  end
end

function bs_108702:DoRealSkill(data)
  local AttackCallBack = BindCallback(self, self.AttackCallBack)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.action_end, 1, 1, AttackCallBack)
end

function bs_108702:AttackCallBack()
  self.isRelease = true
  LuaSkillCtrl:CallEffectWithArg(self.targetRole, self.config.effect_2, self, nil, false, self.SkillEventFunc)
  self:OnSkillEnd()
end

function bs_108702:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger and self.caster ~= nil and self.caster.hp > 0 then
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buff_3, 1, self.arglist[4])
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
      self.arglist[2]
    })
    skillResult:EndResult()
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_1, 0)
  end
end

function bs_108702:OnBreakSkill(role)
  if role == self.caster and self.cskill.isNormalSkill and self.dataID == self.caster.recordTable.lastSkill and not self.lock and not self.isRelease then
    self:OnSkillEnd()
    LuaSkillCtrl:CallResetCDNumForRole(self.caster, 120)
    self.lock = true
  end
end

function bs_108702:OnSkillEnd()
  self:RemoveSkillTrigger(eSkillTriggerType.OnSelfAttrChanged)
  self.skillMode = false
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_2, 0)
  self:StopSkillTimer()
  self.timerT = LuaSkillCtrl:StartTimer(self, 10, function()
    self:CancleCasterWait()
    self.isRelease = false
  end, nil)
end

function bs_108702:CheckAvaliable()
  if self.targetRole == nil or self.targetRole.hp <= 0 then
    return false
  end
  if self.targetRole:ContainFeature(eBuffFeatureType.Exiled) or self.targetRole:ContainFeature(eBuffFeatureType.NotBeSelectedExceptSameBlong) then
    return false
  end
  return true
end

function bs_108702:StopSkillTimer()
  if self.effect1 ~= nil then
    self.effect1:Die()
    self.effect1 = nil
  end
  if self.effect2 ~= nil then
    self.effect2:Die()
    self.effect2 = nil
  end
  if self.cirtTimer ~= nil then
    self.cirtTimer:Stop()
    self.cirtTimer = nil
  end
  if self.timerT ~= nil then
    self.timerT:Stop()
    self.timerT = nil
  end
end

function bs_108702:LuaDispose()
  base.LuaDispose(self)
  self:StopSkillTimer()
end

function bs_108702:OnCasterDie()
  base.OnCasterDie(self)
  self:StopSkillTimer()
end

return bs_108702
