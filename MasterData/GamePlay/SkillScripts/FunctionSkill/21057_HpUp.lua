local bs_21057 = class("bs_21057", LuaSkillBase)
local base = LuaSkillBase
bs_21057.config = {buffId = 110029}

function bs_21057:ctor()
end

function bs_21057:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddHurtResultEndTrigger("bs_21057_16", 1, self.OnHurtResultEnd, nil, nil, eBattleRoleBelong.player)
  self:AddHurtResultStartTrigger("bs_21057_16", 1, self.OnHurtResultStart, nil, nil, eBattleRoleBelong.player)
end

function bs_21057:OnHurtResultStart(skill, context)
  if skill.maker.belongNum == eBattleRoleBelong.player and skill.maker.maxHp ~= 0 and skill.maker.hp * 1000 // skill.maker.maxHp >= self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, skill.maker, self.config.buffId, 1, nil)
  end
end

function bs_21057:OnHurtResultEnd(skill, targetRole, hurtValue)
  if skill.maker.belongNum == eBattleRoleBelong.player then
    LuaSkillCtrl:DispelBuff(skill.maker, self.config.buffId, 0)
  end
end

function bs_21057:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21057
