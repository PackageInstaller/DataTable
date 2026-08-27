local bs_208002 = class("bs_208002", LuaSkillBase)
local base = LuaSkillBase
bs_208002.config = {
  buffId_skill1 = 208002,
  buffId_speed = 208003,
  actionId = 1002,
  action_speed = 1,
  skill_time = 30,
  start_time = 15
}

function bs_208002:ctor()
end

function bs_208002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnSixAttack, self.OnSixAttack)
end

function bs_208002:PlaySkill(data)
  self:CallCasterWait(self.config.skill_time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, self.arglist[1] + self.config.skill_time)
  self:AbandonSkillCdAutoReset(true)
end

function bs_208002:OnAttackTrigger(data)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1] + 2)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_skill1, 1, self.arglist[1])
  LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
    if self.caster ~= nil and self.caster.hp > 0 then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_speed, 0)
      LuaSkillCtrl:DispelBuff(self.caster, 170, 0)
    end
    self:EndSkillAndCallNext()
  end)
end

function bs_208002:EndSkillAndCallNext()
  if self.caster == nil then
    return
  end
  self:CancleCasterWait()
  local skillMgr = self.caster:GetSkillComponent()
  if skillMgr == nil then
    return
  end
  skillMgr.lastSkill = self.cskill
  self:CallNextBossSkill()
  LuaSkillCtrl:StopShowSkillDurationTime(self)
end

function bs_208002:OnSixAttack(target, sender, skill)
  if sender:GetBuffTier(self.config.buffId_skill1) > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_speed, 1)
    local grid = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
    if grid ~= nil then
      LuaSkillCtrl:MoveRoleToTarget(self, grid, self.caster, false, self.OnArrive)
    end
  end
end

function bs_208002:OnCasterDie()
  LuaSkillCtrl:StopShowSkillDurationTime(self)
  base.OnCasterDie(self)
end

return bs_208002
