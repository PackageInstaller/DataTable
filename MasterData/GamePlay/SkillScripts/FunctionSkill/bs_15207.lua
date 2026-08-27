local bs_15207 = class("bs_15207", LuaSkillBase)
local base = LuaSkillBase
bs_15207.config = {
  buffId_shixue = 257,
  buffId = 110106,
  buffId_live = 3009
}

function bs_15207:ctor()
end

function bs_15207:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_15207_1", 949, self.OnSetDeadHurt, nil, self.caster)
  self.Times = 0
end

function bs_15207:OnSetDeadHurt(context)
  local NoDeath = LuaSkillCtrl:RoleContainsBuffFeature(context.target, eBuffFeatureType.NoDeath)
  if self:IsReadyToTake() and context.target.belongNum == self.caster.belongNum and context.target.roleType == 1 and context.target ~= context.sender and context.target:GetBuffTier(self.config.nanaka_buffId) <= 0 and self.Times == 0 and NoDeath == false then
    self.Times = 1
    local buffTier = self.caster:GetBuffTier(self.config.buffId_shixue)
    if buffTier == 0 then
      return
    end
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_live, 1, 1, true)
    local value = buffTier * self.arglist[1] * self.caster.maxHp // 1000
    LuaSkillCtrl:StartTimer(nil, 1, function()
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_shixue, 0)
      LuaSkillCtrl:CallHeal(value, self, self.caster)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, buffTier, nil, true)
    end)
    self:OnSkillTake()
  end
end

function bs_15207:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15207
