local bs_15105 = class("bs_15105", LuaSkillBase)
local base = LuaSkillBase
bs_15105.config = {
  buffId = 2071,
  effectId1 = 12058,
  effectId2 = 12060
}

function bs_15105:ctor()
end

function bs_15105:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15105_4", 1, self.OnAfterBattleStart)
  self.timer = nil
  self.effect = nil
end

function bs_15105:OnAfterBattleStart()
  if self.caster.belongNum ~= eBattleRoleBelong.enemy then
    return
  end
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId2, self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], self.CallBack, self, -1, self.arglist[2])
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil)
end

function bs_15105:CallBack()
  local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult1, 4, {
    self.arglist[3]
  }, true, true)
  skillResult1:EndResult()
  local skillResult2 = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult2, 5, {
    self.arglist[4]
  }, true, true)
  skillResult2:EndResult()
end

function bs_15105:OnCasterDie()
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

return bs_15105
