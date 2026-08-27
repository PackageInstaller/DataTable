local bs_94104 = class("bs_94104", LuaSkillBase)
local base = LuaSkillBase
bs_94104.config = {buffId = 26}

function bs_94104:ctor()
end

function bs_94104:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_94104_3", 1, self.OnAfterHurt, nil, self.caster, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
end

function bs_94104:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender.belongNum == eBattleRoleBelong.enemy and target == self.caster and skill.isCommonAttack and not isTriggerSet and LuaSkillCtrl:CallRange(1, 1000) < self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, sender, self.config.buffId, 1, self.arglist[2])
  end
end

function bs_94104:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_94104
