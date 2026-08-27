local bs_210802 = class("bs_210802", LuaSkillBase)
local base = LuaSkillBase
bs_210802.config = {
  buffId_lockCd = 170,
  buffId_power = 210801,
  buffId_def = 210802,
  actionId_start = 1008,
  actionId_loop = 1007,
  actionId_end = 1009,
  action_speed = 1,
  actionId_start_time = 13,
  actionId_end_time = 25,
  heal_resultId = 3,
  effect_heal = 210806,
  effect_end = 210807
}

function bs_210802:ctor()
end

function bs_210802:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.loopTime = self.arglist[1]
  self.caster.recordTable.buff_num = 0
  self.OnCastSkill = false
end

function bs_210802:PlaySkill(data)
  self:OnSkillTake()
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  local time = self.config.actionId_start_time + self.config.actionId_end_time + self.loopTime
  local time1 = self.config.actionId_start_time + self.loopTime
  self:CallCasterWait(time)
  self.OnCastSkill = true
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
  self.finishAttack = LuaSkillCtrl:StartTimer(self, self.config.actionId_start_time + self.loopTime, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, self.config.action_speed)
    if self.effect_atk ~= nil then
      self.effect_atk:Die()
      self.effect_atk = nil
    end
    if self.atk ~= nil then
      self.atk:Stop()
      self.atk = nil
    end
    LuaSkillCtrl:CallEffect(self.caster, self.config.effect_end, self)
    self.OnCastSkill = false
  end, nil)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_def, 1, time1, true)
end

function bs_210802:OnAttackTrigger(data)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.loopTime)
  self.effect_atk = LuaSkillCtrl:CallEffect(self.caster, self.config.effect_heal, self)
  self.atk = LuaSkillCtrl:StartTimer(self, 15, function()
    local targetList = LuaSkillCtrl:FindRolesAroundRole(self.caster)
    if targetList ~= nil and targetList.Count > 0 then
      for i = targetList.Count - 1, 0, -1 do
        local role = targetList[i]
        if role ~= nil and 0 < role.hp and role.belongNum == self.caster.belongNum then
          LuaSkillCtrl:CallBuff(self, role, self.config.buffId_power, 1, self.arglist[3])
          self.caster.recordTable.buff_num = self.caster.recordTable.buff_num + 1
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
          LuaSkillCtrl:HealResultWithConfig(self, skillResult, self.config.heal_resultId, {
            self.arglist[2]
          })
          skillResult:EndResult()
        end
      end
    end
  end, nil, -1, 10)
end

function bs_210802:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if role == self.caster and self.OnCastSkill == true then
    LuaSkillCtrl:DispelBuff(role, self.config.buffId_def, 1)
    local hpRate = self.arglist[5]
    local damage = role._curHp * hpRate // 1000
    LuaSkillCtrl:RemoveLife(damage, self, self.caster, true, nil, true, true)
    local skills = role:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = skills[j].totalCDTime * -1 * self.arglist[6] // 1000
          if not skills[j].isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
          end
        end
      end
    end
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    if self.effect_atk ~= nil then
      self.effect_atk:Die()
      self.effect_atk = nil
    end
  end
  self:CancleCasterWait()
  self.OnCastSkill = false
end

function bs_210802:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect_atk ~= nil then
    self.effect_atk:Die()
    self.effect_atk = nil
  end
  if self.atk ~= nil then
    self.atk:Stop()
    self.atk = nil
  end
end

function bs_210802:LuaDispose()
  self.effect_atk = nil
  base.LuaDispose(self)
end

return bs_210802
