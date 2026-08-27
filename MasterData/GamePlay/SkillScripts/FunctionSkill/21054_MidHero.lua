local bs_21054 = class("bs_21054", LuaSkillBase)
local base = LuaSkillBase
bs_21054.config = {buffUpId = 110026, buffDownId = 110027}

function bs_21054:ctor()
end

function bs_21054:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21054_1", 1, self.OnAfterBattleStart)
end

function bs_21054:OnAfterBattleStart()
  if self.caster.y == 2 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffUpId, 1, nil)
  else
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffDownId, 1, nil)
  end
end

function bs_21054:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21054
