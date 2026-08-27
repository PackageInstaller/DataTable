local bs_25234 = class("bs_25234", LuaSkillBase)
local base = LuaSkillBase
bs_25234.config = {buffId = 2118, buffId1 = 2128}

function bs_25234:ctor()
end

function bs_25234:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnRealSummonerCaster)
  self:AddOnRoleDieTrigger("bs_25234_2", 2, self.ReCallBuff)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25234_1", 1, self.OnAfterBattleStart)
end

function bs_25234:OnAfterBattleStart()
  local RoleList = LuaSkillCtrl:CallTargetSelect(self, 6, 100)
  for i = 0, RoleList.Count - 1 do
    LuaSkillCtrl:CallBuff(self, RoleList[i].targetRole, self.config.buffId1, 1, nil, true)
  end
  self:ReCallBuff()
end

function bs_25234:OnRealSummonerCaster(role)
  if role.roleType == eBattleRoleType.realSummoner and role.summoner.summonerMaker.belongNum == eBattleRoleBelong.player and not role.summoner:HasSummonerFeature(4) then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId1, 1, nil, true)
    self:ReCallBuff()
  end
end

function bs_25234:ReCallBuff()
  local summonerList = LuaSkillCtrl:CallTargetSelect(self, 82, 100)
  if summonerList.Count == 0 then
    return
  end
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 100)
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:DispelBuff(targetList[i].targetRole, self.config.buffId, 0)
  end
  local buffTier = summonerList.Count
  if buffTier <= 0 then
    return
  end
  local buff_num = buffTier * self.arglist[1] + self.arglist[2]
  if buff_num <= self.arglist[3] then
    for i = 0, targetList.Count - 1 do
      LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffId, buffTier, nil, true)
    end
  elseif buff_num > self.arglist[2] then
    local buffTier1 = (self.arglist[3] - self.arglist[2]) // self.arglist[1]
    for i = 0, targetList.Count - 1 do
      LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffId, buffTier1, nil, true)
    end
  end
end

function bs_25234:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25234
