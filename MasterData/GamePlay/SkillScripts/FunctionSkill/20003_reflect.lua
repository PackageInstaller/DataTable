local bs_20003 = class("bs_20003", LuaSkillBase)
local base = LuaSkillBase
bs_20003.config = {buffId = 1096}

function bs_20003:ctor()
end

function bs_20003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20003_1", 1, self.OnAfterBattleStart)
  self:AddSetHurtTrigger("bs_20003_14", 1, self.OnSetHurt, nil, self.caster)
end

function bs_20003:OnAfterBattleStart()
  self:PlayChipEffect()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, true)
end

function bs_20003:OnSetHurt(context)
  local tier = context.target:GetBuffTier(self.config.buffId)
  if tier <= 0 or context.sender == self.caster or context.isMiss then
    return
  end
  if context.target == self.caster and context.sender ~= self.caster then
    LuaSkillCtrl:RemoveLife(context.hurt, self, context.sender, true, nil, true, false, eHurtType.RealDmg)
    context.hurt = 0
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 1)
  end
end

function bs_20003:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20003
