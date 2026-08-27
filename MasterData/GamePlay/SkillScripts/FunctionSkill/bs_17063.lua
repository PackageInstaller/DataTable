local bs_17063 = class("bs_17063", LuaSkillBase)
local base = LuaSkillBase
bs_17063.config = {
  monsterId = 1014,
  equipmentSummonerId = {1023, 1024},
  effectId = 12025,
  effectId_start = 5002205,
  arglist_11 = 300,
  arglist_12 = 700,
  arglist_13 = 700,
  arglist_14 = 1000,
  arglist_15 = 1000,
  arglist_21 = 600,
  arglist_22 = 1000,
  arglist_23 = 1000,
  arglist_24 = 1000,
  arglist_25 = 1000,
  arglist_31 = 1000,
  arglist_32 = 1500,
  arglist_33 = 1500,
  arglist_34 = 1000,
  arglist_35 = 1000
}

function bs_17063:ctor()
end

function bs_17063:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17063_1", 1, self.OnAfterBattleStart)
  self:AddOnRoleDieTrigger("bs_17063_2", 1, self.OnRoleDie, nil, nil, nil, self.caster.belongNum)
  self.flag = self.arglist[3]
  self.maxCount = self.arglist[2]
  self.Count = 0
  self.table = {}
end

function bs_17063:OnAfterBattleStart()
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], BindCallback(self, self.doSummon), nil, -1, 0)
end

function bs_17063:doSummon()
  if self.Count < self.maxCount then
    self:Summon()
  end
end

function bs_17063:Summon()
  local targetGrid = LuaSkillCtrl:FindEmptyGrid()
  if targetGrid ~= nil then
    if self.flag == 1 then
      local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, targetGrid.x, targetGrid.y)
      summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.arglist_11 // 1000)
      summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.config.arglist_12 // 1000)
      summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.config.arglist_13 // 1000)
      summoner:SetAttr(eHeroAttr.def, self.caster.def * self.config.arglist_14 // 1000)
      summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res * self.config.arglist_15 // 1000)
      summoner:SetAsRealEntity(1)
      local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
      self:CallSelectExecute(summonerEntity)
      self.Count = self.Count + 1
      self.table[self.Count] = summonerEntity
      LuaSkillCtrl:CallEffect(summonerEntity, self.config.effectId_start, self)
    elseif self.flag == 2 then
      local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, targetGrid.x, targetGrid.y)
      summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.arglist_21 // 1000)
      summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.config.arglist_22 // 1000)
      summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.config.arglist_23 // 1000)
      summoner:SetAttr(eHeroAttr.def, self.caster.def * self.config.arglist_24 // 1000)
      summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res * self.config.arglist_25 // 1000)
      summoner:SetAsRealEntity(1)
      local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
      self:CallSelectExecute(summonerEntity)
      self.Count = self.Count + 1
      self.table[self.Count] = summonerEntity
      LuaSkillCtrl:CallEffect(summonerEntity, self.config.effectId_start, self)
    elseif self.flag == 3 then
      local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, targetGrid.x, targetGrid.y)
      summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.arglist_31 // 1000)
      summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.config.arglist_32 // 1000)
      summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.config.arglist_33 // 1000)
      summoner:SetAttr(eHeroAttr.def, self.caster.def * self.config.arglist_34 // 1000)
      summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res * self.config.arglist_35 // 1000)
      summoner:SetAsRealEntity(1)
      local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
      self:CallSelectExecute(summonerEntity)
      self.Count = self.Count + 1
      self.table[self.Count] = summonerEntity
      LuaSkillCtrl:CallEffect(summonerEntity, self.config.effectId_start, self)
    end
  end
end

function bs_17063:OnRoleDie(killer, role)
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

function bs_17063:CallSelectExecute(role)
  if role == nil then
    return
  end
  local existSummoner = LuaSkillCtrl:GetEquipmentSummonerOrHostEntity(role)
  if existSummoner ~= nil then
    warn("该人形已装备了义肢")
    return
  end
  local index = LuaSkillCtrl:CallRange(1, 2)
  local equipmentId = self.config.equipmentSummonerId[index]
  local summoner = LuaSkillCtrl:CreateSummoner(self, equipmentId, role.x, role.y)
  summoner:SetAttr(eHeroAttr.maxHp, 1)
  summoner:SetAttr(eHeroAttr.pow, 1)
  summoner:SetAttr(eHeroAttr.intensity, 1)
  summoner:SetAttr(eHeroAttr.speed, role.speed)
  summoner:SetAsRealEntity(15)
  local key = ConfigData.buildinConfig.EquipmentSummonerKey
  local tab = {
    [key] = role
  }
  summoner:SetRecordTable(tab)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  if summonerEntity ~= nil then
    LuaSkillCtrl:CallBuff(self, summonerEntity, ConfigData.buildinConfig.EquipmentSummonerInvinsibleBuffId, 1, nil)
    role.recordTable[key] = summonerEntity
    if not LuaSkillCtrl.IsInVerify then
      local trans = summonerEntity.lsObject.transform
      if not IsNull(trans) then
        trans:SetLocalScale(trans.localScale.x, trans.localScale.y, -trans.localScale.z)
      end
    end
    summonerEntity:BindHostEntity(role)
  end
  LuaSkillCtrl:CallEffect(summonerEntity, self.config.effectId, self)
end

function bs_17063:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_17063:LuaDispose()
  base.LuaDispose(self)
  self.table = nil
end

return bs_17063
