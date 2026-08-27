local bs_200 = class("bs_200", LuaSkillBase)
local base = LuaSkillBase
bs_200.config = {
  hurt_config = {basehurt_formula = 2012},
  effectIdAttack = 6
}

function bs_200:ctor()
end

function bs_200:InitSkill(isMidwaySkill)
end

function bs_200:PlaySkill(data)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 21, 20)
  self:CallCasterLookAt(targetList)
  LuaSkillCtrl:CallEffect(targetList, self.config.effectIdAttack, self, self.SkillEventFunc)
end

function bs_200:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config)
    skillResult:EndResult()
  end
end

function bs_200:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_200
