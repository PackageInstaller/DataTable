local bs_40035 = class("bs_40035", LuaSkillBase)
local base = LuaSkillBase
bs_40035.config = {
  smallMonsterId = {
    3,
    4,
    5
  },
  middleMonsterId = {
    20,
    21,
    22
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
  maxHpPer = 180,
  powPer = 700,
  skill_intensityPer = 700,
  audioId1 = 300
}

function bs_40035:ctor()
end

function bs_40035:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_40035_1", 1, self.OnAfterBattleStart)
end

function bs_40035:OnAfterBattleStart()
  self.damTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.CallBack, self, -1, self.arglist[1])
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1033, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_196, 1, nil, true)
  self.caster.recordTable["40035_SummonTime"] = 0
  self.index = 1
end

function bs_40035:CallBack()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetList.Count < self.config.maxEnemyNum then
    local gridData = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
    if gridData == nil then
      return
    end
    self:CallCasterWait(self.config.skill_time)
    local moveAttackTrigger = BindCallback(self, self.OnMoveAttackTrigger, gridData)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.startAnimID, 1, self.config.skill_time, moveAttackTrigger)
  end
end

function bs_40035:OnMoveAttackTrigger(gridData)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  local cback = BindCallback(self, self.CallBack1, gridData.x, gridData.y)
  self.damTimer2 = LuaSkillCtrl:StartTimer(nil, 2, cback, nil, 0, 0)
end

function bs_40035:CallBack1(x, y)
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

function bs_40035:OnCasterDie()
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

return bs_40035
