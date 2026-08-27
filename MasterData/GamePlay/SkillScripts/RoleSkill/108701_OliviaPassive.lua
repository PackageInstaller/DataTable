local bs_108701 = class("bs_108701", LuaSkillBase)
local base = LuaSkillBase
bs_108701.config = {
  hurtConfig = 25,
  extra_skill = 108707,
  buff_1 = 108701,
  buff_2 = 108702
}

function bs_108701:ctor()
end

function bs_108701:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_108701_01", 1, self.OnAfterBattleStart)
  LuaSkillCtrl:AddExtraAddSkill(self.config.extra_skill, self.level)
  self:AddAfterHurtTriggerForTable("bs_108701_02", 1, self.OnAfterHurt, {
    sender = self.caster,
    targetBelongNum = eBattleRoleBelong.enemy,
    extraArg2 = false
  })
  local skillCasterEntity = LuaSkillCtrl:GetPlayerRoleEntity()
  skillCasterEntity.recordTable.passiveArg1 = self.arglist[1]
  skillCasterEntity.recordTable.passiveArg2 = self.arglist[2]
  skillCasterEntity.recordTable.passiveArg8 = self.arglist[8]
  skillCasterEntity.recordTable.passiveArg9 = self.arglist[9]
end

function bs_108701:OnAfterBattleStart()
  self.caster:AddRoleProperty(eHeroAttr.crit, self.arglist[3], eHeroAttrType.Extra)
end

function bs_108701:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isCrit and skill.skillType == eBattleSkillLogicType.Original and not isTriggerSet then
    LuaSkillCtrl:CallBuff(self, target, self.config.buff_1, 1, self.arglist[4])
    LuaSkillCtrl:CallBuff(self, target, self.config.buff_2, 1, self.arglist[7])
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
      self.arglist[5]
    }, true)
    skillResult:EndResult()
  end
end

function bs_108701:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_108701:LuaDispose()
  base.LuaDispose(self)
end

return bs_108701
