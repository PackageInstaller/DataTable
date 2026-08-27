local bs_25008 = class("bs_25008", LuaSkillBase)
local base = LuaSkillBase
bs_25008.config = {buffId = 210605}

function bs_25008:ctor()
end

function bs_25008:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25008_1", 1, self.OnAfterBattleStart)
end

function bs_25008:OnAfterBattleStart()
  if self.caster.dataId ~= 20081 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil)
  end
end

function bs_25008:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25008
