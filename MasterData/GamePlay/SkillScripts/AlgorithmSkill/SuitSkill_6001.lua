local bs_6001 = class("bs_6001", LuaSkillBase)
local base = LuaSkillBase
bs_6001.config = {buffId_1151 = 1151}

function bs_6001:ctor()
end

function bs_6001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHealTrigger("bs_6001_4", 1, self.OnSetHeal, self.caster)
end

function bs_6001:OnSetHeal(context)
  if context.sender == self.caster then
    local targetRole = context.target
    local time = self.arglist[2]
    LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId_1151, 1, time, true)
  end
end

function bs_6001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6001
