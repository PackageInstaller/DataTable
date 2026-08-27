local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1001012 = class("bs_1001012", base)
bs_1001012.config = {
  effectId_line = 100103,
  effectId_PassHit = 100104,
  buffId_live = 300901,
  nanaka_buffId = 10260301,
  heal_config = {baseheal_formula = 3021},
  selectId = 20,
  selectRange = 10
}

function bs_1001012:ctor()
end

function bs_1001012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_1001012_1", 99, self.OnSetDeadHurt, nil, nil, nil, self.caster.belongNum, nil, 1)
end

function bs_1001012:OnSetDeadHurt(context)
  if self:IsReadyToTake() and context.target.belongNum == self.caster.belongNum and context.target.roleType == 1 and context.target ~= context.sender and context.target:GetBuffTier(self.config.nanaka_buffId) <= 0 then
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_live, 1, 1, true)
    LuaSkillCtrl:CallEffect(context.target, self.config.effectId_line, self)
    LuaSkillCtrl:CallEffect(context.target, self.config.effectId_PassHit, self)
    LuaSkillCtrl:StartTimer(nil, 1, function()
      if context.target == nil or context.target.hp <= 0 then
        return
      end
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target)
      LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
        self.arglist[1]
      }, false, false)
      skillResult:EndResult()
    end)
    self:OnSkillTake()
  end
end

function bs_1001012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1001012
