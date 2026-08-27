local bs_20233 = class("bs_20233", LuaSkillBase)
local base = LuaSkillBase
bs_20233.config = {}

function bs_20233:ctor()
end

function bs_20233:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnDetonatorCastSkill, self.DetonatorCastSkill)
end

function bs_20233:DetonatorCastSkill(role, target, damage)
  if role == self.caster then
    LuaSkillCtrl:RemoveLife(damage, self, target, true, nil, true, false, eHurtType.RealDmg)
  end
end

function bs_20233:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20233
