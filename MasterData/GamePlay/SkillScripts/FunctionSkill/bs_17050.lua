local bs_17050 = class("bs_17050", LuaSkillBase)
local base = LuaSkillBase
bs_17050.config = {buffId = 2101}

function bs_17050:ctor()
end

function bs_17050:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17050_2", 10, self.OnAfterBattleStart)
  self.typenum = 2
end

function bs_17050:OnAfterBattleStart()
  self.damTimer = LuaSkillCtrl:StartTimer(nil, 5, self.CallBack, self, -1, 5)
end

function bs_17050:CallBack()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  local Num = self.arglist[2] // self.arglist[1]
  local layer = self.caster:GetBuffTier(self.config.buffId)
  if Num > layer and self.caster.state == CS.eBattleRoleState.Moving then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[3], true)
  end
end

function bs_17050:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

function bs_17050:LuaDispose()
  base.LuaDispose(self)
  if self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

return bs_17050
