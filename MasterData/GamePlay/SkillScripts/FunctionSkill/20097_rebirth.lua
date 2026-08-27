local bs_20097 = class("bs_20097", LuaSkillBase)
local base = LuaSkillBase
bs_20097.config = {}

function bs_20097:ctor()
end

function bs_20097:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_20097_2", 1, self.OnSetHurt)
end

function bs_20097:OnSetHurt(context)
  if context.target == self.caster then
    local Hp = self.caster.hp
    local maxHp = self.caster.maxHp
    local resist = 700 * (maxHp - Hp) // maxHp
    context.hurt = context.hurt * (1000 - resist) // 1000
    if context.hurt >= self.caster.hp then
      context.hurt = self.caster.hp - 1
    end
  end
end

function bs_20097:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20097
