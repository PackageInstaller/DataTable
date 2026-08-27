local bs_10290 = class("bs_10290", LuaSkillBase)
local base = LuaSkillBase
bs_10290.config = {buffId = 1198, buffTier = 1}

function bs_10290:ctor()
end

function bs_10290:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10290_1", 1, self.OnAfterPlaySkill)
end

function bs_10290:OnAfterPlaySkill(skill, role)
  if self.caster.recordTable["104502_active"] == false then
    return
  end
  if skill.maker == self.caster and not skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, self.arglist[2], true)
  end
end

function bs_10290:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10290
