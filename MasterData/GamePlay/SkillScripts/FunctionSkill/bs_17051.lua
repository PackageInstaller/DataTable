local bs_17051 = class("bs_17051", LuaSkillBase)
local base = LuaSkillBase
bs_17051.config = {buffId = 2102}

function bs_17051:ctor()
end

function bs_17051:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17051_2", 10, self.OnAfterBattleStart)
  self.typenum = 2
end

function bs_17051:OnAfterBattleStart()
  self.damTimer = LuaSkillCtrl:StartTimer(nil, 5, self.CallBack, self, -1, 5)
end

function bs_17051:CallBack()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  local Num = self.arglist[2] // self.arglist[1]
  local layer = self.caster:GetBuffTier(self.config.buffId)
  if Num > layer and self.caster.state == CS.eBattleRoleState.Moving then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[3], true)
  end
end

function bs_17051:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

function bs_17051:LuaDispose()
  base.LuaDispose(self)
  if self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

return bs_17051
