local bs_30020 = class("bs_30020", LuaSkillBase)
local base = LuaSkillBase
bs_30020.config = {}

function bs_30020:ctor()
end

function bs_30020:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHealTrigger("bs_30020_4", 1, self.OnSetHeal, nil, nil, nil, self.caster.belongNum)
end

function bs_30020:OnSetHeal(context)
  if context.target ~= self.caster and not context.isTriggerSet then
    local healNum = context.heal * self.arglist[1] // 1000
    LuaSkillCtrl:CallHeal(healNum, self, self.caster, true)
  end
end

function bs_30020:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30020
