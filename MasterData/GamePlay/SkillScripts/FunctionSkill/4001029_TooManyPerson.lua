local bs_4001029 = class("bs_4001029", LuaSkillBase)
local base = LuaSkillBase
bs_4001029.config = {buffId = 2023}

function bs_4001029:ctor()
end

function bs_4001029:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.ReCallBuff)
  self:AddOnRoleDieTrigger("bs_4001029_1", 2, self.ReCallBuff)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4001029_2", 1, self.ReCallBuff)
end

function bs_4001029:ReCallBuff()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetList.Count == 0 then
    return
  end
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:DispelBuff(targetList[i], self.config.buffId, 0)
  end
  local buffTier = targetList.Count
  if buffTier <= 0 then
    return
  end
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId, buffTier, nil, true)
  end
end

function bs_4001029:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001029
