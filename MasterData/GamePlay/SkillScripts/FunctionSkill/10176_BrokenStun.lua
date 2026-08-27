local bs_10176 = class("bs_10176", LuaSkillBase)
local base = LuaSkillBase
bs_10176.config = {
  buffId = 66,
  buffTier = 1,
  buffId1 = 1054
}

function bs_10176:ctor()
end

function bs_10176:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_10176_22", 1, self.OnBreakShield)
end

function bs_10176:OnBreakShield(shieldType, sender, target)
  if target.belongNum ~= self.caster.belongNum then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.config.buffTier, self.arglist[1])
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId1, self.arglist[2], self.arglist[1], true)
  end
end

function bs_10176:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10176
