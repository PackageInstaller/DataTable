local bs_17015 = class("bs_17015", LuaSkillBase)
local base = LuaSkillBase
bs_17015.config = {
  buffId = 2098,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0
  },
  effectId = 10936,
  effectIdAttack = 10936,
  buffTier = 1
}

function bs_17015:ctor()
end

function bs_17015:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_17015_1", 1, self.OnAfterPlaySkill)
end

function bs_17015:OnAfterPlaySkill(skill, role)
  if self:IsReadyToTake() and skill.maker == self.caster and not skill.isCommonAttack then
    local roleslist = LuaSkillCtrl:CallTargetSelect(self, 1002, 10)
    if roleslist.Count > self.arglist[1] then
      for i = 0, self.arglist[1] - 1 do
        LuaSkillCtrl:CallEffect(roleslist[i], self.config.effectIdAttack, self, self.SkillEventFunc)
      end
    end
    if roleslist.Count <= self.arglist[1] then
      for i = 0, roleslist.Count - 1 do
        LuaSkillCtrl:CallEffect(roleslist[i], self.config.effectIdAttack, self, self.SkillEventFunc)
      end
    end
  end
end

function bs_17015:SkillEventFunc(effect, eventId, target)
  local skillResult = LuaSkillCtrl:CallSkillResult(effect, target.targetRole)
  local skill_intensity = self.arglist[2]
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, 3, {skill_intensity}, true, true)
  LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId, self.config.buffTier, 90, false)
  skillResult:EndResult()
end

function bs_17015:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17015
