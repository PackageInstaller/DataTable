local card_20008 = class("card_20008", LuaSkillBase)
local base = LuaSkillBase
card_20008.config = {}

function card_20008:ctor()
end

function card_20008:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("card_20008_2", 1, self.OnBeforeAddBuff, nil, self.caster, nil, nil, nil, eBuffType.Debeneficial)
end

function card_20008:OnBeforeAddBuff(target, context)
  if context.buff.buffType == 2 and target == self.caster then
    context.buff.tier = 0
    self:PlayChipEffect()
  end
end

function card_20008:OnCasterDie()
  base.OnCasterDie(self)
end

return card_20008
