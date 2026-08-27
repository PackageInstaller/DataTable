local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_100600 = class("bs_100600", bs_1)
local base = bs_1
bs_100600.config = {
  effectId_trail = 100601,
  effectId_start11 = 100603,
  effectId_start22 = 100604,
  effectId_start33 = 100602,
  audioId6 = 100601,
  effectId_trail_wuxia = 100615
}
bs_100600.config = setmetatable(bs_100600.config, {
  __index = base.config
})

function bs_100600:ctor()
end

function bs_100600:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_100600:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    self.caster.recordTable.lastAttackRole = target
    local extraTarget = self:CheckAndGetExtraEffectTarget(target)
    self:CallShoot(target, data, atkActionId)
    if extraTarget ~= nil then
      self:CallShoot(extraTarget, data, atkActionId)
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
end

function bs_100600:CallShoot(target, data, atkActionId)
  if atkActionId == data.action1 then
    if data.audioId6 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, data.audioId6)
    end
    if LuaSkillCtrl:GetCasterSkinId(self.caster) == 300605 then
      LuaSkillCtrl:CallEffectWithArg(target, data.effectId_trail_wuxia, self, true, false, self.SkillEventFunc, data)
      return
    end
    LuaSkillCtrl:CallEffect(target, data.effectId_start11, self)
    LuaSkillCtrl:CallEffectWithArg(target, data.effectId_trail, self, true, false, self.SkillEventFunc, data)
  else
    if data.audioId6 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, data.audioId6)
    end
    if LuaSkillCtrl:GetCasterSkinId(self.caster) == 300605 then
      LuaSkillCtrl:CallEffectWithArg(target, data.effectId_trail_wuxia, self, true, false, self.SkillEventFunc, data)
      return
    end
    LuaSkillCtrl:CallEffect(target, data.effectId_start33, self)
    LuaSkillCtrl:CallEffect(target, data.effectId_start22, self)
    LuaSkillCtrl:CallEffectWithArg(target, data.effectId_trail, self, true, false, self.SkillEventFunc, data)
  end
end

function bs_100600:SkillEventFunc(configData, effect, eventId, target)
  base.SkillEventFunc(self, configData, effect, eventId, target)
end

function bs_100600:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100600
