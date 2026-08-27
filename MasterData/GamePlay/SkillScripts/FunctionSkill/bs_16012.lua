local bs_16012 = class("bs_16012", LuaSkillBase)
local base = LuaSkillBase
bs_16012.config = {buffId1 = 110139}

function bs_16012:ctor()
end

function bs_16012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_16012_4", 1, self.OnAfterHurt, nil, nil, nil, eBattleRoleBelong.enemy, nil)
  self:AddAfterHealTrigger("bs_16012_6", 1, self.OnAfterHeal, nil, nil, nil, eBattleRoleBelong.enemy, nil)
end

function bs_16012:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  if target.belongNum == eBattleRoleBelong.enemy and not isMiss and target.hp * 1000 // target.maxHp < self.arglist[1] and target:GetBuffTier(self.config.buffId1) == 0 then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId1, 1, nil)
  end
end

function bs_16012:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if target.belongNum == eBattleRoleBelong.enemy and not isMiss and target.hp * 1000 // target.maxHp >= self.arglist[1] and target:GetBuffTier(self.config.buffId1) > 0 then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId1, 1)
  end
end

function bs_16012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_16012
