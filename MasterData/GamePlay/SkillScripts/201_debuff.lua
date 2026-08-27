local bs_201 = class("bs_201", LuaSkillBase)
local base = LuaSkillBase
bs_201.config = {
  effectIdAttack = 1027,
  buffId = 90,
  buffTier = 1,
  buffDuration = 45,
  hurt_config = {basehurt_formula = 2013}
}

function bs_201:ctor()
end

function bs_201:InitSkill(isMidwaySkill)
end

function bs_201:PlaySkill(data)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 21, 20)
  self:CallCasterLookAt(targetList)
  LuaSkillCtrl:CallEffect(targetList, self.config.effectIdAttack, self, self.SkillEventFunc)
  print("1")
end

function bs_201:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config)
    skillResult:EndResult()
  end
end

function bs_201:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_201
