local bs_4010407 = class("bs_4010407", LuaSkillBase)
local base = LuaSkillBase
bs_4010407.config = {buffId = 110069}

function bs_4010407:ctor()
end

function bs_4010407:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_4010407_1", 1, self.OnAfterBattleStart)
end

function bs_4010407:OnAfterBattleStart()
  if self.caster.belongNum == eBattleRoleBelong.player and self.caster ~= nil then
    local buffTier = self.caster.maxHp // self.arglist[1]
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, buffTier, nil)
  end
end

function bs_4010407:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010407
