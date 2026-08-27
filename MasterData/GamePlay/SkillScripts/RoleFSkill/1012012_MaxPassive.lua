local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1012012 = class("bs_1012012", base)
bs_1012012.config = {
  effectId_loop = 101204,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  HurtConfig = {
    hit_formula = 0,
    def_formula = 0,
    basehurt_formula = 3011,
    crit_formula = 0,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0
  }
}

function bs_1012012:ctor()
end

function bs_1012012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_1012012_2", 1, self.OnAfterHurt, self.caster)
end

function bs_1012012:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and not isMiss then
    local effectId_loop = LuaSkillCtrl:CallEffect(target, self.config.effectId_loop, self)
    LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
        self.arglist[2]
      }, true)
      skillResult:EndResult()
      if effectId_loop ~= nil then
        effectId_loop:Die()
        effectId_loop = nil
      end
    end, effectId_loop)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
    if skillResult.roleList.Count ~= 0 then
      for i = 0, self.arglist[4] - 1 do
        if skillResult.roleList[i] ~= nil then
          local role = skillResult.roleList[i]
          local effectLoop = LuaSkillCtrl:CallEffect(role, self.config.effectId_loop, self)
          LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
            LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
              self.arglist[2]
            }, true)
            skillResult:EndResult()
            if effectLoop ~= nil then
              effectLoop:Die()
              effectLoop = nil
            end
          end, effectLoop)
        end
      end
    end
    skillResult:EndResult()
  end
end

function bs_1012012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1012012
