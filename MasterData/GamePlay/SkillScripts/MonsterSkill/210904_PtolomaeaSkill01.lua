local bs_210904 = class("bs_210904", LuaSkillBase)
local base = LuaSkillBase
bs_210904.config = {
  actionId_start = 1022,
  actionId_loop = 1023,
  actionId_end = 1024,
  action_speed = 1,
  actionId_start_time = 20,
  actionId_end_time = 30,
  buffId_hitfly = 130,
  HurtConfigID = 3,
  effect_hit = 210910,
  effect_end = 210911,
  effect_loop = 210912
}

function bs_210904:ctor()
end

function bs_210904:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.loopTime = 105
end

function bs_210904:PlaySkill(data)
  self.times = 0
  self.caster.recordTable.onskill = true
  self:OnSkillTake()
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  local time = self.config.actionId_start_time + self.config.actionId_end_time + self.loopTime
  self:CallCasterWait(time)
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
    self.caster.recordTable.onskill = false
  end, nil)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_def, 1, time, true)
end

function bs_210904:OnAttackTrigger(data)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.loopTime)
  self.effect_atk = LuaSkillCtrl:CallEffect(self.caster, self.config.effect_loop, self)
  self.atk = LuaSkillCtrl:StartTimer(self, 15, function()
    if self.times < 7 then
      self.times = self.times + 1
      local tar
      local targets = LuaSkillCtrl:CallTargetSelect(self, 42, 10)
      if targets ~= nil then
        for i = 0, targets.Count - 1 do
          local role = targets[i].targetRole
          if not LuaSkillCtrl:IsObstacle(role) then
            tar = role
            break
          end
        end
        if tar ~= nil then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, tar)
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
            self.arglist[1]
          })
          skillResult:EndResult()
          LuaSkillCtrl:CallBuff(self, tar, self.config.buffId_hitfly, 1, 10)
          local tar_grid = LuaSkillCtrl:GetGridWithRole(tar)
          local targrid = LuaSkillCtrl:GetTargetWithGrid(tar_grid.x, tar_grid.y)
          LuaSkillCtrl:CallEffect(targrid, self.config.effect_hit, self)
        end
        if self.times >= 7 then
          LuaSkillCtrl:StartTimer(self, 20, function()
            LuaSkillCtrl:CallEffect(self.caster, self.config.effect_end, self)
            local playerList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
            if playerList.Count > 0 then
              for i = playerList.Count - 1, 0, -1 do
                local role = playerList[i]
                if role ~= nil and 0 < role.hp then
                  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
                  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
                    self.arglist[2]
                  })
                  skillResult:EndResult()
                end
              end
            end
          end, nil, nil, 1)
        end
      end
    end
  end, nil, -1, 10)
end

function bs_210904:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  self.caster.recordTable.onskill = false
  if self.effect_atk ~= nil then
    self.effect_atk:Die()
    self.effect_atk = nil
  end
end

function bs_210904:OnCasterDie()
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

function bs_210904:LuaDispose()
  self.effect_atk = nil
  base.LuaDispose(self)
end

return bs_210904
