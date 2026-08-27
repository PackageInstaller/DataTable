local bs_20047 = class("bs_20047", LuaSkillBase)
local base = LuaSkillBase
bs_20047.config = {
  buffId1 = 164,
  buffId2 = 256,
  skillDelay = 60
}

function bs_20047:ctor()
end

function bs_20047:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if self.caster.roleDataId ~= 30003 and self.caster.roleDataId ~= 300030 then
    return
  end
  self.caster.recordTable["20047_root2arg1"] = self.arglist[1]
end

function bs_20047:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20047
