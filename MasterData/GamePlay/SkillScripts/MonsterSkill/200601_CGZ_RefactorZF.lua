local bs_200601 = class("bs_200601", LuaSkillBase)
local base = LuaSkillBase
bs_200601.config = {buffId_1067 = 1067, buffTier = 1}

function bs_200601:ctor()
end

function bs_200601:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHealTrigger("bs_200601_5", 1, self.OnAfterHeal, self.caster)
  self.caster.recordTable.passive = true
end

function bs_200601:OnAfterHeal(sender, target, skill, heal)
  if sender == self.caster then
    local roleBuffTier = target:GetBuffTier(self.config.buffId_1067)
    if roleBuffTier < self.arglist[2] then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_1067, self.config.buffTier, nil)
    end
  end
end

function bs_200601:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_200601
