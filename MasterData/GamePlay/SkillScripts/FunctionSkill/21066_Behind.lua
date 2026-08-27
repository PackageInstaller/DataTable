local bs_21056 = class("bs_21056", LuaSkillBase)
local base = LuaSkillBase
bs_21056.config = {buffId = 110028}

function bs_21056:ctor()
end

function bs_21056:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddHurtResultEndTrigger("bs_21056_16", 1, self.OnHurtResultEnd, nil, nil, eBattleRoleBelong.enemy)
  self:AddHurtResultStartTrigger("bs_21056_17", 1, self.OnHurtResultStart, nil, nil, eBattleRoleBelong.enemy)
end

function bs_21056:OnHurtResultStart(skill, context)
  if skill.maker.belongNum == eBattleRoleBelong.enemy and skill.maker.hp < context.target.hp then
    LuaSkillCtrl:CallBuff(self, skill.maker, self.config.buffId, 1, nil)
  end
end

function bs_21056:OnHurtResultEnd(skill, targetRole, hurtValue)
  if skill.maker.belongNum == eBattleRoleBelong.enemy then
    LuaSkillCtrl:DispelBuff(skill.maker, self.config.buffId, 0)
  end
end

function bs_21056:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21056
