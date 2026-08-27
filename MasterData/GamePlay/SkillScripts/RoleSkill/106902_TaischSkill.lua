local bs_106902 = class("bs_106902", LuaSkillBase)
local base = LuaSkillBase
bs_106902.config = {
  actionId = 1002,
  actionId_start_time = 5,
  action_speed = 1,
  skill_time = 60,
  effectId = 106903,
  effect_Ro = 106904,
  buffId_1 = 106901,
  buffId_2 = 106902
}

function bs_106902:ctor()
end

function bs_106902:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_106902_1", 1, self.OnAfterBattleStart)
  self:AddAfterPlaySkillTrigger("bs_106902_2", 1, self.OnAfterPlaySkill, nil, nil, self.caster.belongNum, nil, nil, nil, nil, eSkillTag.ultSkill)
  self.mark_num = 0
  self.effect1 = nil
end

function bs_106902:PlaySkill(data)
  local time = self.config.skill_time
  self:CallCasterWait(time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
end

function bs_106902:OnAfterBattleStart()
  LuaSkillCtrl:CallAddPlayerHmp(self.arglist[1] * 50)
  self.effect1 = LuaSkillCtrl:CallEffect(self.caster, self.config.effect_Ro, self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1, 2, nil, true)
  self.mark_num = self.mark_num + 2
end

function bs_106902:OnAttackTrigger(data)
  LuaSkillCtrl:CallAddPlayerHmp(self.arglist[2] * 50)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1, 1, nil, true)
  if self.mark_num <= 0 then
    self.effect1 = LuaSkillCtrl:CallEffect(self.caster, self.config.effect_Ro, self)
  end
  self.mark_num = self.mark_num + 1
end

function bs_106902:OnAfterPlaySkill(skill, role)
  if role ~= self.caster and role.roleType == 1 and skill.isUltSkill and self.mark_num > 0 then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId_2, 1, self.arglist[3], true)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_1, 1)
    self.mark_num = self.mark_num - 1
    if self.mark_num <= 0 and self.effect1 ~= nil then
      self.effect1:Die()
      self.effect1 = nil
    end
  end
end

function bs_106902:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect1 ~= nil then
    self.effect1:Die()
    self.effect1 = nil
  end
end

function bs_106902:LuaDispose()
  base.LuaDispose(self)
  self.effect1 = nil
end

return bs_106902
