local bs_40007 = class("bs_40007", LuaSkillBase)
local base = LuaSkillBase
bs_40007.config = {hurtformula = 10093}

function bs_40007:ctor()
end

function bs_40007:InitSkill(isMidwaySkill)
  self:AddSetHurtTrigger("bs_40007_2", 2, self.OnSetHurt, self.caster)
end

function bs_40007:OnSetHurt(context)
  if context.sender == self.caster and not context.isCrit then
    local num = (context.target.maxHp - context.target.hp) * 1000 // context.target.maxHp
    local crit_num = num // self.arglist[1] * self.arglist[2]
    local crit_real = crit_num * 1000 // (1000 - self.caster.crit)
    if crit_real >= LuaSkillCtrl:CallRange(1, 1000) then
      context.isCrit = true
      context.hurt = context.hurt * (1000 + self.caster.critDamage) // 1000
      return
    end
  end
end

function bs_40007:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_40007
