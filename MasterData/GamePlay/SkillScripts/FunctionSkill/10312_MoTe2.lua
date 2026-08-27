local bs_10312 = class("bs_10312", LuaSkillBase)
local base = LuaSkillBase
bs_10312.config = {
  buffId = 1228,
  buffTier = 1,
  buffDuration = 180
}

function bs_10312:ctor()
end

function bs_10312:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10312_11", 1, self.OnRoleDie)
  self.num = 0
end

function bs_10312:OnRoleDie(killer, role, killSkill)
  if killer == self.caster and self:IsReadyToTake() then
    self:OnSkillTake()
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 64, 10)
    if targetlist.Count < 1 then
      return
    end
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i].targetRole
      if targetRole == nil then
        break
      end
      local buffTier = targetRole:GetBuffTier(self.config.buffId)
      if buffTier == 0 then
        LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, self.config.buffTier, self.config.buffDuration)
        self.num = self.num + 1
      end
      if self.num >= self.arglist[1] then
        break
      end
    end
    self.num = 0
    self:PlayChipEffect()
  end
end

function bs_10312:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10312
