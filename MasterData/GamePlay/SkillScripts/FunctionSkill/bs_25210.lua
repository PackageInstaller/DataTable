local bs_25210 = class("bs_25210", LuaSkillBase)
local base = LuaSkillBase
bs_25210.config = {
  effectIdAttack1 = 60614,
  effectId1 = 60615,
  effectIdAttack2 = 60616,
  effectId2 = 60617,
  effectIdAttack3 = 60612,
  effectId3 = 60613,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0
  }
}

function bs_25210:ctor()
end

function bs_25210:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.Callthrows, self.OnCallthrows)
  self.argnum = 0
end

function bs_25210:OnCallthrows(target, flag, argnum, flag1)
  if flag1 == true and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
    self.argnum = argnum
    local targetL = LuaSkillCtrl:CallTargetSelect(self, 55, 10, target)
    if targetL ~= nil and targetL.Count > 0 then
      local targetRole = targetL[0].targetRole
      if flag == 1 then
        LuaSkillCtrl:CallEffect(targetRole, self.config.effectIdAttack1, self, self.SkillEventFunc, target)
        LuaSkillCtrl:CallEffect(targetRole, self.config.effectId1, self, nil)
      elseif flag == 2 then
        LuaSkillCtrl:CallEffect(targetRole, self.config.effectIdAttack2, self, self.SkillEventFunc, target)
        LuaSkillCtrl:CallEffect(targetRole, self.config.effectId2, self, nil)
      else
        LuaSkillCtrl:CallEffect(targetRole, self.config.effectIdAttack3, self, self.SkillEventFunc, target)
        LuaSkillCtrl:CallEffect(targetRole, self.config.effectId3, self, nil)
      end
    end
  end
end

function bs_25210:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    local targetRole = target.targetRole
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.Callthrows, targetRole, self.typenum, self.arglist[1], false)
    if self.caster.recordTable["25211_Flag"] == true then
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
        self.caster.recordTable["25211_arg"] + self.argnum
      }, true)
    else
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
        self.argnum
      }, true)
    end
    skillResult:EndResult()
  end
end

function bs_25210:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25210
