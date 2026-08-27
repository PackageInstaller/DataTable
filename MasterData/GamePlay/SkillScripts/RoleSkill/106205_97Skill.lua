local bs_106202 = require("GamePlay.SkillScripts.RoleSkill.106202_97Skill")
local bs_106205 = class("bs_106205", bs_106202)
local base = bs_106202
bs_106205.config = {weaponLv = 2, effect_hit_1 = 106227}
bs_106205.config = setmetatable(bs_106205.config, {
  __index = base.config
})

function bs_106205:ctor()
end

function bs_106205:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_106205:OnAttackTrigger(target)
  if target:GetBuffTier(self.config.buffId1) >= 4 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
      self.arglist[3]
    })
    skillResult:EndResult()
  else
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
      self.arglist[1]
    })
    skillResult:EndResult()
  end
  self:OnSkillDamageEnd()
  self.caster.recordTable.IsInSkill1 = false
  LuaSkillCtrl:StartTimer(self, 7, function()
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
      self.arglist[4]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(target, self.config.effect_hit_1, self)
  end)
end

function bs_106205:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106205
