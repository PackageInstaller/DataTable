local bs_1031022 = class("bs_1031022", LuaSkillBase)
local base = LuaSkillBase
bs_1031022.config = {
  audioId1 = 103103,
  audioId2 = 103104,
  effectId_heal = 103104,
  effectId_trail = 103103,
  hurt_config = {hit_formula = 0, basehurt_formula = 3010},
  heal_config = {baseheal_formula = 3021}
}

function bs_1031022:ctor()
end

function bs_1031022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_1031022:PlaySkill(data)
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 1) then
    target = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    target = tempTarget.targetRole
  end
  self:CallCasterWait(15)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
  if target ~= nil then
    self.caster:LookAtTarget(target)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1.5, 1, attackTrigger)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  end
end

function bs_1031022:OnAttackTrigger(target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_trail, self, self.SkillEventFunc)
end

function bs_1031022:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local target_effect = LuaSkillCtrl:GetTargetWithGrid(target.targetRole.x, target.targetRole.y)
    local caster_effect = LuaSkillCtrl:GetTargetWithGrid(self.caster.x, self.caster.y)
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target.targetRole)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId2)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.arglist[1]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(caster_effect, self.config.effectId_heal, self, self.SkillEventFunc_heal)
    LuaSkillCtrl:CallEffect(target_effect, self.config.effectId_heal, self, self.SkillEventFunc_heal)
  end
end

function bs_1031022:SkillEventFunc_heal(effect, eventId, target)
  if eventId == eBattleEffectEvent.Create then
    local targetList = LuaSkillCtrl:FindAllRolesWithinRange(target, 1, true)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local role = targetList[i]
        if role.belongNum == self.caster.belongNum then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
          LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
            self.arglist[2]
          })
          skillResult:EndResult()
        end
      end
    end
  end
end

function bs_1031022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1031022
