local bs_25022 = class("bs_25022", LuaSkillBase)
local base = LuaSkillBase
bs_25022.config = {effectId = 10164}

function bs_25022:ctor()
end

function bs_25022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25022_1", 1, self.OnAfterBattleStart)
  self.time = nil
end

function bs_25022:OnAfterBattleStart()
  if self.time ~= nil then
    self.time:stop()
    self.time = nil
  else
    self.time = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.OnCall, self, -1)
  end
end

function bs_25022:OnCall()
  local skills = self.caster:GetBattleSkillList()
  if skills ~= nil then
    local count = skills.Count
    if 0 < count then
      for i = 0, count - 1 do
        local curCd = skills[i].totalCDTime
        if not skills[i].isCommonAttack then
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[i], curCd)
          LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
        end
      end
    end
  end
end

function bs_25022:OnCasterDie()
  if self.timer ~= nil then
    self.timer:stop()
    self.timer = nil
  end
  base.OnCasterDie(self)
end

return bs_25022
