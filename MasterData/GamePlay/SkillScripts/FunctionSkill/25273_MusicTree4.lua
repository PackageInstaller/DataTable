local bs_25273 = class("bs_25273", LuaSkillBase)
local base = LuaSkillBase
bs_25273.config = {buffId = 2132}

function bs_25273:ctor()
end

function bs_25273:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddHurtResultStartTrigger("bs_25273_14", 1, self.OnHurtResultStart, nil, nil, nil, eBattleRoleBelong.player)
  self:AddHurtResultEndTrigger("bs_25273_15", 1, self.OnHurtResultEnd, nil, nil, nil, eBattleRoleBelong.player)
end

function bs_25273:OnHurtResultStart(skill, context)
  if context.target.belongNum == eBattleRoleBelong.player then
    local buffTier = (100 - context.target.hp * 100 // context.target.maxHp) * 10 // self.arglist[1]
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId, buffTier, nil, true)
  end
end

function bs_25273:OnHurtResultEnd(skill, targetRole, hurtValue)
  if targetRole.belongNum == eBattleRoleBelong.player then
    LuaSkillCtrl:DispelBuff(targetRole, self.config.buffId, 0)
  end
end

function bs_25273:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25273
