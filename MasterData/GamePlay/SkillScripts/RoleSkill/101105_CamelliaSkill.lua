local bs_101105 = class("bs_101105", LuaSkillBase)
local base = LuaSkillBase
bs_101105.config = {
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    returndamage_formula = 0
  },
  heal_config = {baseheal_formula = 501, correct_formula = 9990},
  effectId_skill = 101114,
  effectId_Hit = 101106,
  effectId_heal = 101108,
  buffId_211 = 101102,
  buff_lockBlue = 3008,
  actionId = 1002,
  skill_time = 51,
  start_time = 25,
  action_speed = 1
}

function bs_101105:ctor()
end

function bs_101105:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101105:PlaySkill(data)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_lockBlue, 1, self.config.start_time + self.arglist[1], true)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
end

function bs_101105:OnAttackTrigger(data)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1])
  if self.effect_loop ~= nil then
    self.effect_loop:Die()
    self.effect_loop = nil
  end
  local time = 0
  self.effect_loop = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_heal, self)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_skill, self)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 1)
  if 0 < targetList.Count then
    for i = 0, targetList.Count - 1 do
      local target = targetList[i].targetRole
      if target ~= nil and target.belongNum == eBattleRoleBelong.enemy then
        LuaSkillCtrl:CallBuff(self, target, self.config.buffId_211, 1, self.arglist[1])
        time = time + 1
        if target:GetBuffTier(self.config.buffId_211) == 0 then
          time = time + 1
        end
      end
    end
    if self.hurt ~= nil then
      self.hurt:Stop()
      self.hurt = nil
    end
    self.hurt = LuaSkillCtrl:StartTimer(nil, self.arglist[5], function()
      local list = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
      for i = 0, list.Count - 1 do
        local tar = list[i].targetRole
        if tar ~= nil and 0 < tar:GetBuffTier(self.config.buffId_211) then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, tar)
          LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
            self.arglist[2]
          })
          skillResult:EndResult()
          LuaSkillCtrl:CallEffect(tar, self.config.effectId_Hit, self)
        end
      end
      local heal = self.caster.maxHp * (self.arglist[4] + self.arglist[6]) // 1000 * time
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
      LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {heal}, true, false)
      skillResult:EndResult()
    end, self, -1)
    LuaSkillCtrl:StartTimer(nil, self.arglist[1] + 1, function()
      if self.hurt ~= nil then
        self.hurt:Stop()
        self.hurt = nil
      end
      if self.effect_loop ~= nil then
        self.effect_loop:Die()
        self.effect_loop = nil
      end
      self:OnSkillDamageEnd()
    end)
  end
end

function bs_101105:OnBreakSkill(role)
  if role == self.caster and self.isSkillUncompleted == true then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_lockBlue, 0, true)
  end
  base.OnBreakSkill(self, role)
end

function bs_101105:OnCasterDie()
  base.OnCasterDie(self)
  if self.hurt ~= nil then
    self.hurt:Stop()
    self.hurt = nil
  end
  if self.effect_loop ~= nil then
    self.effect_loop:Die()
    self.effect_loop = nil
  end
end

function bs_101105:LuaDispose()
  base.LuaDispose(self)
  if self.hurt ~= nil then
    self.hurt:Stop()
    self.hurt = nil
  end
  self.effect_loop = nil
end

return bs_101105
