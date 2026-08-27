local bs_21251 = class("bs_21251", LuaSkillBase)
local base = LuaSkillBase
bs_21251.config = {buffId = 2172}

function bs_21251:ctor()
end

function bs_21251:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21251_1", 1, self.OnAfterBattleStart)
  self:AddSetHurtTrigger("bs_21251_14", 1, self.OnSetHurt, nil, self.caster)
end

function bs_21251:OnAfterBattleStart()
  self:PlayChipEffect()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, true)
end

function bs_21251:OnSetHurt(context)
  local tier = context.target:GetBuffTier(self.config.buffId)
  if tier <= 0 or context.sender == self.caster or context.isMiss then
    return
  end
  if context.target == self.caster and context.sender ~= self.caster then
    context.hurt = 0
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 1)
    if context.target:GetBuffTier(self.config.buffId) == nil or context.target:GetBuffTier(self.config.buffId) < 1 then
      self:RemoveSkillTrigger(eSkillTriggerType.SetHurt)
    end
  end
end

function bs_21251:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21251
