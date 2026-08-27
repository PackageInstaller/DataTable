local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_213300 = class("bs_213300", bs_1)
local base = bs_1
bs_213300.config = {
  select_id = 9,
  effectId_trail = 203301,
  effectId_trail_ex = 203307,
  hurt_config = {
    hit_formula = 9991,
    crit_formula = 0,
    correct_formula = 9989,
    basehurt_formula = 10007
  },
  select_range = 10
}
bs_213300.config = setmetatable(bs_213300.config, {
  __index = base.config
})

function bs_213300:ctor()
end

function bs_213300:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_213300:PlaySkill(passdata)
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

function bs_213300:FindEnemy(selectId, rangeOffset)
  rangeOffset = rangeOffset or 0
  local targetList = LuaSkillCtrl:CallTargetSelect(self, selectId, rangeOffset)
  if 0 < targetList.Count then
    return targetList[0].targetRole
  end
end

function bs_213300:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if target.belongNum ~= self.caster.belongNum then
    local targetListAll = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id, self.config.select_range)
    if targetListAll.Count > 0 then
      for i = 0, targetListAll.Count - 1 do
        self:ExecuteEffectAttack(data, atkActionId, targetListAll[i])
      end
    end
  end
end

function bs_213300:SkillEventFunc(configData, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config)
    skillResult:EndResult()
  end
end

function bs_213300:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_213300
