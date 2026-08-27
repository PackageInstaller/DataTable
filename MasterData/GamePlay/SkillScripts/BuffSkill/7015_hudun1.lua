local bs_7015 = class("bs_7015", LuaSkillBase)
local base = LuaSkillBase
bs_7015.config = {buffId = 1265, buffTier = 1}

function bs_7015:ctor()
end

function bs_7015:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_7015_1", 1, self.OnSetHurt, nil, self.caster)
end

function bs_7015:OnSetHurt(context)
  if not context.isMiss then
    context.hurt = 0
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
  end
end

function bs_7015:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_7015
