local bs_17042 = class("bs_17042", LuaSkillBase)
local base = LuaSkillBase
bs_17042.config = {
  effectId = 60613,
  effectIdAttack = 60612,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0
  }
}

function bs_17042:ctor()
end

function bs_17042:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17042_3", 1, self.OnAfterBattleStart)
  self.typenum = 3
end

function bs_17042:OnAfterBattleStart()
  self.damTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[3], self.CallBack, self, -1)
end

function bs_17042:CallBack()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  local targetL = LuaSkillCtrl:CallTargetSelect(self, 1)
  if targetL ~= nil and targetL.Count > 0 then
    for i = 0, self.arglist[2] - 1 do
      local target = targetL[0]
      LuaSkillCtrl:CallEffect(target, self.config.effectIdAttack, self, self.SkillEventFunc)
    end
  end
end

function bs_17042:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    local tar = target.targetRole
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.Callthrows, tar, self.typenum, self.arglist[1], true)
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self, nil)
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

function bs_17042:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

return bs_17042
