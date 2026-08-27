local bs_20048 = class("bs_20048", LuaSkillBase)
local base = LuaSkillBase
bs_20048.config = {}

function bs_20048:ctor()
end

function bs_20048:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if self.caster.roleDataId ~= 30004 and self.caster.roleDataId ~= 300040 then
    return
  end
  self.caster.recordTable["20048_root1arg1"] = self.arglist[1]
end

function bs_20048:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20048
