local bs_50016 = class("bs_50016", LuaSkillBase)
local base = LuaSkillBase
bs_50016.config = {
  buffId = 1155,
  buffIdNormal = 1160,
  buffTier = 1
}

function bs_50016:ctor()
end

function bs_50016:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnBattleEnd, "bs_50016_1", 1, self.OnBattleEnd)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_50016_2", 2, self.AfterBattleStart)
end

function bs_50016:AfterBattleStart()
  if self.caster.career == 3 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
  else
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffIdNormal, self.config.buffTier, nil, true)
  end
end

function bs_50016:OnBattleEnd()
  local hurt = self.caster.hp - 1
  self.caster:SubHp(hurt)
end

function bs_50016:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_50016
