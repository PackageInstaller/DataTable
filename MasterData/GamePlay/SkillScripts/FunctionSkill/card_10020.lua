local card_10020 = class("card_10020", LuaSkillBase)
local base = LuaSkillBase
card_10020.config = {}

function card_10020:ctor()
end

function card_10020:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("card_10020", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player, nil, nil, nil)
  self.shp = 0
end

function card_10020:OnRoleDie(killer, role)
  if role.belongNum == eBattleRoleBelong.enemy then
    return
  end
  local isSacrifice = false
  if killer.roleType == eBattleRoleType.character and killer.belongNum == eBattleRoleBelong.player then
    isSacrifice = true
    self.shp = role.maxHp
  end
  LuaSkillCtrl:StartTimer(nil, 7, BindCallback(self, self.eventFunc, isSacrifice))
end

function card_10020:eventFunc(isSacrifice)
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

function card_10020:CallAddSheild(role)
  local shieldValue = self.shp * self.arglist[1] // 1000
  LuaSkillCtrl:AddRoleShield(role, eShieldType.Normal, shieldValue)
end

function card_10020:OnCasterDie()
  base.OnCasterDie(self)
end

return card_10020
