local bs_15220 = class("bs_15220", LuaSkillBase)
local base = LuaSkillBase
bs_15220.config = {
  buffId = 205,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  },
  hurtConfig = 3,
  effectId = 12078
}

function bs_15220:ctor()
end

function bs_15220:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15220_1", 1, self.OnAfterBattleStart)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_15220_2", 1, self.OnAfterPlaySkill)
  self:AddAfterHurtTrigger("bs_15220_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack, false)
  self.flag = false
end

function bs_15220:OnAfterBattleStart()
end

function bs_15220:OnAfterPlaySkill(skill, role)
  if role == self.caster and not skill.isCommonAttack and not self.flag then
    self.flag = true
  end
end

function bs_15220:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and not isTriggerSet and skill.isCommonAttack and self.flag then
    self.flag = false
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
    if skillResult.roleList.Count > 0 then
      for i = 0, skillResult.roleList.Count - 1 do
        local targetRole = skillResult.roleList[i]
        if targetRole.belongNum == eBattleRoleBelong.enemy then
          local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult1, self.config.hurtConfig, {
            self.arglist[1]
          }, true)
          skillResult1:EndResult()
          LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, self.arglist[2], true)
        end
      end
    end
    skillResult:EndResult()
  end
end

function bs_15220:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15220
