local bs_15218 = class("bs_15218", LuaSkillBase)
local base = LuaSkillBase
bs_15218.config = {
  freezeBuff = 1178,
  freezeBuffDuration = 75,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  hurtConfig = 3
}

function bs_15218:ctor()
end

function bs_15218:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_15218_2", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self:AddAfterAddBuffTrigger("bs_15218_3", 1, self.OnAfterAddBuff, self.caster, nil, nil, nil, self.config.freezeBuff)
  self.time = 0
  self.hurtArgs = {
    self.arglist[2]
  }
end

function bs_15218:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if self.time == 0 and target.belongNum == eBattleRoleBelong.enemy and not isMiss and not isTriggerSet and skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, target, self.config.freezeBuff, 1, self.config.freezeBuffDuration)
    self.time = 1
    self:RemoveSkillTrigger(eSkillTriggerType.AfterHurt)
  end
end

function bs_15218:OnAfterAddBuff(buff, target)
  if target.belongNum == eBattleRoleBelong.enemy then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, self.hurtArgs, true)
    skillResult:EndResult()
  end
end

function bs_15218:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15218
