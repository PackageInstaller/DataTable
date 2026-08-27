local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_600 = class("bs_600", bs_1)
local base = bs_1
bs_600.config = {
  effectId_trail = 2048006,
  effectId_trail0 = 2048001,
  effectId_trail3 = 2048004,
  effectId_trail4 = 2048005,
  buffId_151 = 3007,
  skill_time = 99999,
  select_id = 9,
  audioId_hit = 420,
  hurt_config = {
    hit_formula = 9991,
    crit_formula = 0,
    correct_formula = 9989,
    basehurt_formula = 10076
  }
}
bs_600.config = setmetatable(bs_600.config, {
  __index = base.config
})

function bs_600:ctor()
end

function bs_600:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_600:PlaySkill(passdata)
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
  local rangeOffset = 10
  targetRole = self:FindEnemy(10001, 10)
  if targetRole ~= nil and targetRole.hp > 0 then
    self:RealPlaySkill(targetRole, data)
    self.caster:LookAtTarget(targetRole)
  end
end

function bs_600:FindEnemy(selectId, rangeOffset)
  rangeOffset = rangeOffset or 0
  local targetList = LuaSkillCtrl:CallTargetSelect(self, selectId, rangeOffset)
  if 0 < targetList.Count then
    return targetList[0].targetRole
  end
end

function bs_600:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_trail0, self)
  if target.belongNum ~= self.caster.belongNum then
    local targetListAll = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id, self.config.select_range)
    if targetListAll.Count > 0 then
      for i = 0, targetListAll.Count - 1 do
        LuaSkillCtrl:CallEffect(targetListAll[i].targetRole, self.config.effectId_trail, self, self.SkillEventFunc2)
      end
    end
    self:BeatBack(target)
  end
end

function bs_600:SkillEventFunc2(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config)
    skillResult:EndResult()
  end
end

function bs_600:BeatBack(target)
  local random = LuaSkillCtrl:CallRange(1, 1000)
  if random <= self.arglist[2] then
    LuaSkillCtrl:CallEffect(target, self.config.effectId_trail3, self)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_trail4, self)
    local number = 1 - self.caster.attackRange
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, number)
    if targetList ~= nil then
      for i = 0, targetList.Count - 1 do
        local buff = LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffId_151, 1, 3)
      end
    end
  end
end

function bs_600:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_600
