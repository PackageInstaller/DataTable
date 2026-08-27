local bs_4001218 = class("bs_4001218", LuaSkillBase)
local base = LuaSkillBase
bs_4001218.config = {buffId = 2021}

function bs_4001218:ctor()
end

function bs_4001218:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.ReCallBuff)
  self:AddOnRoleDieTrigger("bs_4001218_1", 2, self.ReCallBuff)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4001218_2", 1, self.ReCallBuff)
end

function bs_4001218:ReCallBuff()
  local PlayerList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  local EnemyList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  for i = 0, PlayerList.Count - 1 do
    LuaSkillCtrl:DispelBuff(PlayerList[i], self.config.buffId, 0)
  end
  for i = 0, EnemyList.Count - 1 do
    LuaSkillCtrl:DispelBuff(EnemyList[i], self.config.buffId, 0)
  end
  local buffTier = math.abs(PlayerList.Count - EnemyList.Count)
  if 0 > PlayerList.Count - EnemyList.Count then
    for i = 0, EnemyList.Count - 1 do
      LuaSkillCtrl:CallBuff(self, EnemyList[i], self.config.buffId, buffTier)
    end
  end
  if 0 < PlayerList.Count - EnemyList.Count then
    for i = 0, PlayerList.Count - 1 do
      LuaSkillCtrl:CallBuff(self, PlayerList[i], self.config.buffId, buffTier)
    end
  end
end

function bs_4001218:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001218
