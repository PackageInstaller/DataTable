local bs_10135 = class("bs_10135", LuaSkillBase)
local base = LuaSkillBase
bs_10135.config = {
  heal_config = {
    baseheal_formula = 10076,
    heal_number = 0,
    correct_formula = 9990
  },
  effectId = 10092
}

function bs_10135:ctor()
end

function bs_10135:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_10135_7", 1, self.OnAfterAddBuff, self.caster)
end

function bs_10135:OnAfterAddBuff(buff, target, isOverlay)
  if buff.buffType ~= 0 and buff.maker == self.caster and self:IsReadyToTake() then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 14, 10)
    if targetlist.Count < 1 then
      return
    end
    LuaSkillCtrl:CallEffect(targetlist[0].targetRole, self.config.effectId, self, self.SkillEventFunc)
    self:PlayChipEffect()
    self:OnSkillTake()
  end
end

function bs_10135:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, self.config.aoe_config)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_10135:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10135
