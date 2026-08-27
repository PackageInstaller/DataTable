local bs_108902 = class("bs_108902", LuaSkillBase)
local base = LuaSkillBase
bs_108902.config = {
  effect_attack = 108906,
  effcet_hit = 108907,
  buffId_1 = 108902,
  buffId_2 = 108903,
  buffId_196 = 196,
  start_time = 1,
  start_time1 = 5,
  start_time2 = 5,
  start_time3 = 13,
  start_time4 = 4,
  HurtConfigId = 2
}

function bs_108902:ctor()
end

function bs_108902:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_108902:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local target = self.caster.recordTable.lastAttackRole
  if target == nil or target.hp <= 0 or target.belongNum == eBattleRoleBelong.neutral then
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    target = tempTarget.targetRole
  end
  if target ~= nil then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
    self.caster:LookAtTarget(target)
    local skill_time = self.config.start_time + self.config.start_time1 + self.config.start_time2 + self.config.start_time3 + self.config.start_time4
    self:CallCasterWait(skill_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, self.config.action_speed, self.config.start_time, attackTrigger)
    LuaSkillCtrl:CallEffect(target, self.config.effect_attack, self)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_196, 1, skill_time)
  end
end

function bs_108902:OnAttackTrigger(target, data)
  self.timeskill = LuaSkillCtrl:StartTimer(self, self.config.start_time1, function()
    LuaSkillCtrl:CallEffect(target, self.config.effcet_hit, self)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_1, 1, self.arglist[3])
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_2, 1, self.arglist[3])
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigId, {
      self.arglist[4]
    })
    skillResult:EndResult()
    LuaSkillCtrl:StartTimer(self, self.config.start_time2, function()
      LuaSkillCtrl:CallEffect(target, self.config.effcet_hit, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigId, {
        self.arglist[4]
      })
      skillResult:EndResult()
      LuaSkillCtrl:StartTimer(self, self.config.start_time3, function()
        LuaSkillCtrl:CallEffect(target, self.config.effcet_hit, self)
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigId, {
          self.arglist[4]
        })
        skillResult:EndResult()
        self:OnSkillDamageEnd()
        LuaSkillCtrl:StartTimer(self, self.config.start_time4, function()
          self:CancleCasterWait()
        end)
      end)
    end)
  end)
end

function bs_108902:LuaDispose()
  base.LuaDispose(self)
end

function bs_108902:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_108902
