local bs_201812 = class("bs_201812", LuaSkillBase)
local base = LuaSkillBase
bs_201812.config = {
  smallMonsterId = {
    3,
    4,
    5
  },
  middleMonsterId = {
    6,
    7,
    8
  },
  bigMonsterId = {9, 10},
  buffId = 1033,
  effectId = 10264,
  effectId1 = 10263,
  startAnimID = 1002,
  maxEnemyNum = 8,
  maxSummonNum = 10,
  buffId_196 = 196,
  buffId_1033 = 1033,
  skill_time = 18,
  maxHpPer = 150,
  powPer = 700,
  skill_intensityPer = 700,
  critPer = 1000,
  critDamagePer = 1000,
  defPer = 1000,
  sunderPer = 1000,
  magic_resPer = 1000,
  magic_penPer = 1000,
  audioId1 = 300
}

function bs_201812:ctor()
end

function bs_201812:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_201812_1", 1, self.OnAfterBattleStart)
end

function bs_201812:OnAfterBattleStart()
  self.damTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.CallBack, self, -1, self.arglist[1])
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1033, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_196, 1, nil, true)
  self.caster.recordTable["40035_SummonTime"] = 0
  self.index = 1
end

function bs_201812:CallBack()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetList.Count < self.config.maxEnemyNum then
    local gridData = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
    if gridData == nil then
      return
    end
    self:CallCasterWait(self.config.skill_time)
    local moveAttackTrigger = BindCallback(self, self.OnMoveAttackTrigger, gridData)
    self.timer = LuaSkillCtrl:StartTimer(self, self.config.skill_time, moveAttackTrigger)
  end
end

function bs_201812:OnMoveAttackTrigger(gridData)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  local cback = BindCallback(self, self.CallBack1, gridData.x, gridData.y)
  self.damTimer2 = LuaSkillCtrl:StartTimer(nil, 2, cback, nil, 0, 0)
end

function bs_201812:CallBack1(x, y)
  if self.damTimer2 ~= nil and self.damTimer2:IsOver() then
    self.damTimer2 = nil
  end
  local gridData = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
  if gridData == nil then
    return
  end
  x = gridData.x
  y = gridData.y
  local target = LuaSkillCtrl:GetTargetWithGrid(gridData.x, gridData.y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  if self.caster.recordTable["40035_SummonTime"] < self.config.maxSummonNum then
    if self.index > 3 then
      self.index = 1
    end
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.middleMonsterId[self.index], x, y)
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.maxHpPer // 1000)
    summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.config.powPer // 1000)
    summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.config.skill_intensityPer // 1000)
    summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
    summoner:SetAttr(eHeroAttr.def, self.caster.def * self.config.defPer // 1000)
    summoner:SetAttr(eHeroAttr.crit, self.caster.crit * self.config.critPer // 1000)
    summoner:SetAttr(eHeroAttr.critDamage, self.caster.critDamage * self.config.critDamagePer // 1000)
    summoner:SetAttr(eHeroAttr.sunder, self.caster.sunder * self.config.sunderPer // 1000)
    summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res * self.config.magic_resPer // 1000)
    summoner:SetAttr(eHeroAttr.magic_pen, self.caster.magic_pen * self.config.magic_penPer // 1000)
    summoner:SetAsRealEntity(1)
    local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    self.index = self.index + 1
  else
    if self.index > 3 then
      self.index = 1
    end
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.middleMonsterId[self.index], x, y)
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.maxHpPer // 1000)
    summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.config.powPer // 1000)
    summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.config.skill_intensityPer // 1000)
    summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
    summoner:SetAttr(eHeroAttr.def, self.caster.def * self.config.defPer // 1000)
    summoner:SetAttr(eHeroAttr.crit, self.caster.crit * self.config.critPer // 1000)
    summoner:SetAttr(eHeroAttr.critDamage, self.caster.critDamage * self.config.critDamagePer // 1000)
    summoner:SetAttr(eHeroAttr.sunder, self.caster.sunder * self.config.sunderPer // 1000)
    summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res * self.config.magic_resPer // 1000)
    summoner:SetAttr(eHeroAttr.magic_pen, self.caster.magic_pen * self.config.magic_penPer // 1000)
    summoner:SetAsRealEntity(1)
    local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    self.index = self.index + 1
  end
  local damage = self.caster.maxHp * self.arglist[2] // 1000
  if 1 < self.caster.hp then
    LuaSkillCtrl:RemoveLife(damage, self, self.caster)
    self.caster.recordTable["40035_SummonTime"] = self.caster.recordTable["40035_SummonTime"] + 1
  end
end

function bs_201812:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
  if self.damTimer2 then
    self.damTimer2:Stop()
    self.damTimer2 = nil
  end
end

return bs_201812
