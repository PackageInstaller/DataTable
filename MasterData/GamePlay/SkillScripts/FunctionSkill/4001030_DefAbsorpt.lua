local bs_4001030 = class("bs_4001030", LuaSkillBase)
local base = LuaSkillBase
bs_4001030.config = {
  buffId_good = 1268,
  buffId_bad = 1269,
  buffTier = 1
}

function bs_4001030:ctor()
end

function bs_4001030:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4001030_1", 1, self.OnAfterHurt, nil, nil, eBattleRoleBelong.enemy, eBattleRoleBelong.player)
end

function bs_4001030:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and not isMiss and target ~= sender then
    LuaSkillCtrl:CallBuff(self, sender, self.config.buffId_bad, self.config.buffTier, self.arglist[3], true)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_good, self.config.buffTier, self.arglist[3], true)
  end
end

function bs_4001030:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001030
