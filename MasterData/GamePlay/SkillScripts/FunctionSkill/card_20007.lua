local card_20007 = class("card_20007", LuaSkillBase)
local base = LuaSkillBase
card_20007.config = {buffId = 1502, basebuffId = 1504}

function card_20007:ctor()
end

function card_20007:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.ReCallBuff)
  self:AddOnRoleDieTrigger("card_20007", 2, self.ReCallBuff)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "card_20007", 5, self.OnAfterBattleStart)
end

function card_20007:OnAfterBattleStart()
  local Enemy = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  for i = 0, Enemy.Count - 1 do
    LuaSkillCtrl:CallBuff(self, Enemy[i], self.config.basebuffId, 1, nil, true)
  end
  self:ReCallBuff()
end

function card_20007:ReCallBuff()
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

function card_20007:OnCasterDie()
  base.OnCasterDie(self)
end

return card_20007
