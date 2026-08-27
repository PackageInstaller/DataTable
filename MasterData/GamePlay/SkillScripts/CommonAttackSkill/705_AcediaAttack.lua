local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_705 = class("bs_705", bs_1)
local base = bs_1
bs_705.config = {
  action1 = 1001,
  action2 = 1004,
  action3 = 1020,
  effectId_ex = 208704,
  effectId_1 = 208701,
  effectId_2 = 208702,
  effectId_hitp = 208703,
  effectId_sign = 210201,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0,
    crithur_ratio = 0
  }
}
bs_705.config = setmetatable(bs_705.config, {
  __index = base.config
})

function bs_705:ctor()
end

function bs_705:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_705", 1, self.OnAfterBattleStart)
end

function bs_705:OnAfterBattleStart()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_sign, self)
end

function bs_705:RealPlaySkill(target, data)
  self:CallSelectEffect()
  local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
  local atkSpeedRatio = 1
  local atkActionId = data.action1
  local atkTriggerFrame = 0
  local roll = self.caster.recordTable["208701_Roll"]
  if roll == nil then
    roll = 0
  end
  local roll_attack = false
  if roll >= LuaSkillCtrl:CallRange(1, 1000) then
    roll_attack = true
    atkSpeedRatio = 1
    atkActionId = data.action3
    atkTriggerFrame = 9
  else
    local prob = LuaSkillCtrl:CallRange(1, 2)
    if prob == 1 then
      if data.audioId2 ~= nil then
        LuaSkillCtrl:StartTimer(self, data.time2, function()
          LuaSkillCtrl:PlayAuSource(self.caster, data.audioId2)
        end)
      end
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1)
      atkActionId = data.action1
      atkTriggerFrame = self:GetAtkTriggerFrame(1, atkSpeed) * self.config.baseActionSpd
    else
      if data.audioId1 ~= nil then
        LuaSkillCtrl:StartTimer(self, data.time1, function()
          LuaSkillCtrl:PlayAuSource(self.caster, data.audioId1)
        end)
      end
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1)
      atkActionId = data.action2
      atkTriggerFrame = self:GetAtkTriggerFrame(1, atkSpeed) * self.config.baseActionSpd
    end
  end
  self.caster.recordTable.lastAttackRole = target
  if LuaSkillCtrl.IsInTDBattle and self.caster.belongNum == 2 then
    self.caster.recordTable.lastAttackRole = nil
  end
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame, roll_attack)
  local waitTime = atkSpeed - 1 - (self.rotateWaited and 3 or 0)
  if 0 < waitTime then
    self:CallCasterWait(waitTime + 2)
  end
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, atkTriggerFrame, attackTrigger)
  if self.caster.attackRange == 1 then
    if roll_attack then
      self.caster.recordTable["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, data.effectId_ex, self, nil, nil, atkSpeedRatio, true)
    elseif data.effectId_1 ~= nil then
      if atkActionId == data.action1 then
        self.caster.recordTable["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, data.effectId_1, self, nil, nil, atkSpeedRatio, true)
      else
        self.caster.recordTable["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, data.effectId_2, self, nil, nil, atkSpeedRatio, true)
      end
    end
  end
  if data.effectId_start1 ~= nil then
    if atkActionId == data.action1 then
      LuaSkillCtrl:CallEffect(target, data.effectId_start1, self, nil, nil, atkSpeedRatio, true)
    else
      LuaSkillCtrl:CallEffect(target, data.effectId_start2, self, nil, nil, atkSpeedRatio, true)
    end
  end
end

function bs_705:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame, roll_attack)
  if roll_attack then
    LuaSkillCtrl:CallEffect(target, self.config.effectId_hitp, self)
    local hurtjc = self.caster.recordTable["208701_arg2"]
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {hurtjc})
    skillResult:EndResult()
    LuaSkillCtrl:StartTimer(self, 4, function()
      LuaSkillCtrl:CallEffect(target, self.config.effectId_hitp, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {hurtjc})
      skillResult:EndResult()
    end)
    LuaSkillCtrl:StartTimer(self, 8, function()
      LuaSkillCtrl:CallEffect(target, self.config.effectId_hitp, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {hurtjc})
      skillResult:EndResult()
    end)
    LuaSkillCtrl:StartTimer(self, 16, function()
      LuaSkillCtrl:CallEffect(target, self.config.effectId_hitp, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {hurtjc})
      skillResult:EndResult()
    end)
  else
    base.OnAttackTrigger(self, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  end
end

function bs_705:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_705
