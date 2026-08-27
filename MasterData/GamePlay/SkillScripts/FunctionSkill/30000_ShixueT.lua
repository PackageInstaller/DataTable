local bs_30000 = class("bs_30000", LuaSkillBase)
local base = LuaSkillBase
bs_30000.config = {
  effectId = 1047,
  conditionCheck = "$1>=max(GetSkillArg(1),50)/1000*@maxHp",
  damageFormula = "max(GetSkillArg(1),50)/1000*@maxHp"
}

function bs_30000:ctor()
end

function bs_30000:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_30000_1", 1, self.OnSetHurt, nil, self.caster)
  self.time = 0
end

function bs_30000:OnSetHurt(context)
  if context.target == self.caster and self:IsReadyToTake() and self.time < self.arglist[2] and LuaSkillCtrl:CallFormulaBoolWithSkill(self.config.conditionCheck, self.caster, self.caster, self, context.hurt) then
    local damageNum = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.damageFormula, self.caster, context.target, self)
    context.hurt = damageNum
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, nil)
    self:OnSkillTake()
    self.time = self.time + 1
  end
end

function bs_30000:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30000
