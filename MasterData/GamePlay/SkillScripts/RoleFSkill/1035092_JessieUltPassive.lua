local bs_1035092 = class("bs_1035092", LuaSkillBase)
local base = LuaSkillBase
bs_1035092.config = {}

function bs_1035092:ctor()
end

function bs_1035092:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("bs_1035092_6", 1, self.OnBeforeAddBuff, nil, self.caster, nil, nil, nil, eBuffType.Debeneficial)
end

function bs_1035092:OnBeforeAddBuff(target, context)
  if target == self.caster and context.buff.buffType == 2 then
    context.active = false
  end
end

function bs_1035092:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1035092
