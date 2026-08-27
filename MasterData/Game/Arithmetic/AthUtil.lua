local AthUtil = {}
local ATHEnum = require("Game.Arithmetic.ArthmeticEnum")
AthUtil.AthGridSize = Vector2.New(4, 4)
AthUtil.AthUseGridList = {
  1,
  2,
  5,
  6,
  9,
  10,
  13,
  14
}
AthUtil.AthUseGridDic = {}
for k, v in ipairs(AthUtil.AthUseGridList) do
  AthUtil.AthUseGridDic[v] = true
end

function AthUtil.GetAthGridIdList(athData, pos)
  local athSize = athData:GetAthSize()
  return AthUtil.GetAthGridIdListBySize(athSize, pos)
end

function AthUtil.GetAthGridIdListBySize(athSize, pos)
  local sizeX = AthUtil.AthGridSize.x
  local gridIdList = {pos}
  if athSize == 2 then
    local gridId = pos + sizeX
    table.insert(gridIdList, gridId)
  elseif athSize == 4 then
    for i = 0, 1 do
      local gridId
      if i ~= 0 then
        gridId = pos + i
        table.insert(gridIdList, gridId)
      end
      gridId = pos + i + sizeX
      table.insert(gridIdList, gridId)
    end
  elseif athSize == 8 then
    for i = 0, 1 do
      for j = 0, 3 do
        if i ~= 0 or j ~= 0 then
          local gridId = pos + i + sizeX * j
          table.insert(gridIdList, gridId)
        end
      end
    end
  end
  return gridIdList
end

local sortedSuitUidListDic

function AthUtil.OnekeyInstallAthArea(heroData, slotId, space, maxSpace, areaGridData)
  sortedSuitUidListDic = {}
  local freeSpace = heroData:GetAthSlotList()[slotId]
  areaGridData:InitAthAreaGridData(heroData, space, maxSpace, true)
  local onekeyInstallDic = {}
  local onekeyInstallList = {}
  local slotUninstalledAthList = PlayerDataCenter.allAthData:GetAllAthSlotList(slotId, nil, true, heroData.dataId)
  local slotUninstalledAthDic = {}
  local athDataList = {}
  local athDic = {}
  local existSuitDic = {}
  for k, athData in ipairs(slotUninstalledAthList) do
    local signHeroId = athData:GetAthSignHeroId()
    if signHeroId == 0 or signHeroId == heroData.dataId then
      slotUninstalledAthDic[athData.uid] = athData
      local suitId, suitCfltId = athData:GetAthSuit()
      if suitId ~= 0 then
        local existSuit = existSuitDic[suitId]
        if existSuit == nil then
          existSuit = {
            suitDic = {},
            suitMaxQualityDic = {},
            num = 0
          }
          existSuitDic[suitId] = existSuit
        end
        local suitAthList = existSuit.suitDic[suitCfltId]
        if suitAthList == nil then
          suitAthList = {}
          existSuit.num = existSuit.num + 1
          existSuit.suitDic[suitCfltId] = suitAthList
        end
        table.insert(suitAthList, athData)
        if athData:GetAthQuality() == eItemQualityType.Orange then
          existSuit.suitMaxQualityDic[suitCfltId] = true
        end
      end
    end
  end
  local existSuit3DicNum = 0
  local existSuit2DicNum = 0
  local existSuit3Dic = {}
  local existSuit2Dic = {}
  for suitId, existSuit in pairs(existSuitDic) do
    if existSuit.num == 3 then
      existSuit3Dic[suitId] = existSuit
      existSuit3DicNum = existSuit3DicNum + 1
    elseif existSuit.num == 2 then
      existSuit2Dic[suitId] = existSuit
      existSuit2DicNum = existSuit2DicNum + 1
    end
  end
  
  local function findSuitInstallFunc(propertyLv)
    while 6 <= freeSpace and 0 < existSuit3DicNum do
      local firstSuitId, firstExistSuit
      if propertyLv == 1 then
        firstSuitId, firstExistSuit = AthUtil._FindFirstSuitId1(existSuit3Dic, heroData)
      else
        firstSuitId, firstExistSuit = AthUtil._FindFirstSuitId2(existSuit3Dic, heroData)
      end
      if firstSuitId == nil then
        break
      end
      freeSpace = AthUtil._InstallSuit(firstExistSuit, heroData, onekeyInstallList, onekeyInstallDic, freeSpace, slotUninstalledAthDic, 3)
      existSuit3DicNum = existSuit3DicNum - 1
      existSuit3Dic[firstSuitId] = nil
    end
    while 4 <= freeSpace and (0 < existSuit2DicNum or 0 < existSuit3DicNum) do
      local firstSuitId
      local maxQualityNum = 0
      local firstExistSuit
      if 0 < existSuit3DicNum then
        if propertyLv == 1 then
          firstSuitId, firstExistSuit, maxQualityNum = AthUtil._FindFirstSuitId1(existSuit3Dic, heroData)
          maxQualityNum = math.min(maxQualityNum, 2)
        else
          firstSuitId, firstExistSuit = AthUtil._FindFirstSuitId2(existSuit3Dic, heroData)
        end
      end
      if 0 < existSuit2DicNum then
        if propertyLv == 1 then
          firstSuitId, firstExistSuit = AthUtil._FindFirstSuitId1(existSuit2Dic, heroData, firstSuitId, firstExistSuit, maxQualityNum)
        else
          firstSuitId, firstExistSuit = AthUtil._FindFirstSuitId2(existSuit2Dic, heroData, firstSuitId, firstExistSuit)
        end
      end
      if firstSuitId == nil then
        break
      end
      local isSuit3 = existSuit3Dic[firstSuitId] ~= nil
      freeSpace = AthUtil._InstallSuit(firstExistSuit, heroData, onekeyInstallList, onekeyInstallDic, freeSpace, slotUninstalledAthDic, 2)
      if isSuit3 then
        existSuit3DicNum = existSuit3DicNum - 1
        existSuit3Dic[firstSuitId] = nil
      else
        existSuit2Dic[firstSuitId] = nil
        existSuit2DicNum = existSuit2DicNum - 1
      end
    end
  end
  
  findSuitInstallFunc(1)
  findSuitInstallFunc(2)
  local athInstallDic = AthUtil._fillEmptySpace(onekeyInstallList, freeSpace, areaGridData, slotId, slotUninstalledAthDic, heroData)
  if athInstallDic ~= nil then
    local _, oldAthDic = PlayerDataCenter.allAthData:GetHeroAthList(heroData.dataId, slotId)
    if table.count(athInstallDic) == table.count(oldAthDic) then
      local allSame = true
      for uid, athData in pairs(oldAthDic) do
        if athInstallDic[uid] == nil then
          allSame = false
          break
        end
      end
      if allSame then
        return nil
      end
    end
  end
  return athInstallDic
end

function AthUtil._FindFirstSuitId1(existSuitDic, heroData, firstSuitId, firstExistSuit, maxQualityNum)
  maxQualityNum = maxQualityNum or 0
  local heroCfg = heroData.heroCfg
  for suitId, existSuit in pairs(existSuitDic) do
    if heroCfg.recommendSuitDic[suitId] ~= nil then
      local curNum = table.count(existSuit.suitMaxQualityDic)
      if firstSuitId == nil then
        firstSuitId = suitId
        maxQualityNum = curNum
        firstExistSuit = existSuit
      elseif curNum > maxQualityNum then
        firstSuitId = suitId
        maxQualityNum = curNum
        firstExistSuit = existSuit
      elseif curNum == maxQualityNum then
        local wA, wB = AthUtil:_SuitWeightCompare(firstExistSuit.suitDic, existSuit.suitDic, heroData)
        if wA ~= wB then
          if wA < wB then
            firstSuitId = suitId
            firstExistSuit = existSuit
          end
        else
          local firstSuitPriority = heroCfg.priority2_suit_dic[firstSuitId]
          local curSuitPriority = heroCfg.priority2_suit_dic[suitId]
          if firstSuitPriority > curSuitPriority or firstSuitPriority == curSuitPriority and suitId < firstSuitId then
            firstSuitId = suitId
            firstExistSuit = existSuit
          else
          end
        end
      end
    end
  end
  return firstSuitId, firstExistSuit, maxQualityNum
end

function AthUtil._FindFirstSuitId2(existSuitDic, heroData, firstSuitId, firstExistSuit)
  local heroCfg = heroData.heroCfg
  for suitId, existSuit in pairs(existSuitDic) do
    if firstSuitId == nil then
      firstSuitId = suitId
      firstExistSuit = existSuit
    else
      local wA, wB = AthUtil:_SuitWeightCompare(firstExistSuit.suitDic, existSuit.suitDic, heroData)
      if wA ~= wB then
        if wA < wB then
          firstSuitId = suitId
          firstExistSuit = existSuit
        end
      else
        local firstSuitPriority = heroCfg.priority2_suit_dic[firstSuitId] or math.maxinteger
        local curSuitPriority = heroCfg.priority2_suit_dic[suitId] or math.maxinteger
        if firstSuitPriority > curSuitPriority or firstSuitPriority == curSuitPriority and suitId < firstSuitId then
          firstSuitId = suitId
          firstExistSuit = existSuit
        end
      end
    end
  end
  return firstSuitId, firstExistSuit
end

function AthUtil:_SuitWeightCompare(suitDicA, suitDicB, heroData)
  local weightA, weightB = 0, 0
  for i = 1, ATHEnum.AthSuitConflictMax do
    local athListA = suitDicA[i]
    local athListB = suitDicB[i]
    if athListA ~= nil or athListB ~= nil then
      if athListA == nil and athListB ~= nil then
        weightB = weightB + 1
        goto lbl_52
      elseif athListA ~= nil and athListB == nil then
        weightA = weightA + 1
        goto lbl_52
      end
      if sortedSuitUidListDic[athListA] == nil then
        AthUtil._AthUidListSort(athListA, heroData)
      end
      if sortedSuitUidListDic[athListB] == nil then
        AthUtil._AthUidListSort(athListB, heroData)
      end
      local firstAthA = athListA[1]
      local firstAthB = athListB[1]
      if AthUtil._AthSortFunc(firstAthA, firstAthB, heroData) then
        weightA = weightA + 1
      else
        weightB = weightB + 1
      end
    end
    ::lbl_52::
  end
  return weightA, weightB
end

function AthUtil._InstallSuit(firstExistSuit, heroData, onekeyInstallList, onekeyInstallDic, freeSpace, slotUninstalledAthDic, installNum)
  local curNum = 0
  local athList = {}
  for suitCflsuittId, suitAthList in pairs(firstExistSuit.suitDic) do
    if sortedSuitUidListDic[suitAthList] == nil then
      AthUtil._AthUidListSort(suitAthList, heroData)
    end
    table.insert(athList, suitAthList[1])
  end
  AthUtil._AthUidListSort(athList, heroData)
  for k, athData in ipairs(athList) do
    freeSpace = AthUtil:_InstallAthData(athData, onekeyInstallList, onekeyInstallDic, freeSpace, slotUninstalledAthDic)
    curNum = curNum + 1
    if installNum <= curNum then
      break
    end
  end
  return freeSpace
end

function AthUtil:_InstallAthData(athData, onekeyInstallList, onekeyInstallDic, freeSpace, slotUninstalledAthDic)
  table.insert(onekeyInstallList, athData)
  onekeyInstallDic[athData.uid] = athData
  freeSpace = freeSpace - athData:GetAthSize()
  slotUninstalledAthDic[athData.uid] = nil
  return freeSpace
end

function AthUtil._fillEmptySpace(tryInstallAthList, freeSpace, areaGridData, slotId, slotUninstalledAthDic, heroData)
  local slotUninstalledAthList = {}
  if 0 < freeSpace then
    for uid, athData in pairs(slotUninstalledAthDic) do
      table.insert(slotUninstalledAthList, athData)
    end
    AthUtil._AthUidListSort(slotUninstalledAthList, heroData)
  end
  local tryInstallIdDic = {}
  local tryInstallSuitDic = {}
  if tryInstallAthList == nil then
    tryInstallAthList = {}
  else
    for k, athData in ipairs(tryInstallAthList) do
      tryInstallIdDic[athData.id] = true
      local suitId, cfltId = athData:GetAthSuit()
      if suitId ~= 0 then
        tryInstallSuitDic[suitId] = tryInstallSuitDic[suitId] or {}
        tryInstallSuitDic[suitId][cfltId] = true
      end
    end
  end
  for k, athData in ipairs(slotUninstalledAthList) do
    if freeSpace <= 0 then
      break
    end
    local athSize = athData:GetAthSize()
    local suitId, cfltId = athData:GetAthSuit()
    if freeSpace >= athSize and tryInstallIdDic[athData.id] == nil and (tryInstallSuitDic[suitId] == nil or tryInstallSuitDic[suitId][cfltId] == nil) then
      table.insert(tryInstallAthList, athData)
      tryInstallIdDic[athData.id] = true
      if suitId ~= 0 then
        tryInstallSuitDic[suitId] = tryInstallSuitDic[suitId] or {}
        tryInstallSuitDic[suitId][cfltId] = true
      end
      freeSpace = freeSpace - athSize
    end
  end
  local athInstallDic, athInstalledDic = areaGridData:AutoSortAthTable(tryInstallAthList)
  if athInstallDic == nil then
    return
  end
  local isEqual = true
  for k, v in pairs(athInstallDic) do
    if athInstalledDic[k] ~= v then
      isEqual = false
      break
    end
  end
  if isEqual then
    return
  end
  return athInstallDic
end

function AthUtil._AthUidListSort(athDataList, heroData)
  table.sort(athDataList, function(athDataA, athDataB)
    return AthUtil._AthSortFunc(athDataA, athDataB, heroData)
  end)
end

function AthUtil._AthSortFunc(athDataA, athDataB, heroData)
  local mainAttrPriorityA = AthUtil.GetHeroAthMainAttrPriority(heroData, athDataA)
  local mainAttrPriorityB = AthUtil.GetHeroAthMainAttrPriority(heroData, athDataB)
  local qulityA = athDataA:GetAthQuality()
  local qulityB = athDataB:GetAthQuality()
  local subAttrPriorityA, subAttrQualityA = AthUtil.GetHeroAthSubAttrPriority(heroData, athDataA)
  local subAttrPriorityB, subAttrQualityB = AthUtil.GetHeroAthSubAttrPriority(heroData, athDataB)
  if qulityA ~= qulityB then
    return qulityA > qulityB
  end
  if mainAttrPriorityA ~= mainAttrPriorityB then
    return mainAttrPriorityA < mainAttrPriorityB
  end
  if subAttrPriorityA ~= subAttrPriorityB then
    return subAttrPriorityA < subAttrPriorityB
  end
  if subAttrQualityA ~= subAttrQualityB then
    return subAttrQualityA > subAttrQualityB
  end
  return athDataA.athTs < athDataB.athTs
end

function AthUtil.GetHeroAthMainAttrPriority(heroData, athData)
  local mainAttrId = athData.athMainAttrCfg.attrtibute_id[1]
  local mainAttrPriority = heroData.heroCfg.priority_main_attribute_dic[mainAttrId]
  if mainAttrPriority == nil then
    return 1000
  end
  return mainAttrPriority
end

local subAttrQulityWeightDic = {
  [eItemQualityType.White] = 1,
  [eItemQualityType.Blue] = 2,
  [eItemQualityType.Purple] = 4,
  [eItemQualityType.Orange] = 6
}

function AthUtil.GetHeroAthSubAttrPriority(heroData, athData)
  local highestPriority = 1000
  local subQualityWeight = 0
  local areaId = athData:GetAthAreaType()
  local cfgName = "priority_sub_attribute" .. tostring(areaId) .. "_dic"
  for k, affixElem in ipairs(athData.affixList) do
    local curQuality = subAttrQulityWeightDic[affixElem.quality]
    if curQuality == nil then
      error("Unsurpported quality:" .. tostring(affixElem.quality))
      curQuality = 0
    end
    subQualityWeight = subQualityWeight + curQuality
    local cfg = ConfigData.ath_affix_pool[affixElem.id]
    if cfg == nil then
      error("Can't find ath_affix_pool, id = " .. tostring(affixElem.id))
    else
      local attrId = cfg.affix_para
      local subAttrPriority = heroData.heroCfg[cfgName][attrId]
      if subAttrPriority ~= nil and highestPriority > subAttrPriority then
        highestPriority = subAttrPriority
      end
    end
  end
  return highestPriority, subQualityWeight
end

function AthUtil.ShowATHInfoFunc()
  local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
  GuidePicture.OpenGuidePicture(PicTipsConsts.ATH, nil)
end

function AthUtil.ShowAthRefactorSuccess(athData, heroData, onShowFunc)
  local winId = #PlayerDataCenter.allAthData.athReconsitutionDataList > 1 and UIWindowTypeID.AthRefactorSuccessExtra or UIWindowTypeID.AthRefactorSuccess
  UIManager:ShowWindowAsync(winId, function(window)
    if window == nil then
      return
    end
    window:InitAthRefactorSuccess(athData, heroData)
    if onShowFunc ~= nil then
      onShowFunc()
    end
  end)
end

return AthUtil
