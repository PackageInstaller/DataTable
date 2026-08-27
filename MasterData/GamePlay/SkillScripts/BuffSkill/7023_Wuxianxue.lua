local bs_7023 = class("bs_7023", LuaSkillBase)
local base = LuaSkillBase
bs_7023.config = {}

function bs_7023:ctor()
end

function bs_7023:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_7023_1", 99, self.OnSetDeadHurt, nil, self.caster)
end

function bs_7023:OnSetDeadHurt(context)
  if context.hurt >= context.target.hp then
    local healNum = context.target.maxHp // 5
    LuaSkillCtrl:CallHeal(healNum, self, context.target, true)
    LuaSkillCtrl:CallHeal(healNum, self, context.target, true)
    LuaSkillCtrl:CallHeal(healNum, self, context.target, true)
    LuaSkillCtrl:CallHeal(healNum, self, context.target, true)
    LuaSkillCtrl:CallHeal(healNum, self, context.target, true)
  end
end

function bs_7023:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_7023
