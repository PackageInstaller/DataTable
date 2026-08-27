local bs_25212 = class("bs_25212", LuaSkillBase)
local base = LuaSkillBase
bs_25212.config = {
  effectdoorId = 60611,
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

function bs_25212:ctor()
end

function bs_25212:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_25212_3", 1, self.OnAfterPlaySkill)
end

function bs_25212:OnAfterPlaySkill(skill, role)
  if role == self.caster and not skill.isCommonAttack and not self.flag then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectdoorId, self)
    local roleslist = LuaSkillCtrl:CallTargetSelect(self, 1002, 10)
    if roleslist.Count > self.arglist[2] then
      for i = 0, self.arglist[2] - 1 do
        local flag = math.random(1, 3)
        if flag == 1 then
          LuaSkillCtrl:CallEffect(roleslist[i], self.config.effectIdAttack1, self, self.SkillEventFunc)
          LuaSkillCtrl:CallEffect(roleslist[i], self.config.effectId1, self, nil)
        elseif flag == 2 then
          LuaSkillCtrl:CallEffect(roleslist[i], self.config.effectIdAttack2, self, self.SkillEventFunc)
          LuaSkillCtrl:CallEffect(roleslist[i], self.config.effectId2, self, nil)
        else
          LuaSkillCtrl:CallEffect(roleslist[i], self.config.effectIdAttack3, self, self.SkillEventFunc)
          LuaSkillCtrl:CallEffect(roleslist[i], self.config.effectId3, self, nil)
        end
      end
    end
    if roleslist.Count <= self.arglist[2] then
      for i = 0, roleslist.Count - 1 do
        local flag = math.random(1, 3)
        if flag == 1 then
          LuaSkillCtrl:CallEffect(roleslist[i], self.config.effectIdAttack1, self, self.SkillEventFunc)
          LuaSkillCtrl:CallEffect(roleslist[i], self.config.effectId1, self, nil)
        elseif flag == 2 then
          LuaSkillCtrl:CallEffect(roleslist[i], self.config.effectIdAttack2, self, self.SkillEventFunc)
          LuaSkillCtrl:CallEffect(roleslist[i], self.config.effectId2, self, nil)
        else
          LuaSkillCtrl:CallEffect(roleslist[i], self.config.effectIdAttack3, self, self.SkillEventFunc)
          LuaSkillCtrl:CallEffect(roleslist[i], self.config.effectId3, self, nil)
        end
      end
    end
  end
end

function bs_25212:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    local targetRole = target.targetRole
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.Callthrows, targetRole, self.typenum, self.arglist[1], true)
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

function bs_25212:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25212
