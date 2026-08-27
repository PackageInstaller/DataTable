local bs_17205 = class("bs_17205", LuaSkillBase)
local base = LuaSkillBase
bs_17205.config = {role_mode_tag = 3}

function bs_17205:ctor()
end

function bs_17205:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17205_1", 1, self.OnAfterBattleStart)
end

function bs_17205:OnAfterBattleStart()
  if self.caster.recordTable.Kurisu_Mode == self.config.role_mode_tag then
    self.caster.recordTable.Kurisu_tanshe = self.arglist[1]
  end
end

function bs_17205:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17205
