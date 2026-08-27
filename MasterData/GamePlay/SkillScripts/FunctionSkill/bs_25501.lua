local bs_25501 = class("bs_25501", LuaSkillBase)
local base = LuaSkillBase
bs_25501.config = {buffId = 110165}

function bs_25501:ctor()
end

function bs_25501:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25501_1", 1, self.OnAfterBattleStart)
end

function bs_25501:OnAfterBattleStart()
  local roleList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if roleList.Count ~= 0 then
    for i = 0, roleList.Count - 1 do
      LuaSkillCtrl:CallBuff(self, roleList[i], self.config.buffId, 1, nil, true)
    end
  end
end

function bs_25501:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25501
