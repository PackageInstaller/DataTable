local bs_21263 = class("bs_21263", LuaSkillBase)
local base = LuaSkillBase
bs_21263.config = {targetSkillId = 105203, skillLevel = 2}

function bs_21263:ctor()
end

function bs_21263:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  LuaSkillCtrl:AddChipChipConsumeSkill(self.config.targetSkillId, self.config.skillLevel, 1052)
end

function bs_21263:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21263
