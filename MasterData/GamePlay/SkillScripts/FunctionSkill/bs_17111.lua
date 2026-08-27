local bs_17111 = class("bs_17111", LuaSkillBase)
local base = LuaSkillBase
bs_17111.config = {}

function bs_17111:ctor()
end

function bs_17111:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_17111_1", 1, self.OnSetHurt, self.caster)
end

function bs_17111:OnSetHurt(context)
  local last_target = self.caster.recordTable.lastAttackRole
  if context.target ~= last_target and last_target ~= nil then
    context.hurt = context.hurt + context.hurt * self.arglist[1] // 1000
  end
end

function bs_17111:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17111
