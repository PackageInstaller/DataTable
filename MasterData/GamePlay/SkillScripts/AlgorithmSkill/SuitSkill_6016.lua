local bs_6016 = class("bs_6016", LuaSkillBase)
local base = LuaSkillBase
bs_6016.config = {}

function bs_6016:ctor()
end

function bs_6016:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_6016_3", 1, self.OnSetHurt, self.caster)
end

function bs_6016:OnSetHurt(context)
  if context.hurt <= 0 then
    return
  end
  if context.target.maxHp > context.sender.maxHp and context.sender == self.caster and not context.isTriggerSet and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target)
    local hurt = LuaSkillCtrl:CallFormulaNumber("ceil((#maxHp/@maxHp*3/100+6/100)*$1)-1", self.caster, context.target, context.hurt)
    local hurt2 = LuaSkillCtrl:CallFormulaNumber("ceil(20*$1/100)-1", self.caster, context.target, context.hurt)
    if hurt > hurt2 then
      hurt = hurt2
    end
    if context.hurt_type == eHurtType.PhysicsDmg then
      LuaSkillCtrl:RemoveLife(hurt, self, context.target, true, nil, true, nil, 0)
    end
    if context.hurt_type == eHurtType.MagicDmg then
      LuaSkillCtrl:RemoveLife(hurt, self, context.target, true, nil, true, nil, 1)
    end
  end
end

function bs_6016:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6016
