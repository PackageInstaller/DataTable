local bs_17053 = class("bs_17053", LuaSkillBase)
local base = LuaSkillBase
bs_17053.config = {buffId = 2104}

function bs_17053:ctor()
end

function bs_17053:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17053_2", 10, self.OnAfterBattleStart)
  self.typenum = 2
end

function bs_17053:OnAfterBattleStart()
  self.damTimer = LuaSkillCtrl:StartTimer(nil, 5, self.CallBack, self, -1, 5)
end

function bs_17053:CallBack()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  if self.caster.state == CS.eBattleRoleState.Moving then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[1], true)
  end
end

function bs_17053:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

function bs_17053:LuaDispose()
  base.LuaDispose(self)
  if self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

return bs_17053
