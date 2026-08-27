local bs_214301 = class("bs_214301", LuaSkillBase)
local base = LuaSkillBase
bs_214301.config = {
  target_select_id = 69,
  buffId = 1059,
  time_duration = 75,
  undead = 3009,
  effect = 12201
}

function bs_214301:ctor()
end

function bs_214301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.target = self:FindMaxHp()
  self.effect = nil
  self:AddOnRoleDieTrigger("bs_214301_1", 1, self.OnRoleDie, nil, self.target)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_214301_2", 1, self.BeforeEndBattle)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.undead, 1, nil, true, nil, true)
  local timer_callback = BindCallback(self, self.EventFunction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], timer_callback, nil, -1)
  LuaSkillCtrl:StartTimer(nil, 7, function()
    self.effect = LuaSkillCtrl:CallEffect(self.target, self.config.effect, self)
    if self.caster.recordTable.bs_214302 ~= nil and self.caster.recordTable.bs_214302 == true then
      self:ActiveConnect()
    end
  end)
end

function bs_214301:BeforeEndBattle()
  LuaSkillCtrl:DispelBuff(self.caster, 88, 1, true, true)
  LuaSkillCtrl:RemoveLife(self.caster.maxHp + 1, self, self.caster, true, nil, false, true)
end

function bs_214301:EventFunction()
  LuaSkillCtrl:CallBuff(self, self.target, self.config.buffId, 1, self.config.time_duration, false, nil, false)
end

function bs_214301:FindMaxHp()
  local list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  local max_target = list[0]
  for i = 0, list.Count - 1 do
    if max_target.maxHp < list[i].maxHp then
      max_target = list[i]
    end
  end
  return max_target
end

function bs_214301:OnTargetDie()
  self:RemoveSkillTrigger(eSkillTriggerType.AfterHurt)
  self.target = nil
  LuaSkillCtrl:DispelBuff(self.caster, self.config.undead, 1, true, false)
  LuaSkillCtrl:RemoveLife(99999, self, self.caster, true, nil, false, true, eHurtType.RealDmg, true)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_214301:OnRoleDie(killer, role)
  if role == self.target then
    self:OnTargetDie()
  end
end

function bs_214301:ActiveConnect()
  if self.target == nil then
    return
  end
  self:AddSetHurtTrigger("bs_214301_2", 1, self.OnSetHurt, nil, self.caster)
end

function bs_214301:OnSetHurt(context)
  LuaSkillCtrl:RemoveLife(context.hurt, self, self.target, true, nil, true, true, eHurtType.RealDamge, false)
end

function bs_214301:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_214301:LuaDispose()
  base.LuaDispose(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

return bs_214301
