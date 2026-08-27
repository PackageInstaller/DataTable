local bs_21055 = class("bs_21055", LuaSkillBase)
local base = LuaSkillBase
bs_21055.config = {}

function bs_21055:ctor()
end

function bs_21055:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21055_1", 1, self.OnAfterBattleStart)
  self.Timer = nil
end

function bs_21055:OnAfterBattleStart()
  if self.Timer ~= nil then
    self.Timer:Stop()
    self.Timer = nil
  end
  self.Timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
    local skills = self.caster:GetBattleSkillList()
    if skills ~= nil then
      local count = skills.Count
      if 0 < count then
        for i = 0, count - 1 do
          local curCd = skills[i].totalCDTime * -1 * self.arglist[2] // 1000
          if not skills[i].isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[i], curCd)
          end
        end
      end
    end
  end, nil, -1, 0)
end

function bs_21055:OnCasterDie()
  base.OnCasterDie(self)
  if self.Timer ~= nil then
    self.Timer:Stop()
    self.Timer = nil
  end
end

function bs_21055:LuaDispose()
  base.LuaDispose(self)
  if self.Timer ~= nil then
    self.Timer:Stop()
    self.Timer = nil
  end
end

return bs_21055
