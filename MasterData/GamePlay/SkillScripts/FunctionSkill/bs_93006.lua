local bs_93006 = class("bs_93006", LuaSkillBase)
local base = LuaSkillBase
bs_93006.config = {effectId = 10965}

function bs_93006:ctor()
end

function bs_93006:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_93006_1", 1, self.OnAfterPlaySkill)
end

function bs_93006:OnAfterPlaySkill(skill, role)
  if not skill.isCommonAttack and LuaSkillCtrl:CallRange(1, 1000) < self.arglist[1] and self:IsReadyToTake() then
    self:OnSkillTake()
    LuaSkillCtrl:CallReFillMainSkillCdForRole(self.caster)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, self.SkillEventFunc)
  end
end

function bs_93006:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_93006
