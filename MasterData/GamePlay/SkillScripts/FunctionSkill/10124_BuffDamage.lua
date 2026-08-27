local bs_10124 = class("bs_10124", LuaSkillBase)
local base = LuaSkillBase
bs_10124.config = {
  hurt_config = {
    hit_formula = 0,
    def_formula = 9996,
    basehurt_formula = 10076,
    minhurt_formula = 9994,
    crit_formula = 0,
    crithur_ratio = 9995,
    correct_formula = 9989
  },
  effectId = 1002
}

function bs_10124:ctor()
end

function bs_10124:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_10124_1", 1, self.OnAfterAddBuff, self.caster, nil, nil, nil, nil, eBuffType.Debeneficial)
end

function bs_10124:OnAfterAddBuff(buff, target, isOverlay)
  if buff.buffType == 2 and buff.maker == self.caster then
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self, self.SkillEventFunc)
    self:PlayChipEffect()
  end
end

function bs_10124:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_10124:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10124
