local bs_10224 = class("bs_10224", LuaSkillBase)
local base = LuaSkillBase
bs_10224.config = {
  buffId = 1080,
  buffTier = 1,
  effectId1 = 10749,
  effectId2 = 10750,
  effectId3 = 10751,
  effectId4 = 10752
}

function bs_10224:ctor()
end

function bs_10224:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10224_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10224_10", 2, self.OnRoleDie)
end

function bs_10224:OnAfterBattleStart()
  self:PlayChipEffect()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
  self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId3, self)
end

function bs_10224:OnRoleDie(killer, role)
  if role.belongNum ~= 0 and role.belongNum ~= self.caster.belongNum and not self.caster.recordTable["30009_arg"] then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
  end
end

function bs_10224:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_10224:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

return bs_10224
