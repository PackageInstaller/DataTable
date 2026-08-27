local bs_50004 = class("bs_50004", LuaSkillBase)
local base = LuaSkillBase
bs_50004.config = {buffId = 1051, effectId = 10481}

function bs_50004:ctor()
end

function bs_50004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("bs_50004_2", 1, self.OnBeforeAddBuff, nil, self.caster, nil, nil, nil, eBuffType.Debeneficial)
end

function bs_50004:OnBeforeAddBuff(target, context)
  if context.buff.buffType == 2 and target == self.caster then
    context.buff.tier = 0
  end
end

function bs_50004:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_50004
