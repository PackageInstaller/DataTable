local bs_10238 = class("bs_10238", LuaSkillBase)
local base = LuaSkillBase
bs_10238.config = {
  buffId = 1091,
  buffTier = 1,
  buffId2 = 1125
}

function bs_10238:ctor()
end

function bs_10238:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10238_3", 1, self.OnAfterHurt, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10238_1", 2, self.OnAfterBattleStart)
end

function bs_10238:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
end

function bs_10238:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and isCrit and self:IsReadyToTake() then
    self:OnSkillTake()
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
    if targetlist.Count < 1 then
      return
    end
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i].targetRole
      local buffTier = targetRole:GetBuffTier(self.config.buffId)
      if buffTier < self.arglist[2] then
        LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, self.config.buffTier, nil, true)
      elseif buffTier > self.arglist[2] then
        LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
        LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, self.arglist[2], nil, true)
      end
    end
  end
end

function bs_10238:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10238
