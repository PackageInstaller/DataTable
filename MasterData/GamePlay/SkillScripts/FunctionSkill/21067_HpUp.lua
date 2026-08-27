local bs_21067 = class("bs_21067", LuaSkillBase)
local base = LuaSkillBase
bs_21067.config = {buffId = 110029}

function bs_21067:ctor()
end

function bs_21067:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddHurtResultStartTrigger("bs_21067_15", 1, self.OnHurtResultStart, nil, nil, eBattleRoleBelong.enemy)
  self:AddHurtResultEndTrigger("bs_21067_16", 1, self.OnHurtResultEnd, nil, nil, eBattleRoleBelong.enemy)
end

function bs_21067:OnHurtResultStart(skill, context)
  if skill.maker.belongNum == eBattleRoleBelong.enemy and skill.maker.hp * 1000 // skill.maker.maxHp >= self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, skill.maker, self.config.buffId, 1, nil)
  end
end

function bs_21067:OnHurtResultEnd(skill, targetRole, hurtValue)
  if skill.maker.belongNum == eBattleRoleBelong.enemy then
    LuaSkillCtrl:DispelBuff(skill.maker, self.config.buffId, 0)
  end
end

function bs_21067:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21067
