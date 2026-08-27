local bs_17104 = class("bs_17104", LuaSkillBase)
local base = LuaSkillBase
bs_17104.config = {effectId = 12113, buffId = 2143}

function bs_17104:ctor()
end

function bs_17104:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_17104", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player, nil, nil, nil)
  self:AddLuaTrigger(eSkillLuaTrigger.OnSacrifice, self.OnSacrifice)
end

function bs_17104:OnRoleDie(killer, role)
  if role.belongNum == eBattleRoleBelong.enemy then
    return
  end
  LuaSkillCtrl:StartTimer(nil, 7, BindCallback(self, self.eventFunc, false))
end

function bs_17104:OnSacrifice(killer, role)
  if role.belongNum == eBattleRoleBelong.enemy then
    return
  end
  LuaSkillCtrl:StartTimer(nil, 7, BindCallback(self, self.eventFunc, true))
end

function bs_17104:eventFunc(isSacrifice)
  local roleList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if roleList == nil or roleList.Count < 1 then
    return
  end
  if not isSacrifice then
    local range = LuaSkillCtrl:CallRange(0, roleList.Count - 1)
    local role = roleList[range]
    self:CallAddSheild(role)
  else
    for i = 0, roleList.Count - 1 do
      local role = roleList[i]
      self:CallAddSheild(role)
    end
  end
end

function bs_17104:CallAddSheild(role)
  local shieldValue = role.maxHp * self.arglist[1] // 1000
  LuaSkillCtrl:AddRoleShield(role, eShieldType.Normal, shieldValue)
end

function bs_17104:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17104
