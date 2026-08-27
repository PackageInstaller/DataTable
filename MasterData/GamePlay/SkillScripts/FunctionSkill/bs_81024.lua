local bs_81024 = class("bs_81024", LuaSkillBase)
local base = LuaSkillBase
bs_81024.config = {buffId = 110130}

function bs_81024:ctor()
end

function bs_81024:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_81024_4", 1, self.OnAfterBattleStart)
end

function bs_81024:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil)
end

function bs_81024:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_81024
