local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1025012 = class("bs_1025012", base)
bs_1025012.config = {
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0,
    crithur_ratio = 0,
    returndamage_formula = 0
  },
  buffId_CH = 10250101
}

function bs_1025012:ctor()
end

function bs_1025012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_1025012_3", 90, self.OnAfterHurt, self.caster)
  self:AddBuffDieTrigger("bs_1025012_5", 99, self.OnBuffDie, nil, eBattleRoleBelong.player, self.config.buffId_CH)
end

function bs_1025012:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and target.belongNum ~= self.caster.belongNum and isTriggerSet ~= true and (skill.dataId == 102500 or skill.dataId == 1025022) then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_CH, 1)
  end
end

function bs_1025012:OnBuffDie(buff, target, removeType)
  if target.belongNum ~= self.caster.belongNum then
    local num = buff.tier
    if 0 < num then
      local hurt = num * self.arglist[1]
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {hurt})
      skillResult:EndResult()
    end
  end
end

function bs_1025012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1025012
