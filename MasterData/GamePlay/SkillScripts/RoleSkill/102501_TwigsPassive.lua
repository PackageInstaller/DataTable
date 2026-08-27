local bs_102501 = class("bs_102501", LuaSkillBase)
local base = LuaSkillBase
bs_102501.config = {
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0,
    crithur_ratio = 0,
    returndamage_formula = 0
  },
  buffId_CH = 102501,
  weaponLv = 0,
  effectId_skill = 102516
}

function bs_102501:ctor()
end

function bs_102501:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_102501_3", 90, self.OnAfterHurt, self.caster)
  self:AddBuffDieTrigger("bs_102501_5", 99, self.OnBuffDie, nil, 2, self.config.buffId_CH)
  self.caster.recordTable["102501_weaponLv"] = self.config.weaponLv
end

function bs_102501:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and target.belongNum ~= self.caster.belongNum and isTriggerSet ~= true then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_CH, 1)
  end
end

function bs_102501:OnBuffDie(buff, target, removeType)
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

function bs_102501:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102501
