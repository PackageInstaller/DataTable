local bs_15052 = class("bs_15052", LuaSkillBase)
local base = LuaSkillBase
bs_15052.config = {buffId = 1243}

function bs_15052:ctor()
end

function bs_15052:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15052_1", 1, self.OnAfterBattleStart)
  self:AddSetHurtTrigger("bs_15052_2", 1, self.OnSetHurt, self.caster)
end

function bs_15052:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[2], nil, true)
end

function bs_15052:OnSetHurt(context)
  if context.sender == self.caster and context.isCrit then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 1)
  end
end

function bs_15052:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15052
