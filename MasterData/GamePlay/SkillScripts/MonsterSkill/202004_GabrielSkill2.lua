local bs_202004 = class("bs_202004", LuaSkillBase)
local base = LuaSkillBase
bs_202004.config = {
  hurtConfig = {
    hit_formula = 0,
    def_formula = 0,
    basehurt_formula = 1047,
    crit_formula = 0,
    correct_formula = 0,
    minhurt_formula = 0
  },
  hurt_delay = 15,
  effectId = 10758
}

function bs_202004:ctor()
end

function bs_202004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_202004_1", 1, self.OnAfterBattleStart)
end

function bs_202004:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.caoTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], arriveCallBack, nil, -1, self.config.hurt_delay)
end

function bs_202004:OnArriveAction()
  if self.caoTimer ~= nil and self.caoTimer:IsOver() then
    self.caoTimer = nil
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, self.SkillEventFunc)
end

function bs_202004:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtConfig, nil, true)
    skillResult:EndResult()
  end
end

function bs_202004:OnCasterDie()
  base.OnCasterDie(self)
  if self.caoTimer ~= nil then
    self.caoTimer:Stop()
    self.caoTimer = nil
  end
end

return bs_202004
