local bs_207801 = class("bs_207801", LuaSkillBase)
local base = LuaSkillBase
bs_207801.config = {
  skill_time = 25,
  start_time = 25,
  start_time2 = 4,
  dd_time = 3,
  hdRate = 30,
  actionId_attack3 = 1025,
  actionId_start = 1008,
  actionId_loop = 1007,
  actionId_end = 1009,
  action_speed = 1,
  buffId_1 = 207801,
  buffIdHD = 207802,
  effectId_skill = 10779,
  effectId_bnfffire = 100307,
  effectId_trail2 = 207803,
  effectId_bd = 207805,
  buffId_170 = 3008,
  audioId = 207803
}

function bs_207801:ctor()
end

function bs_207801:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_207801_3", 1, self.OnAfterHurt, self.caster)
  self:AddAfterBuffRemoveTrigger("bs_207801_4", 1, self.AfterBuffRemove, self.caster, nil, self.config.buffId_1, nil)
end

function bs_207801:PlaySkill(data)
  local buff_time = self.config.skill_time + self.arglist[1] + 28
  local noAttack_time = buff_time + 30
  self:CallCasterWait(noAttack_time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, self.config.action_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1, 1, buff_time, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, buff_time, true)
end

function bs_207801:OnAttackTrigger()
  local buff_time1 = self.arglist[1] + 28
  local arg1 = self.caster.recordTable.skill_intensity_up
  local arg2 = self.caster.recordTable.maxHp
  LuaSkillCtrl:StartShowSkillDurationTime(self, buff_time1)
  local value1 = self.caster.skill_intensity * arg1 // 1000
  local value2 = self.caster.maxHp * arg2 // 1000
  local value3 = value1 + value2
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop)
  local times = self.arglist[1] // self.config.hdRate
  LuaSkillCtrl:StartTimer(self, self.config.hdRate, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_attack3)
    LuaSkillCtrl:StartTimer(self, self.config.start_time2, function()
      if 0 < value3 then
        LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.normal, value3)
        local buff = LuaSkillCtrl:GetRoleBuffById(self.caster, self.config.buffIdHD)
        if buff == nil then
          LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffIdHD, 1, nil, true)
        end
      end
      local targetListAll = LuaSkillCtrl:CallTargetSelect(self, 2, 10)
      if targetListAll.Count >= 3 then
        self.caster:LookAtTarget(targetListAll[0].targetRole)
        LuaSkillCtrl:StartTimer(self, 6, function()
          LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_bd, self)
          LuaSkillCtrl:CallEffect(targetListAll[0].targetRole, self.config.effectId_trail2, self)
          LuaSkillCtrl:StartTimer(nil, self.config.dd_time, function()
            if 0 < value3 then
              LuaSkillCtrl:AddRoleShield(targetListAll[0].targetRole, eShieldType.normal, value3)
              local buff = LuaSkillCtrl:GetRoleBuffById(targetListAll[0].targetRole, self.config.buffIdHD)
              if buff == nil then
                LuaSkillCtrl:CallBuff(self, targetListAll[0].targetRole, self.config.buffIdHD, 1, nil, true)
              end
            end
          end)
        end)
        LuaSkillCtrl:StartTimer(self, 8, function()
          self.caster:LookAtTarget(targetListAll[1].targetRole)
        end)
        LuaSkillCtrl:StartTimer(self, 11, function()
          LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_bd, self)
          LuaSkillCtrl:CallEffect(targetListAll[1].targetRole, self.config.effectId_trail2, self)
          LuaSkillCtrl:StartTimer(nil, self.config.dd_time, function()
            if 0 < value3 then
              LuaSkillCtrl:AddRoleShield(targetListAll[1].targetRole, eShieldType.normal, value3)
              local buff = LuaSkillCtrl:GetRoleBuffById(targetListAll[1].targetRole, self.config.buffIdHD)
              if buff == nil then
                LuaSkillCtrl:CallBuff(self, targetListAll[1].targetRole, self.config.buffIdHD, 1, nil, true)
              end
            end
          end)
        end)
        LuaSkillCtrl:StartTimer(self, 16, function()
          LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_bd, self)
          for i = 2, targetListAll.Count - 1 do
            LuaSkillCtrl:CallEffect(targetListAll[i].targetRole, self.config.effectId_trail2, self)
            LuaSkillCtrl:StartTimer(nil, self.config.dd_time, function()
              if 0 < value3 then
                LuaSkillCtrl:AddRoleShield(targetListAll[i].targetRole, eShieldType.normal, value3)
                local buff = LuaSkillCtrl:GetRoleBuffById(targetListAll[i].targetRole, self.config.buffIdHD)
                if buff == nil then
                  LuaSkillCtrl:CallBuff(self, targetListAll[i].targetRole, self.config.buffIdHD, 1, nil, true)
                end
              end
            end)
          end
        end)
      end
      if targetListAll.Count == 2 then
        self.caster:LookAtTarget(targetListAll[0].targetRole)
        LuaSkillCtrl:StartTimer(self, 6, function()
          LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_bd, self)
          LuaSkillCtrl:CallEffect(targetListAll[0].targetRole, self.config.effectId_trail2, self)
          LuaSkillCtrl:StartTimer(nil, self.config.dd_time, function()
            if 0 < value3 then
              LuaSkillCtrl:AddRoleShield(targetListAll[0].targetRole, eShieldType.normal, value3)
              local buff = LuaSkillCtrl:GetRoleBuffById(targetListAll[0].targetRole, self.config.buffIdHD)
              if buff == nil then
                LuaSkillCtrl:CallBuff(self, targetListAll[0].targetRole, self.config.buffIdHD, 1, nil, true)
              end
            end
          end)
        end)
        LuaSkillCtrl:StartTimer(self, 8, function()
          self.caster:LookAtTarget(targetListAll[1].targetRole)
        end)
        LuaSkillCtrl:StartTimer(self, 11, function()
          LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_bd, self)
          LuaSkillCtrl:CallEffect(targetListAll[1].targetRole, self.config.effectId_trail2, self)
          LuaSkillCtrl:StartTimer(nil, self.config.dd_time, function()
            if 0 < value3 then
              LuaSkillCtrl:AddRoleShield(targetListAll[1].targetRole, eShieldType.normal, value3)
              local buff = LuaSkillCtrl:GetRoleBuffById(targetListAll[1].targetRole, self.config.buffIdHD)
              if buff == nil then
                LuaSkillCtrl:CallBuff(self, targetListAll[1].targetRole, self.config.buffIdHD, 1, nil, true)
              end
            end
          end)
        end)
        LuaSkillCtrl:StartTimer(self, 13, function()
          LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop)
        end)
      end
      if targetListAll.Count == 1 then
        self.caster:LookAtTarget(targetListAll[0].targetRole)
        LuaSkillCtrl:StartTimer(self, 6, function()
          LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_bd, self)
          LuaSkillCtrl:CallEffect(targetListAll[0].targetRole, self.config.effectId_trail2, self)
          LuaSkillCtrl:StartTimer(nil, self.config.dd_time, function()
            if 0 < value3 then
              LuaSkillCtrl:AddRoleShield(targetListAll[0].targetRole, eShieldType.normal, value3)
              local buff = LuaSkillCtrl:GetRoleBuffById(targetListAll[0].targetRole, self.config.buffIdHD)
              if buff == nil then
                LuaSkillCtrl:CallBuff(self, targetListAll[0].targetRole, self.config.buffIdHD, 1, nil, true)
              end
            end
          end)
        end)
        LuaSkillCtrl:StartTimer(self, 8, function()
          LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop)
        end)
      end
      if targetListAll.Count == 0 then
        LuaSkillCtrl:StartTimer(self, 3, function()
          LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop)
        end)
      end
    end)
  end, nil, times - 1, self.config.hdRate)
end

function bs_207801:AfterBuffRemove(buffId, target, removeType)
  LuaSkillCtrl:StopShowSkillDurationTime(self)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId)
  LuaSkillCtrl:StartTimer(self, 28, function()
    self:CancleCasterWait()
  end)
end

function bs_207801:Onover()
  LuaSkillCtrl:StopShowSkillDurationTime(self)
  self:CancleCasterWait()
  LuaSkillCtrl:CallRoleAction(self.caster, 100)
end

function bs_207801:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_207801
