local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_526 = class("bs_526", bs_1)
local base = bs_1
bs_526.config = {
  effectId_trail = 10445,
  effectIdPJ = 10513,
  HurtConfig = {
    hit_formula = 0,
    def_formula = 0,
    basehurt_formula = 10085
  },
  audioId1 = 317,
  audioId2 = 361
}
bs_526.config = setmetatable(bs_526.config, {
  __index = base.config
})

function bs_526:ctor()
end

function bs_526:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_526:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId)
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    self.caster:LookAtTarget(target)
    if data.effectId_trail ~= nil then
      if data.audioId4 ~= nil then
        LuaSkillCtrl:PlayAuSource(self.caster, data.audioId4)
      end
      local roll = self.caster.recordTable["521_Roll"]
      if roll == nil then
        roll = 0
      end
      if roll >= LuaSkillCtrl:CallRange(1, 1000) then
        LuaSkillCtrl:CallEffectWithArg(target, data.effectIdPJ, self, true, false, self.SkillEventFunc, data, 1)
      else
        LuaSkillCtrl:CallEffectWithArg(target, data.effectId_trail, self, true, false, self.SkillEventFunc, data, 2)
      end
    end
    if self.caster.recordTable.completeFirstComatk == nil then
      self.caster.recordTable.completeFirstComatk = true
    end
  else
    self:BreakSkill()
  end
  self:CancleCasterWait()
end

function bs_526:SkillEventFunc(configData, num, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    if configData.audioId5 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, configData.audioId5)
    end
    if num == 1 then
      local arg = self.caster.recordTable["521_arg2"]
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:PlayAuHit(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {arg})
      skillResult:EndResult()
    else
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:PlayAuHit(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult)
      skillResult:EndResult()
    end
  end
end

function bs_526:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_526
