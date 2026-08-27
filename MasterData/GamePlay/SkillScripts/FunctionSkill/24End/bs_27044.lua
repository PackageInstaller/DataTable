local bs_27044 = class("bs_27044", LuaSkillBase)
local base = LuaSkillBase
bs_27044.config = {buff = 2304, effect = 12056}

function bs_27044:ctor()
end

function bs_27044:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_27044", 1, self.OnAfterBattleStart)
end

function bs_27044:OnAfterBattleStart()
  self.tier = self.caster.maxHp // self.arglist[1]
  local cb = BindCallback(self, self.BuffEvent)
  local rand = LuaSkillCtrl:CallRange(0, 15)
  if self.tier > 0 then
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[2] + rand, cb, nil, -1)
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff, self.tier, self.arglist[2])
end

function bs_27044:BuffEvent()
  local eList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if eList == nil or eList.Count < 1 then
    return
  end
  local rand = LuaSkillCtrl:CallRange(0, eList.Count - 1)
  local randomTargetRole = eList[rand]
  if self.tier > 3 then
    self.tier = 2
  end
  if 1 > self.tier and self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  local effect = LuaSkillCtrl:CallEffect(randomTargetRole, self.config.effect, self, self.SkillEventFunc)
  for i = 0, self.tier - 1 do
    LuaSkillCtrl:CallEffect(randomTargetRole, self.config.effect, self)
  end
end

function bs_27044:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, 14, {
      self.arglist[3] * self.tier
    }, true, true)
    skillResult:EndResult()
  end
end

function bs_27044:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_27044:OnDispose()
  base.OnDispose(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_27044
