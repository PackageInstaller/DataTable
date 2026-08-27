local bs_15097 = class("bs_15097", LuaSkillBase)
local base = LuaSkillBase
bs_15097.config = {effectId = 12056, fenEnBuff = 101901}

function bs_15097:ctor()
end

function bs_15097:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("bs_15097_3", 2, self.OnBeforeAddBuff, self.caster, nil, nil, eBattleRoleBelong.enemy, 101901)
  self:AddAfterAddBuffTrigger("bs_15097_2", 1, self.OnAfterAddBuff, self.caster, nil, nil, eBattleRoleBelong.enemy, nil, nil, eBuffFeatureType.BeatBack)
end

function bs_15097:OnAfterAddBuff(buff, target)
  if target.belongNum == eBattleRoleBelong.enemy and self:IsReadyToTake() then
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self, self.SkillEventFunc)
  end
  self:OnSkillTake()
end

function bs_15097:OnBeforeAddBuff(target, context)
  if target.belongNum == eBattleRoleBelong.enemy and self:IsReadyToTake() then
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self, self.SkillEventFunc)
  end
  self:OnSkillTake()
end

function bs_15097:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, 3, {
      self.arglist[1]
    }, true, true)
    skillResult:EndResult()
  end
end

function bs_15097:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15097
