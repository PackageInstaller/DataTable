local bs_10284 = class("bs_10284", LuaSkillBase)
local base = LuaSkillBase
bs_10284.config = {effectId = 10907}

function bs_10284:ctor()
end

function bs_10284:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHealTrigger("bs_10284_4", 1, self.OnSetHeal, nil, nil, nil, self.caster.belongNum)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10284_2", 2, self.OnAfterBattleStart)
end

function bs_10284:OnAfterBattleStart()
  self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
end

function bs_10284:OnSetHeal(context)
  if context.target ~= self.caster and not context.isTriggerSet and context.target.roleType == 1 then
    local dis = 1
    if dis >= LuaSkillCtrl:GetRoleGridsDistance(context.target, self.caster) then
      local healNum = context.heal * self.arglist[1] // 1000
      LuaSkillCtrl:CallHeal(healNum, self, self.caster, true)
    end
  end
end

function bs_10284:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

return bs_10284
