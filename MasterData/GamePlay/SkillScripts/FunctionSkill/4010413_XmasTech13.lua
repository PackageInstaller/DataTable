local bs_4010413 = class("bs_4010413", LuaSkillBase)
local base = LuaSkillBase
bs_4010413.config = {}

function bs_4010413:ctor()
end

function bs_4010413:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4010413_1", 1, self.OnAfterHurt, nil, self.caster, nil, eBattleRoleBelong.player, nil, nil, nil, eSkillTag.commonAttack)
end

function bs_4010413:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and skill.isCommonAttack and not isTriggerSet and not isMiss then
    local exHurtValue = self.caster.maxHp * self.arglist[1] // 1000
    LuaSkillCtrl:RemoveLife(exHurtValue, self, sender, true, nil, true, true, eHurtType.RealDmg)
  end
end

function bs_4010413:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010413
