local bs_17036 = class("bs_17036", LuaSkillBase)
local base = LuaSkillBase
bs_17036.config = {
  effectId = 60617,
  effectIdAttack = 60616,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0
  }
}

function bs_17036:ctor()
end

function bs_17036:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTrigger("bs_17036_3", 1, self.OnAfterPlaySkill, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self.typenum = 2
end

function bs_17036:OnAfterPlaySkill(battleSkill, role)
  if role == self.caster and battleSkill.isCommonAttack and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[2] then
    local targetL = self.caster.recordTable.lastAttackRole
    if targetL ~= nil then
      LuaSkillCtrl:CallEffect(targetL, self.config.effectIdAttack, self, self.SkillEventFunc)
    end
  end
end

function bs_17036:SkillEventFunc(effect, eventId, target)
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

function bs_17036:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17036
