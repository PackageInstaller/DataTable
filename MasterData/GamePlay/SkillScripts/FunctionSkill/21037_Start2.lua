local bs_21037 = class("bs_21037", LuaSkillBase)
local base = LuaSkillBase
bs_21037.config = {
  HurtConfig = {hit_formula = 0, basehurt_formula = 10186}
}

function bs_21037:ctor()
end

function bs_21037:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21037_1", 1, self.OnAfterBattleStart)
  self.Timer = nil
end

function bs_21037:OnAfterBattleStart()
  if self.Timer ~= nil then
    self.Timer:Stop()
    self.Timer = nil
  end
  self.Timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 46, 20)
    if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
      local targetlist = LuaSkillCtrl:GetAllEnmyRoles()
      if 0 < #targetlist then
        for k, v in pairs(targetlist) do
          local targetRole = v
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
          LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
            highAttRole[0].targetRole.skill_intensity
          }, true)
          skillResult:EndResult()
        end
      end
    end
  end, nil, -1, 0)
end

function bs_21037:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_21037:LuaDispose()
  base.LuaDispose(self)
  if self.Timer ~= nil then
    self.Timer:Stop()
    self.Timer = nil
  end
end

return bs_21037
