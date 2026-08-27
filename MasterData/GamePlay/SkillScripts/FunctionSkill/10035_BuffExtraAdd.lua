local bs_10035 = class("bs_10035", LuaSkillBase)
local base = LuaSkillBase
bs_10035.config = {}

function bs_10035:ctor()
end

function bs_10035:InitSkill(isMidwaySkill)
  self:AddBeforeAddBuffTrigger("bs_10035_2", 1, self.OnBeforeAddBuff, self.caster, nil, nil, nil, nil, eBuffType.Debeneficial)
end

function bs_10035:OnBeforeAddBuff(target, context)
  if context.buff.buffType == 2 and context.buff.maker == self.caster and self:IsReadyToTake() and LuaSkillCtrl:CallRange(1, 100) < self.arglist[1] then
    context.buff.tier = context.buff.tier + 1
    self:PlayChipEffect()
    self:OnSkillTake()
  end
end

function bs_10035:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10035
