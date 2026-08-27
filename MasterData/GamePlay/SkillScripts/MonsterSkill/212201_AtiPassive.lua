local bs_212201 = class("bs_212201", LuaSkillBase)
local base = LuaSkillBase
bs_212201.config = {
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0
  },
  actionId = 1002,
  action_speed = 1,
  aoe_config = {
    effect_shape = eSkillResultShapeType.Target,
    aoe_select_code = 4,
    aoe_range = 1
  }
}

function bs_212201:ctor()
end

function bs_212201:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_212201_1", 1, self.OnSetHurt, self.caster)
  self.caster.recordTable.arglist1 = self.arglist[1]
end

function bs_212201:OnSetHurt(context)
  local distance = 0
  if context.sender == self.caster then
    distance = LuaSkillCtrl:GetGridsDistance(self.caster.x, self.caster.y, context.target.x, context.target.y)
    context.hurt = context.hurt + context.hurt * distance * self.arglist[1] // 1000
  end
end

function bs_212201:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_212201:LuaDispose()
  base.LuaDispose(self)
end

return bs_212201
