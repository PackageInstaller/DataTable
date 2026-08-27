local bs_200401 = class("bs_200401", LuaSkillBase)
local base = LuaSkillBase
bs_200401.config = {
  normalAttackId = 504,
  hurt_config1 = {basehurt_formula = 10019, hit_formula = 10201},
  hurt_config2 = {basehurt_formula = 10025, hit_formula = 10201},
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  effectId = 10099,
  buffId_66 = 66,
  buffTier = 1,
  buffDuration = 30,
  startAnimID = 1004,
  audioId1 = 25,
  skill_time = 28,
  skill_speed = 1,
  start_time = 16
}

function bs_200401:ctor()
end

function bs_200401:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforePlaySkill, "bs_200401_1", 1, self.OnBeforePlaySkill)
end

function bs_200401:OnBeforePlaySkill(role, context)
  if context.skill.maker == self.caster and context.skill.dataId == self.config.normalAttackId and LuaSkillCtrl:CallRange(1, 100) <= self.arglist[1] then
    local targetRole = self.caster.recordTable.lastAttackRole
    if targetRole == nil then
      local moveTarget = LuaSkillCtrl:GetRoleComAtkSkillMoveSelectTarget(self.caster)
      if moveTarget ~= nil then
        local curAtkRole = moveTarget.targetRole
        if curAtkRole ~= nil then
          if self.lastAttackRole ~= curAtkRole then
            self.displaySelectEfc = true
          end
          self.lastAttackRole = curAtkRole
        end
      end
      if moveTarget ~= nil then
        targetRole = moveTarget.targetRole
      else
        return
      end
    end
    if LuaSkillCtrl:IsAbleAttackTarget(self.caster, targetRole, 1) then
      context.active = false
      self.caster:LookAtTarget(targetRole)
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, targetRole)
      self:CallCasterWait(self.config.skill_time)
      LuaSkillCtrl:CallEffect(targetRole, self.config.effectId, self)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.startAnimID, self.config.skill_speed, self.config.start_time, attackTrigger)
      LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
    end
  end
end

function bs_200401:OnAttackTrigger(target)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:PlayAuHit(self, target)
  if target.hp > 0 then
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config2)
  end
  skillResult:EndResult()
  local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
  if target.hp > 0 then
    LuaSkillCtrl:HurtResult(self, skillResult1, self.config.hurt_config1)
  end
  skillResult1:EndResult()
end

function bs_200401:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_200401:LuaDispose()
  base.LuaDispose(self)
  self.lastAttackRole = nil
end

return bs_200401
