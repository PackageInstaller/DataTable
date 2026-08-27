local bs_4031 = class("bs_4031", LuaSkillBase)
local base = LuaSkillBase
bs_4031.config = {buffid = 40311}

function bs_4031:ctor()
end

function bs_4031:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4031_1", 1, self.OnAfterBattleStart)
end

function bs_4031:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffid, 1)
end

function bs_4031:LuaDispose()
  base.LuaDispose(self)
end

function bs_4031:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4031
