local bs_17204 = class("bs_17204", LuaSkillBase)
local base = LuaSkillBase
bs_17204.config = {buffId = 2204, role_mode_tag = 3}

function bs_17204:ctor()
end

function bs_17204:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17204_1", 1, self.OnAfterBattleStart)
end

function bs_17204:OnAfterBattleStart()
  if self.caster.recordTable.Kurisu_Mode == self.config.role_mode_tag then
    local num, level = LuaSkillCtrl:GetDynPlayerChipCountAndLevelSum()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, num, nil, true)
  end
end

function bs_17204:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17204
