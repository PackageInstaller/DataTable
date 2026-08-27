local bs_10233 = class("bs_10233", LuaSkillBase)
local base = LuaSkillBase
bs_10233.config = {effectId = 10632}

function bs_10233:ctor()
end

function bs_10233:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHealTrigger("bs_10233_4", 1, self.OnSetHeal, self.caster)
end

function bs_10233:OnSetHeal(context)
  if context.sender == self.caster and self:IsReadyToTake() and context.target.maxHp - context.target.hp < context.heal then
    self:OnSkillTake()
    local exHeal = (context.heal - context.target.maxHp + context.target.hp) * self.arglist[1] // 1000
    if exHeal <= 0 then
      exHeal = context.heal
    end
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 30, 10)
    if 1 > targetlist.Count then
      return
    end
    LuaSkillCtrl:CallEffect(targetlist[0].targetRole, self.config.effectId, self, self.SkillEventFunc)
    LuaSkillCtrl:CallHeal(exHeal, self, targetlist[0].targetRole, true)
  end
end

function bs_10233:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10233
