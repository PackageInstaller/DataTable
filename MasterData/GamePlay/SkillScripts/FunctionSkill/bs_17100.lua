local bs_17100 = class("bs_17100", LuaSkillBase)
local base = LuaSkillBase
bs_17100.config = {
  buffId1 = 2141,
  buffId2 = 2154,
  effectId = 12113
}

function bs_17100:ctor()
end

function bs_17100:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_17100_1", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player)
  self:AddLuaTrigger(eSkillLuaTrigger.OnSacrifice, self.OnSacrifice)
end

function bs_17100:OnRoleDie(killer, role)
  if role.belongNum == eBattleRoleBelong.enemy then
    return
  end
  self:eventFunc(killer, role, false)
end

function bs_17100:OnSacrifice(killer, role)
  if role.belongNum == eBattleRoleBelong.enemy then
    return
  end
  self:eventFunc(killer, role, true)
end

function bs_17100:eventFunc(killer, role, isSacrifice)
  local enemyList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if enemyList.Count < 1 then
    return
  end
  if not isSacrifice then
    local max = enemyList.Count - 1
    local range = LuaSkillCtrl:CallRange(0, max)
    local enemyRole = enemyList[range]
    LuaSkillCtrl:CallBuff(self, enemyRole, self.config.buffId1, 1, self.arglist[3], true)
  else
    for i = 0, enemyList.Count - 1 do
      local enemyRole = enemyList[i]
      LuaSkillCtrl:CallBuff(self, enemyRole, self.config.buffId1, 1, self.arglist[3], true)
    end
  end
end

function bs_17100:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17100
