local bs_10247 = class("bs_10247", LuaSkillBase)
local base = LuaSkillBase
bs_10247.config = {damageFormular = 10123, effectId = 10785}

function bs_10247:ctor()
end

function bs_10247:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10247_3", 1, self.OnAfterHurt, self.caster)
  self.damageTime = 0
end

function bs_10247:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isTriggerSet then
    self.damageTime = self.damageTime + 1
    if self.damageTime >= self.arglist[1] and self:IsReadyToTake() then
      self:OnSkillTake()
      self.damageTime = 0
      LuaSkillCtrl:CallEffect(target, self.config.effectId, self, self.SkillEventFunc)
      self:PlayChipEffect()
    end
  end
end

function bs_10247:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, self.config.aoe_config)
    if skillResult.roleList.Count < 1 then
      return
    end
    local hurt = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.damageFormular, self.caster, skillResult.roleList[0], self)
    LuaSkillCtrl:RemoveLife(hurt, self, skillResult.roleList[0], true, nil, true, false, eHurtType.RealDmg)
    skillResult:EndResult()
  end
end

function bs_10247:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10247
