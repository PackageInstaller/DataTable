local bs_10147 = class("bs_10147", LuaSkillBase)
local base = LuaSkillBase
bs_10147.config = {
  buffId = 1028,
  buffTier = 1,
  effectId1 = 10252,
  effectId2 = 10253,
  effectId = 10336,
  effectIdAttack = 10254,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10032,
    crit_formula = 0
  }
}

function bs_10147:ctor()
end

function bs_10147:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10147_3", 3, self.OnAfterPlaySkill)
  self:AddAfterHurtTrigger("bs_10147_3", 20, self.OnAfterHurt, self.caster)
  self:AddSelfTrigger(eSkillTriggerType.BeforePlaySkill, "bs_10147_1", 1, self.OnBeforePlaySkill)
  self.caster.recordTable["10147_attackflag"] = false
end

function bs_10147:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if skill.maker == self.caster and skill.isCommonAttack and self.caster.recordTable["10147_attackflag"] and not isTriggerSet then
    local loopTime = self.arglist[1]
    local loopJiange = self.arglist[3] // self.arglist[1]
    local arriveCallBack = BindCallback(self, self.OnArriveAction, target)
    self.timer = LuaSkillCtrl:StartTimer(nil, loopJiange, arriveCallBack, self, loopTime, loopJiange)
    self.caster.recordTable["10147_attackflag"] = false
  end
end

function bs_10147:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and not skill.isCommonAttack then
    self.caster.recordTable["10147_attackflag"] = true
  end
end

function bs_10147:OnArriveAction(role)
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  if role.hp == 0 or role:IsUnSelect(self.caster) then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
    if targetlist.Count < 1 then
      if self.timer ~= nil then
        self.timer:Stop()
        self.timer = nil
      end
      return
    end
    LuaSkillCtrl:CallEffect(targetlist[0].targetRole, self.config.effectIdAttack, self, self.SkillEventFunc)
  else
    LuaSkillCtrl:CallEffect(role, self.config.effectIdAttack, self, self.SkillEventFunc)
  end
end

function bs_10147:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config)
    skillResult:EndResult()
  end
end

function bs_10147:OnBeforePlaySkill(role, context)
  local tier = self.caster:GetBuffTier(self.config.buffId)
  if role == self.caster and context.skill.isCommonAttack and 0 < tier then
    local passdata = {
      effectId = self.config.effectId
    }
    context.passdata = passdata
  end
end

function bs_10147:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10147
