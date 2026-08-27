local bs_15103 = class("bs_15103", LuaSkillBase)
local base = LuaSkillBase
bs_15103.config = {buffId = 2069}

function bs_15103:ctor()
end

function bs_15103:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15103_4", 1, self.OnAfterBattleStart)
  self.hurtTime = nil
end

function bs_15103:OnAfterBattleStart()
  if self.hurtTime ~= nil then
    self.hurtTime:Stop()
    self.hurtTime = nil
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1)
  local callback = BindCallback(self, self.FunSkill)
  self.hurtTime = LuaSkillCtrl:StartTimer(nil, self.arglist[2], callback, nil, -1, self.arglist[2])
end

function bs_15103:FunSkill()
  if self.caster.belongNum == eBattleRoleBelong.player then
    local value = self.caster.maxHp * self.arglist[3] // 1000
    LuaSkillCtrl:RemoveLife(value, self, self.caster, true, nil, true, true, eHurtType.RealDmg)
  end
end

function bs_15103:OnCasterDie()
  base.OnCasterDie(self)
  if self.hurtTime ~= nil then
    self.hurtTime:Stop()
    self.hurtTime = nil
  end
end

return bs_15103
