local bs_20227 = class("bs_20227", LuaSkillBase)
local base = LuaSkillBase
bs_20227.config = {}

function bs_20227:ctor()
end

function bs_20227:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_20227_3", 1, self.OnAfterHurt, self.caster)
end

function bs_20227:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if skill.isCommonAttack and not isTriggerSet then
    local sheildNum = LuaSkillCtrl:GetRoleAllShield(self.caster) * self.arglist[1] // 1000
    if 0 < sheildNum then
      LuaSkillCtrl:RemoveLife(sheildNum, self, target, true, nil, true, false, eHurtType.RealDmg)
    end
  end
end

function bs_20227:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20227
