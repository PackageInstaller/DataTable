local bs_10228 = class("bs_10228", LuaSkillBase)
local base = LuaSkillBase
bs_10228.config = {
  buffId = 1083,
  buffTier = 1,
  buffSL = 1184
}

function bs_10228:ctor()
end

function bs_10228:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_10228_2", 1, self.OnAfterAddBuff, self.caster)
end

function bs_10228:OnAfterAddBuff(buff, target, isOverlay)
  if buff.buffType ~= 0 and buff.maker == self.caster and self:IsReadyToTake() then
    local buffTier = self.caster:GetBuffTier(self.config.buffId)
    if buffTier < 1 then
      self.caster.recordTable["10228_time"] = self.arglist[1]
      self.caster.recordTable["10228_Damage"] = self.arglist[2]
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, self.arglist[1], true)
      if self.caster.recordTable["30013_arg"] then
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffSL, self.config.buffTier, self.arglist[1], true)
      end
      self:OnSkillTake()
    end
  end
end

function bs_10228:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10228
