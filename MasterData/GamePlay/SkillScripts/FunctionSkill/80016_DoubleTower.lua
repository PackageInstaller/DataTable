local bs_80016 = class("bs_80016", LuaSkillBase)
local base = LuaSkillBase
bs_80016.config = {}

function bs_80016:ctor()
end

function bs_80016:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_80016_2", 1, self.OnAfterAddBuff, nil, nil, nil, eBattleRoleBelong.enemy, nil, eBuffType.Debeneficial)
end

function bs_80016:OnAfterAddBuff(buff, target)
  if target.belongNum == eBattleRoleBelong.enemy and target.intensity > 0 and buff.buffType == 2 then
    local shieldValue = self.caster.skill_intensity * self.arglist[1] // 1000
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue, nil, true)
  end
end

function bs_80016:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_80016
