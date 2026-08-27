local bs_20035 = class("bs_20035", LuaSkillBase)
local base = LuaSkillBase
bs_20035.config = {}

function bs_20035:ctor()
end

function bs_20035:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if self.caster.roleDataId ~= 30001 and self.caster.roleDataId ~= 30002 and self.caster.roleDataId ~= 300010 then
    return
  end
  self.caster.recordTable["20035_root1arg"] = self.arglist[1]
end

function bs_20035:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20035
