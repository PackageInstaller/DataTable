local bs_215003 = class("bs_215003", LuaSkillBase)
local base = LuaSkillBase
bs_215003.config = {
  heal_config = 7,
  buffId = 215001,
  actionId = 1060,
  action_speed = 1,
  skilltime = 35
}

function bs_215003:ctor()
end

function bs_215003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.P2 = false
  self:AddLuaTrigger(eSkillLuaTrigger.OnEosPassive01, self.OnEosPassive01)
end

function bs_215003:OnEosPassive01()
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId, self.config.action_speed)
  LuaSkillCtrl:StartTimer(nil, 24, function()
    self.caster.recordTable.P2 = true
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResultWithConfig(self, skillResult, self.config.heal_config, {1000}, true, true)
    skillResult:EndResult()
  end, nil)
end

function bs_215003:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_215003
