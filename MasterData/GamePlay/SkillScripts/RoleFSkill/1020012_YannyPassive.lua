local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1020012 = class("bs_1020012", base)
bs_1020012.config = {buffId = 10200101, healBuffId = 10200201}

function bs_1020012:ctor()
end

function bs_1020012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_1020012_1", 1, self.OnAfterBattleStart)
  self:AddSetHealTrigger("bs_1020012_2", 99, self.OnSetHeal, nil, self.caster)
end

function bs_1020012:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_1020012:OnSetHeal(context)
  if context.target == self.caster and context.isTriggerSet ~= true then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.healBuffId, 1, self.arglist[3])
  end
end

function bs_1020012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1020012
