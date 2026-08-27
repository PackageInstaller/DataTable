local bs_10060 = class("bs_10060", LuaSkillBase)
local base = LuaSkillBase
bs_10060.config = {healEffectId = 1005, healNumFormula = 10007}

function bs_10060:ctor()
end

function bs_10060:InitSkill(isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_10060_2", 1, self.OnAfterAddBuff, self.caster, nil, nil, nil, nil, eBuffType.Debeneficial)
end

function bs_10060:OnAfterAddBuff(buff, target, isOverlay)
  if buff.buffType == 2 and isOverlay and buff.maker == self.caster then
    local healNum = math.max(LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.healNumFormula, self.caster, target, self), 1)
    self:PlayChipEffect()
    LuaSkillCtrl:CallHeal(healNum, self, self.caster, true)
    LuaSkillCtrl:CallEffect(self.caster, self.config.healEffectId, self)
  end
end

function bs_10060:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10060
