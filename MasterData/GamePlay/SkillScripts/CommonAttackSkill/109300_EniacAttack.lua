local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_109300 = class("bs_109300", bs_1)
local base = bs_1
bs_109300.config = {
  effectId_trail = 109301,
  action1 = 1001,
  action2 = 1001,
  heal_config = {
    baseheal_formula = 3020,
    heal_number = 0,
    crit_formula = 9992,
    crithur_ratio = 9995,
    correct_formula = 9990
  }
}
bs_109300.config = setmetatable(bs_109300.config, {
  __index = base.config
})

function bs_109300:ctor()
end

function bs_109300:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.effectID = self.config.effectId_trail
end

function bs_109300:PlaySkill(passdata)
  self:CheckAndRecordIsDoubleAttack(passdata)
  local data
  if passdata ~= nil then
    data = setmetatable(passdata, {
      __index = self.config
    })
  else
    data = self.config
  end
  local targetRole
  local rangeOffset = 0
  targetRole = self:FindEnemy(86)
  if targetRole ~= nil and 0 < targetRole.hp then
    self:RealPlaySkill(targetRole, data)
    self.caster:LookAtTarget(targetRole)
  end
end

function bs_109300:FindEnemy(selectId, rangeOffset)
  rangeOffset = rangeOffset or 0
  local targetList = LuaSkillCtrl:CallTargetSelect(self, selectId, rangeOffset)
  if 0 < targetList.Count then
    return targetList[0].targetRole
  end
end

function bs_109300:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  LuaSkillCtrl:CallEffect(target, self.effectID, self, self.SkillEventFunc2)
  local extraTarget = self:CheckAndGetExtraEffectTarget(target, 86)
  if extraTarget ~= nil then
    LuaSkillCtrl:CallEffect(extraTarget, self.effectID, self, self.SkillEventFunc2)
  end
end

function bs_109300:SkillEventFunc2(effect, eventId, target)
  local miss = LuaSkillCtrl:CallFormulaBoolWithSkill(10051, self.caster, self.caster, self)
  if miss and eventId == eBattleEffectEvent.Trigger and effect.dataId == self.effectID then
    local arg = self.caster.recordTable["arglist[1]"]
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {arg}, false)
    skillResult:EndResult()
  end
end

function bs_109300:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_109300
