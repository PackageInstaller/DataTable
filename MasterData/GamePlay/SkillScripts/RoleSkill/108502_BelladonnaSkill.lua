local bs_108502 = class("bs_108502", LuaSkillBase)
local base = LuaSkillBase
bs_108502.config = {
  heal_config = {baseheal_formula = 10087},
  heal_configF = {baseheal_formula = 10088},
  HurtConfigID = 13,
  effectId_trail = 108508,
  effectId_hit = 108509,
  selectId = 24,
  selectRange = 10,
  skill_time = 12,
  start_time = 6,
  actionId = 1002,
  act_speed = 1,
  time_heal = 3,
  buff_recover = 1088,
  buff_id2 = 108502
}

function bs_108502:ctor()
end

function bs_108502:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.targetTag = {}
end

function bs_108502:PlaySkill(data)
  self.targetList = {}
  self.healNum = 0
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 94, 20)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self.caster:LookAtTarget(targetList[0].targetRole)
  self:CallCasterWait(self.config.skill_time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, targetList[0].targetRole, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.act_speed, self.config.start_time, attackTrigger)
end

function bs_108502:OnAttackTrigger(target, data)
  self:RealPlaySkill(self.caster, target)
end

function bs_108502:RealPlaySkill(sender, target)
  if sender == self.caster then
    LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_trail, self, false, false, self.SkillEventFunc, sender)
  else
    LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId_trail, self, sender, false, false, self.SkillEventFunc, sender)
  end
end

function bs_108502:SkillEventFunc(sender, effect, eventId, target)
  if effect.dataId == self.config.effectId_trail and eventId == eBattleEffectEvent.Trigger then
    self:CallBack(target.targetRole, sender)
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buff_recover, self.arglist[3], 90)
    LuaSkillCtrl:CallEffect(target.targetRole, self.config.effectId_hit, self)
    table.insert(self.targetList, target.targetRole)
    local healTarget = self:CheckSkillTarget(target)
    if healTarget ~= nil then
      self:RealPlaySkill(target.targetRole, healTarget)
    else
      self.targetTag = {}
    end
  end
end

function bs_108502:CheckSkillTarget(overriderSender)
  local healList = LuaSkillCtrl:CallTargetSelect(self, 95, 20, overriderSender.targetRole)
  if healList ~= nil and healList.Count > 0 then
    for i = 0, healList.Count - 1 do
      local healTarget = healList[i].targetRole
      if not table.contain(self.targetList, healTarget) then
        return healTarget
      end
    end
  end
  return nil
end

function bs_108502:CallBack(targetRole, sender)
  local healCfg
  self.healNum = self.healNum + 1
  if self.healNum == 1 then
    healCfg = self.config.heal_config
  else
    healCfg = self.config.heal_configF
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HealResult(skillResult, healCfg)
  skillResult:EndResult()
  self:DoDamge(targetRole)
end

function bs_108502:DoDamge(healTarget)
  local targetList = LuaSkillCtrl:FindAllRolesWithinRange(healTarget, 1, false)
  if targetList ~= nil and targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      if targetList[i].belongNum == eBattleRoleBelong.enemy then
        LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnBelladonnaAddBuff, targetList[i], self.arglist[6])
      end
      if targetList[i].belongNum ~= eBattleRoleBelong.player then
        if self.targetTag[targetList[i]] ~= nil then
          self.targetTag[targetList[i]] = self.targetTag[targetList[i]] + 1
        else
          self.targetTag[targetList[i]] = 1
        end
        local multi = (self.targetTag[targetList[i]] - 1) * self.arglist[7]
        local damage = (targetList[i]:GetBuffTier(self.config.buff_id2) * self.arglist[5] + self.arglist[4]) * (multi + 1000) // 1000
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i])
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {damage})
        skillResult:EndResult()
      end
    end
  end
end

function bs_108502:LuaDispose()
  base.LuaDispose(self)
  if self.targetTag ~= nil then
    self.targetTag = nil
  end
end

function bs_108502:OnCasterDie()
  base.OnCasterDie(self)
  if self.targetTag ~= nil then
    self.targetTag = nil
  end
end

return bs_108502
