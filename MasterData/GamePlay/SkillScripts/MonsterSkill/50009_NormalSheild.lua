local bs_50009 = class("bs_50009", LuaSkillBase)
local base = LuaSkillBase
bs_50009.config = {
  buffId = 1076,
  reBuffId = 1049,
  sheildBuffId = 174,
  effectId = 10616,
  shieldKey = "50009_HuDun"
}

function bs_50009:ctor()
end

function bs_50009:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_50009_1", 1, self.OnSetHurt, nil, self.caster)
end

function bs_50009:OnSetHurt(context)
end

function bs_50009:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_50009
