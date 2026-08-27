local bs_25232 = class("bs_25232", LuaSkillBase)
local base = LuaSkillBase
bs_25232.config = {buffId = 2116, buffId1 = 2126}

function bs_25232:ctor()
end

function bs_25232:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnRealSummonerCaster)
  self:AddOnRoleDieTrigger("bs_25232_2", 2, self.ReCallBuff)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25232_1", 1, self.ReCallBuff)
end

function bs_25232:OnRealSummonerCaster(role)
  if role.summoner.summonerMaker.belongNum == eBattleRoleBelong.player then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId1, 1, nil, true)
    self:ReCallBuff()
  end
end

function bs_25232:ReCallBuff()
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

function bs_25232:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25232
