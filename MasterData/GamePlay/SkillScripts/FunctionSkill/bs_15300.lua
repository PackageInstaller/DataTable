local bs_15300 = class("bs_15300", LuaSkillBase)
local base = LuaSkillBase
bs_15300.config = {}

function bs_15300:ctor()
end

function bs_15300:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15300_1", 1, self.OnAfterBattleStart)
  self.time = nil
end

function bs_15300:OnAfterBattleStart()
  if self.time ~= nil then
    self.time:Stop()
    self.time = nil
  end
  self.time = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.CallBack, self, -1, 0)
end

function bs_15300:CallBack()
  local value = (self.caster.def + self.caster.magic_res) * self.arglist[2] // 1000
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 14, 10)
  if targetList.Count > 0 then
    local targetRole = targetList[0].targetRole
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
    LuaSkillCtrl:HealResultWithConfig(self, skillResult, 6, {value}, false, false)
    skillResult:EndResult()
  end
end

function bs_15300:OnCasterDie()
  base.OnCasterDie(self)
  if self.time ~= nil then
    self.time:Stop()
    self.time = nil
  end
end

return bs_15300
