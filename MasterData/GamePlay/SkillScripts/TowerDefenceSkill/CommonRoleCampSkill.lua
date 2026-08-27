local CommonRoleCampSkill = class("CommonRoleCampSkill", LuaSkillBase)
local base = LuaSkillBase
CommonRoleCampSkill.config = {}

function CommonRoleCampSkill:OnCasterDie()
  base.OnCasterDie(self)
  LuaSkillCtrl:ForceEndBattle(false)
end

return CommonRoleCampSkill
