local bs_17041 = class("bs_17041", LuaSkillBase)
local base = LuaSkillBase
bs_17041.config = {
  effectId = 60613,
  effectIdAttack = 60612,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0
  }
}

function bs_17041:ctor()
end

function bs_17041:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.PickUpCoins, self.OnPickUpCoins)
  self.typenum = 3
end

function bs_17041:OnPickUpCoins()
  local targetL = LuaSkillCtrl:CallTargetSelect(self, 1)
  if targetL ~= nil and targetL.Count > 0 then
    local target = targetL[0]
    LuaSkillCtrl:CallEffect(target, self.config.effectIdAttack, self, self.SkillEventFunc)
  end
end

function bs_17041:SkillEventFunc(effect, eventId, target)
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

function bs_17041:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17041
