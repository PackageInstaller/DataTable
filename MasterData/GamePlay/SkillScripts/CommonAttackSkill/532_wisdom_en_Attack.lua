local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_532 = class("bs_532", bs_1)
local base = bs_1
bs_532.config = {
  HurtConfig = {},
  heal_config = {
    baseheal_formula = 10174,
    heal_number = 0,
    correct_formula = 9990
  },
  effectId_trail1 = 10912,
  effectId_trail = 10579,
  effectId_trailBoom = 10916
}
bs_532.config = setmetatable(bs_532.config, {
  __index = base.config
})

function bs_532:ctor()
end

function bs_532:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.three = false
end

function bs_532:RealPlaySkill(target, data)
  self.three = self.caster.recordTable["203204_attakflag"]
  if self.three then
    self.caster.recordTable["203204_attakflag"] = false
  end
  self:CallSelectEffect()
  local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
  local atkSpeedRatio = 1
  local atkActionId = data.action1
  local atkTriggerFrame = self:GetAtkTriggerFrame(2, atkSpeed)
  self.caster.recordTable.lastAttackRole = target
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  local waitTime = atkSpeed - 1 - (self.rotateWaited and 3 or 0)
  if 0 < waitTime then
    self:CallCasterWait(waitTime + 2)
  end
  if self.three == true then
  end
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, atkTriggerFrame, attackTrigger)
end

function bs_532:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if self.three == true then
    local extraTarget = self:CheckAndGetExtraEffectTarget(target)
    self:CallColliderEmission(target)
    if extraTarget ~= nil then
      self:CallColliderEmission(extraTarget)
    end
    if self.isDoubleAttack then
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
      self:CheckAndExecuteSecondAttack(data, target, atkTriggerFrame, atkSpeedRatio, atkActionId, attackTrigger)
    else
      self:CancleCasterWait()
    end
  else
    base.OnAttackTrigger(self, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  end
end

function bs_532:CallColliderEmission(target)
  local collisionTrigger = BindCallback(self, self.OnCollision, target)
  local cusEffect = LuaSkillCtrl:CallEffect(target, self.config.effectId_trail1, self, nil, nil, 0.5)
  LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 15, 5, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, nil, true, true, BindCallback(self, self.OnEmissionArive), nil)
end

function bs_532:OnEmissionArive(emission)
  if self.cusEffect ~= nil then
    self.cusEffect:Die()
    self.cusEffect = nil
  end
end

function bs_532:OnCollision(target, collider, index, entity)
  if self.caster == nil or self.caster.hp <= 0 or 0 < entity:GetBuffTier(self.config.buffId_tip) then
    return
  end
  local _Cskill = self.caster.recordTable.cs_Skill
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig)
  skillResult:EndResult()
  if self.caster.recordTable["203204_arg"] ~= nil then
    local arg = self.caster.recordTable["203204_arg"]
    local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResult(skillResult1, self.config.heal_config, {arg})
    skillResult:EndResult()
  end
  LuaSkillCtrl:CallEffect(entity, self.config.effectId_trailBoom, self)
end

function bs_532:OnCasterDie()
  base.OnCasterDie(self)
  if self.cusEffect ~= nil then
    self.cusEffect:Die()
    self.cusEffect = nil
  end
end

function bs_532:LuaDispose()
  base.LuaDispose(self)
  if self.cusEffect ~= nil then
    self.cusEffect:Die()
    self.cusEffect = nil
  end
end

return bs_532
