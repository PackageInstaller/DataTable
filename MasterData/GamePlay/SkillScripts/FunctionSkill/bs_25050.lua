local bs_25050 = class("bs_25050", LuaSkillBase)
local base = LuaSkillBase
bs_25050.config = {buffId = 110076}

function bs_25050:ctor()
end

function bs_25050:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddHurtResultStartTrigger("bs_25050_16", 1, self.OnHurtResultStart, nil, nil, eBattleRoleBelong.player, nil, eBattleRoleType.character)
  self:AddHurtResultEndTrigger("bs_25050_17", 1, self.OnHurtResultEnd, nil, nil, eBattleRoleBelong.player, nil, eBattleRoleType.character)
end

function bs_25050:OnHurtResultStart(skill, context)
  if skill.maker.belongNum == eBattleRoleBelong.player and skill.maker.roleType == eBattleRoleType.character then
    local value = (1000 - skill.maker.hp * 1000 // skill.maker.maxHp) // self.arglist[1]
    LuaSkillCtrl:CallBuff(self, skill.maker, self.config.buffId, value, nil, true)
  end
end

function bs_25050:OnHurtResultEnd(skill, targetRole, hurtValue)
  if skill.maker.belongNum == eBattleRoleBelong.player and skill.maker.roleType == eBattleRoleType.character then
    LuaSkillCtrl:DispelBuff(skill.maker, self.config.buffId, 0, true)
  end
end

function bs_25050:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25050
