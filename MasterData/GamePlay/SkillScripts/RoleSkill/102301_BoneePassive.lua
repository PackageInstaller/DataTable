local bs_102301 = class("bs_102301", LuaSkillBase)
local base = LuaSkillBase
bs_102301.config = {audioId1 = 238}

function bs_102301:ctor()
end

function bs_102301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_102301_1", 1, self.OnAfterBattleStart)
  self:AddSetHealTrigger("bs_102301_4", 1, self.OnSetHeal, nil, self.caster)
end

function bs_102301:OnAfterBattleStart()
  local shieldValue = self.caster.skill_intensity * self.arglist[1] // 1000
  if 0 < shieldValue then
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  end
end

function bs_102301:OnSetHeal(context)
  if context.target == self.caster and context.isTriggerSet ~= true then
    local shieldValue_heal = context.heal * self.arglist[2] // 1000
    if 0 < shieldValue_heal then
      LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue_heal)
    end
  end
end

function bs_102301:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102301
