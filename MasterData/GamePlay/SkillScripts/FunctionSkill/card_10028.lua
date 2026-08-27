local card_10028 = class("card_10028", LuaSkillBase)
local base = LuaSkillBase
card_10028.config = {}

function card_10028:ctor()
end

function card_10028:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("card_10028", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player, nil, nil, nil)
  self.shp = 0
end

function card_10028:OnRoleDie(killer, role)
  if role.belongNum == eBattleRoleBelong.enemy then
    return
  end
  local isSacrifice = false
  if killer.roleType == eBattleRoleType.character and killer.belongNum == eBattleRoleBelong.player then
    isSacrifice = true
  end
  LuaSkillCtrl:StartTimer(nil, 7, BindCallback(self, self.eventFunc, isSacrifice, role))
end

function card_10028:eventFunc(isSacrifice, role)
  self.shp = role.maxHp
  local roleList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if roleList == nil or roleList.Count < 1 then
    return
  end
  if not isSacrifice then
    return
  else
    for i = 0, roleList.Count - 1 do
      local role = roleList[i]
      self:CallAddSheild(role)
    end
  end
end

function card_10028:CallAddSheild(role)
  local shieldValue = self.shp * self.arglist[1] // 1000
  LuaSkillCtrl:AddRoleShield(role, eShieldType.Normal, shieldValue)
end

function card_10028:OnCasterDie()
  base.OnCasterDie(self)
end

return card_10028
