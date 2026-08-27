local bs_20007 = class("bs_20007", LuaSkillBase)
local base = LuaSkillBase
bs_20007.config = {formula = 1047}

function bs_20007:ctor()
end

function bs_20007:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20007_1", 1, self.OnAfterBattleStart)
end

function bs_20007:OnAfterBattleStart()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 30, 0)
  if targetList ~= nil and 0 < targetList.Count then
    local healNum = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.formula, targetList[0].targetRole, nil, self)
    if 0 < healNum then
      LuaSkillCtrl:CallHeal(healNum, self, targetList[0].targetRole, true)
    end
  end
end

function bs_20007:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20007
