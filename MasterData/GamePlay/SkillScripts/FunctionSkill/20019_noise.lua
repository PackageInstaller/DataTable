local bs_20019 = class("bs_20019", LuaSkillBase)
local base = LuaSkillBase
bs_20019.config = {}

function bs_20019:ctor()
end

function bs_20019:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("bs_20019_6", 1, self.OnBeforeAddBuff, nil, self.caster, nil, nil, nil, eBuffType.Debeneficial)
end

function bs_20019:OnBeforeAddBuff(target, context)
  if target == self.caster and context.buff.buffType == 2 and LuaSkillCtrl:CallRange(1, 1000) < self.arglist[1] and self:IsReadyToTake() then
    self:PlayChipEffect()
    context.active = false
  end
end

function bs_20019:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20019
