local bs_15135 = class("bs_15135", LuaSkillBase)
local base = LuaSkillBase
bs_15135.config = {buffId = 110081}

function bs_15135:ctor()
end

function bs_15135:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15135_1", 1, self.OnAfterBattleStart)
end

function bs_15135:OnAfterBattleStart()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 46, 10)
  if targetList.Count > 0 then
    local targetRole = targetList[0].targetRole
    LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, nil, true)
  end
end

function bs_15135:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15135
