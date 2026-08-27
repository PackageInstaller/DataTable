local bs_4003 = class("bs_4003", LuaSkillBase)
local base = LuaSkillBase
bs_4003.config = {}

function bs_4003:ctor()
end

function bs_4003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_4003", 1, self.OnSetHurt, self.caster)
end

function bs_4003:OnSetHurt(context)
  local distance = 0
  if context.sender == self.caster then
    distance = LuaSkillCtrl:GetGridsDistance(self.caster.x, self.caster.y, context.target.x, context.target.y) - 1
    context.hurt = context.hurt + context.hurt * distance * self.arglist[1] // 1000
  end
end

function bs_4003:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_4003:LuaDispose()
  base.LuaDispose(self)
end

return bs_4003
