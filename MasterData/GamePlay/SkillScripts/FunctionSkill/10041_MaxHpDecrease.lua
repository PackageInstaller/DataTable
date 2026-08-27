local bs_10041 = class("bs_10041", LuaSkillBase)
local base = LuaSkillBase
bs_10041.config = {buffId = 1011}

function bs_10041:ctor()
end

function bs_10041:InitSkill(isMidwaySkill)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, true)
end

function bs_10041:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10041
