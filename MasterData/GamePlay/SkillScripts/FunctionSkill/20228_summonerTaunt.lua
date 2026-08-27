local bs_20228 = class("bs_20228", LuaSkillBase)
local base = LuaSkillBase
bs_20228.config = {buffId = 3002}

function bs_20228:ctor()
end

function bs_20228:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20228_1", 1, self.OnAfterBattleStart)
end

function bs_20228:OnAfterBattleStart()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffId, 1)
  end
end

function bs_20228:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20228
