local bs_17038 = class("bs_17038", LuaSkillBase)
local base = LuaSkillBase
bs_17038.config = {
  effectId = 60617,
  effectIdAttack = 60616,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0
  }
}

function bs_17038:ctor()
end

function bs_17038:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_17038_3", 1, self.OnAfterPlaySkill)
  self:AddHurtResultStartTrigger("bs_17038_4", 1, self.OnHurtResultStart, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self.typenum = 2
end

function bs_17038:OnAfterPlaySkill(skill, role)
  if role == self.caster and not skill.isCommonAttack and not self.flag then
    self.flag = true
  end
end

function bs_17038:OnHurtResultStart(skill, context)
  if context.sender == self.caster and skill.isCommonAttack and self.flag then
    LuaSkillCtrl:CallEffect(context.target, self.config.effectIdAttack, self, self.SkillEventFunc)
    local curRole = context.target
    local targetL = LuaSkillCtrl:CallTargetSelect(self, 55, 22, curRole)
    local role_count = self.arglist[2]
    if targetL ~= nil and targetL.Count > 0 then
      for i = 0, targetL.Count - 1 do
        local targetRole = targetL[i].targetRole
        LuaSkillCtrl:CallEffect(targetRole, self.config.effectIdAttack, self, self.SkillEventFunc, curRole)
        role_count = role_count - 1
        if role_count <= 0 then
          break
        end
      end
    end
    self.flag = false
  end
end

function bs_17038:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self, nil)
    local tar = target.targetRole
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.Callthrows, tar, self.typenum, self.arglist[1], true)
    if self.caster.recordTable["25211_Flag"] == true then
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
        self.caster.recordTable["25211_arg"] + self.arglist[1]
      }, true)
    else
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
        self.arglist[1]
      }, true)
    end
    skillResult:EndResult()
  end
end

function bs_17038:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if role ~= self.caster then
    return
  end
  self.flag = false
end

function bs_17038:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17038
