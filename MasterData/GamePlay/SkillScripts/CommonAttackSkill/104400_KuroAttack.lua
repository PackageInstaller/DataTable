local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_104400 = class("bs_104400", bs_1)
local base = bs_1
bs_104400.config = {
  effectId_trail = 104401,
  effectId_trail_pass = 104403,
  configId_pass = 5,
  action1 = 1031,
  action2 = 1034,
  end_time_1 = 11,
  end_time_2 = 14,
  actionId_1_end = 1033,
  actionId_2_end = 1036,
  effectId_action_1 = 104416,
  effectId_action_2 = 104416,
  interval = 3,
  configId_weaponLv = 17,
  buff_blind = 3012
}
bs_104400.config = setmetatable(bs_104400.config, {
  __index = base.config
})

function bs_104400:ctor()
end

function bs_104400:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.roll_rate = self.caster.recordTable["self.roll"]
  self.caster.recordTable.weaponLv = 0
end

function bs_104400:ExecuteEffectAttack(data, atkActionId, target)
  if data.audioId4 ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, data.audioId4)
  end
  if data.effectId_trail_ex ~= nil then
    if atkActionId == data.action1 then
      LuaSkillCtrl:CallEffectWithArg(target, data.effectId_trail, self, nil, false, self.SkillEventFunc, data)
    else
      LuaSkillCtrl:CallEffectWithArg(target, data.effectId_trail_ex, self, nil, false, self.SkillEventFunc, data)
    end
  else
    LuaSkillCtrl:CallEffectWithArg(target, data.effectId_trail, self, nil, false, self.SkillEventFunc, data)
  end
  self.rollNum = 0
  self:Roll(target, atkActionId)
end

function bs_104400:Roll(target, atkActionId)
  if self.roll_rate ~= nil and LuaSkillCtrl:CallRange(1, 1000) <= self.roll_rate and target ~= nil and target.hp > 0 and self.rollNum < self.caster.recordTable["self.max"] then
    self.rollNum = self.rollNum + 1
    self:CallCasterWait(self.config.interval + 1)
    if self.again ~= nil then
      self.again:Stop()
      self.again = nil
    end
    self.again = LuaSkillCtrl:StartTimer(self, self.config.interval, function()
      self:Open(target, atkActionId)
    end, self)
  else
    self:OnOver(atkActionId)
  end
end

function bs_104400:Open(target, atkActionId)
  if target ~= nil and target.hp >= 0 then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_action_1, self)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_trail_pass, self, self.SkillEventFunc_pass)
    self:Roll(target, atkActionId)
  else
    self:OnOver(atkActionId)
  end
end

function bs_104400:SkillEventFunc_pass(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    local dam, dam_config
    if self.caster.recordTable.weaponLv >= 3 then
      dam = self.caster.recordTable["self.number"] + self.caster.recordTable.dam_bullet
    else
      dam = self.caster.recordTable["self.number"]
    end
    if self.caster.recordTable.weaponLv >= 2 and self.rollNum >= self.caster.recordTable.blind_triNum then
      LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buff_blind, 1, self.caster.recordTable.blind_time)
    end
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId_pass, {dam}, nil, nil, nil, 104)
    skillResult:EndResult()
  end
end

function bs_104400:OnOver(atkActionId)
  if atkActionId == self.config.action1 then
    self:CallCasterWait(self.config.end_time_1)
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_1_end)
  else
    self:CallCasterWait(self.config.end_time_2)
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_2_end)
  end
end

function bs_104400:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104400
