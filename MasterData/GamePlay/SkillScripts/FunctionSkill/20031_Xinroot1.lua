local bs_20031 = class("bs_20031", LuaSkillBase)
local base = LuaSkillBase
bs_20031.config = {buffId = 1138, buffTier = 1}

function bs_20031:ctor()
end

function bs_20031:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if self.caster.roleDataId ~= 30000 then
    return
  end
  self:AddSetHurtTrigger("bs_20031_2", 1, self.OnSetHurt, self.caster)
end

function bs_20031:OnSetHurt(context)
  if context.sender == self.caster and context.skill.dataId == 300002 then
    LuaSkillCtrl:CallHeal(context.hurt, self, self.caster)
  end
end

function bs_20031:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20031
