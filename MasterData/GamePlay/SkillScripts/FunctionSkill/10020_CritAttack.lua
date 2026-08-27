local bs_10020 = class("bs_10020", LuaSkillBase)
local base = LuaSkillBase
bs_10020.config = {buffId = 64, buffTier = 1}

function bs_10020:ctor()
end

function bs_10020:InitSkill(isMidwaySkill)
end

function bs_10020:PlaySkill()
  self:PlayChipEffect()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, self.arglist[1])
end

function bs_10020:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10020
