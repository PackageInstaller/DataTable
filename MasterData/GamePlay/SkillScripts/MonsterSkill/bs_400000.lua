local bs_400000 = class("bs_400000", LuaSkillBase)
local base = LuaSkillBase
bs_400000.config = {}

function bs_400000:ctor()
end

function bs_400000:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_400000_13", 1, self.OnAfterPlaySkill)
end

function bs_400000:OnAfterPlaySkill(skill, role)
end

function bs_400000:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_400000
