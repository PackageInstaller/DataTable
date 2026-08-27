local EpMvpData = class("EpMvpData")
local cs_BattleStatistics = CS.BattleStatistics.Instance
EpMvpData.mvpParaType = {
  injury = 1,
  damage = 2,
  selfHeal = 3,
  otherHeal = 4
}
EpMvpData.mvpType = {
  heal = 0,
  damagem = 1,
  injury = 2
}

function EpMvpData:ctor(heros)
  self.heroStatisicsDic = {}
  self.heroBossDic = {}
  self.totalDamage = 0
  self.totalInjury = 0
  self.totalHeal = 0
  self.cachedMvpId = nil
  self.dirtyData = false
  self.defaultMVPHeroId = nil
  self.heroIdMapping = {}
  for k, v in pairs(heros) do
    self.heroIdMapping[v.uid] = v.dataId
    if self.defaultMVPHeroId == nil then
      self.defaultMVPHeroId = v.dataId
    end
  end
end

function EpMvpData:UpdataEpMvpDataHeroIdMapping(heros, removeHeroList)
  self.heroIdMapping = {}
  for k, v in pairs(heros) do
    self.heroIdMapping[v.uid] = v.dataId
  end
  for k, dynHero in ipairs(removeHeroList) do
    self.heroStatisicsDic[dynHero.dataId] = nil
    self.heroBossDic[dynHero.dataId] = nil
  end
  self.defaultMVPHeroId = heros[1].dataId
end

function EpMvpData:AddHeroData(heroId, damage, ingjury, healSelf, healOther)
  self.totalDamage = self.totalDamage + damage
  self.totalInjury = self.totalInjury + ingjury
  self.totalHeal = self.totalHeal + healSelf + healOther
  if self.heroStatisicsDic[heroId] == nil then
    self.heroStatisicsDic[heroId] = {
      damage = 0,
      ingjury = 0,
      healSelf = 0,
      healOther = 0
    }
  end
  self.heroStatisicsDic[heroId].damage = self.heroStatisicsDic[heroId].damage + damage
  self.heroStatisicsDic[heroId].ingjury = self.heroStatisicsDic[heroId].ingjury + ingjury
  self.heroStatisicsDic[heroId].healSelf = self.heroStatisicsDic[heroId].healSelf + healSelf
  self.heroStatisicsDic[heroId].healOther = self.heroStatisicsDic[heroId].healOther + healOther
  self.dirtyData = true
end

function EpMvpData:CoverBossFightData(heroId, damage, ingjury, healSelf, healOther)
  self.heroBossDic[heroId] = {
    damage = damage or 0,
    ingjury = ingjury or 0,
    healSelf = healSelf or 0,
    healOther = healOther or 0
  }
end

function EpMvpData:AddBattleStatisticsData(isBossFight)
  local temp = {}
  
  local function getTempSingleFunc(id)
    local res = temp[id]
    if res == nil then
      res = {
        damage = 0,
        ingjury = 0,
        healSelf = 0,
        healOther = 0
      }
      temp[id] = res
    end
    return res
  end
  
  for key, value in pairs(cs_BattleStatistics.playerDamage) do
    if key.roleType == eBattleRoleType.character and key.belongNum == eBattleRoleBelong.player then
      getTempSingleFunc(key.roleDataId).damage = value.damage
    end
  end
  for key, value in pairs(cs_BattleStatistics.playerTakeDamage) do
    if key.roleType == eBattleRoleType.character and key.belongNum == eBattleRoleBelong.player then
      getTempSingleFunc(key.roleDataId).ingjury = value.damage
    end
  end
  for key, value in pairs(cs_BattleStatistics.playerHeal) do
    if key.roleType == eBattleRoleType.character and key.belongNum == eBattleRoleBelong.player then
      local tempSingle = getTempSingleFunc(key.roleDataId)
      tempSingle.healSelf = value.selfHeal
      tempSingle.healOther = value.otherHeal
    end
  end
  for key, value in pairs(temp) do
    self:AddHeroData(key, value.damage, value.ingjury, value.healSelf, value.healOther)
    if isBossFight then
      self:CoverBossFightData(key, value.damage, value.ingjury, value.healSelf, value.healOther)
    end
  end
end

function EpMvpData:AddServerSaveData(data)
  for uid, value in pairs(data) do
    local heroId = self.heroIdMapping[uid]
    if heroId == nil then
      error("heroId Inexistence " .. tostring(uid))
    else
      local heroCfg = ConfigData.hero_data[heroId]
      if heroCfg ~= nil then
        if value.record ~= nil and value.record ~= nil then
          local record = value.record
          self:AddHeroData(heroId, record[2], record[1], record[3], record[4])
        end
        if value.record ~= nil and value.bossRecord ~= nil then
          local record = value.bossRecord
          self:CoverBossFightData(heroId, record[2], record[1], record[3], record[4])
        end
      end
    end
  end
end

function EpMvpData:CalculateMvp(datadDic)
  local mvpList = {}
  for heroId, data in pairs(datadDic) do
    local MvpNum
    local dataId = heroId
    local heroCfg = ConfigData.hero_data[dataId]
    if heroCfg == nil then
      error("can't read heroData config heroId = " .. dataId)
    else
      MvpNum = data.damage * (heroCfg.mvp_para[EpMvpData.mvpParaType.damage] or 1) + data.ingjury * (heroCfg.mvp_para[EpMvpData.mvpParaType.injury] or 1) + data.healSelf * (heroCfg.mvp_para[EpMvpData.mvpParaType.selfHeal] or 1) + data.healOther * (heroCfg.mvp_para[EpMvpData.mvpParaType.otherHeal] or 1)
      table.insert(mvpList, {heroId = dataId, MvpNum = MvpNum})
    end
  end
  table.sort(mvpList, function(a, b)
    if a.MvpNum ~= b.MvpNum then
      return a.MvpNum > b.MvpNum
    else
      return a.heroId < b.heroId
    end
  end)
  return mvpList[1]
end

function EpMvpData:GetEpMvpID()
  if self.dirtyData then
    self.dirtyData = false
  else
    return self.cachedMvpId ~= nil and self.cachedMvpId or self.defaultMVPHeroId
  end
  local mvpData = self:CalculateMvp(self.heroStatisicsDic)
  if mvpData ~= nil then
    self.cachedMvpId = mvpData.heroId
  end
  return self.cachedMvpId ~= nil and self.cachedMvpId or self.defaultMVPHeroId
end

function EpMvpData:GetEpMvpData()
  local MvpType = EpMvpData.mvpType.damagem
  local diggestRate = 0
  local heroId = self:GetEpMvpID()
  if heroId == nil then
    heroId = self.defaultMVPHeroId
  end
  local heroData = self.heroStatisicsDic[heroId]
  local healRate
  if self.totalHeal == 0 then
    healRate = 0
  else
    healRate = (heroData.healSelf + heroData.healOther) / self.totalHeal
  end
  if diggestRate <= healRate then
    MvpType = EpMvpData.mvpType.heal
    diggestRate = healRate
  end
  local injuryRate
  if self.totalInjury == 0 then
    injuryRate = 0
  else
    injuryRate = heroData.ingjury / self.totalInjury
  end
  if diggestRate <= injuryRate then
    MvpType = EpMvpData.mvpType.injury
    diggestRate = injuryRate
  end
  local damageRate
  if self.totalDamage == 0 then
    damageRate = 0
  else
    damageRate = heroData.damage / self.totalDamage
  end
  if diggestRate <= damageRate then
    MvpType = EpMvpData.mvpType.damagem
    diggestRate = damageRate
  end
  return heroId, MvpType, diggestRate
end

function EpMvpData:GetSaveData(heroId, containsBossFightData)
  local recordArry = {}
  local heroStatisics = self.heroStatisicsDic[heroId]
  if heroStatisics ~= nil then
    table.insert(recordArry, heroStatisics.ingjury)
    table.insert(recordArry, heroStatisics.damage)
    table.insert(recordArry, heroStatisics.healSelf)
    table.insert(recordArry, heroStatisics.healOther)
  else
    table.insert(recordArry, 0)
    table.insert(recordArry, 0)
    table.insert(recordArry, 0)
    table.insert(recordArry, 0)
  end
  local bossRecordArray
  if containsBossFightData then
    bossRecordArray = {}
    local heroBossFightData = self.heroBossDic[heroId]
    if heroBossFightData ~= nil then
      table.insert(bossRecordArray, heroBossFightData.ingjury)
      table.insert(bossRecordArray, heroBossFightData.damage)
      table.insert(bossRecordArray, heroBossFightData.healSelf)
      table.insert(bossRecordArray, heroBossFightData.healOther)
    else
      table.insert(bossRecordArray, 0)
      table.insert(bossRecordArray, 0)
      table.insert(bossRecordArray, 0)
      table.insert(bossRecordArray, 0)
    end
  end
  return {record = recordArry, bossRecord = bossRecordArray}
end

function EpMvpData:GetBossFightMvp(isNeedUid)
  local mvpId
  local mvpData = self:CalculateMvp(self.heroBossDic)
  if mvpData ~= nil then
    mvpId = mvpData.heroId
  else
    mvpId = self:GetEpMvpID()
  end
  if isNeedUid then
    mvpId = self:GetUidByDataId(mvpId)
  end
  return mvpId
end

function EpMvpData:GetUidByDataId(dataId)
  for k, v in pairs(self.heroIdMapping) do
    if v == dataId then
      return k
    end
  end
  return nil
end

return EpMvpData
