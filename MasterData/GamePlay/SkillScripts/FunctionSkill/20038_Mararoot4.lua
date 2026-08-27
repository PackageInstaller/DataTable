local bs_20038 = class("bs_20038", LuaSkillBase)
local base = LuaSkillBase
bs_20038.config = {
  effectId = 10795,
  buffId = 66,
  buffTier = 1,
  hurt_config = {basehurt_formula = 10076},
  skillDelay = 30
}

function bs_20038:ctor()
end

function bs_20038:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if self.caster.roleDataId ~= 30001 and self.caster.roleDataId ~= 30002 and self.caster.roleDataId ~= 300010 then
    return
  end
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_20038_3", 3, self.OnAfterPlaySkill)
end

function bs_20038:OnAfterPlaySkill(skill, role)
  if skill.maker.belongNum ~= self.caster.belongNum and skill.maker.roleType == 1 and not skill.isCommonAttack then
    local arriveCallBack = BindCallback(self, self.OnArriveAction, skill.maker)
    LuaSkillCtrl:StartTimer(nil, self.config.skillDelay, arriveCallBack)
  end
end

function bs_20038:OnArriveAction(role)
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self, self.SkillEventFunc)
end

function bs_20038:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, self.config.aoe_config)
    skillResult:BuffResult(self.config.buffId, self.config.buffTier, self.arglist[2])
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config)
    skillResult:EndResult()
  end
end

function bs_20038:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20038
