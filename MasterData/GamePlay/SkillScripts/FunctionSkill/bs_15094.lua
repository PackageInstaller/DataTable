local bs_15094 = class("bs_15094", LuaSkillBase)
local base = LuaSkillBase
bs_15094.config = {}

function bs_15094:ctor()
end

function bs_15094:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_15094_2", 1, self.OnAfterAddBuff, self.caster, nil, nil, eBattleRoleBelong.enemy, nil, nil, eBuffFeatureType.Stun)
end

function bs_15094:OnAfterAddBuff(buff, target)
  if target.belongNum == eBattleRoleBelong.enemy and self:IsReadyToTake() then
    local shieldValue = self.caster.maxHp * self.arglist[1] // 1000
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue, nil, true)
  end
  self:OnSkillTake()
end

function bs_15094:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15094
