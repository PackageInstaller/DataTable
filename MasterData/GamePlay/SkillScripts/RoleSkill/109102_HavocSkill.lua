local bs_109102 = class("bs_109102", LuaSkillBase)
local base = LuaSkillBase
bs_109102.config = {
  buff_stun = 109102,
  buff_1 = 109103,
  buff_2 = 109104,
  buff_3 = 109105,
  HurtConfigId = 25,
  effect_cast = 109106,
  effcet_hit1 = 109107,
  effcet_hit2 = 109108,
  skill_time = 30,
  actionId_start = 1008,
  actionId_end = 1009,
  action_speed = 1,
  start_time = 2,
  start_time1 = 3,
  start_time2 = 6,
  start_time3 = 10
}

function bs_109102:ctor()
end

function bs_109102:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_109102:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local target = self.caster.recordTable.lastAttackRole
  if target == nil or target.hp <= 0 or target.belongNum == eBattleRoleBelong.neutral then
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    target = tempTarget.targetRole
  end
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
  self.caster:LookAtTarget(target)
  local skilltime = self.config.skill_time
  self:CallCasterWait(skilltime)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, self.config.action_speed, self.config.start_time, attackTrigger)
end

function bs_109102:OnAttackTrigger(target)
  local energyNum = self.caster.recordTable.press_energy // 2
  local totalDmg = (energyNum * self.arglist[5] + 1000) * self.arglist[1] // 1000
  self.caster.recordTable.press_energy = self.caster.recordTable.press_energy - energyNum
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_3, energyNum, true)
  LuaSkillCtrl:CallEffect(target, self.config.effect_cast, self)
  self.timeskill = LuaSkillCtrl:StartTimer(self, self.config.start_time1, function()
    LuaSkillCtrl:CallEffect(target, self.config.effcet_hit1, self)
    LuaSkillCtrl:CallBuff(self, target, self.config.buff_stun, 1, self.arglist[2])
    LuaSkillCtrl:CallBuff(self, target, self.config.buff_1, 1, self.arglist[4])
    LuaSkillCtrl:CallBuff(self, target, self.config.buff_2, energyNum, self.arglist[4])
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigId, {totalDmg})
    skillResult:EndResult()
    LuaSkillCtrl:StartTimer(self, self.config.start_time2, function()
      LuaSkillCtrl:CallEffect(target, self.config.effcet_hit2, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigId, {totalDmg})
      skillResult:EndResult()
      LuaSkillCtrl:StartTimer(self, self.config.start_time3, function()
        self:CancleCasterWait()
      end)
    end)
  end)
end

function bs_109102:LuaDispose()
  base.LuaDispose(self)
  if self.timeskill ~= nil then
    self.timeskill:Stop()
    self.timeskill = nil
  end
end

function bs_109102:OnCasterDie()
  base.OnCasterDie(self)
  if self.timeskill ~= nil then
    self.timeskill:Stop()
    self.timeskill = nil
  end
end

return bs_109102
