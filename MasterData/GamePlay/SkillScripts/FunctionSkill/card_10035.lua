local card_10035 = class("card_10035", LuaSkillBase)
local base = LuaSkillBase
card_10035.config = {
  effect = 12095,
  buffId_1 = 1611,
  buffId_2 = 1612
}

function card_10035:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddHurtResultStartTrigger("card_10035_14", 1, self.OnHurtResultStart, nil, nil, nil, eBattleRoleBelong.enemy)
  self:AddHurtResultEndTrigger("card_10035_15", 1, self.OnHurtResultEnd, nil, nil, nil, eBattleRoleBelong.enemy)
end

function card_10035:OnHurtResultStart(skill, context)
  if context.target.belongNum == eBattleRoleBelong.enemy then
    local buffTier = (100 - context.target.hp * 100 // context.target.maxHp) * 10 // self.arglist[1]
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_1, buffTier, nil, true)
  end
end

function card_10035:OnHurtResultEnd(skill, targetRole, hurtValue)
  if targetRole.belongNum == eBattleRoleBelong.enemy then
    LuaSkillCtrl:DispelBuff(targetRole, self.config.buffId_1, 0)
  end
end

function card_10035:OnCasterDie()
  base.OnCasterDie(self)
end

return card_10035
