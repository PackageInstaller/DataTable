local bs_202601 = class("bs_202601", LuaSkillBase)
local base = LuaSkillBase
bs_202601.config = {}

function bs_202601:ctor()
end

function bs_202601:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable["521_Roll"] = self.arglist[1]
  self.caster.recordTable["521_arg2"] = self.arglist[2]
end

function bs_202601:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_202601
