local bs_10342 = class("bs_10342", LuaSkillBase)
local base = LuaSkillBase
bs_10342.config = {buffId = 1290, buffTier = 1}

function bs_10342:ctor()
end

function bs_10342:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10342_1", 1, self.OnAfterBattleStart)
end

function bs_10342:OnAfterBattleStart()
  local hurtNum = self.caster.hp * self.arglist[1] // 1000
  LuaSkillCtrl:RemoveLife(hurtNum, self, self.caster, true, nil, true, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
end

function bs_10342:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10342
