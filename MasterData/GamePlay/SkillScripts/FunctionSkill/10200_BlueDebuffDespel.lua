local bs_10200 = class("bs_10200", LuaSkillBase)
local base = LuaSkillBase
bs_10200.config = {buffId = 1053, buffTier = 1}

function bs_10200:ctor()
end

function bs_10200:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10200_1", 1, self.OnAfterBattleStart)
end

function bs_10200:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.neutral)
  if targetlist.Count <= 0 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i]
    if targetRole.roleDataId == 1002 then
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, self.config.buffTier, nil, true)
    end
  end
  self:PlayChipEffect()
end

function bs_10200:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10200
