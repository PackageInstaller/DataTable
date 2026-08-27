local bs_16026 = class("bs_16026", LuaSkillBase)
local base = LuaSkillBase
bs_16026.config = {buffId = 210605}

function bs_16026:ctor()
end

function bs_16026:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25008_1", 1, self.OnAfterBattleStart)
end

function bs_16026:OnAfterBattleStart()
  if self.caster.dataId ~= 20081 and self.caster.belongNum == 2 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil)
  end
end

function bs_16026:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_16026
