local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_100800 = class("bs_100800", bs_1)
local base = bs_1
bs_100800.config = {
  effectId_trail = 100801,
  effectId_trail_live = 100821,
  buffIdBJ = 100801,
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
bs_100800.config = setmetatable(bs_100800.config, {
  __index = base.config
})

function bs_100800:ctor()
end

function bs_100800:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.effectID = self.config.effectId_trail
  if LuaSkillCtrl:GetCasterSkinId(self.caster) == 300805 then
    self.effectID = self.config.effectId_trail_live
  end
end

function bs_100800:PlaySkill(passdata)
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
    if self.caster.recordTable.weapon == true then
      targetRole = self:FindEnemy(14, rangeOffset)
    else
      targetRole = self:FindEnemy(3, rangeOffset)
    end
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

function bs_100800:FindEnemy(selectId, rangeOffset)
  rangeOffset = rangeOffset or 0
  local targetList = LuaSkillCtrl:CallTargetSelect(self, selectId, rangeOffset)
  if 0 < targetList.Count then
    return targetList[0].targetRole
  end
end

function bs_100800:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if target.belongNum == self.caster.belongNum and self.caster.recordTable.BJ == true then
    if self.caster:GetBuffTier(self.config.buffIdBJ) > 0 then
      local targetListAll = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
      if 0 < targetListAll.Count then
        for i = 0, targetListAll.Count - 1 do
          LuaSkillCtrl:CallEffect(targetListAll[i].targetRole, self.effectID, self, self.SkillEventFunc2)
        end
      end
    else
      LuaSkillCtrl:CallEffect(target, self.effectID, self, self.SkillEventFunc2)
      local extraTarget = self:CheckAndGetExtraEffectTarget(target, 34)
      if extraTarget ~= nil then
        LuaSkillCtrl:CallEffect(extraTarget, self.effectID, self, self.SkillEventFunc2)
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

function bs_100800:SkillEventFunc2(effect, eventId, target)
  local miss = LuaSkillCtrl:CallFormulaBoolWithSkill(10051, self.caster, self.caster, self)
  if miss and eventId == eBattleEffectEvent.Trigger and effect.dataId == self.effectID then
    local arg = self.caster.recordTable["arglist[1]"]
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    if self.caster.recordTable.weapon2 == true then
      arg = arg + self.caster.recordTable.exHeal_rate
      local hpRate = target.targetRole._curHp * 1000 // target.targetRole.maxHp
      if hpRate <= 500 then
        arg = arg * (1000 + self.caster.recordTable.exHeal) // 1000
      end
    end
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {arg}, false)
    skillResult:EndResult()
  end
end

function bs_100800:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100800
