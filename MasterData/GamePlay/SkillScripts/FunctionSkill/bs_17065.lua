local bs_17065 = class("bs_17065", LuaSkillBase)
local base = LuaSkillBase
bs_17065.config = {
  monsterId = 70,
  effectId_start = 10264,
  arglist_11 = 500,
  arglist_13 = 500,
  arglist_21 = 650,
  arglist_23 = 1000,
  arglist_31 = 800,
  arglist_33 = 1500
}

function bs_17065:ctor()
end

function bs_17065:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17065_1", 1, self.OnAfterBattleStart)
  self:AddOnRoleDieTrigger("bs_17065_2", 1, self.OnRoleDie, nil, nil, nil, self.caster.belongNum)
  self.flag = self.arglist[3]
  self.maxCount = self.arglist[2]
  self.Count = 0
  self.table = {}
end

function bs_17065:OnAfterBattleStart()
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], BindCallback(self, self.doSummon), nil, -1, 0)
end

function bs_17065:doSummon()
  if self.Count < self.maxCount then
    self:Summon()
  end
end

function bs_17065:Summon()
  local targetGrid = LuaSkillCtrl:FindEmptyGrid()
  if targetGrid ~= nil then
    if self.flag == 1 then
      local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, targetGrid.x, targetGrid.y)
      summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.arglist_11 // 1000)
      summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.config.arglist_13 // 1000)
      summoner:SetAttr(eHeroAttr.speed, 0)
      summoner:SetAsRealEntity(1)
      local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
      summonerEntity.recordTable.deathTime = self.arglist[4]
      LuaSkillCtrl:CallEffect(summonerEntity, self.config.effectId_start, self)
      self.Count = self.Count + 1
      self.table[self.Count] = summonerEntity
    elseif self.flag == 2 then
      local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, targetGrid.x, targetGrid.y)
      summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.arglist_21 // 1000)
      summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.config.arglist_23 // 1000)
      summoner:SetAttr(eHeroAttr.speed, 0)
      summoner:SetAsRealEntity(1)
      local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
      summonerEntity.recordTable.deathTime = self.arglist[4]
      LuaSkillCtrl:CallEffect(summonerEntity, self.config.effectId_start, self)
      self.Count = self.Count + 1
      self.table[self.Count] = summonerEntity
    elseif self.flag == 3 then
      local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, targetGrid.x, targetGrid.y)
      summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.arglist_31 // 1000)
      summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.config.arglist_33 // 1000)
      summoner:SetAttr(eHeroAttr.speed, 0)
      summoner:SetAsRealEntity(1)
      local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
      summonerEntity.recordTable.deathTime = self.arglist[4]
      LuaSkillCtrl:CallEffect(summonerEntity, self.config.effectId_start, self)
      self.Count = self.Count + 1
      self.table[self.Count] = summonerEntity
    end
  end
end

function bs_17065:OnRoleDie(killer, role)
  if role == self.table[1] then
    self.table[1] = self.table[2]
    self.table[2] = self.table[3]
    self.table[3] = nil
    self.Count = self.Count - 1
  elseif role == self.table[2] then
    self.table[2] = self.table[3]
    self.table[3] = nil
    self.Count = self.Count - 1
  elseif role == self.table[3] then
    self.table[3] = nil
    self.Count = self.Count - 1
  end
end

function bs_17065:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_17065:LuaDispose()
  base.LuaDispose(self)
  self.table = nil
end

return bs_17065
