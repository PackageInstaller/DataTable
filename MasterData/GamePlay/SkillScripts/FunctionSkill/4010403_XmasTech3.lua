local bs_4010403 = class("bs_4010403", LuaSkillBase)
local base = LuaSkillBase
bs_4010403.config = {}

function bs_4010403:ctor()
end

function bs_4010403:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_4010403_1", 1, self.OnAfterBattleStart)
end

function bs_4010403:OnAfterBattleStart()
  if self.caster ~= nil then
    local value = self.caster.maxHp * self.arglist[1] // 1000
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, value)
  end
end

function bs_4010403:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010403
