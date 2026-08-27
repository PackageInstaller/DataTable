local bs_21036 = class("bs_21036", LuaSkillBase)
local base = LuaSkillBase
bs_21036.config = {buffId = 110030}

function bs_21036:ctor()
end

function bs_21036:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddHurtResultStartTrigger("bs_21036_14", 1, self.OnHurtResultStart, nil, nil, nil, eBattleRoleBelong.player)
  self:AddHurtResultEndTrigger("bs_21036_15", 1, self.OnHurtResultEnd, nil, nil, nil, eBattleRoleBelong.player)
end

function bs_21036:OnHurtResultStart(skill, context)
  if context.target.belongNum == eBattleRoleBelong.player then
    local buffTier = (100 - context.target.hp * 100 // context.target.maxHp) * 10 // self.arglist[1]
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId, buffTier, nil, true)
  end
end

function bs_21036:OnHurtResultEnd(skill, targetRole, hurtValue)
  if targetRole.belongNum == eBattleRoleBelong.player then
    LuaSkillCtrl:DispelBuff(targetRole, self.config.buffId, 0)
  end
end

function bs_21036:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21036
