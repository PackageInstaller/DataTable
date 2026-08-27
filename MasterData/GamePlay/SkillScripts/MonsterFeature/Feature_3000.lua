local bs_3000 = class("bs_3000", LuaSkillBase)
local base = LuaSkillBase
bs_3000.config = {}

function bs_3000:ctor()
end

function bs_3000:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_3000", 1, self.OnAfterBattleStart)
end

function bs_3000:OnAfterBattleStart()
  self.caster:AddRoleProperty(eHeroAttr.moveSpeed, -self.caster.moveSpeed * 750 // 1000, eHeroAttrType.Origin)
  if self.caster.attackRange > 4 then
    self.caster:AddRoleProperty(eHeroAttr.attackRange, 4 - self.caster.attackRange, eHeroAttrType.Origin)
  end
end

function bs_3000:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_3000
