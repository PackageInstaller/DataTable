local bs_107802 = class("bs_107802", LuaSkillBase)
local base = LuaSkillBase
bs_107802.config = {
  actionId = 1002,
  actionId_start_time = 5,
  action_speed = 1,
  skill_time = 15,
  effectId_1 = 107805,
  buffid_counter = 107801,
  hurt_config = 48
}

function bs_107802:ctor()
end

function bs_107802:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnKurisuSummonerSkill, self.OnKurisuSummonerSkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnKurisuSummonerHurt, self.OnKurisuSummonerHurt)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_107802_1", 1, self.OnRoleDie)
  self.hurtArgs = {}
end

function bs_107802:PlaySkill(data)
  local time = self.config.skill_time
  self:CallCasterWait(time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
end

function bs_107802:OnAttackTrigger(data)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_1, self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffid_counter, self.arglist[1], nil, false)
end

function bs_107802:OnKurisuSummonerSkill(luaSkill, type, skillTag)
  if skillTag == eSkillTag.normalSkill then
    if type == 0 then
      LuaSkillCtrl:CallBeforSkillPlayTrigger(self, self.caster)
    elseif type == 1 then
      LuaSkillCtrl:CallAfterSkillPlayTrigger(self, self.caster)
    end
  end
end

function bs_107802:OnKurisuSummonerHurt(target, skillTag, TargetNum)
  if skillTag == eSkillTag.normalSkill then
    if target ~= nil then
      local damageRatio = (TargetNum - 1) * self.arglist[3] + self.arglist[2]
      if damageRatio >= self.arglist[4] + self.arglist[2] then
        damageRatio = self.arglist[4] + self.arglist[2]
      end
      self.target_skill = target
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      local args = LuaSkillCtrl:CreatCacheTable(damageRatio, self.hurtArgs)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurt_config, args)
      skillResult:EndResult()
      if target.hp ~= 0 then
        self.target_skill = nil
      end
    else
      self:OnSkillDamageEnd()
    end
  end
end

function bs_107802:OnRoleDie(killer, role)
  if role == self.target_skill and role.hp <= 0 and role ~= nil then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffid_counter, self.arglist[5], nil, false)
  end
end

function bs_107802:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_107802:LuaDispose()
  base.LuaDispose(self)
  self.target_skill = nil
end

return bs_107802
