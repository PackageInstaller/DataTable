local bs_203502 = class("bs_203502", LuaSkillBase)
local base = LuaSkillBase
bs_203502.config = {
  skill_time = 25,
  start_time = 9,
  effectId_start = 10772,
  effectId_line = 10771,
  delay = 25,
  monster = 15,
  buffId_198 = 198,
  buffId_253 = 253,
  antion1 = 1002
}

function bs_203502:ctor()
end

function bs_203502:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_203502:PlaySkill(data)
  self:CallCasterWait(self.config.skill_time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.antion1, 1, self.config.start_time, attackTrigger)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self)
end

function bs_203502:OnAttackTrigger()
  local realgrid = LuaSkillCtrl:CallFindEmptyGridMostRolesArounded(2)
  if realgrid ~= nil then
    local Grid = LuaSkillCtrl:GetTargetWithGrid(realgrid.x, realgrid.y)
    LuaSkillCtrl:CallEffect(Grid, self.config.effectId_line, self)
    local monster = self.config.monster
    local arg1 = self.arglist[1]
    local arg2 = self.arglist[2]
    local time = self.arglist[3]
    local summoner = LuaSkillCtrl:CreateSummoner(self, monster, Grid.x, Grid.y)
    summoner:SetAttr(eHeroAttr.maxHp, self.arglist[4] * 100)
    summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity)
    summoner:SetAsRealEntity(1)
    local tab = {
      arg_1 = arg1,
      arg_2 = arg2,
      time = time
    }
    summoner:SetRecordTable(tab)
    local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    LuaSkillCtrl:CallBuff(self, summonerEntity, self.config.buffId_198, 1, self.arglist[3], true)
    LuaSkillCtrl:CallBuff(self, summonerEntity, self.config.buffId_253, 1, self.arglist[3], true)
  end
end

function bs_203502:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_203502
