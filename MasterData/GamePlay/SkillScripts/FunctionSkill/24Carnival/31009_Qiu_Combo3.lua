local bs_31009 = class("bs_31009", LuaSkillBase)
local base = LuaSkillBase
bs_31009.config = {
  buffId = 2227,
  buffId_true = 2232,
  scale_max = 2.0
}

function bs_31009:ctor()
end

function bs_31009:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.bs_31009 = self
end

function bs_31009:Growth(target)
  LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, nil, true, target, true)
  local tier = target:GetBuffTier(self.config.buffId)
  local tier1 = target:GetBuffTier(self.config.buffId_true)
  local to_tier = tier // self.arglist[1]
  if tier1 < to_tier then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_true, 0, true, true)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_true, to_tier, nil, true)
    local scale = target:GetBuffTier(self.config.buffId_true) * 0.15 + 1.0
    if scale > self.config.scale_max then
      scale = self.config.scale_max
    end
    LuaSkillCtrl:CallStartLocalScale(target, Vector3.New(scale, scale, scale), 0.4)
  end
end

function bs_31009:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_31009
