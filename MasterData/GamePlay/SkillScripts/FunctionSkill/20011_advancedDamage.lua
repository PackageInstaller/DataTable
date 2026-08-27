local bs_20011 = class("bs_20011", LuaSkillBase)
local base = LuaSkillBase
bs_20011.config = {buffId1 = 1110, buffId2 = 1113}

function bs_20011:ctor()
end

function bs_20011:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1)
  LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId1, 0)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
  end, 1, self.arglist[1])
end

function bs_20011:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20011
