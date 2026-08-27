local bs_15134 = class("bs_15134", LuaSkillBase)
local base = LuaSkillBase
bs_15134.config = {buffId = 110080}

function bs_15134:ctor()
end

function bs_15134:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15134_1", 1, self.OnAfterBattleStart)
end

function bs_15134:OnAfterBattleStart()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 31, 10)
  if targetList.Count > 0 then
    local targetRole = targetList[0].targetRole
    if targetRole.roleType == eBattleRoleType.character then
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, nil, true)
    end
  end
end

function bs_15134:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15134
