local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_108400 = class("bs_108400", bs_1)
local base = bs_1
bs_108400.config = {
  aoe_config = {
    effect_shape = 2,
    aoe_select_code = 4,
    aoe_range = 1
  },
  HurtConfigID = 10,
  audioId_hit = nil,
  buffSpeed = 108405,
  buffAtkUp = 108401,
  effectId_1 = 108401,
  effectId_1_2 = 108402,
  effectId_1_3 = 108403,
  effectId_2 = 108404,
  effectId_2_2 = 108405,
  effectId_2_3 = 108406,
  effectId_3 = 108407,
  effectId_ex = 108408,
  effectId_ex_2 = 108409,
  effectId_ex_3 = 108410,
  actionSpecial = 1025
}
bs_108400.config = setmetatable(bs_108400.config, {
  __index = base.config
})

function bs_108400:ctor()
end

function bs_108400:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_108401_1", 1, self.OnAfterBattleStart)
  self.aoe = false
end

function bs_108400:OnAfterBattleStart()
  self.arg = self.caster.recordTable.attackArg
end

function bs_108400:RealPlaySkill(target, data)
  if self.caster:GetBuffTier(self.config.buffSpeed) > 0 then
    self.aoe = true
  else
    self.aoe = false
  end
  self:CallSelectEffect()
  local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
  local atkSpeedRatio = 1
  local atkActionId = data.action1
  local atkTriggerFrame = 0
  local atkId = 1
  if self.aoe then
    atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 2) * self.config.baseActionSpd
    atkActionId = self.config.actionSpecial
    atkTriggerFrame = self:GetAtkTriggerFrame(2, atkSpeed)
  elseif 1 < self.attackNum then
    local prob = LuaSkillCtrl:CallRange(1, 2)
    atkId = prob
    if prob == 1 then
      if data.audioId2 ~= nil and self.aoe == false then
        LuaSkillCtrl:StartTimer(self, data.time2, function()
          LuaSkillCtrl:PlayAuSource(self.caster, data.audioId2)
        end)
      end
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 2) * self.config.baseActionSpd
      atkActionId = data.action2
      atkTriggerFrame = self:GetAtkTriggerFrame(2, atkSpeed)
      self.attackNum = 0
    else
      if data.audioId1 ~= nil and self.aoe == false then
        LuaSkillCtrl:StartTimer(self, data.time1, function()
          LuaSkillCtrl:PlayAuSource(self.caster, data.audioId1)
        end)
      end
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1)
      atkActionId = data.action1
      atkTriggerFrame = self:GetAtkTriggerFrame(1, atkSpeed) * self.config.baseActionSpd
      self.attackNum = self.attackNum + 1
    end
  else
    if data.audioId1 ~= nil and self.aoe == false then
      LuaSkillCtrl:StartTimer(self, data.time1, function()
        LuaSkillCtrl:PlayAuSource(self.caster, data.audioId1)
      end)
    end
    atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1) * self.config.baseActionSpd
    atkTriggerFrame = self:GetAtkTriggerFrame(1, atkSpeed)
    atkActionId = data.action1
    self.attackNum = self.attackNum + 1
  end
  self.caster.recordTable.lastAttackRole = target
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  local waitTime = atkSpeed - 1 - (self.rotateWaited and 3 or 0)
  if 0 < waitTime then
    self:CallCasterWait(waitTime + 2)
  end
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, atkTriggerFrame, attackTrigger, atkId)
  if self.caster.attackRange == 1 then
    if data.effectId_1 ~= nil then
      local attackEffect1Id, attackEffect2Id, attackEffectExId
      local tier = self.caster:GetBuffTier(self.config.buffAtkUp)
      if 40 <= tier then
        attackEffect1Id = self.config.effectId_1_3
        attackEffect2Id = self.config.effectId_2_3
        attackEffectExId = self.config.effectId_ex_3
      elseif 20 <= tier then
        attackEffect1Id = self.config.effectId_1_2
        attackEffect2Id = self.config.effectId_2_2
        attackEffectExId = self.config.effectId_ex_2
      else
        attackEffect1Id = self.config.effectId_1
        attackEffect2Id = self.config.effectId_2
        attackEffectExId = self.config.effectId_ex
      end
      if atkActionId == data.action1 then
        self.caster.recordTable["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, attackEffect1Id, self, nil, nil, atkSpeedRatio, true)
      elseif self.aoe then
        self.caster.recordTable["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, attackEffectExId, self, nil, nil, atkSpeedRatio, true)
      else
        self.caster.recordTable["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, attackEffect2Id, self, nil, nil, atkSpeedRatio, true)
      end
    end
    if data.effectId_3 ~= nil then
      LuaSkillCtrl:StartTimer(self, atkTriggerFrame, function()
        LuaSkillCtrl:CallEffect(target, data.effectId_3, self, nil, nil, atkSpeedRatio)
      end)
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

function bs_108400:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if self.aoe == true then
    self:CallAoeDamage(target)
    if data.audioId3 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, data.audioId3)
    end
    if self.isDoubleAttack then
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
      self:CheckAndExecuteSecondAttack(data, target, atkTriggerFrame, atkSpeedRatio, atkActionId, attackTrigger)
    else
      self:CancleCasterWait()
    end
    if self.cskill.skillCfg.BreakNum ~= 0 then
      target:TryCallBreakNumChange(-self.cskill.skillCfg.BreakNum)
    end
  else
    base.OnAttackTrigger(self, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  end
end

function bs_108400:CallAoeDamage(target)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, self.config.aoe_config)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
    self.arg
  })
  skillResult:EndResult()
  if self.config.audioId_hit ~= nil then
    LuaSkillCtrl:PlayAuSource(target, self.config.audioId_hit)
  end
end

function bs_108400:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_108400
