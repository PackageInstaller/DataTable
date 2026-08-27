local bs_25503 = class("bs_25503", LuaSkillBase)
local base = LuaSkillBase
bs_25503.config = {buffId = 110164}

function bs_25503:ctor()
end

function bs_25503:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25503_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_25503_4", 1, self.OnAfterHurt, nil, self.caster, nil, nil)
  self.tier = nil
end

function bs_25503:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, true)
  self.tier = LuaSkillCtrl:StartTimer(self, self.arglist[4], function()
    local buffnum = self.caster:GetBuffTier(self.config.buffId)
    if buffnum < 10 then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[5], nil, true)
    end
  end, nil, -1)
end

function bs_25503:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  if isMiss ~= true and 0 < hurt and 0 < target:GetBuffTier(self.config.buffId) then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, self.arglist[3], true)
  end
end

function bs_25503:OnCasterDie()
  base.OnCasterDie(self)
  if self.tier ~= nil then
    self.tier:Stop()
    self.tier = nil
  end
end

return bs_25503
