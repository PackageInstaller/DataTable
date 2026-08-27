local bs_91025 = class("bs_91025", LuaSkillBase)
local base = LuaSkillBase
bs_91025.config = {buffId = 2047, buffTier = 1}

function bs_91025:ctor()
end

function bs_91025:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddHurtResultStartTrigger("bs_91024_15", 1, self.OnHurtResultStart, self.caster, nil, eBattleRoleBelong.player)
  self:AddHurtResultEndTrigger("bs_91024_16", 1, self.OnHurtResultEnd, self.caster, nil, eBattleRoleBelong.player)
end

function bs_91025:OnHurtResultStart(skill, context)
  if skill.maker == self.caster and skill.maker.maxHp ~= 0 and skill.maker.hp * 1000 // skill.maker.maxHp <= self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, skill.maker, self.config.buffId, self.config.buffTier, nil)
  end
end

function bs_91025:OnHurtResultEnd(skill, targetRole, hurtValue)
  if skill.maker == self.caster and skill.maker.hp * 1000 // skill.maker.maxHp > self.arglist[1] then
    LuaSkillCtrl:DispelBuff(skill.maker, self.config.buffId, 0)
  end
end

function bs_91025:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_91025
