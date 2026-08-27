local bs_15206 = class("bs_15206", LuaSkillBase)
local base = LuaSkillBase
bs_15206.config = {buffId_shixue = 257, buffId = 110105}

function bs_15206:ctor()
end

function bs_15206:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15206_1", 1, self.OnAfterBattleStart)
  self:AddAfterAddBuffTrigger("bs_15206_3", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, self.config.buffId_shixue)
  self:AddBeforeBuffDispelTrigger("bs_15206_5", 1, self.BeforeBuffDispel, self.caster, nil, self.config.buffId_shixue)
end

function bs_15206:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_shixue, self.arglist[1], nil)
end

function bs_15206:OnAfterAddBuff(buff, target)
  if target == self.caster then
    local buffTier = self.caster:GetBuffTier(self.config.buffId_shixue)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, buffTier, nil, true)
  end
end

function bs_15206:BeforeBuffDispel(targetRole, context)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, context.tier, true)
end

function bs_15206:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15206
