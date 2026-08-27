local bs_4010412 = class("bs_4010412", LuaSkillBase)
local base = LuaSkillBase
bs_4010412.config = {}

function bs_4010412:ctor()
end

function bs_4010412:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4010412_1", 1, self.OnAfterHurt, self.caster, nil, eBattleRoleBelong.player, nil, nil, nil, nil, eSkillTag.commonAttack)
end

function bs_4010412:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and not isTriggerSet and not isMiss then
    local exHurtValue = self.caster.maxHp * self.arglist[1] // 1000
    LuaSkillCtrl:RemoveLife(exHurtValue, self, target, true, nil, true, true, eHurtType.RealDmg)
  end
end

function bs_4010412:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010412
