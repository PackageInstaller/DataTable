local bs_15136 = class("bs_15136", LuaSkillBase)
local base = LuaSkillBase
bs_15136.config = {buffId = 110082}

function bs_15136:ctor()
end

function bs_15136:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15136_1", 1, self.OnAfterBattleStart)
end

function bs_15136:OnAfterBattleStart()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 77, 10)
  if targetList.Count > 0 then
    local targetRole = targetList[0].targetRole
    if targetRole.roleType == eBattleRoleType.character then
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, nil, true)
    end
  end
end

function bs_15136:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15136
