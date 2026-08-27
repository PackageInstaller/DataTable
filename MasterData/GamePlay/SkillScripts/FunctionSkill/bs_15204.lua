local bs_15204 = class("bs_15204", LuaSkillBase)
local base = LuaSkillBase
bs_15204.config = {buffId = 110103}

function bs_15204:ctor()
end

function bs_15204:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15204_1", 1, self.OnAfterBattleStart)
end

function bs_15204:OnAfterBattleStart()
  if self.caster.hp > 0 then
    local value = self.caster.hp * self.arglist[1] // 1000
    LuaSkillCtrl:RemoveLife(value, self, self.caster, true, nil, true, true, eHurtType.RealDmg)
    value = value * self.arglist[2] // 1000
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, value, nil, true)
  end
end

function bs_15204:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15204
