local bs_7011 = class("bs_7011", LuaSkillBase)
local base = LuaSkillBase
bs_7011.config = {}

function bs_7011:ctor()
end

function bs_7011:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnSelfAfterMove, "bs_7011_OnSelfAfterMove", 1, self.OnSelfAfterMove)
end

function bs_7011:OnSelfAfterMove()
  if self.caster.intensity < 3 then
    local damage = self.caster.hp * self.caster.recordTable["15063_damagePer"] // 1000
    LuaSkillCtrl:RemoveLife(damage, self, self.caster, true)
  end
end

function bs_7011:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_7011
