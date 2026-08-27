local bs_103002 = class("bs_103002", LuaSkillBase)
local base = LuaSkillBase
bs_103002.config = {
  buffId_def = 103001,
  effectId_start = 103006,
  effectId_open = 103005,
  effectId_trail = 103007,
  actionId = 1002,
  skill_time = 29,
  start_time = 7,
  skill_speed = 1,
  selectId_skill = 6
}

function bs_103002:ctor()
end

function bs_103002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_103002:PlaySkill(data)
  local role = self.caster.recordTable.pass_target
  if role == nil or role.hp <= 0 then
    return
  end
  if LuaSkillCtrl.IsInTDBattle and role.x == ConfigData.buildinConfig.BenchX then
    self.caster.recordTable.pass_target = nil
    return
  end
  local skilltime = self.config.skill_time * 100 // (self.config.skill_speed * 100)
  local starttime = self.config.start_time * 100 // (self.config.skill_speed * 100)
  self:CallCasterWait(skilltime)
  local triggerCallBack = BindCallback(self, self.OnActionCallBack, role)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.skill_speed, starttime, triggerCallBack)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self, nil, nil, nil, true)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_open, self)
end

function bs_103002:OnActionCallBack(role)
  LuaSkillCtrl:CallEffect(role, self.config.effectId_trail, self, self.OnEffectTrigger)
end

function bs_103002:OnEffectTrigger(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger and target ~= nil and target.targetRole.hp > 0 then
    LuaSkillCtrl:StartTimer(nil, 9, function()
      LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId_def, 1, self.arglist[3])
      local shieldValue = self.caster.skill_intensity * self.arglist[1] // 1000
      LuaSkillCtrl:AddRoleShield(target.targetRole, eShieldType.Normal, shieldValue)
    end)
  end
end

function bs_103002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103002
