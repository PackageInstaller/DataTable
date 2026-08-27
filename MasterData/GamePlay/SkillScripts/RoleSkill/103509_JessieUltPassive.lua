local bs_103509 = class("bs_103509", LuaSkillBase)
local base = LuaSkillBase
bs_103509.config = {}

function bs_103509:ctor()
end

function bs_103509:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("bs_103509_6", 1, self.OnBeforeAddBuff, nil, self.caster, nil, nil, nil, eBuffType.Debeneficial)
end

function bs_103509:OnBeforeAddBuff(target, context)
  if target == self.caster and context.buff.buffType == 2 then
    context.active = false
  end
end

function bs_103509:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103509
