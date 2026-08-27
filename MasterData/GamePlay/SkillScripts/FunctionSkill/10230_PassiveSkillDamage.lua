local bs_10230 = class("bs_10230", LuaSkillBase)
local base = LuaSkillBase
bs_10230.config = {buffId = 1085, buffTier = 1}

function bs_10230:ctor()
end

function bs_10230:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_10230_2", 1, self.OnAfterAddBuff, self.caster)
end

function bs_10230:OnAfterAddBuff(buff, target, isOverlay)
  if buff.buffType ~= 0 and buff.maker == self.caster and self:IsReadyToTake() then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
    self:PlayChipEffect()
  end
end

function bs_10230:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10230
