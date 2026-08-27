local bs_537 = class("bs_537", LuaSkillBase)
local base = LuaSkillBase
bs_537.config = {
  aoe = {
    effect_shape = 3,
    aoe_select_code = 2,
    aoe_range = 1
  },
  HealConfig = {baseheal_formula = 10122},
  effectId_target = 10773
}

function bs_537:ctor()
end

function bs_537:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_target, self)
  self:AddSetHurtTrigger("bs_537_1", 99, self.OnSetHurt, nil, self.caster)
  self.over_time = true
  local arg1 = self.caster.recordTable.arg_1
  local arg2 = self.caster.recordTable.arg_2
  local time = self.caster.recordTable.time
  local heal = BindCallback(self, self.Onheal, arg1, arg2)
  LuaSkillCtrl:StartTimer(self, 15, heal, self, -1)
  local over = BindCallback(self, self.Onover)
  LuaSkillCtrl:StartTimer(self, time, over)
end

function bs_537:Onheal(arg1, arg2)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 34, 0)
  if 0 < targetList.Count then
    for i = 0, targetList.Count - 1 do
      local target = targetList[i].targetRole
      if target.name ~= "仁慈-召唤" then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HealResult(skillResult, self.config.HealConfig, {arg1, arg2})
        skillResult:EndResult()
      end
    end
  end
end

function bs_537:Onover()
  if self.caster.hp > 0 then
    self.over_time = false
    LuaSkillCtrl:RemoveLife(self.caster.hp + 10000, self, self.caster, false, nil, false, true, eHurtType.RealDmg)
  end
end

function bs_537:OnSetHurt(context)
  if context.target == self.caster and context.hurt > 0 and self.over_time == true then
    context.hurt = 100
  end
end

function bs_537:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_537
