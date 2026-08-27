local bs_10033 = class("bs_10033", LuaSkillBase)
local base = LuaSkillBase
bs_10033.config = {buffId = 1006}

function bs_10033:ctor()
end

function bs_10033:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetDeadHurt, "bs_10033_1", 1, self.OnSetDeadHurt)
end

function bs_10033:OnSetDeadHurt(context)
  if context.target.hp > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, true)
  end
end

function bs_10033:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10033
