local bs_15108 = class("bs_15108", LuaSkillBase)
local base = LuaSkillBase
bs_15108.config = {buffId1 = 3004, buffId2 = 110088}

function bs_15108:ctor()
end

function bs_15108:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.CallBuff)
  self:AddOnRoleDieTrigger("bs_4001218_1", 2, self.CallBuff)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4001218_2", 1, self.CallBuff)
end

function bs_15108:CallBuff()
  local num = 0
  local PlayerList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, PlayerList.Count - 1 do
    if PlayerList[i].roleType == eBattleRoleType.character then
      num = num + 1
    end
  end
  if num == 1 then
    self:RemoveSkillTrigger(eSkillTriggerType.RoleDie)
    self:UnRegisterLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster)
    for i = 0, PlayerList.Count - 1 do
      if PlayerList[i].roleType == eBattleRoleType.character then
        LuaSkillCtrl:CallBuff(self, PlayerList[i], self.config.buffId1, 1, self.arglist[2], false)
        LuaSkillCtrl:CallBuff(self, PlayerList[i], self.config.buffId2, 1, self.arglist[2], false)
      end
    end
  end
end

function bs_15108:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15108
