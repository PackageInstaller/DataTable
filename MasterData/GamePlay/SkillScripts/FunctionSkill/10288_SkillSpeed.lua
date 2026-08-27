local bs_10288 = class("bs_10288", LuaSkillBase)
local base = LuaSkillBase
bs_10288.config = {buffId = 1197, buffTier = 1}

function bs_10288:ctor()
end

function bs_10288:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10288_1", 1, self.OnAfterPlaySkill)
end

function bs_10288:OnAfterPlaySkill(skill, role)
  if self.caster.recordTable["104502_active"] == false then
    return
  end
  if skill.maker == self.caster and not skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, self.arglist[2], true)
  end
end

function bs_10288:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10288
