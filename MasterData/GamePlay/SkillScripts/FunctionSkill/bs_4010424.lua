local bs_4010424 = class("bs_4010424", LuaSkillBase)
local base = LuaSkillBase
bs_4010424.config = {buffId = 1227, duration = 90}

function bs_4010424:ctor()
end

function bs_4010424:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4010424", 1, self.OnAfterHurt, nil, self.caster, eBattleRoleBelong.enemy)
end

function bs_4010424:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and isMiss and self:IsReadyToTake() then
    LuaSkillCtrl:CallBuff(self, sender, self.config.buffId, self.arglist[1], self.config.duration, true)
    self:OnSkillTake()
  end
end

function bs_4010424:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010424
