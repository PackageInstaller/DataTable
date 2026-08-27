local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_527 = class("bs_527", bs_1)
local base = bs_1
bs_527.config = {
  action1 = 1001,
  action2 = 1001,
  buffId_26 = 26,
  HurtConfig = {basehurt_formula = 10086},
  effectId_bird = 10521
}
bs_527.config = setmetatable(bs_527.config, {
  __index = base.config
})

function bs_527:ctor()
end

function bs_527:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.targetreal = self.caster.recordTable.attackTarget
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_527_10", 1, self.OnRoleDie)
  self.killcaster = nil
  self.time = self.caster.recordTable.time + 2
end

function bs_527:OnRoleDie(killer, role)
  if role == self.targetreal then
    LuaSkillCtrl:DispelBuff(self.caster, 88, 0)
    LuaSkillCtrl:RemoveLife(999, self, self.caster, false, nil, false, false, eHurtType.RealDmg)
    self.caster:BindHostEntity(nil)
  end
end

function bs_527:RealPlaySkill(target, data)
  target = self.targetreal
  if target.hp <= 0 then
    LuaSkillCtrl:DispelBuff(self.caster, 88, 0)
    LuaSkillCtrl:RemoveLife(999, self, self.caster, false, nil, false, false, eHurtType.RealDmg)
    self.caster:BindHostEntity(nil)
  end
  if self.killcaster == nil then
    self.killcaster = LuaSkillCtrl:StartTimer(nil, self.time, function()
      if self.killcaster ~= nil and self.killcaster:IsOver() then
        self.killcaster = nil
      end
      if self.caster.hp > 0 then
        LuaSkillCtrl:RemoveLife(999, self, self.caster, false, nil, false, false, eHurtType.RealDmg)
        self.killcaster = nil
      end
    end, self)
  end
  if target:IsUnSelect(self.caster) or LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.Exiled) then
    return
  end
  base.RealPlaySkill(self, target, data)
end

function bs_527:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId)
  if data.audioId3 ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, data.audioId3)
  end
  if not target:IsUnSelect(self.caster) then
    LuaSkillCtrl:CallEffect(target, self.config.effectId_bird, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    local arg = self.caster.recordTable.arg_1
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {arg})
    LuaSkillCtrl:PlayAuHit(self, target)
    skillResult:EndResult()
    local arg2 = self.caster.recordTable.arg_2
    local arg3 = self.caster.recordTable.arg_3
    if arg2 >= LuaSkillCtrl:CallRange(1, 1000) then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_26, 1, arg3)
    end
    if self.caster.recordTable.completeFirstComatk == nil then
      self.caster.recordTable.completeFirstComatk = true
    end
  else
    self:BreakSkill()
  end
end

function bs_527:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_527
