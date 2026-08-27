local card_20035 = class("card_20035", LuaSkillBase)
local base = LuaSkillBase
card_20035.config = {
  effect = 12095,
  buffId_1 = 1611,
  buffId_2 = 1612
}

function card_20035:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddHurtResultEndTrigger("card_20035_14", 1, self.OnHurtResultEnd, nil, nil, nil, eBattleRoleBelong.enemy)
  self.buffTier = 0
end

function card_20035:OnHurtResultEnd(skill, targetRole, hurtValue)
  if targetRole.belongNum == eBattleRoleBelong.enemy then
    local buffTier = (100 - targetRole.hp * 100 // targetRole.maxHp) * 10 // self.arglist[1]
    if buffTier ~= self.buffTier then
      LuaSkillCtrl:DispelBuff(targetRole, self.config.buffId_2, 0)
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId_2, buffTier, nil, true)
      self.buffTier = buffTier
    end
  end
end

function card_20035:OnCasterDie()
  base.OnCasterDie(self)
end

return card_20035
