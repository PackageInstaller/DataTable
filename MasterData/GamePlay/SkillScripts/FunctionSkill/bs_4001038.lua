local bs_4001038 = class("bs_4001038", LuaSkillBase)
local base = LuaSkillBase
bs_4001038.config = {buffId = 2073}

function bs_4001038:ctor()
end

function bs_4001038:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_4001038_1", 10, self.OnRoleDie, self.caster, nil, nil, eBattleRoleBelong.enemy)
end

function bs_4001038:OnRoleDie(killer, role)
  if killer ~= self.caster or self.caster:GetBuffTier(self.config.buffId) < 1 then
    return
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, false)
end

function bs_4001038:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001038
