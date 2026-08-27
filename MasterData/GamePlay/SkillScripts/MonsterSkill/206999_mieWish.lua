local bs_206999 = class("bs_206999", LuaSkillBase)
local base = LuaSkillBase
bs_206999.config = {buffId = 206901}

function bs_206999:ctor()
end

function bs_206999:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_206999_1", 1, self.OnAfterBattleStart)
end

function bs_206999:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1)
end

function bs_206999:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_206999
