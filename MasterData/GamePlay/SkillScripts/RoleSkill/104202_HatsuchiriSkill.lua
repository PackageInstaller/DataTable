local bs_104202 = class("bs_104202", LuaSkillBase)
local base = LuaSkillBase
bs_104202.config = {
  buffId_tig = 104204,
  actionId = 1020,
  actionId_speed = 1,
  skill_time = 40,
  start_time = 4,
  start_time2 = 6,
  start_time3 = 10,
  effectId_start = 104206,
  effectId_hit1 = 104207,
  effectId_hit2 = 104208,
  effectId_hit2_zw = 104221,
  effectId_hit3 = 104209,
  effectId_hit3_zw = 104222,
  Aoe = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0
  },
  audioId_hit = 104208,
  weaponLv = 0
}

function bs_104202:ctor()
end

function bs_104202:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104202:PlaySkill(data)
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 1) then
    target = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    target = tempTarget.targetRole
  end
  if target ~= nil then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
    self.caster:LookAtTarget(target)
    self:CallCasterWait(self.config.skill_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_start, self, nil, nil, nil, true)
  end
end

function bs_104202:OnAttackTrigger(target)
  if target == nil or target.hp <= 0 then
    return
  end
  if target.intensity ~= 0 then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_tig, 1, self.arglist[2])
  end
  LuaSkillCtrl:CallEffect(target, self.config.effectId_hit1, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  local isConditionToHp = self:CheckHpCondition(target)
  if isConditionToHp then
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
      self.arglist[1] + self.arglist[7]
    })
  else
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
      self.arglist[1]
    })
  end
  skillResult:EndResult()
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_hit)
  LuaSkillCtrl:StartTimer(self, self.config.start_time2, function()
    if target == nil or target.hp <= 0 then
      return
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, self.config.Aoe)
    for i = 0, skillResult.roleList.Count - 1 do
      local role = skillResult.roleList[i]
      isConditionToHp = self:CheckHpCondition(role)
      if isConditionToHp then
        LuaSkillCtrl:CallEffect(role, self.config.effectId_hit2_zw, self)
      else
        LuaSkillCtrl:CallEffect(role, self.config.effectId_hit2, self)
      end
      if role ~= target then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
        if isConditionToHp then
          LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
            self.arglist[3] + self.arglist[7]
          }, true)
        else
          LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
            self.arglist[3]
          }, true)
        end
        skillResult:EndResult()
      else
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
        if isConditionToHp then
          LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
            self.arglist[3] + self.arglist[7]
          })
        else
          LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
            self.arglist[3]
          })
        end
        skillResult:EndResult()
      end
    end
    skillResult:EndResult()
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_hit)
    if target.intensity ~= 0 then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_tig, 1, self.arglist[2])
    end
    LuaSkillCtrl:StartTimer(self, self.config.start_time3, function()
      if target == nil or target.hp <= 0 then
        return
      end
      isConditionToHp = self:CheckHpCondition(target)
      if isConditionToHp then
        LuaSkillCtrl:CallEffect(target, self.config.effectId_hit3_zw, self)
      else
        LuaSkillCtrl:CallEffect(target, self.config.effectId_hit3, self)
      end
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      if isConditionToHp then
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
          self.arglist[4] + self.arglist[7]
        })
      else
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
          self.arglist[4]
        })
      end
      skillResult:EndResult()
      if target.intensity ~= 0 then
        LuaSkillCtrl:CallBuff(self, target, self.config.buffId_tig, 1, self.arglist[2])
      end
      LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_hit)
      self:OnSkillDamageEnd()
    end)
  end)
end

function bs_104202:CheckHpCondition(target)
  if self.config.weaponLv >= 3 then
    return true
  end
  return false
end

function bs_104202:OnCasterDie()
  base.OnCasterDie(self)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList.Count <= 0 then
    return
  end
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:DispelBuffByMaker(self.caster, targetList[i].targetRole, self.config.buffId_tig, 1)
  end
end

return bs_104202
