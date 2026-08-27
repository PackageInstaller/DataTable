local bs_21018 = class("bs_21018", LuaSkillBase)
local base = LuaSkillBase
bs_21018.config = {}

function bs_21018:ctor()
end

function bs_21018:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21018_1", 1, self.OnAfterBattleStart)
  self.Timer = nil
end

function bs_21018:OnAfterBattleStart()
  if self.Timer ~= nil then
    self.Timer:Stop()
    self.Timer = nil
  end
  self.Timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 46, 20)
    if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
      local value = highAttRole[0].targetRole.skill_intensity * self.arglist[2] // 1000
      local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
      if targetlist.Count > 0 then
        for i = 0, targetlist.Count - 1 do
          local targetRole = targetlist[i]
          LuaSkillCtrl:CallHeal(value, self, targetRole, true)
        end
      end
    end
  end, nil, -1)
end

function bs_21018:OnCasterDie()
  base.OnCasterDie(self)
  if self.Timer ~= nil then
    self.Timer:Stop()
    self.Timer = nil
  end
end

function bs_21018:LuaDispose()
  base.LuaDispose(self)
  if self.Timer ~= nil then
    self.Timer:Stop()
    self.Timer = nil
  end
end

return bs_21018
