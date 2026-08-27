local bs_4030 = class("bs_4030", LuaSkillBase)
local base = LuaSkillBase
bs_4030.config = {
  buff_id = 3012,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10187,
    crit_formula = 0
  }
}

function bs_4030:ctor()
end

function bs_4030:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4030_1", 1, self.OnAfterBattleStart)
end

function bs_4030:OnAfterBattleStart()
  self.passive = LuaSkillCtrl:StartTimer(self, self.arglist[1], self.Callback, self, -1)
end

function bs_4030:Callback()
  if self.passive ~= nil and self.passive:IsOver() then
    self.passive = nil
  end
  local Damage = 0
  local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 80, 20)
  if highAttRole ~= nil and 0 < highAttRole.Count and highAttRole[0] ~= nil then
    Damage = highAttRole[0].targetRole.skill_intensity * self.arglist[2] // 1000
  end
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 20)
  if targetList.Count >= 1 and targetList[0] ~= nil then
    for i = targetList.Count - 1, 0, -1 do
      local role = targetList[i].targetRole
      LuaSkillCtrl:CallBuff(self, role, self.config.buff_id, 1, self.arglist[3])
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {Damage}, true, false)
      skillResult:EndResult()
    end
  end
end

function bs_4030:OnCasterDie()
  base.OnCasterDie(self)
  if self.passive ~= nil then
    self.passive:Stop()
    self.passive = nil
  end
end

function bs_4030:LuaDispose()
  if self.passive ~= nil then
    self.passive:Stop()
    self.passive = nil
  end
  base.LuaDispose(self)
end

return bs_4030
