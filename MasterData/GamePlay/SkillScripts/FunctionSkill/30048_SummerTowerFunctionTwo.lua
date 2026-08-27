local bs_30048 = class("bs_30048", LuaSkillBase)
local base = LuaSkillBase
bs_30048.config = {}

function bs_30048:ctor()
end

function bs_30048:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_30048_1", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player, nil, eBattleRoleType.character)
end

function bs_30048:OnRoleDie(killer, role)
  if killer == nil then
    return
  end
  local TowerCd = LuaSkillCtrl:GetTowerCastCd(role)
  if TowerCd > self.arglist[1] * 2 then
    TowerCd = TowerCd - self.arglist[1]
  else
    TowerCd = self.arglist[1]
  end
  LuaSkillCtrl:ResetTowerCastCd(role, TowerCd)
end

function bs_30048:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30048
