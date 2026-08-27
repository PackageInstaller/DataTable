local bs_30051 = class("bs_30051", LuaSkillBase)
local base = LuaSkillBase
bs_30051.config = {
  checkBuffId = 1228,
  fuyuBuffId = 1088,
  buffDuration = 90
}

function bs_30051:ctor()
end

function bs_30051:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBuffDieTrigger("bs_30051_1", 1, self.OnBuffDie, nil, nil, self.config.checkBuffId)
end

function bs_30051:OnBuffDie(buff, target, removeType)
  if target == self.caster then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.fuyuBuffId, self.arglist[1], self.config.buffDuration)
  end
end

function bs_30051:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30051
