local bs_100608 = class("bs_100608", LuaSkillBase)
local base = LuaSkillBase
bs_100608.config = {
  buffId_hurt = 100602,
  buffId_lz1 = 107101,
  hurt_config = 38,
  effectId = 100619
}

function bs_100608:ctor()
end

function bs_100608:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTriggerForTable("bs_100608_1", 1, self.OnAfterHurt, {
    sender = self.caster,
    senderBelongNum = self.caster.belongNum,
    targetBelongNum = eBattleRoleBelong.enemy,
    extraArg1 = eSkillTag.normalSkill,
    extraArg2 = false,
    extraArg3 = false
  })
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_100608_2", 1, self.OnAfterPlaySkill)
  self.times = 0
end

function bs_100608:OnAfterPlaySkill(skill, role)
  if skill.isNormalSkill and self.caster == role then
    self.times = self.arglist[7]
  end
end

function bs_100608:OnAfterHurt(role, target, skill, hurt)
  if skill.isNormalSkill and target.belongNum == eBattleRoleBelong.enemy and self.times > 0 then
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    if 0 < target:GetBuffTier(self.config.buffId_lz1) then
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurt_config, {
        self.arglist[6]
      }, true)
    else
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurt_config, {
        self.arglist[5]
      }, true)
    end
    skillResult:EndResult()
    self.times = self.times - 1
  end
end

function bs_100608:OnCasterDie()
  base.OnCasterDie(self)
  self.times = 0
end

return bs_100608
