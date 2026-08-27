local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_1008002 = class("bs_1008002", bs_1)
local base = bs_1
bs_1008002.config = {
  effectId_trail = 100801,
  buffIdBJ = 10080101,
  heal_config = {
    baseheal_formula = 3021,
    heal_number = 0,
    crit_formula = 9992,
    crithur_ratio = 9995,
    correct_formula = 9990
  },
  audioId1 = 100801,
  audioId2 = 100802
}
bs_1008002.config = setmetatable(bs_1008002.config, {
  __index = base.config
})

function bs_1008002:ctor()
end

function bs_1008002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_1008002:PlaySkill(passdata)
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
  if 0 < self.caster:GetBuffTier(self.config.buffIdBJ) then
    rangeOffset = 10
  end
  if self.caster.recordTable.BJ == true then
    targetRole = self:FindEnemy(3, rangeOffset)
    if targetRole == nil then
      targetRole = self:FindEnemy(10001)
    end
  else
    targetRole = self:FindEnemy(10001)
  end
  if targetRole ~= nil and 0 < targetRole.hp then
    self:RealPlaySkill(targetRole, data)
    self.caster:LookAtTarget(targetRole)
  end
end

function bs_1008002:FindEnemy(selectId, rangeOffset)
  rangeOffset = rangeOffset or 0
  local targetList = LuaSkillCtrl:CallTargetSelect(self, selectId, rangeOffset)
  if 0 < targetList.Count then
    return targetList[0].targetRole
  end
end

function bs_1008002:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if target.belongNum == self.caster.belongNum and self.caster.recordTable.BJ == true then
    if self.caster:GetBuffTier(self.config.buffIdBJ) > 0 then
      local influenceType
      if self.caster.belongNum == eBattleRoleBelong.player then
        influenceType = 10
      elseif self.caster.belongNum == eBattleRoleBelong.enemy then
        influenceType = 12
      end
      if influenceType ~= nil then
        local targetListAll = LuaSkillCtrl:CallTargetSelect(self, 6, influenceType)
        if 0 < targetListAll.Count then
          for i = 0, targetListAll.Count - 1 do
            LuaSkillCtrl:CallEffect(targetListAll[i].targetRole, self.config.effectId_trail, self, self.SkillEventFunc2)
          end
        end
      end
    else
      LuaSkillCtrl:CallEffect(target, self.config.effectId_trail, self, self.SkillEventFunc2)
      local extraTarget = self:CheckAndGetExtraEffectTarget(target, 34)
      if extraTarget ~= nil then
        LuaSkillCtrl:CallEffect(extraTarget, self.config.effectId_trail, self, self.SkillEventFunc2)
      end
    end
    if self.caster.recordTable.completeFirstComatk == nil then
      self.caster.recordTable.completeFirstComatk = true
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

function bs_1008002:SkillEventFunc2(effect, eventId, target)
  local miss = LuaSkillCtrl:CallFormulaBoolWithSkill(10051, self.caster, self.caster, self)
  if miss and eventId == eBattleEffectEvent.Trigger then
    local arg = self.caster.recordTable["arglist[1]"]
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {arg}, false)
    skillResult:EndResult()
  end
end

function bs_1008002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1008002
