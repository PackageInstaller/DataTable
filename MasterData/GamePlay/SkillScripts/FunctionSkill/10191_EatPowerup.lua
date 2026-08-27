local bs_10191 = class("bs_10191", LuaSkillBase)
local base = LuaSkillBase
bs_10191.config = {buffId = 1071, buffTier = 1}

function bs_10191:ctor()
end

function bs_10191:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnDoodad, self.OnDoodad)
end

function bs_10191:OnDoodad(sender, targetRole)
  if targetRole == self.caster then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, self.arglist[2], true)
  end
end

function bs_10191:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10191
