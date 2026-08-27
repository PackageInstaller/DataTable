local bs_20060 = class("bs_20060", LuaSkillBase)
local base = LuaSkillBase
bs_20060.config = {buffId1 = 1165, buffId2 = 26}

function bs_20060:ctor()
end

function bs_20060:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20060_1", 99, self.OnAfterBattleStart)
end

function bs_20060:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist.Count <= 0 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i].targetRole
    LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId1, 1, nil, true)
    LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId2, 1, 150, true)
  end
end

function bs_20060:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20060
