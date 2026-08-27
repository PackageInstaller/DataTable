local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1039012 = class("bs_1039012", base)
bs_1039012.config = {
  buffId_back = 15101,
  buffId_dizzy = 6601,
  effectId_high = 103904,
  audioId1 = 103901,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0,
    returndamage_formula = 0
  },
  Aoe = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  }
}

function bs_1039012:ctor()
end

function bs_1039012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_1039012_3", 1, self.OnAfterHurt, self.caster)
  self.attackNum = 0
end

function bs_1039012:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and self:IsReadyToTake() then
    LuaSkillCtrl:CallEffect(target, self.config.effectId_high, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.Aoe)
    for i = 0, skillResult.roleList.Count - 1 do
      LuaSkillCtrl:CallBuff(self, skillResult.roleList[i], self.config.buffId_dizzy, 1, self.arglist[2])
    end
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.arglist[1]
    })
    skillResult:EndResult()
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
    self:OnSkillTake()
  end
end

function bs_1039012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1039012
