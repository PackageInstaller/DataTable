local bs_17037 = class("bs_17037", LuaSkillBase)
local base = LuaSkillBase
bs_17037.config = {
  effectId = 60617,
  effectIdAttack = 60616,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0
  }
}

function bs_17037:ctor()
end

function bs_17037:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17037_1", 1, self.OnAfterBattleStart)
  self.typenum = 2
end

function bs_17037:OnAfterBattleStart()
  self.damTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[3], self.CallBack, self, -1)
end

function bs_17037:CallBack()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  local roleslist = LuaSkillCtrl:CallTargetSelect(self, 1002, 10)
  if roleslist.Count > self.arglist[2] then
    for i = 0, self.arglist[2] - 1 do
      LuaSkillCtrl:CallEffect(roleslist[i], self.config.effectIdAttack, self, self.SkillEventFunc)
    end
  end
  if roleslist.Count <= self.arglist[2] then
    for i = 0, roleslist.Count - 1 do
      LuaSkillCtrl:CallEffect(roleslist[i], self.config.effectIdAttack, self, self.SkillEventFunc)
    end
  end
end

function bs_17037:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self, nil)
    local tar = target.targetRole
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.Callthrows, tar, self.typenum, self.arglist[1], true)
    if self.caster.recordTable["25211_Flag"] == true then
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
        self.caster.recordTable["25211_arg"] + self.arglist[1]
      }, true)
    else
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
        self.arglist[1]
      }, true)
    end
    skillResult:EndResult()
  end
end

function bs_17037:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

return bs_17037
