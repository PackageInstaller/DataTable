local bs_204802 = class("bs_204802", LuaSkillBase)
local base = LuaSkillBase
bs_204802.config = {
  maxHpPer = 100,
  powPer = 500,
  buffFeature_ignoreDie = 6,
  effect_hudun = 204806,
  effect_killSummoner = 204807,
  effect_zd = 204809,
  effect_heal = 204810,
  effect_summon = 204814,
  actionId = 1008,
  action_speed = 1,
  start_time = 15,
  actionId_end = 1009,
  buffId_170 = 3008,
  buff_SummonerSign = 2048011,
  buff_invincible = 2048021,
  buffId_attack1 = 2048022,
  buffId_int1 = 2048023,
  buffId_defense1 = 2048024,
  buffId_attack2 = 2048025,
  buffId_int2 = 2048026,
  buffId_defense2 = 2048027,
  buffId_skillfast = 2048028,
  SetStage2Hp = 700,
  SetStage3Hp = 400
}

function bs_204802:ctor()
end

function bs_204802:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnSummonerDieForDemiurge, self.RoleDie)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_204802_2", 1, self.AfterBattleStart)
  self.heal = 0
  self.SummonerAliveCount = 0
  self.caster.recordTable.stage = 1
end

function bs_204802:AfterBattleStart()
  if self.caster.hp < self.caster.maxHp * self.arglist[5] // 1000 then
    self.caster.recordTable.stage = 3
  elseif self.caster.hp < self.caster.maxHp * self.arglist[4] // 1000 then
    self.caster.recordTable.stage = 2
  else
    self.caster.recordTable.stage = 1
  end
  self:AddSetHurtTrigger("bs_204802_2", 99, self.OnSetHurt, nil, self.caster)
end

function bs_204802:OnSetHurt(context)
  local ShieldNormal = LuaSkillCtrl:GetShield(self.caster, eShieldType.Normal)
  local num1 = self.caster.hp + ShieldNormal - self.caster.maxHp * self.arglist[4] // 1000
  if context.target == self.caster and num1 <= context.hurt and self.caster.recordTable.stage == 1 and LuaSkillCtrl:GetRoleBuffById(self.caster, self.config.buff_invincible) == nil then
    context.hurt = num1
    LuaSkillCtrl:RemoveLife(num1, self, self.caster, true, nil, false, true, eHurtType.RealDmg, true)
    self.caster.recordTable.stage = 2
    self:PlaySkill()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_attack1, 1, nil, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_int1, 1, nil, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_defense1, 1, nil, true)
    return
  end
  local num2 = self.caster.hp + ShieldNormal - self.caster.maxHp * self.arglist[5] // 1000
  if context.target == self.caster and num2 <= context.hurt and self.caster.recordTable.stage == 2 and LuaSkillCtrl:GetRoleBuffById(self.caster, self.config.buff_invincible) == nil then
    context.hurt = num2
    LuaSkillCtrl:RemoveLife(num2, self, self.caster, true, nil, false, true, eHurtType.RealDmg, true)
    self.caster.recordTable.stage = 3
    self:PlaySkill()
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_attack1, 1, true)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_int1, 1, true)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_defense1, 1, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_attack2, 1, nil, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_int2, 1, nil, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_defense2, 1, nil, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_skillfast, 1, nil, true)
  end
end

function bs_204802:PlaySkill(data)
  self:CallCasterWait(self.arglist[1])
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.arglist[1])
  self:InvincibleSummon()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, self.arglist[1], true)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1])
end

function bs_204802:InvincibleSummon()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_invincible, 1, self.arglist[1], true)
  LuaSkillCtrl:StartTimer(self, self.arglist[1], function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, 1)
  end)
  LuaSkillCtrl:StartTimer(self, self.arglist[1] + 15, function()
    if self.heal > 0 then
      LuaSkillCtrl:CallHeal(self.heal, self, self.caster)
      LuaSkillCtrl:CallEffect(self.caster, self.config.effect_heal, self)
      self.heal = 0
    end
  end)
  LuaSkillCtrl:StartTimer(nil, 2, function()
    self:CallSummoner()
  end, nil, self.arglist[3], 2)
end

function bs_204802:CallSummoner()
  local EmptyGrids = LuaSkillCtrl:FindEmptyGrid(nil)
  if EmptyGrids == nil then
    return
  end
  local x = EmptyGrids.x
  local y = EmptyGrids.y
  local effectGrid = LuaSkillCtrl:GetTargetWithGrid(x, y)
  LuaSkillCtrl:CallEffect(effectGrid, self.config.effect_summon, self)
  local num = LuaSkillCtrl:CallRange(25, 28)
  local summoner = LuaSkillCtrl:CreateSummoner(self, num, x, y)
  summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.maxHpPer // 1000)
  summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.config.powPer // 1000)
  summoner:SetAttr(eHeroAttr.intensity, self.caster.intensity * self.config.powPer // 1000)
  summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  LuaSkillCtrl:CallBuff(self, summonerEntity, 2048040, 1, nil, true)
  summonerEntity.recordTable.IsSummoner = true
  self.SummonerAliveCount = self.SummonerAliveCount + 1
  LuaSkillCtrl:StartTimer(self, self.arglist[1], function()
    local IfRoleCotainsIgnoreDieBuff = LuaSkillCtrl:RoleContainsBuffFeature(summonerEntity, self.config.buffFeature_ignoreDie)
    if IfRoleCotainsIgnoreDieBuff == true then
      local buff_ignoreDie = LuaSkillCtrl:GetRoleAllBuffsByFeature(summonerEntity, self.config.buffFeature_ignoreDie)
      if buff_ignoreDie.Count > 0 then
        for i = 0, buff_ignoreDie.Count - 1 do
          LuaSkillCtrl:DispelBuff(summonerEntity, buff_ignoreDie[i].dataId, 0)
          IfRoleCotainsIgnoreDieBuff = false
        end
      end
    end
    if 0 < summonerEntity.hp and IfRoleCotainsIgnoreDieBuff == false then
      self.heal = summonerEntity.hp * self.arglist[2] // 1000 + self.heal
      LuaSkillCtrl:RemoveLife(summonerEntity.hp, self, summonerEntity, true, nil, false, true, eHurtType.RealDmg, true)
      LuaSkillCtrl:CallEffect(summonerEntity, self.config.effect_killSummoner, self)
      LuaSkillCtrl:CallEffect(summonerEntity, self.config.effect_zd, self, nil, self.caster, 1, true)
      self.SummonerAliveCount = 0
    end
  end)
end

function bs_204802:RoleDie(role)
  local camp = role.camp
  if role.roleType == eBattleRoleType.realSummoner then
    camp = LuaSkillCtrl:GetSummonerCamp(role)
  end
  if camp == 2 and role ~= self.caster and role.recordTable.IsSummoner == true then
    self.SummonerAliveCount = self.SummonerAliveCount - 1
  end
  local InvincibleBuff = LuaSkillCtrl:GetRoleBuffById(self.caster, self.config.buff_invincible)
  if self.SummonerAliveCount == 0 and InvincibleBuff ~= nil then
    LuaSkillCtrl:DispelBuffByMaker(self.caster, self.caster, self.config.buffId_170, 1, true)
    LuaSkillCtrl:DispelBuffByMaker(self.caster, self.caster, self.config.buff_invincible, 1, true)
    self:CancleCasterWait()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, 1)
    LuaSkillCtrl:StopShowSkillDurationTime(self)
  end
end

function bs_204802:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_204802:LuaDispose()
  base.LuaDispose(self)
end

return bs_204802
