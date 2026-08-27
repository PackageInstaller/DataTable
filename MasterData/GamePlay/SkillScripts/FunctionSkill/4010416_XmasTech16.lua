local bs_4010416 = class("bs_4010416", LuaSkillBase)
local base = LuaSkillBase
bs_4010416.config = {buffId = 1059}

function bs_4010416:ctor()
end

function bs_4010416:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4010416_3", 1, self.OnAfterHurt, nil, nil, eBattleRoleBelong.enemy, self.caster.belongNum)
end

function bs_4010416:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.belongNum == self.caster.belongNum and isMiss then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, sender, self.config.buffId, self.arglist[1], 75)
  end
end

function bs_4010416:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010416
