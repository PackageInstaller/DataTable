local bs_10219 = class("bs_10219", LuaSkillBase)
local base = LuaSkillBase
bs_10219.config = {
  buffId = 1027,
  buffTier = 1,
  effectId = 10251
}

function bs_10219:ctor()
end

function bs_10219:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10219_1", 2, self.OnAfterPlaySkill)
end

function bs_10219:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and not skill.isCommonAttack then
    self:PlayChipEffect()
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 30, 10)
    if targetlist.Count <= 0 then
      return
    end
    LuaSkillCtrl:CallBuff(self, targetlist[0].targetRole, self.config.buffId, self.config.buffTier, self.arglist[1])
  end
end

function bs_10219:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10219
