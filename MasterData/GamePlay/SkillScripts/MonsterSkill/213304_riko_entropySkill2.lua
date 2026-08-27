local bs_213304 = class("bs_213304", LuaSkillBase)
local base = LuaSkillBase
bs_213304.config = {
  skillID = 213304,
  skill_time = 21,
  effectId_summoner = 203305,
  actionId = 1020,
  action_speed = 1,
  start_time = 7,
  monsterId = 80
}

function bs_213304:ctor()
end

function bs_213304:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_213304_1", 1, self.OnAfterBattleStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.SummonerCaster)
  self.calltimes = 0
end

function bs_213304:OnAfterBattleStart()
  self:fastcastskill()
end

function bs_213304:SummonerCaster(summonerEntity)
  if summonerEntity == self.caster then
    self:fastcastskill()
  end
end

function bs_213304:fastcastskill(data)
  local skills = self.caster:GetBattleSkillList()
  if skills ~= nil then
    local skillCount = skills.Count
    if 0 < skillCount then
      for j = 0, skillCount - 1 do
        local curTotalCd = skills[j].totalCDTime
        if skills[j].dataId == self.config.skillID then
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd // 2)
        end
      end
    end
  end
end

function bs_213304:PlaySkill(data)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, self.config.skill_time)
  self:AbandonSkillCdAutoReset(true)
end

function bs_213304:OnAttackTrigger()
  self.num_summon = self.arglist[1] + math.min(self.calltimes, self.arglist[9])
  for i = 1, self.num_summon do
    LuaSkillCtrl:StartTimer(self, i * 3, function()
      self:Summon(i)
    end, nil)
  end
  self:EndSkillAndCallNext()
end

function bs_213304:Summon(num)
  local Grid = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
  if Grid == nil then
    Grid = LuaSkillCtrl:FindRoleRightEmptyGrid(self.caster, 10)
  end
  if Grid ~= nil then
    local target = LuaSkillCtrl:GetTargetWithGrid(Grid.x, Grid.y)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_summoner, self)
    local summoner
    summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, Grid.x, Grid.y)
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.arglist[6] * (1000 + self.calltimes * self.arglist[8]) // 1000000)
    summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.arglist[7] * (1000 + self.calltimes * self.arglist[8]) // 1000000)
    summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.arglist[7] * (1000 + self.calltimes * self.arglist[8]) // 1000000)
    summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
    summoner:SetAttr(eHeroAttr.moveSpeed, math.floor(self.caster.moveSpeed * 0.7))
    summoner:SetAttr(eHeroAttr.def, self.caster.def)
    summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res)
    summoner:SetAttr(eHeroAttr.lucky, self.caster.lucky)
    summoner:SetAttr(eHeroAttr.sunder, self.caster.sunder)
    summoner:SetAttr(eHeroAttr.magic_pen, self.caster.magic_pen)
    summoner:SetAttr(eHeroAttr.dodge, self.caster.dodge)
    summoner:SetAttr(eHeroAttr.crit, self.caster.crit)
    summoner:SetAttr(eHeroAttr.critDamage, self.caster.critDamage)
    summoner:SetAttr(eHeroAttr.damage_increase, self.caster.damage_increase)
    summoner:SetAttr(eHeroAttr.injury_reduce, self.caster.injury_reduce)
    summoner:SetAttr(eHeroAttr.resistance, self.caster.resistance)
    summoner:SetAttr(eHeroAttr.cd_reduce, self.caster.cd_reduce)
    summoner:SetAsRealEntity(1)
    local arg_timer_ready = self.arglist[2]
    local arg_timer_boom = self.arglist[3]
    local arg_dam = self.arglist[4]
    local arg_dam_plus = self.arglist[5]
    local tab = {
      arg_timer_ready = arg_timer_ready,
      arg_timer_boom = arg_timer_boom,
      arg_dam = arg_dam,
      arg_dam_plus = arg_dam_plus
    }
    summoner:SetRecordTable(tab)
    LuaSkillCtrl:AddSummonerRole(summoner)
  end
  if num >= self.num_summon then
    self.calltimes = self.calltimes + 1
  end
end

function bs_213304:EndSkillAndCallNext()
  if self.caster == nil then
    return
  end
  self:CancleCasterWait()
  local skillMgr = self.caster:GetSkillComponent()
  if skillMgr == nil then
    return
  end
  skillMgr.lastSkill = self.cskill
  self:CallNextBossSkill()
  LuaSkillCtrl:StopShowSkillDurationTime(self)
end

function bs_213304:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_213304
