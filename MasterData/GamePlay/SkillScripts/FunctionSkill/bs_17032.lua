local bs_17032 = class("bs_17032", LuaSkillBase)
local base = LuaSkillBase
bs_17032.config = {
  effectId = 60615,
  effectIdAttack = 60614,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0
  }
}

function bs_17032:ctor()
end

function bs_17032:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTrigger("bs_17032_1", 1, self.OnAfterPlaySkill, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self.typenum = 1
end

function bs_17032:OnAfterPlaySkill(battleSkill, role)
  if role == self.caster and battleSkill.isCommonAttack and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[2] then
    local targetL = self.caster.recordTable.lastAttackRole
    if targetL ~= nil then
      LuaSkillCtrl:CallEffect(targetL, self.config.effectIdAttack, self, self.SkillEventFunc)
      LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.Callthrows, target, self.typenum, self.arglist[1])
    end
  end
end

function bs_17032:SkillEventFunc(effect, eventId, target)
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

function bs_17032:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17032
