local bs_16027 = class("bs_16027", LuaSkillBase)
local base = LuaSkillBase
bs_16027.config = {buffId1 = 111143, buffId2 = 111144}

function bs_16027:ctor()
end

function bs_16027:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_16027_1", 1, self.OnAfterBattleStart)
  self:AddOnRoleDieTrigger("bs_16027_2", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.enemy)
end

function bs_16027:OnAfterBattleStart()
  if self.caster.belongNum == 2 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil)
  end
end

function bs_16027:OnRoleDie(killer, role, killSkill)
  if role.belongNum == eBattleRoleBelong.enemy then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, self.arglist[3])
  end
end

function bs_16027:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_16027
