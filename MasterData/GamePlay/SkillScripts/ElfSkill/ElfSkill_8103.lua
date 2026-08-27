local bs_8103 = class("bs_8103", LuaSkillBase)
local base = LuaSkillBase
bs_8103.config = {buffId = 613}

function bs_8103:ctor()
end

function bs_8103:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_8103_1", 1, self.OnAfterBattleStart)
end

function bs_8103:OnAfterBattleStart()
  if self.caster.roleType == eBattleRoleType.character then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_8103:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_8103
