local bs_4006 = class("bs_4006", LuaSkillBase)
local base = LuaSkillBase
bs_4006.config = {buffId_1 = 40062, buffId_2 = 40061}

function bs_4006:ctor()
end

function bs_4006:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4006_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_4006_10", 1, self.OnRoleDie)
end

function bs_4006:OnAfterBattleStart()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 2, 10)
  if targetList.Count > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1, targetList.Count)
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_2, 1)
end

function bs_4006:OnRoleDie(killer, role)
  if role.belongNum == self.caster.belongNum and role.roleType ~= eBattleRoleType.realSummoner then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_1, 1)
  end
end

function bs_4006:LuaDispose()
  base.LuaDispose(self)
end

function bs_4006:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4006
