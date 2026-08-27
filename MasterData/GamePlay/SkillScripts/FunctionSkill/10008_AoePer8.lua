local bs_10008 = class("bs_10008", LuaSkillBase)
local base = LuaSkillBase
bs_10008.config = {
  hurt_config = {basehurt_formula = 10007},
  effectIdAttack = 1006
}

function bs_10008:ctor()
end

function bs_10008:InitSkill(isMidwaySkill)
end

function bs_10008:PlaySkill()
  self:PlayChipEffect()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  self:CallCasterLookAt(targetList)
  LuaSkillCtrl:CallEffect(targetList, self.config.effectIdAttack, self, self.SkillEventFunc)
end

function bs_10008:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_10008:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10008
