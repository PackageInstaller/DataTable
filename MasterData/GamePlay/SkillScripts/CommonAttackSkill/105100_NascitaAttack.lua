local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_105100 = class("bs_105100", bs_1)
local base = bs_1
bs_105100.config = {
  action1 = 1001,
  action2 = 1004,
  selectId = 9,
  selectRange = 10,
  BuffId_slide = 1051013,
  buffId_claw = 1051012,
  buffId_ult = 1051031,
  buffId_CD = 1051014,
  effectId_1 = 105101,
  effectId_2 = 105102,
  effectId_up = 105104,
  effectId_down = 105112,
  specialColor = {
    r = 134,
    g = 50,
    b = 191
  },
  audioId1 = 105101,
  time1 = 0,
  audioId2 = 105102,
  time2 = 0
}
bs_105100.config = setmetatable(bs_105100.config, {
  __index = base.config
})
local AtkState = {
  Atk = 1,
  Splash = 2,
  Stop = 3
}
local RoleState = {normal = 1, special = 2}

function bs_105100:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.__atkNum = 0
  self.__complateExeCount = 0
  self.__roleState = RoleState.normal
  self.state = AtkState.Stop
  if not LuaSkillCtrl.IsInVerify then
    LuaSkillCtrl:SetCountingColor(self.caster, 255, 255, 255, 255)
  end
  self:ShowAttackCounting(0)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_105100_1", 1, self.BeforeEndBattle)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_105100_2", 2, self.OnAfterBattleStart)
end

function bs_105100:PlaySkill(passdata)
  self:CallCasterWait(450)
  base.PlaySkill(self, passdata)
end

function bs_105100:OnAfterBattleStart()
  if self.caster.recordTable.BattlestartPlay ~= nil then
    self.__atkNum = self.caster.recordTable.BattlestartPlay
  end
end

function bs_105100:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if data.audioId3 ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, data.audioId3)
  end
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    self.caster:LookAtTarget(target)
    if self.__roleState == RoleState.special then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, 10, {
        self.caster.recordTable.SplashAttackLow
      })
      skillResult:EndResult()
    else
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      if data.Imp == true then
        LuaSkillCtrl:PlayAuHit(self, target)
      end
      LuaSkillCtrl:HurtResult(self, skillResult)
      skillResult:EndResult()
    end
    if self.__roleState == RoleState.normal then
      self.__atkNum = self.__atkNum + 1
      self:ShowAttackCounting(self.__atkNum, self.__atkNum > 1)
    else
      LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnNascitaAttack, target, self.caster, self.cskill)
    end
    if self.caster:GetBuffTier(self.config.buffId_ult) > 0 then
      LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnNascitaAttack, target, self.caster, self.cskill)
    end
    if self.caster.recordTable.completeFirstComatk == nil then
      self.caster.recordTable.completeFirstComatk = true
    end
  else
    self:BreakSkill()
  end
  if self.isDoubleAttack then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
    self:CheckAndExecuteSecondAttack(data, target, atkTriggerFrame, atkSpeedRatio, atkActionId, attackTrigger)
  else
    self:CancleCasterWait()
  end
  if self.recordDoubleAttackNum == nil or self.recordDoubleAttackNum == 0 then
    if self.__roleState == RoleState.normal then
      if self.__atkNum < self.caster.recordTable.MaxAttackCount then
        return
      end
      self.__roleState = RoleState.special
      self.specialAtkCount = self:CalcSpecialAtkCount()
      self:ShowAttackCounting(self.specialAtkCount, false)
      if not LuaSkillCtrl.IsInVerify then
        LuaSkillCtrl:SetCountingColor(self.caster, self.config.specialColor.r, self.config.specialColor.g, self.config.specialColor.b, 255)
      end
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_CD, 1, nil)
      self.__atkNum = 0
    end
    if self.__roleState == RoleState.special and 0 >= self.caster:GetBuffTier(self.config.buffId_CD) then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_CD, 1, nil)
    end
    self:CheckAtkAndSplash(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  end
end

function bs_105100:CalcSpecialAtkCount()
  local normalCount = self.caster.recordTable.SplashAttackCount
  if self.caster.recordTable.ultPassive == nil then
    return normalCount
  else
    local ultCount = self.caster.recordTable.ultPassive + normalCount
    return self.caster:GetBuffTier(self.config.buffId_ult) > 0 and ultCount or normalCount
  end
end

function bs_105100:ShowAttackCounting(value, isUpdate)
  if LuaSkillCtrl.IsInVerify then
    return
  end
  if value == 0 and not isUpdate then
    LuaSkillCtrl:HideCounting(self.caster)
    return
  end
  if isUpdate then
    LuaSkillCtrl:UpdateCounting(self.caster, value)
  else
    local maxValue = self.__roleState == RoleState.special and self.specialAtkCount or self.caster.recordTable.MaxAttackCount
    LuaSkillCtrl:ShowCounting(self.caster, value, maxValue)
  end
end

function bs_105100:CheckAtkAndSplash(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if self.__roleState == RoleState.special and self.__complateExeCount >= self.specialAtkCount then
    self:ClearAtkState()
    return
  end
  if self.state == AtkState.Stop then
    self:CheckAtkNumAndExecute(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
    return
  end
  if self.state == AtkState.Atk then
    self:CheckAndExecuteSplash(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
    return
  end
end

function bs_105100:ClearAtkState()
  if not LuaSkillCtrl.IsInVerify then
    LuaSkillCtrl:SetCountingColor(self.caster, 255, 255, 255, 255)
  end
  self:ShowAttackCounting(0)
  self:CancleCasterWait()
  self.state = AtkState.Stop
  self.__roleState = RoleState.normal
  self.__atkNum = 0
  self.__complateExeCount = 0
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_CD, 0)
end

function bs_105100:BeforeEndBattle()
  if not LuaSkillCtrl.IsInVerify then
    LuaSkillCtrl:SetCountingColor(self.caster, 255, 255, 255, 255)
  end
  self:ShowAttackCounting(0)
end

function bs_105100:CheckAndExecuteSplash(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  self.state = AtkState.Splash
  self.__complateExeCount = self.__complateExeCount + 1
  self:ShowAttackCounting(self.specialAtkCount - self.__complateExeCount, true)
  self:InternalSplash(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
end

function bs_105100:InternalSplash(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.BeatBack) or LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.KnockOff) or LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.Stun) or LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.AbandonMove) then
    self.state = AtkState.Stop
    return
  end
  local targets = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, self.config.selectRange)
  if targets.Count == 0 then
    self.state = AtkState.Stop
    return
  end
  local minTier = 999
  local targetRole, targetGrid
  local onFireRole = self.caster:TryToGetFocusFiringRole()
  if onFireRole == nil then
    for i = 0, targets.Count - 1 do
      local role = targets[i].targetRole
      if role.belongNum ~= eBattleRoleBelong.neutral and role:IsUnSelect(self.caster, true) ~= true then
        local grid = LuaSkillCtrl:FindEmptyGridAroundRole(role)
        if grid ~= nil then
          local tier = role:GetBuffTier(self.config.buffId_claw)
          if minTier > tier then
            minTier = tier
            targetRole = role
            targetGrid = grid
          end
        end
      end
    end
  else
    local grid = LuaSkillCtrl:FindEmptyGridAroundRole(onFireRole)
    if grid ~= nil then
      targetRole = onFireRole
      targetGrid = grid
    end
  end
  if targetGrid == nil or targetRole == nil then
    local grid = LuaSkillCtrl:GetGridWithPos(self.caster.x, self.caster.y)
    if grid ~= nil then
      local roleList = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 1, false)
      if roleList.Count > 0 then
        for i = 0, roleList.Count - 1 do
          local role = roleList[i]
          if role.belongNum == eBattleRoleBelong.enemy and role:IsUnSelect(self.caster, true) ~= true then
            targetRole = role
            targetGrid = grid
          end
        end
      end
    end
  end
  if targetGrid == nil or targetRole == nil then
    for i = targets.Count - 1, 0, -1 do
      local role = targets[i].targetRole
      if role.belongNum == eBattleRoleBelong.neutral and role:IsUnSelect(self.caster, true) ~= true then
        local grid = LuaSkillCtrl:FindEmptyGridAroundRole(role)
        if grid ~= nil then
          local tier = role:GetBuffTier(self.config.buffId_claw)
          if minTier > tier then
            minTier = tier
            targetRole = role
            targetGrid = grid
          end
        end
      end
    end
  end
  if targetGrid == nil or targetRole == nil then
    self.state = AtkState.Stop
    return
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_up, self)
  local effectGrid = LuaSkillCtrl:GetTargetWithGrid(self.caster.x, self.caster.y)
  local target = LuaSkillCtrl:GetTargetWithGrid(targetGrid)
  LuaSkillCtrl:SetRolePos(targetGrid, self.caster)
  self.caster:LookAtTarget(targetRole)
  LuaSkillCtrl:CallEffect(effectGrid, self.config.effectId_down, self)
  self.state = AtkState.Stop
  self.caster.recordTable.lastAttackRole = targetRole
  self:CheckAtkAndSplash(targetRole, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
end

function bs_105100:CheckAtkNumAndExecute(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  self.state = AtkState.Atk
  self:PassiveAttack(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
end

function bs_105100:PassiveAttack(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    if not LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.StopCommonAttackCD) then
      LuaSkillCtrl:CallResetComAtkCDRatioForRole(self.caster, 100)
    end
  elseif self.state == AtkState.Atk then
    self:CheckAndExecuteSplash(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  end
end

function bs_105100:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if role == self.caster and self.state == AtkState.Stop then
    self:CancleCasterWait()
  end
  if self.__roleState == RoleState.special then
    self.isBeBreak = true
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_CD, 0)
    self:CancleCasterWait()
  end
end

function bs_105100:OnCasterDie()
  if not LuaSkillCtrl.IsInVerify then
    LuaSkillCtrl:SetCountingColor(self.caster, 255, 255, 255, 255)
  end
  self:ShowAttackCounting(0)
  base.OnCasterDie(self)
end

return bs_105100
