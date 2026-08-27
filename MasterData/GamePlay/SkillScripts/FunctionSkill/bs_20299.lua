local bs_20299 = class("bs_20299", LuaSkillBase)
local base = LuaSkillBase
bs_20299.config = {buffId = 2206}

function bs_20299:ctor()
end

function bs_20299:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_20299_1", 1, self.OnRoleDie)
  self.commander = LuaSkillCtrl:GetPlayerRoleEntity()
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20299_2", 1, self.OnAfterBattleStart)
end

function bs_20299:OnAfterBattleStart()
  self.tier = 0
  if self.commander.recordTable.croode_degree ~= nil then
    self.tier = self.commander.recordTable.croode_degree
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.tier, nil)
end

function bs_20299:OnRoleDie(killer, role)
  if role ~= self.caster and role.belongNum == self.caster.belongNum then
    local healNum = self.tier * self.caster.maxHp * self.arglist[2] // 1000
    LuaSkillCtrl:CallHeal(healNum, self, self.caster)
  end
end

function bs_20299:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20299
