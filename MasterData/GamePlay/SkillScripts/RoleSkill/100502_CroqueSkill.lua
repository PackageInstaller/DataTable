local bs_100502 = class("bs_100502", LuaSkillBase)
local base = LuaSkillBase
bs_100502.config = {
  buffId_Taunt = 3002,
  effectId_CF = 123,
  effectId_start = 100504,
  effectId_Hit1 = 100506,
  effectId_Hit2 = 100507,
  effectId_Hit3 = 100508,
  effectId_Hit4 = 100509,
  effectId_Hit5 = 100510,
  effectId_Hit6 = 100511,
  effectId_Hit7 = 100512,
  effectId_Hit8 = 100513,
  effectId_Hit9 = 100514,
  effectId_Hit10 = 100515,
  effectId_start02 = 100517,
  shieldFormula = 3021,
  buffId_Super = 3003,
  actionId_start = 1002,
  actionId_loop = 1007,
  action_speed = 1,
  skill_time = 15,
  start_time = 5,
  buffId_170 = 170,
  weaponLv = 0
}

function bs_100502:ctor()
end

function bs_100502:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.OnBreakShield, "bs_100502_22", 1, self.OnBreakShield)
  self.caster.recordTable.peopleNum = 0
  self.caster.recordTable.skill = false
  self.time = 1
  self.caster.recordTable.recover_shield = 0
  self.caster.recordTable.chiyan_Num = 0
end

function bs_100502:PlaySkill(data)
  local speed = 0
  if LuaSkillCtrl:GetCasterSkinId(self.caster) == 300506 then
    speed = 4
  else
    speed = self.config.action_speed
  end
  local times = self.arglist[3]
  if self.time == 1 then
    times = self.arglist[2]
  end
  local bufftime = self.config.skill_time + times + 5
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Super, 1, bufftime, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, nil, true)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, self.time, times)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, speed, self.config.start_time, attackTrigger)
  self.hudunEffect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self, nil, nil, nil, true)
  self.hudunEffect02 = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start02, self, nil, nil, nil, true)
end

function bs_100502:OnAttackTrigger(time, duration)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_CF, self, nil, nil, nil, true)
  LuaSkillCtrl:StartShowSkillDurationTime(self, duration)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop)
  local Arg = self.arglist[4]
  if time == 1 then
    Arg = self.arglist[1]
  end
  local shieldValue = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.shieldFormula, self.caster, nil, self, Arg)
  if 0 < shieldValue then
    if 0 < self.caster.recordTable.recover_shield then
      shieldValue = shieldValue + self.caster.recordTable.recover_shield
    end
    if 0 < self.caster.recordTable.chiyan_Num then
      local ExtraShield = self.caster.recordTable.chiyan_Num * self.caster.skill_intensity * self.arglist[5] // 1000
      shieldValue = shieldValue + ExtraShield
    end
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
  end
  if self.caster.recordTable.recover_shield ~= 0 then
    self.caster.recordTable.recover_shield = 0
  end
  if self.caster.recordTable.chiyan_Num ~= 0 then
    self.caster.recordTable.chiyan_Num = 0
  end
  local rangeOffset = 1
  if time == 1 then
    rangeOffset = 10
  end
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, rangeOffset)
  if 0 < targetList.Count then
    for i = 0, targetList.Count - 1 do
      if targetList[i].targetRole.intensity ~= 0 then
        LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffId_Taunt, 1, duration)
        self.caster.recordTable.peopleNum = self.caster.recordTable.peopleNum + 1
      end
    end
  end
  self.caster.recordTable.skill = true
  self.time = self.time + 1
  LuaSkillCtrl:StartTimer(nil, duration, BindCallback(self, self.Onover), self)
end

function bs_100502:Onover()
  if self.caster.recordTable.skill == true then
    if self.hudunEffect ~= nil then
      self.hudunEffect:Die()
      self.hudunEffect = nil
    end
    if self.hudunEffect02 ~= nil then
      self.hudunEffect02:Die()
      self.hudunEffect02 = nil
    end
    self.caster.recordTable.skill = false
    self.caster.recordTable.peopleNum = 0
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    self:CancleCasterWait()
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if 0 >= targetList.Count then
      return
    end
    for i = 0, targetList.Count - 1 do
      LuaSkillCtrl:DispelBuffByMaker(self.caster, targetList[i].targetRole, self.config.buffId_Taunt, 1)
    end
  end
  LuaSkillCtrl:CallRoleAction(self.caster, 100)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_Super, 0, true)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0, true)
end

function bs_100502:OnBreakShield(shieldType, sender, target)
  if shieldType == 0 and target == self.caster and self.caster.recordTable.skill == true then
    self:Onover()
  end
end

function bs_100502:OnBreakSkill(role)
  if role == self.caster then
    self:Onover()
  end
  base.OnBreakSkill(self, role)
end

function bs_100502:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_100502:LuaDispose()
  base.LuaDispose(self)
  self.hudunEffect = nil
  self.hudunEffect02 = nil
end

return bs_100502
