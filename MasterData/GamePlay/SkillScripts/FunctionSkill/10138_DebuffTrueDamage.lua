local bs_10138 = class("bs_10138", LuaSkillBase)
local base = LuaSkillBase
bs_10138.config = {
  realDamageConfig = {
    hit_formula = 0,
    basehurt_formula = 10038,
    crit_formula = 0
  },
  effectId = 10248
}

function bs_10138:ctor()
end

function bs_10138:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10138", 1, self.OnAfterHurt, self.caster)
end

function bs_10138:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and not isTriggerSet then
    local debuffNum = 0
    local buffs = LuaSkillCtrl:GetRoleBuffs(target)
    if buffs ~= nil and 0 < buffs.Count then
      for i = 0, buffs.Count - 1 do
        if buffs[i].buffType == 2 then
          debuffNum = debuffNum + 1
        end
      end
    end
    if 30 < debuffNum then
      debuffNum = 30
    end
    if 0 < debuffNum then
      LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId, self, true, false, self.SkillEventFunc, debuffNum)
    end
  end
end

function bs_10138:SkillEventFunc(debuffNum, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.realDamageConfig, {debuffNum}, true)
    skillResult:EndResult()
  end
end

function bs_10138:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10138
