local bs_10268 = class("bs_10268", LuaSkillBase)
local base = LuaSkillBase
bs_10268.config = {splitShootBuff = 1180}

function bs_10268:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10268_start", 1, self.OnAfterBattleStart)
end

function bs_10268:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.splitShootBuff, 1, nil, true)
end

function bs_10268:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10268
