local bs_15109 = class("bs_15109", LuaSkillBase)
local base = LuaSkillBase
bs_15109.config = {effectId = 12063}

function bs_15109:ctor()
end

function bs_15109:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15109_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_15109_10", 1, self.OnRoleDie)
  self.time = 0
  self.money = 0
end

function bs_15109:OnAfterBattleStart()
  if self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
  self.damTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
    self.time = 1
    self:RemoveSkillTrigger(eSkillTriggerType.RoleDie)
  end, 1)
end

function bs_15109:OnRoleDie(killer, role)
  if role.belongNum == eBattleRoleBelong.enemy and self.time == 0 then
    self.money = self.arglist[3] + self.money
    LuaSkillCtrl:SetCacheGold(self.money)
    LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
  end
end

function bs_15109:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

return bs_15109
