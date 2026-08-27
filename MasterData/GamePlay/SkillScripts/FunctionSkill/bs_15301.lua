local bs_15301 = class("bs_15301", LuaSkillBase)
local base = LuaSkillBase
bs_15301.config = {buffId1 = 110131, buffId2 = 110132}

function bs_15301:ctor()
end

function bs_15301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15301_1", 1, self.OnAfterBattleStart)
  self:AddSetHurtTrigger("bs_15301_3", 1, self.OnSetHurt, nil, self.caster)
  self.maxHp = 0
end

function bs_15301:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil, true)
end

function bs_15301:OnSetHurt(context)
  if context.target == self.caster and self.maxHp ~= self.caster.maxHp then
    self.maxHp = self.caster.maxHp
    local buffTier = self.maxHp // self.arglist[2]
    local buffTierNow = self.caster:GetBuffTier(self.config.buffId2)
    if buffTier ~= buffTierNow then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId2, 0, true)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, buffTier, nil, true)
    end
  end
end

function bs_15301:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15301
