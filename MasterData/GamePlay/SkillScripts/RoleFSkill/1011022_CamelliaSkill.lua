local bs_1011022 = class("bs_1011022", LuaSkillBase)
local base = LuaSkillBase
bs_1011022.config = {
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    returndamage_formula = 0
  },
  heal_config = {baseheal_formula = 501, correct_formula = 9990},
  effectId_skill = 101104,
  effectId_Hit = 101106,
  effectId_heal = 101108,
  buffId_211 = 101102,
  buff_lockBlue = 3008,
  actionId = 1002,
  skill_time = 51,
  start_time = 25,
  action_speed = 1
}

function bs_1011022:ctor()
end

function bs_1011022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_1011022_3", 1, self.BeforeEndBattle)
end

function bs_1011022:PlaySkill(data)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_lockBlue, 1, self.config.start_time + self.arglist[1], true)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
end

function bs_1011022:OnAttackTrigger(data)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1])
  local effect_loop = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_heal, self)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_skill, self)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
  if 0 < targetList.Count then
    for i = 0, targetList.Count - 1 do
      local target = targetList[i].targetRole
      if target ~= nil then
        LuaSkillCtrl:CallBuff(self, target, self.config.buffId_211, 1, self.arglist[1])
      end
    end
    local hurt = LuaSkillCtrl:StartTimer(nil, self.arglist[5], function()
      local list = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
      local time = 0
      for i = 0, list.Count - 1 do
        local tar = list[i].targetRole
        if tar ~= nil and 0 < tar:GetBuffTier(self.config.buffId_211) then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, tar)
          LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
            self.arglist[2]
          })
          skillResult:EndResult()
          LuaSkillCtrl:CallEffect(tar, self.config.effectId_Hit, self)
          time = time + 1
        end
      end
      local heal = self.caster.maxHp * self.arglist[4] // 1000 * time
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
      LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {heal}, true, false)
      skillResult:EndResult()
    end, self, -1)
    LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
      if hurt ~= nil then
        hurt:Stop()
        hurt = nil
      end
      if effect_loop ~= nil then
        effect_loop:Die()
        effect_loop = nil
      end
      if self.loopaudio ~= nil then
        LuaSkillCtrl:StopAudioByBack(self.loopaudio)
        self.loopaudio = nil
      end
    end)
  end
end

function bs_1011022:BeforeEndBattle()
  if self.loopaudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopaudio)
    self.loopaudio = nil
  end
end

function bs_1011022:OnBreakSkill(role)
  if role == self.caster and self.isSkillUncompleted == true then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_lockBlue, 0, true)
  end
  base.OnBreakSkill(self, role)
end

function bs_1011022:OnCasterDie()
  base.OnCasterDie(self)
  if self.loopaudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopaudio)
    self.loopaudio = nil
  end
end

return bs_1011022
