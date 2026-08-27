local bs_10050 = class("bs_10050", LuaSkillBase)
local base = LuaSkillBase
bs_10050.config = {}

function bs_10050:ctor()
end

function bs_10050:InitSkill(isMidwaySkill)
  self.caster.recordTable.buffTime = self.arglist[1]
  self:AddBeforeAddBuffTrigger("bs_10050_2", 1, self.OnBeforeAddBuff, nil, self.caster, nil, nil, nil, eBuffType.Debeneficial)
end

function bs_10050:OnBeforeAddBuff(target, context)
  if context.buff.buffType == 2 and target == self.caster and self.caster.recordTable.buffTime > 0 then
    context.buff.tier = 0
    self:PlayChipEffect()
    self.caster.recordTable.buffTime = self.caster.recordTable.buffTime - 1
  end
end

function bs_10050:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10050
