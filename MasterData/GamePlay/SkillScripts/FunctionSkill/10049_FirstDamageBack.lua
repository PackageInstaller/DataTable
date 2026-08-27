local bs_10049 = class("bs_10049", LuaSkillBase)
local base = LuaSkillBase
bs_10049.config = {}

function bs_10049:ctor()
end

function bs_10049:InitSkill(isMidwaySkill)
  self.caster.recordTable.SkillTime = self.arglist[1]
  self:AddSetHurtTrigger("bs_10049_1", 1, self.OnSetHurt, nil, self.caster)
end

function bs_10049:OnSetHurt(context)
  if context.target == self.caster and self.caster.recordTable.SkillTime > 0 then
    local damage = math.max(context.hurt * self.arglist[2] // 1000)
    LuaSkillCtrl:RemoveLife(damage, self, context.sender, true)
    context.hurt = 0
    LuaSkillCtrl:CallFloatText(self.caster, 8)
    self:PlayChipEffect()
    self.caster.recordTable.SkillTime = self.caster.recordTable.SkillTime - 1
  end
end

function bs_10049:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10049
