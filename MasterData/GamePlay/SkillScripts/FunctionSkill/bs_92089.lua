local bs_92089 = class("bs_92089", LuaSkillBase)
local base = LuaSkillBase
bs_92089.config = {}

function bs_92089:ctor()
end

function bs_92089:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnSelfAfterMove, "bs_92089_1", 1, self.OnAfterMove)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
  self:AddSetHurtTrigger("bs_92089_2", 20, self.OnSetHurt, self.caster)
  self.PowerHit = 0
end

function bs_92089:OnAfterMove()
  if self.PowerHit < 1 then
    self.PowerHit = self.arglist[1]
  end
end

function bs_92089:OnRoleSplash(role, grid)
  if role == self.caster and self.PowerHit < 1 then
    self.PowerHit = self.arglist[1]
  end
end

function bs_92089:OnSetHurt(context)
  if self.PowerHit >= 1 then
    context.hurt = context.hurt + context.hurt * self.arglist[2] // 1000
    self.PowerHit = self.PowerHit - 1
  end
end

function bs_92089:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92089
