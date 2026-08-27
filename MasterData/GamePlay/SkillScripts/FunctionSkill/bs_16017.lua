local bs_16017 = class("bs_16017", LuaSkillBase)
local base = LuaSkillBase
bs_16017.config = {buffId1 = 111140}

function bs_16017:ctor()
end

function bs_16017:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_16017_1", 1, self.OnAfterBattleStart)
end

function bs_16017:OnAfterBattleStart()
  local roleList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if roleList.Count > 0 then
    for i = 0, roleList.Count - 1 do
      local role = roleList[i]
      LuaSkillCtrl:CallBuff(self, role, self.config.buffId1, 1, nil)
    end
  end
end

function bs_16017:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_16017
