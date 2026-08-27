local bs_20001 = class("bs_20001", LuaSkillBase)
local base = LuaSkillBase
bs_20001.config = {buffId = 175, buffUndefeatable = 88}

function bs_20001:ctor()
end

function bs_20001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20001_1", 1, self.OnAfterBattleStart)
end

function bs_20001:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.neutral)
  if targetlist.Count <= 0 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i]
    if targetRole.roleDataId == 1003 then
      local restTier = targetRole:GetBuffTier(self.config.buffId)
      if 0 < restTier then
        LuaSkillCtrl:DispelBuff(targetRole, self.config.buffId, 0)
        LuaSkillCtrl:DispelBuff(targetRole, self.config.buffUndefeatable, 0)
      end
    end
  end
end

function bs_20001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20001
