local bs_25413 = class("bs_25413", LuaSkillBase)
local base = LuaSkillBase
bs_25413.config = {buffId2 = 2158}

function bs_25413:ctor()
end

function bs_25413:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25413_1", 1, self.OnAfterBattleStart)
end

function bs_25413:OnAfterBattleStart()
  local enemylist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  for i = 0, enemylist.Count - 1 do
    local enemyRole = enemylist[i]
    if 1 > enemyRole:GetBuffTier(self.config.buffId2) then
      LuaSkillCtrl:CallBuff(self, enemyRole, self.config.buffId2, 1, nil, true)
    end
  end
end

function bs_25413:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25413
