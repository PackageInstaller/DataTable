local bs_10229 = class("bs_10229", LuaSkillBase)
local base = LuaSkillBase
bs_10229.config = {buffId = 1084, buffTier = 1}

function bs_10229:ctor()
end

function bs_10229:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_10229_2", 1, self.OnAfterAddBuff, self.caster, nil, nil, nil, nil, eBuffType.Beneficial)
end

function bs_10229:OnAfterAddBuff(buff, target, isOverlay)
  if buff.buffType == 1 and isOverlay and buff.maker == self.caster and self:IsReadyToTake() then
    self:OnSkillTake()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, self.arglist[2], true)
    local buffTier = self.caster:GetBuffTier(self.config.buffId)
    if buffTier > self.arglist[1] then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, buffTier - self.arglist[1], true)
    end
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.config.buffTier, self.arglist[2], true)
    local buffTier1 = target:GetBuffTier(self.config.buffId)
    if buffTier1 > self.arglist[1] then
      LuaSkillCtrl:DispelBuff(target, self.config.buffId, buffTier1 - self.arglist[1], true)
    end
  end
end

function bs_10229:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10229
