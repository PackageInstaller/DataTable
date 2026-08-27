local bs_15225 = class("bs_15225", LuaSkillBase)
local base = LuaSkillBase
bs_15225.config = {buffId = 110120}

function bs_15225:ctor()
end

function bs_15225:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15225_1", 1, self.OnAfterBattleStart)
  self:AddAfterAddBuffTrigger("bs_15225_3", 1, self.OnAfterAddBuff, self.caster)
end

function bs_15225:OnAfterBattleStart()
end

function bs_15225:OnAfterAddBuff(buff, target)
  local buffTier = self.caster:GetBuffTier(self.config.buffId)
  if buffTier < self.arglist[3] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_15225:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15225
