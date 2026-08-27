local bs_15063 = class("bs_15063", LuaSkillBase)
local base = LuaSkillBase
bs_15063.config = {effectId = 10955, buffId = 1255}

function bs_15063:ctor()
end

function bs_15063:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_15063_1", 1, self.OnAfterBattleStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.CallBuffForSameCamp)
end

function bs_15063:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil)
  self.caster.recordTable["15063_damagePer"] = self.arglist[1]
end

function bs_15063:CallBuffForSameCamp(role)
  if role.summoner.summonerMaker == self.caster then
    local camp = role.camp
    if role.roleType == eBattleRoleType.realSummoner then
      camp = LuaSkillCtrl:GetSummonerCamp(role)
    end
    if camp == self.caster.camp and role:GetBuffTier(self.config.buffId) == 0 then
      LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, nil)
      role.recordTable["15063_damagePer"] = self.arglist[1]
    end
  end
end

function bs_15063:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15063
