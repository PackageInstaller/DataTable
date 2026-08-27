local bs_21022 = class("bs_21022", LuaSkillBase)
local base = LuaSkillBase
bs_21022.config = {}

function bs_21022:ctor()
end

function bs_21022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_21022_1", 1, self.OnAfterHurt, nil, nil, eBattleRoleBelong.player, nil, nil, nil, nil, eSkillTag.commonAttack)
  self.count = 0
end

function bs_21022:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and not isTriggerSet and not isMiss then
    self.count = self.count + 1
    if self.count >= self.arglist[1] + 1 then
      self.count = 0
      local exHurtValue = self.caster.maxHp * self.arglist[2] // 1000
      LuaSkillCtrl:RemoveLife(exHurtValue, self, target, true, nil, true, true, eHurtType.RealDmg)
    end
  end
end

function bs_21022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21022
