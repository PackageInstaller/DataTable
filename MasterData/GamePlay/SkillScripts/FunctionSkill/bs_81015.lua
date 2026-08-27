local bs_81015 = class("bs_81015", LuaSkillBase)
local base = LuaSkillBase
bs_81015.config = {
  buffId1 = 175,
  buffId2 = 1033,
  buffId3 = 198,
  buffId4 = 88
}

function bs_81015:ctor()
end

function bs_81015:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_81015_2", 1, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_81015_1", 2, self.OnAfterBattleStart)
  self.num = 0
end

function bs_81015:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetlist.Count < 1 then
    return
  end
  for i = targetlist.Count - 1, 0, -1 do
    local targetRole = targetlist[i]
    if targetRole.roleDataId == 40042 then
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId1, 1, nil, true)
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId2, 1, nil, true)
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId3, 1, nil, true)
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId4, 1, nil, true)
    end
  end
  LuaSkillCtrl:StartAvgWithPauseGame("23winter_s20_1", nil, nil)
end

function bs_81015:OnRoleDie(killer, role)
  if role.belongNum ~= self.caster.belongNum then
    self.num = self.num + 1
    if self.num >= 12 then
      LuaSkillCtrl:ForceEndBattle(true)
    end
  end
end

function bs_81015:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_81015
