local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_207704 = class("bs_207704", bs_1)
local base = bs_1
bs_207704.config = {action1 = 0, action2 = 0}
bs_207704.config = setmetatable(bs_207704.config, {
  __index = base.config
})

function bs_207704:ctor()
end

function bs_207704:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_207704:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if self.caster.attackRange == 1 then
    if data.audioId3 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, data.audioId3)
    end
    if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange) then
      local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
      if 0 < targetList.Count then
        for i = 0, targetList.Count - 1 do
          local target = targetList[i]
          if data.Imp == true then
            LuaSkillCtrl:PlayAuHit(self, target)
          end
        end
      end
      if self.caster.recordTable.completeFirstComatk == nil then
        self.caster.recordTable.completeFirstComatk = true
      end
    else
      self:BreakSkill()
    end
  elseif LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange) then
    if data.effectId_action_1 ~= nil then
      if atkActionId == data.action1 then
        LuaSkillCtrl:CallEffect(self.caster, data.effectId_action_1, self)
      else
        LuaSkillCtrl:CallEffect(self.caster, data.effectId_action_2, self)
      end
    end
    if data.effectId_start3 ~= nil then
      if atkActionId == data.action1 then
        LuaSkillCtrl:CallEffect(target, data.effectId_start3, self, nil, nil, atkSpeedRatio)
      else
        LuaSkillCtrl:CallEffect(target, data.effectId_start4, self, nil, nil, atkSpeedRatio)
      end
    end
    local extraTarget = self:CheckAndGetExtraEffectTarget(target)
    self:ExecuteEffectAttack(data, atkActionId, target)
    if extraTarget ~= nil then
      self:ExecuteEffectAttack(data, atkActionId, extraTarget, data.effectId_split_shoot, data.effectId_split_shoot_ex)
    end
    if self.caster.recordTable.completeFirstComatk == nil then
      self.caster.recordTable.completeFirstComatk = true
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

function bs_207704:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_207704
