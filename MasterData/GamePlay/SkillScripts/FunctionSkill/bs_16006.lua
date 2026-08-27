local bs_16006 = class("bs_16006", LuaSkillBase)
local base = LuaSkillBase
bs_16006.config = {buffId1 = 110136, buffId2 = 110137}

function bs_16006:ctor()
end

function bs_16006:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_16006_1", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.enemy, nil)
end

function bs_16006:OnRoleDie(killer, role)
  if role.belongNum == eBattleRoleBelong.enemy and role.belongNum ~= 0 then
    local enemyList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
    if 0 < enemyList.Count then
      for i = 0, enemyList.Count - 1 do
        local enemyRole = enemyList[i]
        LuaSkillCtrl:CallBuff(self, enemyRole, self.config.buffId1, 1, nil)
        LuaSkillCtrl:CallBuff(self, enemyRole, self.config.buffId2, 1, nil)
      end
    end
  end
end

function bs_16006:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_16006
