local AllAthData = class("AllAthData")
local ArithmeticData = require("Game.PlayerData.Arithmetic.ArithmeticData")

function AllAthData:ctor()
  self.athDic = {}
  self.slotAthDic = {}
  for i = 1, ConfigData.game_config.athSlotCount do
    self.slotAthDic[i] = {}
  end
  self.heroAthDic = {}
  self.heroAthSlotDic = {}
  self.failure = 0
  self._showSuitUsingRate = true
end

function AllAthData:InitAllAthData(msg)
  self.athDic = {}
  self.heroAthDic = {}
  self.slotAthDic = {}
  for i = 1, ConfigData.game_config.athSlotCount do
    self.slotAthDic[i] = {}
  end
  self.heroAthSlotDic = msg.heroSlot
  self.failure = msg.failure
  self.autoDeco = msg.autoDeco
  self.athReconsitutionDataList = msg.reconsitution
end

function AllAthData:InitBatchAllAthData(msg)
  for uid, v in pairs(msg.data) do
    self:__NewAthData(v)
  end
end

function AllAthData:UpdateAthReconsitutionData(reconsitution)
  self.athReconsitutionDataList = reconsitution
end

function AllAthData:SyncAthDiff(msg)
  PlayerDataCenter.lastAthDiff = {}
  for uid, v in pairs(msg.updateAth) do
    local athData = self.athDic[uid]
    if athData == nil then
      athData = self:__NewAthData(v)
    else
      local oldBindInfo = athData.bindInfo
      athData:UpdateAthData(v)
      if athData.bindInfo ~= nil then
        PlayerDataCenter.attributeBonus:DirtyHeroAthBonus(athData.bindInfo.id)
      end
      local newBindInfo = athData.bindInfo
      if oldBindInfo ~= nil and newBindInfo == nil then
        self:__RemoveFromHero(oldBindInfo.id, oldBindInfo.idx, athData.uid)
      elseif oldBindInfo ~= nil and newBindInfo ~= nil and oldBindInfo.id ~= newBindInfo.id then
        self:__RemoveFromHero(oldBindInfo.id, oldBindInfo.idx, athData.uid)
        self:__AddToHero(athData)
      elseif oldBindInfo == nil and newBindInfo ~= nil then
        self:__AddToHero(athData)
      end
    end
    table.insert(PlayerDataCenter.lastAthDiff, athData)
  end
  for uid, v in pairs(msg.deleteAth) do
    local athData = self.athDic[uid]
    if athData ~= nil then
      self:__RemoveFromSlot(athData)
      if athData.bindInfo ~= nil then
        self:__RemoveFromHero(athData.bindInfo.id, athData.bindInfo.idx, uid)
      end
      self.athDic[uid] = nil
    end
  end
  for heroId, v in pairs(msg.heroSlot) do
    self.heroAthSlotDic[heroId] = v
    PlayerDataCenter.attributeBonus:DirtyHeroAthBonus(heroId)
  end
end

function AllAthData:UpdateAthFalure(faluer)
  self.failure = faluer
end

function AllAthData:__NewAthData(msg)
  local athData = ArithmeticData.New(msg)
  self.athDic[athData.uid] = athData
  self:__AddToSlot(athData)
  self:__AddToHero(athData)
  return athData
end

function AllAthData:__AddToSlot(athData)
  local slotAthList = self.slotAthDic[athData.area_type]
  if slotAthList == nil then
    error("Can't find arithmetic slot. slot id = " .. tostring(athData.bindInfo.idx))
    return
  end
  slotAthList[athData.uid] = athData
end

function AllAthData:__RemoveFromSlot(athData)
  local slotAthList = self.slotAthDic[athData.area_type]
  if slotAthList == nil then
    return
  end
  slotAthList[athData.uid] = nil
end

function AllAthData:__AddToHero(athData)
  if athData.bindInfo ~= nil then
    local heroId = athData.bindInfo.id
    local slotId = athData.bindInfo.idx
    local heroAth = self.heroAthDic[heroId]
    if heroAth == nil then
      heroAth = {}
      self.heroAthDic[heroId] = heroAth
    end
    local heroAthSlot = heroAth[slotId]
    if heroAthSlot == nil then
      heroAthSlot = {}
      heroAth[slotId] = heroAthSlot
    end
    heroAthSlot[athData.uid] = athData
    PlayerDataCenter.attributeBonus:DirtyHeroAthBonus(heroId)
  end
end

function AllAthData:__RemoveFromHero(heroId, slotId, uid)
  local heroAth = self.heroAthDic[heroId]
  if heroAth == nil then
    return
  end
  local heroAthSlot = heroAth[slotId]
  if heroAthSlot == nil then
    return
  end
  heroAthSlot[uid] = nil
  PlayerDataCenter.attributeBonus:DirtyHeroAthBonus(heroId)
end

function AllAthData:GetHeroAthList(heroId, slotId)
  local heroAth = self.heroAthDic[heroId]
  if heroAth == nil then
    return {}, {}
  end
  local athDic = heroAth[slotId]
  if athDic == nil then
    return {}, {}
  end
  local athList = {}
  for uid, data in pairs(athDic) do
    table.insert(athList, data)
  end
  table.sort(athList, function(a, b)
    if a.size ~= b.size then
      return a.size < b.size
    else
      return a.id < b.id
    end
  end)
  return athList, athDic
end

function AllAthData:GetHeroAthSlotInfo(heroId)
  local level = 1
  local exp = 0
  local heroArea = self.heroAthSlotDic[heroId]
  if heroArea ~= nil then
    level = heroArea.lv
    exp = heroArea.exp
  end
  return level, exp
end

function AllAthData:IsHeroAthSlotMaxLevel(heroId)
  local level = self:GetHeroAthSlotInfo(heroId)
  return level >= ConfigData.ath_efficiency.maxLevel
end

function AllAthData:GetAllAthList(space, ignoreInstalled, quality)
  local dic = self.athDic
  if dic == nil then
    error("Can't find athDic")
    return {}
  end
  local list = {}
  for k, v in pairs(dic) do
    if (not ignoreInstalled or v.bindInfo == nil) and (quality == nil or v:GetAthQuality() == quality) then
      if space == nil then
        table.insert(list, v)
      elseif v.size == space then
        table.insert(list, v)
      end
    end
  end
  return list
end

function AllAthData:GetAllAthSlotList(slotId, space, ignoreInstalled, withoutIgnoreHeroId)
  local dic = self.slotAthDic[slotId]
  if dic == nil then
    error("Can't find slotAthDic, slotId = " .. tostring(slotId))
    return {}
  end
  local list = {}
  for k, v in pairs(dic) do
    if not ignoreInstalled or v.bindInfo == nil or v.bindInfo.id == withoutIgnoreHeroId then
      if space == nil then
        table.insert(list, v)
      elseif v.size == space then
        table.insert(list, v)
      end
    end
  end
  return list
end

function AllAthData:GetAthEfficiency(slotLevel)
  local cfg = ConfigData.ath_efficiency[slotLevel]
  if cfg == nil then
    error("Can't find ath_efficiency, level = " .. tostring(slotLevel))
    return 0
  end
  return cfg.attribute_promote
end

function AllAthData:HeroContainAthById(heroId, slotId, athId)
  local heroAth = self.heroAthDic[heroId]
  if heroAth == nil then
    return false
  end
  if slotId == nil then
    for k, athDic in pairs(heroAth) do
      for uid, data in pairs(athDic) do
        if data.id == athId then
          return true, data
        end
      end
    end
  else
    local athDic = heroAth[slotId]
    if athDic == nil then
      return false
    end
    for uid, data in pairs(athDic) do
      if data.id == athId then
        return true, data
      end
    end
  end
  return false
end

function AllAthData:HeroContainAthByUid(heroId, uid)
  local heroAth = self.heroAthDic[heroId]
  if heroAth == nil then
    return false
  end
  for k, athDic in pairs(heroAth) do
    for installUid, data in pairs(athDic) do
      if uid == installUid then
        return true
      end
    end
  end
end

function AllAthData:GetHeroAthFreeSpace(heroData, slotId)
  local ok = false
  local freeSpace = 0
  local usedSpace = 0
  self.curheroAth = self.heroAthDic[heroData.dataId]
  if self.curheroAth ~= nil then
    self.currAthDic = self.curheroAth[slotId]
    if self.currAthDic ~= nil then
      for uid, data in pairs(self.currAthDic) do
        usedSpace = usedSpace + data.size
      end
    end
  end
  local heroAthSpace = heroData:GetAthSlotList()[slotId]
  if heroAthSpace == nil then
    return ok, freeSpace
  end
  freeSpace = heroAthSpace - usedSpace
  if 0 < freeSpace then
    ok = true
  end
  return ok, freeSpace
end

function AllAthData:GetHeroCanLoaded(heroData)
  local athslotList = heroData:GetAthSlotList()
  for slotId, v in ipairs(athslotList) do
    if self:GetHeroCanLoadedSlot(heroData, slotId) then
      return true
    end
  end
  return false
end

function AllAthData:GetHeroCanLoadedSlot(heroData, slotId, ignoreSpace)
  local ATHCount = 0
  local canLoad = false
  local freeSpace = 0
  if not ignoreSpace then
    local ok
    ok, freeSpace = self:GetHeroAthFreeSpace(heroData, slotId)
    if not ok then
      return canLoad, ATHCount
    end
  end
  local slotList = self:GetAllAthSlotList(slotId, nil, true)
  local athDataList, athDic = self:GetHeroAthList(heroData.dataId, slotId)
  local installedAthIdDic = {}
  local installedAthSuitDic = {}
  for k, athData in pairs(athDic) do
    installedAthIdDic[athData.id] = true
    local suitId = athData:GetAthSuit()
    local conflictId = athData:GetAthSuitConflictId()
    if suitId ~= 0 and conflictId ~= 0 then
      installedAthSuitDic[suitId] = installedAthSuitDic[suitId] or {}
      installedAthSuitDic[suitId][conflictId] = true
    end
  end
  for k, data in pairs(slotList) do
    local suitId = data:GetAthSuit()
    local suitCfltId = data:GetAthSuitConflictId()
    if (ignoreSpace or freeSpace >= data.size) and installedAthIdDic[data.id] == nil and (installedAthSuitDic[suitId] == nil or installedAthSuitDic[suitId][suitCfltId] == nil) then
      ATHCount = 1
      break
    end
  end
  if 0 < ATHCount then
    canLoad = true
  end
  return canLoad, ATHCount
end

function AllAthData:GetAthFightPower(athAttrDic)
  local power = ConfigData.GetFormulaValue(eFormulaType.Ath, athAttrDic)
  return power
end

function AllAthData:GetAthDensity(athAttrDic, size)
  local power = self:GetAthFightPower(athAttrDic)
  return power / size
end

function AllAthData:GetAthEfficiencyCfg(level)
  local cfg = ConfigData.ath_efficiency[level]
  if cfg == nil then
    error("Cant't get ath_efficiency cfg, level = " .. tostring(level))
    return nil
  end
  return cfg
end

function AllAthData:TryAddAthAreaExp(exp, curLevel, curExp)
  local curLvlCfg = self:GetAthEfficiencyCfg(curLevel)
  local nextExp = 0
  local nextTotalExp = curLvlCfg.shard
  local overflowExp = 0
  local testExp = exp + curExp
  local testLevel = curLevel
  for i = curLevel, ConfigData.ath_efficiency.maxLevel - 1 do
    local levelCfg = self:GetAthEfficiencyCfg(i)
    if levelCfg == nil then
      return testLevel, nextExp, nextTotalExp, overflowExp
    end
    nextTotalExp = levelCfg.shard
    if testExp < levelCfg.shard then
      break
    end
    testExp = testExp - levelCfg.shard
    testLevel = i + 1
  end
  if testLevel == ConfigData.ath_efficiency.maxLevel then
    nextExp = 0
    overflowExp = testExp
    nextTotalExp = 0
  else
    nextExp = testExp
    overflowExp = 0
  end
  return testLevel, nextExp, nextTotalExp, overflowExp
end

function AllAthData:GetHeroAthSuitIdDic(heroId, ignoreSlotId)
  local suitIdDic = {}
  local heroAth = self.heroAthDic[heroId]
  if heroAth == nil then
    return suitIdDic
  end
  for slotId, athDic in pairs(heroAth) do
    if ignoreSlotId ~= slotId then
      for uid, athData in pairs(athDic) do
        local suitId = athData:GetAthSuit()
        if suitId ~= 0 then
          suitIdDic[suitId] = true
        end
      end
    end
  end
  return suitIdDic
end

function AllAthData:GetHeroAthAttr(heroId)
  local heroData = PlayerDataCenter.heroDic[heroId]
  if heroData == nil then
    error("Can't get heroData, id = " .. tostring(heroId))
    return
  end
  local athSlotList = heroData:GetAthSlotList()
  local allAttrDic = table.GetDefaulValueTable(0)
  local allAttrDicNoEfcc = table.GetDefaulValueTable(0)
  local slotAttrTab = {}
  local slotAttrTabNoEfcc = {}
  local suitDic = {}
  for slotId, v in ipairs(athSlotList) do
    local attrDic = table.GetDefaulValueTable(0)
    local slotAttrDicNoEfcc = table.GetDefaulValueTable(0)
    slotAttrTab[slotId] = attrDic
    slotAttrTabNoEfcc[slotId] = slotAttrDicNoEfcc
    local athList = self:GetHeroAthList(heroId, slotId)
    for k, athData in ipairs(athList) do
      for k2, attrId in ipairs(athData.athMainAttrCfg.attrtibute_id) do
        local value = athData.athMainAttrCfg.attrtibute_num[k2]
        local slotLevel = self:GetHeroAthSlotInfo(heroId)
        local efficiency = self:GetAthEfficiency(slotLevel)
        local attrValue = value * efficiency // 1000
        attrDic[attrId] = attrValue + attrDic[attrId]
        slotAttrDicNoEfcc[attrId] = value + slotAttrDicNoEfcc[attrId]
        allAttrDic[attrId] = attrValue + allAttrDic[attrId]
        allAttrDicNoEfcc[attrId] = value + allAttrDicNoEfcc[attrId]
      end
      for k2, elem in ipairs(athData.affixList) do
        local cfg = ConfigData.ath_affix_pool[elem.id]
        if cfg == nil then
          error("Cant't find ath_affix_pool, id = " .. tostring(elem.id))
        else
          local attrId = cfg.affix_para
          local attrValue = elem.value
          attrDic[attrId] = attrValue + attrDic[attrId]
          slotAttrDicNoEfcc[attrId] = attrValue + slotAttrDicNoEfcc[attrId]
          allAttrDic[attrId] = attrValue + allAttrDic[attrId]
          allAttrDicNoEfcc[attrId] = attrValue + allAttrDicNoEfcc[attrId]
        end
      end
      local suitId = athData.suit
      if suitId ~= 0 and suitDic[suitId] == nil then
        local suitAthList = ConfigData.arithmetic.suitDic[suitId]
        if suitAthList == nil then
          error("Can't find ConfigData.arithmetic.suitDic,id = " .. tostring(suitId))
        end
        local suitAthCount = 0
        local suitAthDic = {}
        for k2, athIdList in pairs(suitAthList) do
          for k3, athId in ipairs(athIdList) do
            local installed, instAthData = self:HeroContainAthById(heroId, nil, athId)
            if installed then
              suitAthCount = suitAthCount + 1
              suitAthDic[instAthData.id] = instAthData
            end
          end
        end
        local suitCfg = ConfigData.ath_suit[suitId]
        if suitCfg == nil then
          error("Can't find suitCfg, id = " .. tostring(suitId))
          return
        end
        local suitDetailCfg
        local suitMaxCount = 0
        if 0 < suitAthCount then
          suitDetailCfg = suitCfg[1]
        end
        for k2, v2 in ipairs(suitCfg) do
          if suitAthCount >= v2.num then
            suitDetailCfg = v2
            for k2, attrId in ipairs(suitDetailCfg.attrIdList) do
              local attrValue = suitDetailCfg.attrValueList[k2]
              allAttrDic[attrId] = attrValue + allAttrDic[attrId]
              allAttrDicNoEfcc[attrId] = attrValue + allAttrDicNoEfcc[attrId]
            end
          end
          suitMaxCount = math.max(v2.num)
        end
        if suitDetailCfg ~= nil then
          suitDic[suitId] = {
            curCount = suitAthCount,
            maxCount = suitMaxCount,
            cfg = suitDetailCfg,
            suitAthDic = suitAthDic
          }
        end
      end
    end
  end
  return allAttrDic, slotAttrTab, suitDic, allAttrDicNoEfcc, slotAttrTabNoEfcc
end

function AllAthData:GenAthAffixValue(affixId, quality, level)
  local affixCfg = ConfigData.ath_affix_pool[affixId]
  if affixCfg == nil then
    error("Cant get ath_affix_pool, id = " .. tostring(affixId))
    return
  end
  local index = affixCfg.qualityIndexDic[quality]
  local baseValue = affixCfg.attribute_num[index]
  if baseValue == nil then
    error(string.format("Cant get ath_affix_pool.quality, id:%s, quality:%s", affixId, quality))
    return
  end
  local affixLvCfg = ConfigData.ath_affix_lv[level]
  if affixLvCfg == nil then
    error("Cant get ath_affix_lv, level = " .. tostring(level))
    return
  end
  local value = affixLvCfg.promote * baseValue // 1000
  return value
end

function AllAthData:GetAthNumById(cfgId)
  local num = 0
  for uid, athData in pairs(self.athDic) do
    if uid >> 32 == cfgId then
      num = num + 1
    end
  end
  return num
end

function AllAthData:GetAllAthIdNumDic()
  local athIdNumDic = table.GetDefaulValueTable(0)
  for uid, athData in pairs(self.athDic) do
    athIdNumDic[athData.id] = athIdNumDic[athData.id] + 1
  end
  return athIdNumDic
end

function AllAthData:GetSuitAthList(suitId, suitPartId)
  local list = {}
  local allSuitPartAthNum = 0
  for uid, athData in pairs(self.athDic) do
    if athData:GetAthSuit() == suitId then
      allSuitPartAthNum = allSuitPartAthNum + 1
      if suitPartId == nil or athData:GetAthSuitConflictId() == suitPartId then
        table.insert(list, athData)
      end
    end
  end
  return list, allSuitPartAthNum
end

function AllAthData:IsAthSuitIdConflict(suitIdA, conflictIdA, suitIdB, conflictIdB)
  return suitIdA ~= 0 and suitIdA == suitIdB and conflictIdA ~= 0 and conflictIdA == conflictIdB
end

function AllAthData:IsAthSuitConflict(athDataA, athDataB)
  local suitIdA = athDataA:GetAthSuit()
  local conflictIdA = athDataA:GetAthSuitConflictId()
  local suitIdB = athDataB:GetAthSuit()
  local conflictIdB = athDataB:GetAthSuitConflictId()
  return self:IsAthSuitIdConflict(suitIdA, conflictIdA, suitIdB, conflictIdB)
end

function AllAthData:SetAthItemAttrShow(show)
  self._athItemAttrShow = show
  MsgCenter:Broadcast(eMsgEventId.OnAthItemDetailShow, show)
end

function AllAthData:IsAthItemAttrShow()
  return self._athItemAttrShow
end

function AllAthData:ClearHeroAthStat()
  self._heroAthStat = nil
end

function AllAthData:GetHeroAthStat(heroId, callBack)
  self._getHeroAthStatcallBack = callBack
  self._heroAthStat = self._heroAthStat or {}
  if self._heroAthStat.heroId == heroId then
    callBack(self._heroAthStat)
    return
  end
  self._reqAthStatHeroId = heroId
  self._OnReqHeroAthStatFunc = self._OnReqHeroAthStatFunc or BindCallback(self, self._OnReqHeroAthStat)
  NetworkManager:GetNetwork(NetworkTypeID.Arithmetic):CS_ATH_Stat(heroId, self._OnReqHeroAthStatFunc)
end

function AllAthData:_OnReqHeroAthStat(objList)
  if objList.Count ~= 1 then
    error("objList.Count error:" .. tostring(objList.Count))
    return
  end
  
  local function sortFunc(elemA, elemB)
    return elemA.ratio > elemB.ratio
  end
  
  local msg = objList[0]
  self._heroAthStat.heroId = self._reqAthStatHeroId
  self._heroAthStat.slots = {}
  for k, slot in ipairs(msg.slots) do
    self._heroAthStat.slots[k] = {}
    self._heroAthStat.slots[k].suit = slot.suit
    table.sort(slot.suit, sortFunc)
    self._heroAthStat.slots[k].affix = slot.affix
    table.sort(slot.affix, sortFunc)
  end
  if self._getHeroAthStatcallBack then
    self._getHeroAthStatcallBack(self._heroAthStat)
  end
end

function AllAthData:IsShowAthSuitUsingRate()
  return self._showSuitUsingRate and FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_Rate)
end

function AllAthData:SetShowAthSuitUsingRate(isShow)
  self._showSuitUsingRate = isShow
end

return AllAthData
