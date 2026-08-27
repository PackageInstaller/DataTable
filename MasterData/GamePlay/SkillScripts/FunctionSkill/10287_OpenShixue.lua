local bs_10287 = class("bs_10287", LuaSkillBase)
local base = LuaSkillBase
bs_10287.config = {buffId_shixue = 257}

function bs_10287:ctor()
end

function bs_10287:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10287_2", 2, self.OnAfterBattleStart)
end

function bs_10287:OnAfterBattleStart()
  self:PlayChipEffect()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_shixue, self.arglist[1])
end

function bs_10287:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10287
