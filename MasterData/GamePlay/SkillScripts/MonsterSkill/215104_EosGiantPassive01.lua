local bs_215104 = class("bs_215104", LuaSkillBase)
local base = LuaSkillBase
bs_215104.config = {
  monsterId = 106,
  giantHitCheckTime = 3,
  giantBuffCheckTime = 3
}
bs_215104.summonerGrids = {
  {x = 4, y = 2},
  {x = 4, y = 1},
  {x = 4, y = 3},
  {x = 5, y = 3},
  {x = 5, y = 1},
  {x = 6, y = 2}
}

function bs_215104:ctor()
end

function bs_215104:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_215104_1", 1, self.OnAfterBattleStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnCreatGiantHitGrid, self.OnCreatGiantHitGrid)
  self:AddLuaTrigger(eSkillLuaTrigger.OnDestoryGiantHitGrid, self.OnDestoryGiantHitGrid)
  self:AddHurtResultEndTriggerForTable("bs_25104_2", 1, self.OnHurtResultEnd, {
    target = self.caster
  })
  self:AddHurtResultStartTriggerForTable("bs_215104_3", 1, self.OnHurtResultStart, {
    target = self.caster
  })
  self:AddBeforeAddBuffTriggerForTable("bs_25104_4", 1, self.OnBeforeAddBuff, {
    target = self.caster
  })
  self.summoners = {}
  self.giantHitCheck = {}
  self.giantBuffCheck = {}
  self.caster.recordTable.giantHitCheck = self.giantHitCheck
  self.caster.recordTable.giantBuffCheck = self.giantBuffCheck
end

function bs_215104:OnAfterBattleStart()
  for k, grid in pairs(self.summonerGrids) do
    self:Summon(grid.x, grid.y)
  end
  self.hitCheckTimer = LuaSkillCtrl:StartTimer(nil, self.config.giantHitCheckTime, BindCallback(self, self.GiantHitCheck), self)
  self.buffCheckTimer = LuaSkillCtrl:StartTimer(nil, self.config.giantBuffCheckTime, BindCallback(self, self.GiantBuffCheck), self)
end

function bs_215104:GiantHitCheck()
  self.giantHitCheck = {}
end

function bs_215104:GiantBuffCheck()
  self.giantBuffCheck = {}
end

function bs_215104:Summon(gridx, gridy)
  local summonerEntity
  local target = LuaSkillCtrl:GetTargetWithGrid(gridx, gridy)
  if target.targetRole == nil then
    local monsterId = self.config.monsterId
    local summoner = LuaSkillCtrl:CreateSummoner(self, monsterId, gridx, gridy)
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp)
    summoner:SetAsRealEntity(8)
    summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    if summonerEntity ~= nil then
      self.summoners[summonerEntity] = true
    end
  end
end

function bs_215104:OnCreatGiantHitGrid(entity, gridx, gridy)
  if self.caster ~= entity then
    return
  end
  self:Summon(gridx, gridy)
end

function bs_215104:OnDestoryGiantHitGrid(entity, gridx, gridy)
  if self.caster ~= entity then
    return
  end
  local role = LuaSkillCtrl:GetRoleWithPos(gridx, gridx)
  if self.summoners[role] == true then
    self.summoners[role] = nil
    LuaSkillCtrl:RemoveLife(role.hp + 1, self, role, false, nil, false, true, nil, true)
  end
end

function bs_215104:OnHurtResultStart(skill, context)
  if self.giantHitCheck[skill] == true then
    context.active = false
  end
end

function bs_215104:OnBeforeAddBuff(target, context)
  local buff = context.buff
  if self.giantBuffCheck[buff.dataId] ~= nil and self.giantBuffCheck[buff.dataId] ~= self.caster then
    context.active = false
    return
  end
  self.giantBuffCheck[buff.dataId] = self.caster
end

function bs_215104:OnHurtResultEnd(skill, targetRole, hurtValue)
  self.giantHitCheck[skill] = true
end

function bs_215104:OnCasterDie()
  base.OnCasterDie(self)
  for summoner, v in pairs(self.summoners) do
    LuaSkillCtrl:RemoveLife(summoner.hp + 1, self, summoner, false, nil, false, true, nil, true)
  end
  self.summoners = {}
  if self.hitCheckTimer ~= nil then
    self.hitCheckTimer:Stop()
    self.hitCheckTimer = nil
  end
  if self.buffCheckTimer ~= nil then
    self.buffCheckTimer:Stop()
    self.buffCheckTimer = nil
  end
end

function bs_215104:LuaDispose()
  base.LuaDispose(self)
  self.summoners = nil
  self.giantHitCheck = nil
  self.giantBuffCheck = nil
end

return bs_215104
