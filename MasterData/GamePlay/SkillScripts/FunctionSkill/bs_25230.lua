local bs_25230 = class("bs_25230", LuaSkillBase)
local base = LuaSkillBase
bs_25230.config = {buffId = 2114, buffId1 = 2124}

function bs_25230:ctor()
end

function bs_25230:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnRealSummonerCaster)
  self:AddOnRoleDieTrigger("bs_25230_2", 2, self.ReCallBuff)
end

function bs_25230:OnRealSummonerCaster(role)
  if role.roleType == eBattleRoleType.realSummoner and role.summoner.summonerMaker.belongNum == eBattleRoleBelong.player and not role.summoner:HasSummonerFeature(4) then
    local heal_Num1 = role.maxHp * self.arglist[2] // 1000
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId1, 1, nil, true)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
    LuaSkillCtrl:HealResultWithConfig(self, skillResult, 6, {heal_Num1}, true, true)
    self:ReCallBuff()
  end
end

function bs_25230:ReCallBuff()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 82, 100)
  if targetList.Count == 0 then
    return
  end
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:DispelBuff(targetList[i].targetRole, self.config.buffId, 0)
  end
  local buffTier = targetList.Count
  if buffTier <= 0 then
    return
  end
  for i = 0, targetList.Count - 1 do
    local heal_percent = targetList[i].targetRole.hp // targetList[i].targetRole.maxHp
    local heal_Num2 = targetList[i].targetRole.hp
    LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffId, buffTier, nil, true)
    local heal_Num3 = heal_percent * targetList[i].targetRole.maxHp
    local heal_Num = math.max(0, heal_Num3 - heal_Num2)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i].targetRole)
    LuaSkillCtrl:HealResultWithConfig(self, skillResult, 6, {heal_Num}, true, true)
  end
end

function bs_25230:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25230
