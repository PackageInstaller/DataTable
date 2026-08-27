local bs_16011 = class("bs_16011", LuaSkillBase)
local base = LuaSkillBase
bs_16011.config = {buffId1 = 110138}

function bs_16011:ctor()
end

function bs_16011:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_16011_4", 1, self.OnAfterHurt, nil, nil, nil, eBattleRoleBelong.enemy, nil)
  self:AddAfterHealTrigger("bs_16011_6", 1, self.OnAfterHeal, nil, nil, nil, eBattleRoleBelong.enemy, nil)
end

function bs_16011:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  if target.belongNum == eBattleRoleBelong.enemy and not isMiss and target.hp * 1000 // target.maxHp < self.arglist[1] and target:GetBuffTier(self.config.buffId1) == 0 then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId1, 1, nil)
  end
end

function bs_16011:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if target.belongNum == eBattleRoleBelong.enemy and not isMiss and target.hp * 1000 // target.maxHp >= self.arglist[1] and target:GetBuffTier(self.config.buffId1) > 0 then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId1, 1)
  end
end

function bs_16011:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_16011
