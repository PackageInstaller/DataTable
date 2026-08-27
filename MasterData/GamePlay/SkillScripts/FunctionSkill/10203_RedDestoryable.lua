local bs_10203 = class("bs_10203", LuaSkillBase)
local base = LuaSkillBase
bs_10203.config = {buffId = 175}

function bs_10203:ctor()
end

function bs_10203:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10203_1", 1, self.OnAfterBattleStart)
end

function bs_10203:OnAfterBattleStart()
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
      end
    end
  end
end

function bs_10203:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10203
