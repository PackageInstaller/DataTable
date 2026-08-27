local bs_10261 = class("bs_10261", LuaSkillBase)
local base = LuaSkillBase
bs_10261.config = {damageIncreaseFmId = 10161}

function bs_10261:ctor()
end

function bs_10261:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_1026_ob_damage", 99, self.OnSetHurt, self.caster)
end

function bs_10261:OnSetHurt(context)
  if context.target.hp <= 0 then
    return
  end
  if context.target.hp < context.target.maxHp then
    local fHurt = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.damageIncreaseFmId, self.caster, context.target, self, context.hurt)
    context.hurt = fHurt
  end
end

function bs_10261:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10261
