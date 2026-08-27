local bs_91024 = class("bs_91024", LuaSkillBase)
local base = LuaSkillBase
bs_91024.config = {buffId = 2046, buffTier = 1}

function bs_91024:ctor()
end

function bs_91024:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddHurtResultEndTrigger("bs_91024_16", 1, self.OnHurtResultEnd, nil, self.caster, nil, eBattleRoleBelong.player)
  self:AddHealResultEndTrigger("bs_91024_17", 1, self.OnHealResultEnd, nil, self.caster, nil, eBattleRoleBelong.player)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_91024_18", 1, self.OnAfterBattleStart)
end

function bs_91024:OnAfterBattleStart()
  if self.caster.hp * 1000 // self.caster.maxHp > self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil)
  end
end

function bs_91024:OnHealResultEnd(skill, targetRole, healValue)
  if self.caster.hp * 1000 // self.caster.maxHp > self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil)
  end
end

function bs_91024:OnHurtResultEnd(skill, targetRole, hurtValue)
  if self.caster.hp * 1000 // self.caster.maxHp < self.arglist[1] then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_91024:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_91024
