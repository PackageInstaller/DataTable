local bs_10083 = class("bs_10083", LuaSkillBase)
local base = LuaSkillBase
bs_10083.config = {}

function bs_10083:ctor()
end

function bs_10083:InitSkill(isMidwaySkill)
  self.caster.recordTable.buffTime = self.arglist[1]
  self:AddBeforeAddBuffTrigger("bs_10083_2", 1, self.OnBeforeAddBuff, nil, self.caster, nil, nil, nil, eBuffType.Debeneficial)
end

function bs_10083:OnBeforeAddBuff(target, context)
  if context.buff.buffType == 2 and target == self.caster and self.caster.recordTable.buffTime > 0 then
    context.buff.tier = 0
    self:PlayChipEffect()
    self.caster.recordTable.buffTime = self.caster.recordTable.buffTime - 1
  end
end

function bs_10083:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10083
