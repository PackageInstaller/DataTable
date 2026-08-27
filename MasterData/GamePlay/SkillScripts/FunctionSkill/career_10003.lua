local career_10003 = class("career_10003", LuaSkillBase)
local base = LuaSkillBase
career_10003.config = {buffId = 1121}

function career_10003:ctor()
end

function career_10003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnRealSummonerCaster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "career_10003_5", 1, self.OnAfterBattleStart)
end

function career_10003:OnAfterBattleStart()
  if self.caster.career == 2 or self.caster.recordTable.transfCareer == 2 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
    self:PlayChipEffect()
  end
end

function career_10003:OnRealSummonerCaster(summonerEntity)
  if summonerEntity.belongNum == eBattleRoleBelong.player and summonerEntity.career == 2 then
    LuaSkillCtrl:CallBuff(self, summonerEntity, self.config.buffId, 1, nil, true)
    self:PlayChipEffect()
  end
end

function career_10003:OnCasterDie()
  base.OnCasterDie(self)
end

return career_10003
