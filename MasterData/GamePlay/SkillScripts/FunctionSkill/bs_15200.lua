local bs_15200 = class("bs_15200", LuaSkillBase)
local base = LuaSkillBase
bs_15200.config = {buffId = 110100, buffId2 = 110101}

function bs_15200:ctor()
end

function bs_15200:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15200_1", 1, self.OnAfterBattleStart)
  self:AddOnRoleDieTrigger("bs_15200_02", 1, self.ReCallBuff, nil, nil, nil, eBattleRoleBelong.enemy)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.ReCallBuff)
end

function bs_15200:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetList.Count >= 0 then
    local buffTier = targetList.Count
    if 0 < buffTier then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, buffTier, nil, true)
    end
  end
end

function bs_15200:ReCallBuff()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetList.Count >= 0 then
    local buffTier = targetList.Count
    if 0 < buffTier then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId2, 0, true)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, buffTier, nil, true)
    else
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId2, 0, true)
    end
  end
end

function bs_15200:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15200
