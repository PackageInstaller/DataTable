local bs_208701 = class("bs_208701", LuaSkillBase)
local base = LuaSkillBase
bs_208701.config = {
  skill_time = 38,
  skill_speed = 1,
  start_time = 13,
  buffId_170 = 170,
  buffIdHDBJ = 208701,
  buffIdAtkUp = 208702,
  actionId_attack3 = 1025,
  actionIdstart = 1008,
  actionId_loop = 1007,
  actionId_end = 1009,
  action_speed = 1
}

function bs_208701:ctor()
end

function bs_208701:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_208701_2", 1, self.OnBreakShield)
end

function bs_208701:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  local time = self.arglist[4] + self.config.skill_time
  self:CallCasterWait(time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionIdstart, self.config.skill_speed, self.config.start_time, attackTrigger)
end

function bs_208701:OnAttackTrigger(data)
  local value1 = self.caster.maxHp * self.arglist[1] // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.normal, value1)
  local SelfShieldValue = LuaSkillCtrl:GetShield(self.caster, eShieldType.normal)
  if SelfShieldValue ~= 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffIdHDBJ, 1)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, nil, true)
    LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[4])
    local atkUpTime = self.arglist[4] // 15
    self.passive = LuaSkillCtrl:StartTimer(self, 15, self.callBack, self, atkUpTime, 1)
    LuaSkillCtrl:StartTimer(self, self.arglist[4], function()
      if self.passive ~= nil then
        self.passive:Stop()
        self.passive = nil
      end
      local buff = LuaSkillCtrl:GetRoleBuffById(self.caster, self.config.buffIdHDBJ)
      if buff ~= nil then
        LuaSkillCtrl:DispelBuff(self.caster, self.config.buffIdHDBJ, 0)
        LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end)
        LuaSkillCtrl:StopShowSkillDurationTime(self)
        LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0)
        LuaSkillCtrl:StartTimer(self, 28, function()
          self:CancleCasterWait()
        end)
      end
    end)
  else
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    self:CancleCasterWait()
    LuaSkillCtrl:CallRoleAction(self.caster, 100)
    local buff1 = LuaSkillCtrl:GetRoleBuffById(self.caster, self.config.buffId_170)
    if buff1 ~= nil then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0)
    end
  end
end

function bs_208701:callBack()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffIdAtkUp, 1)
end

function bs_208701:OnBreakShield(shieldType, sender, target)
  if target == self.caster then
    local buff = LuaSkillCtrl:GetRoleBuffById(target, self.config.buffIdHDBJ)
    if buff ~= nil then
      LuaSkillCtrl:DispelBuff(target, self.config.buffIdHDBJ, 0)
      LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end)
      if self.passive ~= nil then
        self.passive:Stop()
        self.passive = nil
      end
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0)
      LuaSkillCtrl:StopShowSkillDurationTime(self)
      LuaSkillCtrl:StartTimer(self, 28, function()
        self:CancleCasterWait()
      end)
    end
  end
end

function bs_208701:Onover()
  LuaSkillCtrl:StopShowSkillDurationTime(self)
  self:CancleCasterWait()
  LuaSkillCtrl:CallRoleAction(self.caster, 100)
  local buff1 = LuaSkillCtrl:GetRoleBuffById(self.caster, self.config.buffId_170)
  if buff1 ~= nil then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0)
  end
end

function bs_208701:OnBreakSkill(role)
  if role == self.caster then
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    self:CancleCasterWait()
    LuaSkillCtrl:CallRoleAction(self.caster, 100)
    local buff1 = LuaSkillCtrl:GetRoleBuffById(self.caster, self.config.buffId_170)
    if buff1 ~= nil then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0)
    end
    local buff = LuaSkillCtrl:GetRoleBuffById(self.caster, self.config.buffIdHDBJ)
    if buff ~= nil then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffIdHDBJ, 0)
    end
    if self.passive ~= nil then
      self.passive:Stop()
      self.passive = nil
    end
    base.OnBreakSkill(self, role)
  end
end

function bs_208701:OnCasterDie()
  base.OnCasterDie(self)
  if self.passive ~= nil then
    self.passive:Stop()
    self.passive = nil
  end
end

function bs_208701:LuaDispose()
  if self.passive ~= nil then
    self.passive:Stop()
    self.passive = nil
  end
  base.LuaDispose(self)
end

return bs_208701
