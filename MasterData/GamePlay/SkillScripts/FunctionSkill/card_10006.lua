local card_10006 = class("card_10006", LuaSkillBase)
local base = LuaSkillBase
card_10006.config = {buffId = 1502, basebuffId = 1504}

function card_10006:ctor()
end

function card_10006:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.ReCallBuff)
  self:AddOnRoleDieTrigger("card_10006", 2, self.ReCallBuff)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "card_10006", 5, self.OnAfterBattleStart)
end

function card_10006:OnAfterBattleStart()
  local Player = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, Player.Count - 1 do
    LuaSkillCtrl:CallBuff(self, Player[i], self.config.basebuffId, 1, nil, true)
  end
  self:ReCallBuff()
end

function card_10006:OnRoleDie(killer, role)
  if role.belongNum ~= eBattleRoleBelong.neutral then
    self:ReCallBuff()
  end
end

function card_10006:ReCallBuff()
  local PlayerList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  local EnemyList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  for i = 0, PlayerList.Count - 1 do
    LuaSkillCtrl:DispelBuff(PlayerList[i], self.config.buffId, 0)
  end
  for i = 0, EnemyList.Count - 1 do
    LuaSkillCtrl:DispelBuff(EnemyList[i], self.config.buffId, 0)
  end
  local buffTier = math.min(5, math.abs(PlayerList.Count - EnemyList.Count))
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

function card_10006:OnCasterDie()
  base.OnCasterDie(self)
end

return card_10006
