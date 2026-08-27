local bs_25255 = class("bs_25255", LuaSkillBase)
local base = LuaSkillBase
bs_25255.config = {buffId = 2073}

function bs_25255:ctor()
end

function bs_25255:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_25255_1", 900, self.OnSetDeadHurt, self.caster)
end

function bs_25255:OnSetDeadHurt(context)
  if context.sender ~= self.caster then
    return
  end
  if context.skill.skillTag ~= eSkillTag.ultSkill then
    return
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, false)
end

function bs_25255:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25255
