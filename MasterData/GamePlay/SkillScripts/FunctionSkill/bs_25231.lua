local bs_25231 = class("bs_25231", LuaSkillBase)
local base = LuaSkillBase
bs_25231.config = {buffId = 2115, buffId1 = 2125}

function bs_25231:ctor()
end

function bs_25231:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnRealSummonerCaster)
  self:AddOnRoleDieTrigger("bs_25231_2", 2, self.ReCallBuff)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25231_1", 1, self.ReCallBuff)
end

function bs_25231:OnRealSummonerCaster(role)
  if role.summoner.summonerMaker.belongNum == eBattleRoleBelong.player then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId1, 1, nil, true)
    self:ReCallBuff()
  end
end

function bs_25231:ReCallBuff()
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
    LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffId, buffTier, nil, true)
  end
end

function bs_25231:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25231
