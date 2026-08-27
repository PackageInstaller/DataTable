local bs_10007 = class("bs_10007", LuaSkillBase)
local base = LuaSkillBase
bs_10007.config = {
  hurt_config = {basehurt_formula = 10007},
  effectIdAttack = 1006
}

function bs_10007:ctor()
end

function bs_10007:InitSkill(isMidwaySkill)
end

function bs_10007:PlaySkill()
  self:PlayChipEffect()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
  self:CallCasterLookAt(targetList)
  LuaSkillCtrl:CallEffect(targetList, self.config.effectIdAttack, self, self.SkillEventFunc)
end

function bs_10007:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_10007:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10007
