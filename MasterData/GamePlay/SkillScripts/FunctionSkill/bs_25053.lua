local bs_25053 = class("bs_25053", LuaSkillBase)
local base = LuaSkillBase
bs_25053.config = {buffId = 110077}

function bs_25053:ctor()
end

function bs_25053:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25053_1", 1, self.OnAfterBattleStart)
end

function bs_25053:OnAfterBattleStart()
  if self.caster.belongNum == eBattleRoleBelong.enemy and self.caster.intensity >= 2 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_25053:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25053
