local bs_10075 = class("bs_10075", LuaSkillBase)
local base = LuaSkillBase
bs_10075.config = {buffId = 1011}

function bs_10075:ctor()
end

function bs_10075:InitSkill(isMidwaySkill)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, true)
end

function bs_10075:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10075
