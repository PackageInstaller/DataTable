local bs_10064 = class("bs_10064", LuaSkillBase)
local base = LuaSkillBase
bs_10064.config = {buffId = 1006}

function bs_10064:ctor()
end

function bs_10064:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetDeadHurt, "bs_10064_1", 1, self.OnSetDeadHurt)
end

function bs_10064:OnSetDeadHurt(context)
  if context.target.hp > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, true)
  end
end

function bs_10064:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10064
