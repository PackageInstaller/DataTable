local bs_108302 = class("bs_108302", LuaSkillBase)
local base = LuaSkillBase
bs_108302.config = {
  effcet_zuantou = 108306,
  effect_zuantousj = 108307,
  effect_jiesuan = 108308,
  effect_jiesuansj = 108309,
  actionId1_start = 1008,
  actionId1_loop = 1007,
  actionId1_end = 1009,
  action_speed = 1,
  start_time = 10,
  end_time = 14,
  buffId_qiyou = 108302,
  buffId_bati = 196,
  buffId_ranjie = 107101,
  selectId = 1,
  skill_time = 30,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3010,
    def_formula = 9996,
    minhurt_formula = 9994,
    crit_formula = 9992,
    crithur_ratio = 9995,
    correct_formula = 9989,
    lifesteal_formula = 1001,
    spell_lifesteal_formula = 1002,
    returndamage_formula = 0,
    hurt_type = 1,
    hurt_tag = 1
  }
}

function bs_108302:ctor()
end

function bs_108302:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("108302_1", 1, self.OnAfterAddBuff, nil, nil, eBattleRoleBelong.player, eBattleRoleBelong.enemy, self.config.buffId_ranjie)
  self:AddOnRoleDieTrigger("108302_2", 2, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.enemy)
  self.buffCount = 0
  self.skillTarget = nil
  self.skillMode = false
  self.DamageNum = 0
end

function bs_108302:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local target = self.caster.recordTable.lastAttackRole
  if target == nil or target.hp <= 0 or target.belongNum == eBattleRoleBelong.neutral then
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    target = tempTarget.targetRole
  end
  if target ~= nil then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
    self.caster:LookAtTarget(target)
    local skill_time = 60
    self:CallCasterWait(skill_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId1_start, self.config.action_speed, self.config.start_time, attackTrigger)
  end
end

function bs_108302:OnAttackTrigger(target, data)
  self.skillMode = true
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_bati, 1)
  self.skillTarget = target
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnShaleBuffAdd, target, true)
  self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effcet_zuantou, self)
  local DamageTime = self.arglist[1] / self.arglist[2]
  self.timeskill = LuaSkillCtrl:StartTimer(self, DamageTime, function()
    LuaSkillCtrl:CallEffect(target, self.config.effect_zuantousj, self)
    if LuaSkillCtrl:RoleContainsBuffFeature(target, 5) then
      self:OnSkillEnd(target, true)
      return
    end
    self.DamageNum = self.DamageNum + 1
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.arglist[3]
    })
    skillResult:EndResult()
    if self.timeskill.over and target ~= nil and target.hp > 0 then
      self:OnSkillEnd(target, false)
    end
  end, self, self.arglist[2] - 1, DamageTime)
end

function bs_108302:OnAfterAddBuff(buff, target)
  if self.skillMode and target ~= nil and target == self.skillTarget and target.hp > 0 then
    self.buffCount = self.buffCount + 1
  end
end

function bs_108302:OnRoleDie(killer, role)
  if self.skillMode and role == self.skillTarget then
    if self.timeskill ~= nil then
      self.timeskill:Stop()
    end
    self:OnSkillEnd(role, false)
  end
end

function bs_108302:OnSkillEnd(target, IfRoleCotainsUnselectedBuff)
  if not self.skillMode then
    return
  end
  if not IfRoleCotainsUnselectedBuff then
    self:ChooseSkillEndAffect(target)
  end
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId1_end, self.config.action_speed)
  LuaSkillCtrl:StartTimer(self, self.config.end_time, function()
    self:CancleCasterWait()
  end)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_bati, 0)
  self.skillMode = false
  self.buffCount = 0
  self.skillTarget = nil
  self.DamageNum = 0
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_108302:ChooseSkillEndAffect(target)
  if target ~= nil and target.hp > 0 then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effect_jiesuan, self)
    local BuffCoountMax = self.arglist[6] // self.arglist[5]
    if BuffCoountMax <= self.buffCount then
      self.buffCount = BuffCoountMax
    end
    local Arg = self.arglist[4] + self.buffCount * self.arglist[5]
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {Arg})
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(target, self.config.effect_jiesuansj, self)
  else
    local returnPercent = 100 - self.DamageNum * 100 // self.arglist[2]
    local curCd = self.cskill.totalCDTime
    local value = curCd * returnPercent // 100
    LuaSkillCtrl:CallResetCDNumForRole(self.caster, value)
  end
end

function bs_108302:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  self:CancleCasterWait()
  self.skillMode = false
  self.buffCount = 0
  self.skillTarget = nil
  self.DamageNum = 0
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.timeskill ~= nil then
    self.timeskill:Stop()
    self.timeskill = nil
  end
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_bati, 0)
end

function bs_108302:OnCasterDie()
  base.OnCasterDie(self)
  if self.timeskill ~= nil then
    self.timeskill:Stop()
    self.timeskill = nil
  end
end

function bs_108302:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
  self.skillTarget = nil
  if self.timeskill ~= nil then
    self.timeskill:Stop()
    self.timeskill = nil
  end
end

return bs_108302
