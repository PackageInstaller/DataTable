local bs_15230 = class("bs_15230", LuaSkillBase)
local base = LuaSkillBase
bs_15230.config = {buffId = 1, buffId_fuyu = 1088}

function bs_15230:ctor()
end

function bs_15230:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15230_1", 1, self.OnAfterBattleStart)
  self:AddSetHurtTrigger("bs_15230_2", 1, self.OnSetHurt, nil, self.caster)
end

function bs_15230:OnAfterBattleStart()
end

function bs_15230:OnSetHurt(context)
  local buffTier = self.caster:GetBuffTier(self.config.buffId_fuyu)
  if buffTier >= self.arglist[1] and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[2] then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_fuyu, 1, false)
    context.hurt = context.hurt * self.arglist[3] // 1000
  end
end

function bs_15230:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15230
