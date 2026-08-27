local bs_10141 = class("bs_10141", LuaSkillBase)
local base = LuaSkillBase
bs_10141.config = {
  damageFormula = 10040,
  buffId = 1026,
  buffId2 = 1131
}

function bs_10141:ctor()
end

function bs_10141:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10141_3", 1, self.OnAfterHurt, nil, self.caster)
  self.caster.recordTable["10141_TotalDamage"] = 0
end

function bs_10141:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and hurt ~= 0 then
    self.caster.recordTable["10141_TotalDamage"] = self.caster.recordTable["10141_TotalDamage"] + hurt
    local num = self.caster.recordTable["10141_TotalDamage"]
    local damagerRate = LuaSkillCtrl:CallFormulaNumberWithSkill(10040, self.caster, self.caster, self, num)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, damagerRate, nil, true)
    self:PlayChipEffect()
  end
end

function bs_10141:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10141
