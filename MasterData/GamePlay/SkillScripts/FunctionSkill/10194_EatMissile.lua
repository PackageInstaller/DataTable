local bs_10194 = class("bs_10194", LuaSkillBase)
local base = LuaSkillBase
bs_10194.config = {
  buffId = 1206,
  buffCm = 26,
  buffTier = 1
}

function bs_10194:ctor()
end

function bs_10194:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnDoodad, self.OnDoodad)
end

function bs_10194:OnDoodad(sender, targetRole)
  if targetRole.belongNum == 2 then
    self:PlayChipEffect()
    if targetRole:GetBuffTier(self.config.buffId) < 1 then
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, self.config.buffTier, self.arglist[1], true)
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffCm, self.config.buffTier, self.arglist[1], true)
    end
  end
end

function bs_10194:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10194
