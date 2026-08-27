local bs_203205 = class("bs_203205", LuaSkillBase)
local base = LuaSkillBase
bs_203205.config = {
  buffId_Boom = 1216,
  skillId = 532,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 10078,
    crit_formula = 0
  },
  HurtConfig1 = {
    hit_formula = 0,
    basehurt_formula = 10080,
    crit_formula = 0
  },
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 2
  },
  action1 = 1001,
  start_time = 24,
  effectIdXiao = 10913,
  effectIdDa = 10914,
  effectIdDao = 10915,
  countDownDuration = 21,
  boomDuration = 3,
  effectBoomtrail = 10919,
  effectBoom = 10917
}

function bs_203205:ctor()
end

function bs_203205:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBuffDieTrigger("bs_203205_buffdie", 1, self.OnBuffDie, nil, nil, self.config.buffId_Boom)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_203205_10", 1, self.OnRoleDie)
  self.buffNum = 0
  self.index = 0
  self.flag = false
  self.reset = false
end

function bs_203205:PlaySkill(data)
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 1) then
    target = last_target
  else
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 1, 0)
    if targetlist ~= nil and 0 < targetlist.Count then
      target = targetlist[0].targetRole
    else
      return
    end
  end
  self:CallCasterWait(self.config.start_time)
  self.caster:LookAtTarget(target)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.action1, 1, self.config.start_time, attackTrigger)
  local time_196 = self.config.start_time - 1
end

function bs_203205:OnAttackTrigger(target)
  LuaSkillCtrl:CallEffect(target, self.config.effectBoomtrail, self, self.SkillEventFunc)
  self:CancleCasterWait()
  self:CallNextBossSkill()
  if self.reset then
    local skills = self.caster:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          if skills[j].dataId == 203207 then
            local curTotalCd = skills[j].totalCDTime * 1000 // 1000
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
          end
        end
      end
    end
    self.reset = false
  else
    self.reset = true
  end
end

function bs_203205:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local bufftier = target.targetRole:GetBuffTier(self.config.buffId_Boom)
    if 0 < bufftier then
      LuaSkillCtrl:DispelBuff(target.targetRole, self.config.buffId_Boom, 0)
      LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId_Boom, 1, self.arglist[2])
    else
      LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId_Boom, 1, self.arglist[2])
    end
    local countDownEffect = LuaSkillCtrl:CallEffect(target.targetRole, self.config.effectIdDao, self)
    if countDownEffect ~= nil then
      self.caster.recordTable.countDownEfc = countDownEffect
      if not LuaSkillCtrl.IsInVerify then
        countDownEffect:SetCountValue(0)
      end
      self.time = 1
      self.timer203205 = LuaSkillCtrl:StartTimer(nil, self.config.countDownDuration, function()
        local countDownEfc = self.caster.recordTable.countDownEfc
        if self.time >= 5 and countDownEfc ~= nil then
          countDownEfc:Die()
          self.caster.recordTable.countDownEfc = nil
          return
        end
        countDownEfc = LuaSkillCtrl:CallEffect(target.targetRole, self.config.effectIdDao, self)
        if not LuaSkillCtrl.IsInVerify then
          countDownEfc:SetCountValue(self.time)
        end
        self.time = self.time + 1
        self.caster.recordTable.countDownEfc = countDownEfc
      end, self, 4)
    end
  end
end

function bs_203205:OnBuffDie(buff, target, removeType)
  if target ~= nil and target.belongNum ~= self.caster.belongNum and buff.dataId == self.config.buffId_Boom and target.hp > 0 then
    LuaSkillCtrl:CallEffect(target, self.config.effectBoom, self)
    local grid = LuaSkillCtrl:GetGridWithRole(target)
    local targetList = LuaSkillCtrl:FindRolesAroundGrid(grid, target.belongNum)
    if targetList ~= nil and 0 < targetList.Count then
      LuaSkillCtrl:StartTimer(nil, self.config.boomDuration, function()
        if self.index > targetList.Count - 1 then
          self.index = 0
        end
        local targetRole = self.caster.recordTable["203205_targetRole"]
        if targetRole == nil then
          targetRole = targetList[self.index]
          self.caster.recordTable["203205_targetRole"] = targetRole
        else
          if targetRole == targetList[self.index] then
            self.flag = true
          end
          targetRole = targetList[self.index]
          self.caster.recordTable["203205_targetRole"] = targetRole
        end
        if targetList[self.index] ~= nil and 0 < targetList[self.index].hp then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[self.index])
          LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig)
          skillResult:EndResult()
          LuaSkillCtrl:CallEffect(targetList[self.index], self.config.effectIdXiao, self)
        end
        self.index = self.index + 1
      end, self, self.arglist[4] - 1)
    end
    local delaytime = self.config.boomDuration * self.arglist[4] + self.config.boomDuration * 2
    LuaSkillCtrl:StartTimer(nil, delaytime, function()
      if self.flag then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        if target ~= nil and target.hp > 0 then
          LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig1)
          skillResult:EndResult()
          LuaSkillCtrl:CallEffect(target, self.config.effectIdDa, self)
        end
        self.flag = false
        self.index = 0
        self.caster.recordTable["203205_targetRole"] = nil
      end
    end, self)
    self:KillCountDownEfc()
  end
end

function bs_203205:OnRoleDie(killer, role)
  local buffTier = role:GetBuffTier(self.config.buffId_Boom)
  if 0 < buffTier then
    LuaSkillCtrl:DispelBuff(role, self.config.buffId_Boom, 0, true, true)
    self:KillCountDownEfc()
    if self.timer203205 ~= nil then
      self.timer203205:Stop()
      self.timer203205 = nil
    end
  end
end

function bs_203205:OnCasterDie()
  base.OnCasterDie(self)
  self:KillCountDownEfc()
end

function bs_203205:KillCountDownEfc()
  local countDownEfc = self.caster.recordTable.countDownEfc
  if countDownEfc ~= nil then
    countDownEfc:Die()
    self.caster.recordTable.countDownEfc = nil
  end
end

return bs_203205
