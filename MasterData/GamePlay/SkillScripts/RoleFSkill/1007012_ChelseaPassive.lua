local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1007012 = class("bs_1007012", base)
bs_1007012.config = {
  hurtConfigId = 2,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0,
    crithur_ratio = 0
  }
}

function bs_1007012:ctor()
end

function bs_1007012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_1007012_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, 100700)
end

function bs_1007012:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.dataId == 100700 then
    local targets = self:GetBehindTargetsPos(2, self.caster.x, self.caster.y, target.x, target.y)
    local targetNext
    if targets ~= nil and 2 <= table.length(targets) and targets[2].belongNum ~= self.caster.belongNum then
      targetNext = targets[2]
    end
    if targetNext ~= nil then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetNext)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
        self.arglist[1]
      })
      skillResult:EndResult()
    end
  end
end

function bs_1007012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1007012
