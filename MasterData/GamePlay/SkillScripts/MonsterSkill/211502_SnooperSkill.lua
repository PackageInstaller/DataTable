local bs_211502 = class("bs_211502", LuaSkillBase)
local base = LuaSkillBase
bs_211502.config = {
  skill_time = 25,
  start_time = 6,
  start_time2 = 4,
  dd_time = 3,
  hdRate = 30,
  actionId_start = 1022,
  actionId_loop = 1023,
  actionId_end = 1024,
  effectid_direction = 211504,
  effectid_directionEnd = 211505,
  effectid_directionHit = 211506,
  buffId_170 = 170,
  time_loop = 7,
  buff_ReduceDef = 211502,
  buff_ReduceMagicRes = 211504,
  buff_IncreaseDef = 211503,
  buff_IncreaseMagicRes = 211505,
  buff_IncreasePow = 211510,
  buff_IncreaseSkill = 211511,
  buff_Stun = 3006
}

function bs_211502:ctor()
end

function bs_211502:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.num1 = 0
  self.num2 = 0
  self.num3 = 0
  self.num4 = 0
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_211502_1", 1, self.OnRoleDie)
end

function bs_211502:OnRoleDie(killer, role)
  if role == self.target_skill and role.hp == 0 and role ~= nil then
    self:CancleCasterWait()
    LuaSkillCtrl:BreakCurrentAction(self.caster)
    self:Onover()
  end
end

function bs_211502:PlaySkill(data)
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and last_target.roleType == eBattleRoleType.character and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 10) then
    target = last_target
  else
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
  end
  if target ~= nil then
    self.caster:LookAtTarget(target)
    local noAttack_time = 10
    self:CallCasterWait(noAttack_time + 5)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, self.config.action_speed, self.config.start_time, attackTrigger)
    LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 10, true)
    LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, 10, true)
  end
end

function bs_211502:OnAttackTrigger(target)
  self.target_skill = target
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop)
  self.effect = LuaSkillCtrl:CallEffect(target, self.config.effectid_direction, self)
  local time = self.arglist[2] // 15
  LuaSkillCtrl:StartTimer(self, 15, function()
    local DefNum = target.def * self.arglist[1] // 1000
    local MagicNum = target.magic_res * self.arglist[1] // 1000
    local SkillNum = target.skill_intensity * self.arglist[1] // 1000
    local PowNum = target.pow * self.arglist[1] // 1000
    self.num1 = self.num1 + DefNum
    self.num2 = self.num2 + MagicNum
    self.num3 = self.num3 + SkillNum
    self.num4 = self.num4 + PowNum
    LuaSkillCtrl:CallEffect(target, self.config.effectid_directionHit, self)
    LuaSkillCtrl:CallBuff(self, target, self.config.buff_Stun, 1, 15, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_IncreaseDef, DefNum, nil, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_IncreaseMagicRes, MagicNum, nil, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_IncreasePow, PowNum, nil, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_IncreaseSkill, SkillNum, nil, true)
  end, self, time - 1, 14)
  local time1 = self.arglist[2] + 10
  LuaSkillCtrl:StartShowSkillDurationTime(self, time1)
  self:AddCasterWait(time1 + 10)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, time1, true)
  LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, time1, true)
  LuaSkillCtrl:StartTimer(self, time1 - 5, function()
    LuaSkillCtrl:StartTimer(self, 5, function()
      if self.effect ~= nil then
        self.effect:Die()
        self.effect = nil
      end
      LuaSkillCtrl:BreakCurrentAction(self.caster)
      self:Onover()
    end)
  end)
end

function bs_211502:Onover()
  self.target_skill = nil
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0)
  LuaSkillCtrl:DispelBuff(self.caster, 196, 0)
  self.num1 = 0
  self.num2 = 0
  self.num3 = 0
  self.num4 = 0
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  self:CancleCasterWait()
  LuaSkillCtrl:StartTimer(self, self.arglist[3], function()
    local num1 = self.caster:GetBuffTier(self.config.buff_IncreaseDef)
    local num2 = self.caster:GetBuffTier(self.config.buff_IncreaseMagicRes)
    local num3 = self.caster:GetBuffTier(self.config.buff_IncreaseSkill)
    local num4 = self.caster:GetBuffTier(self.config.buff_IncreasePow)
    local dispelNum1 = num1 - self.num1
    local dispelNum2 = num2 - self.num2
    local dispelNum3 = num3 - self.num3
    local dispelNum4 = num4 - self.num4
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_IncreaseDef, dispelNum1)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_IncreaseMagicRes, dispelNum2)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_IncreaseSkill, dispelNum3)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_IncreasePow, dispelNum4)
  end)
end

function bs_211502:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  self:CancleCasterWait()
  self.target_skill = nil
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0)
  LuaSkillCtrl:DispelBuff(self.caster, 196, 0)
end

function bs_211502:OnCasterDie()
  base.OnCasterDie(self)
  self:Onover()
end

function bs_211502:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

return bs_211502
