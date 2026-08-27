local card_10027 = class("card_10027", LuaSkillBase)
local base = LuaSkillBase
card_10027.config = {buffId = 1603, basebuffId = 1604}

function card_10027:ctor()
end

function card_10027:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.ReCallBuff)
  self:AddOnRoleDieTrigger("card_10027", 2, self.ReCallBuff)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "card_10027", 5, self.OnAfterBattleStart)
end

function card_10027:OnAfterBattleStart()
  local Player = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, Player.Count - 1 do
    LuaSkillCtrl:CallBuff(self, Player[i], self.config.basebuffId, 1, nil, true)
  end
  self:ReCallBuff()
end

function card_10027:OnRoleDie(killer, role)
  if role.belongNum ~= eBattleRoleBelong.neutral then
    self:ReCallBuff()
  end
end

function card_10027:ReCallBuff()
  local PlayerList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  local EnemyList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  for i = 0, PlayerList.Count - 1 do
    LuaSkillCtrl:DispelBuff(PlayerList[i], self.config.buffId, 0, true)
  end
  for i = 0, EnemyList.Count - 1 do
    LuaSkillCtrl:DispelBuff(EnemyList[i], self.config.buffId, 0, true)
  end
  local buffTier = math.min(5, math.abs(PlayerList.Count - EnemyList.Count))
  if 0 > PlayerList.Count - EnemyList.Count then
    for i = 0, EnemyList.Count - 1 do
      LuaSkillCtrl:CallBuff(self, EnemyList[i], self.config.buffId, buffTier, nil, true)
    end
  end
  if 0 < PlayerList.Count - EnemyList.Count then
    for i = 0, PlayerList.Count - 1 do
      LuaSkillCtrl:CallBuff(self, PlayerList[i], self.config.buffId, buffTier, nil, true)
    end
  end
end

function card_10027:OnCasterDie()
  base.OnCasterDie(self)
end

return card_10027
