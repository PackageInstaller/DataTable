local bs_10160 = class("bs_10160", LuaSkillBase)
local base = LuaSkillBase
bs_10160.config = {buffId = 1254}

function bs_10160:ctor()
end

function bs_10160:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnSelfAfterMove, "bs_10160_1", 1, self.OnAfterMove)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, self.OnRolePhaseMoveStart)
end

function bs_10160:OnAfterMove()
  if self:IsReadyToTake() then
    self:OnSkillTake()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_10160:OnRoleSplash(role, grid)
  if role == self.caster and self:IsReadyToTake() then
    self:OnSkillTake()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_10160:OnRolePhaseMoveStart(role, luaskill)
  if role == self.caster and self:IsReadyToTake() then
    self:OnSkillTake()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_10160:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10160
