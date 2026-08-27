local bs_103502 = class("bs_103502", LuaSkillBase)
local base = LuaSkillBase
bs_103502.config = {
  selectId = 6,
  buffId_resist = 148,
  buffId_253 = 253,
  effectId_skill = 10198,
  actionId = 1002,
  audioId1 = 70,
  skill_time = 36,
  HealConfig = {baseheal_formula = 10088},
  HealConfig2 = {baseheal_formula = 10048},
  audioId2 = 71
}

function bs_103502:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BuffDie, "bs_103502_buffDie", 1, self.OnBuffDie)
end

function bs_103502:PlaySkill(data)
  self.__checkBuffAlive = true
  self:CallCasterWait(self.config.skill_time)
  local targets = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, 20)
  if targets.Count > 0 then
    local skillActionTrigger = BindCallback(self, self.ActionCallBack, targets)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, 2, 12, skillActionTrigger)
  end
end

function bs_103502:ActionCallBack(targets)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_skill, self)
  for i = 0, targets.Count - 1 do
    local target_now = targets[i].targetRole
    local time = self.arglist[1] * 2
    LuaSkillCtrl:CallBuff(self, target_now, self.config.buffId_resist, 1, time)
    LuaSkillCtrl:CallBuff(self, target_now, self.config.buffId_253, 1, self.arglist[1], true)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target_now)
    LuaSkillCtrl:HealResult(skillResult, self.config.HealConfig)
    skillResult:EndResult()
  end
  self.__checkBuffAlive = false
  LuaSkillCtrl:StartTimer(nil, self.arglist[1] + 15, BindCallback(self, self.CheckCasterAliveAndRemoveTrigger))
end

function bs_103502:CheckCasterAliveAndRemoveTrigger()
  self.__checkBuffAlive = true
  if self.caster ~= nil and self.caster.hp > 0 then
    return
  end
  base.OnCasterDie(self)
end

function bs_103502:OnBuffDie(buff, target, removeType)
  LuaSkillCtrl:PlayAuSource(target, self.config.audioId2)
  if (removeType == eBuffRemoveType.Timeout or removeType == eBuffRemoveType.Conflict) and buff.dataId == self.config.buffId_253 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HealResult(skillResult, self.config.HealConfig2)
    skillResult:EndResult()
  end
end

function bs_103502:OnCasterDie()
  if self.__checkBuffAlive then
    base.OnCasterDie(self)
  end
end

return bs_103502
