local ConfigData = require("GameCore.Data.ConfigData")
local DiscData = require("GameCore.Data.DataClass.DiscData")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local PlayerDiscData = class("PlayerDiscData")

function PlayerDiscData:Init()
  self._mapDisc = {}
  self._mapLimitedTrialDisc = {}
  self.nMaxBreakLimitMat = 5
  self:ProcessTableData()
end

function PlayerDiscData:ProcessTableData()
  self:ProcessExpTable()
  self:ProcessConfigTable()
  self:ProcessDiscTable()
end

function PlayerDiscData:ProcessExpTable()
  self.tbItemExp = {}
  
  local function foreachDiscItemExp(mapData)
    table.insert(self.tbItemExp, {
      nItemId = mapData.ItemId,
      nExpValue = mapData.Exp
    })
  end
  
  ForEachTableLine(DataTable.DiscItemExp, foreachDiscItemExp)
  
  local function sort(a, b)
    return a.nExpValue > b.nExpValue
  end
  
  table.sort(self.tbItemExp, sort)
end

function PlayerDiscData:ProcessConfigTable()
  self.tbExpPerGold = {}
  local tbGold = ConfigTable.GetConfigNumberArray("DiscStrengthenGoldFactor")
  if type(tbGold) == "table" then
    for nRarity, sValue in ipairs(tbGold) do
      self.tbExpPerGold[nRarity] = sValue / 1000
    end
  end
  self.tbMaxStar = {}
  local tbBreak = ConfigTable.GetConfigNumberArray("DiscRarityLimitBreakMax")
  if type(tbBreak) == "table" then
    for nRarity, sValue in ipairs(tbBreak) do
      self.tbMaxStar[nRarity] = sValue
    end
  end
end

function PlayerDiscData:ProcessDiscTable()
  self.ItemToDisc = {}
  
  local function func_ForEach(mapData)
    self.ItemToDisc[mapData.TransformItemId] = mapData.Id
  end
  
  ForEachTableLine(DataTable.Disc, func_ForEach)
  
  local function func_ForEach_main(mapData)
    CacheTable.SetField("_MainSkill", mapData.GroupId, mapData.Level, mapData)
  end
  
  ForEachTableLine(DataTable.MainSkill, func_ForEach_main)
  
  local function func_ForEach_Note(mapData)
    CacheTable.SetField("_SubNoteSkillPromoteGroup", mapData.GroupId, mapData.Phase, mapData)
  end
  
  ForEachTableLine(DataTable.SubNoteSkillPromoteGroup, func_ForEach_Note)
  
  local function func_ForEach_Secondary(mapData)
    CacheTable.SetField("_SecondarySkill", mapData.GroupId, mapData.Level, mapData)
  end
  
  ForEachTableLine(DataTable.SecondarySkill, func_ForEach_Secondary)
end

function PlayerDiscData:GetAllDisc()
  local discList = {}
  for _, discData in pairs(self._mapDisc) do
    table.insert(discList, discData)
  end
  return discList
end

function PlayerDiscData:GetDiscById(nId)
  if not nId or nId == 0 then
    return
  end
  if self._mapDisc[nId] == nil then
  end
  return self._mapDisc[nId]
end

function PlayerDiscData:GetDiscSkillScore(nId, tbNote)
  local mapDisc = self._mapDisc[nId]
  local nScore = 0
  for i = 1, 2 do
    if mapDisc.tbSubSkillGroupId[i] then
      local tbGroup = CacheTable.GetData("_SecondarySkill", mapDisc.tbSubSkillGroupId[i])
      if tbGroup then
        local nMaxLayer = #tbGroup
        for j = nMaxLayer, 1, -1 do
          if tbGroup[j] then
            local bActive = mapDisc:CheckSubSkillActive(tbNote, tbGroup[j])
            if bActive then
              nScore = nScore + tbGroup[j].Score
              break
            end
          end
        end
      end
    end
  end
  return nScore
end

function PlayerDiscData:GetDiscSkill(tbDisc, tbHasNote)
  local mapSkill = {}
  for _, nDiscId in pairs(tbDisc) do
    local mapData = self:GetDiscById(nDiscId)
    if mapData == nil then
      return {}
    end
    for _, nSubSkillGroupId in pairs(mapData.tbSubSkillGroupId) do
      local tbGroup = CacheTable.GetData("_SecondarySkill", nSubSkillGroupId)
      if tbGroup then
        local nCurLayer = 0
        local nMaxLayer = #tbGroup
        for i = nMaxLayer, 1, -1 do
          if tbGroup[i] then
            local bActive = mapData:CheckSubSkillActive(tbHasNote, tbGroup[i])
            if bActive then
              nCurLayer = i
              break
            end
          end
        end
        local nNextLayer = nCurLayer == nMaxLayer and nMaxLayer or nCurLayer + 1
        if tbGroup[nNextLayer] then
          local nSubSkillId = tbGroup[nNextLayer].Id
          local tbActiveNote = CacheTable.GetData("_SecondarySkillNeedNotes", nSubSkillId)
          if tbActiveNote == nil then
            local mapJsonData = decodeJson(tbGroup[nNextLayer].NeedSubNoteSkills)
            tbActiveNote = {}
            for key, nCount in pairs(mapJsonData) do
              local nId = tonumber(key)
              table.insert(tbActiveNote, {nId, nCount})
            end
            
            local function sort(a, b)
              return a[1] < b[1]
            end
            
            table.sort(tbActiveNote, sort)
            CacheTable.SetData("_SecondarySkillNeedNotes", nSubSkillId, tbActiveNote)
          end
          local tbMaxLayerActiveNote = CacheTable.GetData("_SecondarySkillNeedNotes", tbGroup[nMaxLayer].Id)
          if tbMaxLayerActiveNote == nil then
            local mapJsonData = decodeJson(tbGroup[nMaxLayer].NeedSubNoteSkills)
            tbMaxLayerActiveNote = {}
            for key, nCount in pairs(mapJsonData) do
              local nId = tonumber(key)
              table.insert(tbMaxLayerActiveNote, {nId, nCount})
            end
            
            local function sort(a, b)
              return a[1] < b[1]
            end
            
            table.sort(tbMaxLayerActiveNote, sort)
            CacheTable.SetData("_SecondarySkillNeedNotes", tbGroup[nMaxLayer].Id, tbMaxLayerActiveNote)
          end
          mapSkill[tbGroup[nNextLayer].GroupId] = {
            nCurLevel = nCurLayer,
            nId = nSubSkillId,
            tbNote = tbActiveNote,
            tbMaxLayerActiveNote = tbMaxLayerActiveNote,
            nDiscId = nDiscId
          }
        end
      end
    end
  end
  return mapSkill
end

function PlayerDiscData:GetDiscSkillByNote(tbDisc, tbHasNote, nNeedNote)
  local tbSkill = {}
  local sNote = tostring(nNeedNote)
  for _, nDiscId in pairs(tbDisc) do
    local mapData = self:GetDiscById(nDiscId)
    if mapData == nil then
      return {}
    end
    for _, nSubSkillGroupId in pairs(mapData.tbSubSkillGroupId) do
      local tbGroup = CacheTable.GetData("_SecondarySkill", nSubSkillGroupId)
      if tbGroup then
        local nCurLayer = 0
        local nMaxLayer = #tbGroup
        for i = nMaxLayer, 1, -1 do
          if tbGroup[i] then
            local bActive = mapData:CheckSubSkillActive(tbHasNote, tbGroup[i])
            if bActive then
              nCurLayer = i
              break
            end
          end
        end
        local nNextLayer = nCurLayer == nMaxLayer and nMaxLayer or nCurLayer + 1
        if tbGroup[nNextLayer] then
          local nSubSkillId = tbGroup[nNextLayer].Id
          local tbActiveNote = decodeJson(tbGroup[nNextLayer].NeedSubNoteSkills)
          if tbActiveNote[sNote] then
            local tbNote = {}
            for k, v in pairs(tbActiveNote) do
              local nNoteId = tonumber(k)
              local nNoteCount = tonumber(v)
              if nNoteId then
                tbNote[nNoteId] = nNoteCount
              end
            end
            local tbMaxLayerActiveNote = decodeJson(tbGroup[nMaxLayer].NeedSubNoteSkills)
            local nMaxLayerNoteNeed = 0
            if tbMaxLayerActiveNote[sNote] then
              for k, v in pairs(tbMaxLayerActiveNote) do
                local nNoteId = tonumber(k)
                local nNoteCount = tonumber(v)
                if nNoteId == nNeedNote then
                  nMaxLayerNoteNeed = nNoteCount
                  break
                end
              end
            end
            table.insert(tbSkill, {
              nCurLevel = nCurLayer,
              nId = nSubSkillId,
              tbNote = tbNote,
              nMaxLayerNoteNeed = nMaxLayerNoteNeed
            })
          end
        end
      end
    end
  end
  return tbSkill
end

function PlayerDiscData:GetDiscSkillByNoteCurrentLevel(tbDisc, tbHasNote, nNeedNote)
  local tbSkill = {}
  local sNote = tostring(nNeedNote)
  for _, nDiscId in pairs(tbDisc) do
    local mapData = self:GetDiscById(nDiscId)
    if mapData == nil then
      return {}
    end
    for _, nSubSkillGroupId in pairs(mapData.tbSubSkillGroupId) do
      local tbGroup = CacheTable.GetData("_SecondarySkill", nSubSkillGroupId)
      if tbGroup then
        local nCurLayer = 0
        local nMaxLayer = #tbGroup
        for i = nMaxLayer, 1, -1 do
          if tbGroup[i] then
            local bActive = mapData:CheckSubSkillActive(tbHasNote, tbGroup[i])
            if bActive then
              nCurLayer = i
              break
            end
          end
        end
        local nNextLayer = nCurLayer == nMaxLayer and nMaxLayer or nCurLayer + 1
        local nSubSkillId = tbGroup[nCurLayer] and tbGroup[nCurLayer].Id or tbGroup[nNextLayer].Id
        if tbGroup[nNextLayer] then
          local tbActiveNote = decodeJson(tbGroup[nNextLayer].NeedSubNoteSkills)
          if tbActiveNote[sNote] then
            local tbNote = {}
            for k, v in pairs(tbActiveNote) do
              local nNoteId = tonumber(k)
              local nNoteCount = tonumber(v)
              if nNoteId then
                tbNote[nNoteId] = nNoteCount
              end
            end
            local tbMaxLayerActiveNote = decodeJson(tbGroup[nMaxLayer].NeedSubNoteSkills)
            local nMaxLayerNoteNeed = 0
            if tbMaxLayerActiveNote[sNote] then
              for k, v in pairs(tbMaxLayerActiveNote) do
                local nNoteId = tonumber(k)
                local nNoteCount = tonumber(v)
                if nNoteId == nNeedNote then
                  nMaxLayerNoteNeed = nNoteCount
                  break
                end
              end
            end
            table.insert(tbSkill, {
              nCurLevel = nCurLayer,
              nId = nSubSkillId,
              tbNote = tbNote,
              nMaxLayerNoteNeed = nMaxLayerNoteNeed
            })
          end
        end
      end
    end
  end
  return tbSkill
end

function PlayerDiscData:GetBGMDisc()
  return self.nBGMDisc or 0
end

function PlayerDiscData:CheckDiscL2D(nId)
  local discData = self._mapDisc[nId]
  if not discData then
    return false
  end
  return discData.bUnlockL2D
end

function PlayerDiscData:CalcDiscEffect(nId)
  local discData = self._mapDisc[nId]
  local tbEft = {}
  if discData ~= nil then
    for _, mapEft in ipairs(discData:GetSkillEffect()) do
      table.insert(tbEft, mapEft)
    end
  end
  return tbEft
end

function PlayerDiscData:CalcDiscEffectInBuild(nId, tbSecondarySkill)
  local discData = self._mapDisc[nId]
  local tbEffectId = {}
  if discData == nil then
    return tbEffectId
  end
  
  local function add(tbEfId)
    if not tbEfId then
      return
    end
    for _, nEfId in pairs(tbEfId) do
      if type(nEfId) == "number" and 0 < nEfId then
        table.insert(tbEffectId, {nEfId, 0})
      end
    end
  end
  
  local mapMainCfg = ConfigTable.GetData("MainSkill", discData.nMainSkillId)
  if mapMainCfg then
    add(mapMainCfg.EffectId)
  end
  for _, v in ipairs(tbSecondarySkill) do
    local mapSubCfg = ConfigTable.GetData("SecondarySkill", v)
    if mapSubCfg and table.indexof(discData.tbSubSkillGroupId, mapSubCfg.GroupId) > 0 then
      add(mapSubCfg.EffectId)
    end
  end
  return tbEffectId
end

function PlayerDiscData:CalcDiscInfoInBuild(nId, tbSecondarySkill)
  local discData = self._mapDisc[nId]
  local discInfo = CS.Lua2CSharpInfo_DiscInfo()
  if discData == nil then
    return discInfo
  end
  local tbSkillInfo = {}
  for _, v in ipairs(tbSecondarySkill) do
    local mapSubCfg = ConfigTable.GetData("SecondarySkill", v, true)
    if mapSubCfg and table.indexof(discData.tbSubSkillGroupId, mapSubCfg.GroupId) > 0 then
      local skillInfo = CS.Lua2CSharpInfo_DiscSkillInfo()
      skillInfo.skillId = v
      skillInfo.skillLevel = mapSubCfg.Level
      table.insert(tbSkillInfo, skillInfo)
    end
  end
  local mapMainCfg = ConfigTable.GetData("MainSkill", discData.nMainSkillId, true)
  if mapMainCfg then
    local skillInfo = CS.Lua2CSharpInfo_DiscSkillInfo()
    skillInfo.skillId = discData.nMainSkillId
    skillInfo.skillLevel = 1
    table.insert(tbSkillInfo, skillInfo)
  end
  discInfo.discId = nId
  discInfo.discScript = discData.sSkillScript
  discInfo.skillInfos = tbSkillInfo
  discInfo.discLevel = discData.nLevel
  return discInfo
end

function PlayerDiscData:GenerateLocalDiscData(configId, nExp, nLevel, nPhase, nStar)
  if not configId then
    printError("GenerateLocalDiscData Failed!")
    return
  end
  local mapDisc = {}
  mapDisc.Id = configId
  mapDisc.Exp = nExp or 0
  mapDisc.Level = nLevel or 1
  mapDisc.Phase = nPhase or 0
  mapDisc.Star = nStar or 0
  mapDisc.Read = false
  local discData = DiscData.new(mapDisc)
  return discData
end

function PlayerDiscData:GetAttrBase(nGroupId, nPhase, nTargetLv, nExtraGroupId, nStar)
  local mapExtra
  if 0 < nStar and 0 < nExtraGroupId then
    local nExtraId = UTILS.GetDiscExtraAttributeId(nExtraGroupId, nStar)
    mapExtra = ConfigTable.GetData("DiscExtraAttribute", tostring(nExtraId))
  end
  local nAttrId = UTILS.GetDiscAttributeId(nGroupId, nPhase, nTargetLv)
  local mapAttribute = ConfigTable.GetData_Attribute(tostring(nAttrId))
  local mapAttr = {}
  if mapAttribute then
    for _, v in ipairs(AllEnum.AttachAttr) do
      local nParamValue = mapAttribute[v.sKey] or 0
      mapAttr[v.sKey] = {
        Key = v.sKey,
        Value = v.bPercent and nParamValue * ConfigData.IntFloatPrecision * 100 or nParamValue,
        CfgValue = mapAttribute[v.sKey] or 0
      }
      if mapExtra then
        local nExtraParamValue = mapExtra[v.sKey] or 0
        local nExtraValue = v.bPercent and nExtraParamValue * ConfigData.IntFloatPrecision * 100 or nExtraParamValue
        mapAttr[v.sKey].Value = mapAttr[v.sKey].Value + nExtraValue
        mapAttr[v.sKey].CfgValue = mapAttr[v.sKey].CfgValue + nExtraParamValue
      end
    end
  end
  return mapAttr
end

function PlayerDiscData:GetDiscMaxStar(nRarity)
  return self.tbMaxStar[nRarity]
end

function PlayerDiscData:GetBreakLimitMat(nId)
  local discData = self._mapDisc[nId]
  local nMatId = discData.nTransformItemId
  local nCount = PlayerData.Item:GetItemCountByID(nMatId)
  return nMatId, nCount
end

function PlayerDiscData:GetAllBreakLimitMat()
  local tbMat = {}
  for nId, discData in pairs(self._mapDisc) do
    local nMatId, nCount = self:GetBreakLimitMat(nId)
    if nCount > discData.nMaxStar - discData.nStar then
      nCount = discData.nMaxStar - discData.nStar
    end
    if 0 < nCount then
      table.insert(tbMat, {nTid = nMatId, nCount = nCount})
    end
  end
  table.sort(tbMat, function(a, b)
    local rarityA = ConfigTable.GetData_Item(a.nTid).Rarity
    local rarityB = ConfigTable.GetData_Item(b.nTid).Rarity
    if rarityA ~= rarityB then
      return rarityA < rarityB
    elseif a.nCount ~= b.nCount then
      return a.nCount > b.nCount
    else
      return a.nTid < b.nTid
    end
  end)
  return tbMat
end

function PlayerDiscData:GetIndexOfNewBreakLimitMat(tbMat)
  local nCurCount = 0
  for _, _ in pairs(tbMat) do
    nCurCount = nCurCount + 1
  end
  if nCurCount == self.nMaxBreakLimitMat then
    return 0
  end
  local nIndex = 0
  for _, v in pairs(tbMat) do
    if nIndex < v.nAddIndex then
      nIndex = v.nAddIndex
    end
  end
  return nIndex + 1
end

function PlayerDiscData:GetMaxLv(nRarity, nCurPhase)
  local nMaxLv = 1
  
  local function foreachDiscPromoteLimit(mapData)
    if mapData.Rarity == nRarity and tonumber(mapData.Phase) == nCurPhase then
      nMaxLv = mapData.MaxLevel
    end
  end
  
  ForEachTableLine(DataTable.DiscPromoteLimit, foreachDiscPromoteLimit)
  return tonumber(nMaxLv)
end

function PlayerDiscData:GetUpgradeNote(nId)
  local tbShowNote = {}
  local mapDisc = self._mapDisc[nId]
  local mapGroup = CacheTable.GetData("_SubNoteSkillPromoteGroup", mapDisc.nSubNoteSkillGroupId)
  if not mapGroup then
    return tbShowNote
  end
  local nNextPhase = mapDisc.nPhase + 1
  local mapCfg
  while type(nNextPhase) == "number" and 0 <= nNextPhase do
    mapCfg = mapGroup[nNextPhase]
    if mapCfg then
      break
    end
    nNextPhase = nNextPhase - 1
  end
  if not mapCfg then
    return tbShowNote
  end
  local tbCurSubNoteSkills = mapDisc.tbSubNoteSkills
  local tbNextSubNoteSkills = {}
  local tbNote = decodeJson(mapCfg.SubNoteSkills)
  for k, v in pairs(tbNote) do
    local nNoteId = tonumber(k)
    local nNoteCount = tonumber(v)
    if nNoteId then
      table.insert(tbNextSubNoteSkills, {nId = nNoteId, nCount = nNoteCount})
    end
  end
  for _, mapNextNote in pairs(tbNextSubNoteSkills) do
    local bNew = true
    for _, mapCurNote in pairs(tbCurSubNoteSkills) do
      if mapNextNote.nId == mapCurNote.nId then
        bNew = false
        if mapNextNote.nCount > mapCurNote.nCount then
          table.insert(tbShowNote, {
            mapNextNote.nId,
            mapCurNote.nCount,
            mapNextNote.nCount
          })
        end
        break
      end
    end
    if bNew then
      table.insert(tbShowNote, {
        mapNextNote.nId,
        mapNextNote.nCount
      })
    end
  end
  return tbShowNote
end

function PlayerDiscData:GetUpgradeMatList()
  local tbMat = {}
  for _, value in ipairs(self.tbItemExp) do
    table.insert(tbMat, {
      nItemId = value.nItemId,
      nExpValue = value.nExpValue,
      nCost = 0
    })
  end
  return tbMat
end

function PlayerDiscData:GetCustomizeLevelExp(nId, nLevel)
  local mapDisc = self._mapDisc[nId]
  local nUpgradeGroupId = mapDisc.nStrengthenGroupId
  local nTargetLevel = nLevel >= mapDisc.nMaxLv and mapDisc.nMaxLv or nLevel
  local nNextExp = self:CalUpgradeExp(nUpgradeGroupId, mapDisc.nLevel, nTargetLevel, mapDisc.nExp)
  return nNextExp
end

function PlayerDiscData:GetMaxLevelExp(nId)
  local mapDisc = self._mapDisc[nId]
  local nUpgradeGroupId = mapDisc.nStrengthenGroupId
  local nNextExp = self:CalUpgradeExp(nUpgradeGroupId, mapDisc.nLevel, mapDisc.nMaxLv, mapDisc.nExp)
  return nNextExp
end

function PlayerDiscData:GetCustomizeLevelDataAndCost(nId, nLevel)
  local nTargetExp = self:GetCustomizeLevelExp(nId, nLevel)
  local tbMat = self:CalUpgradeMat(nTargetExp)
  local mapTargetLevel, nGoldCost = self:GetLevelDataAndCostByMat(nId, tbMat)
  return mapTargetLevel, tbMat, nGoldCost
end

function PlayerDiscData:GetMaxLevelDataAndCost(nId)
  local nTargetExp = self:GetMaxLevelExp(nId)
  local tbMat = self:CalUpgradeMat(nTargetExp)
  local mapTargetLevel, nGoldCost = self:GetLevelDataAndCostByMat(nId, tbMat)
  return mapTargetLevel, tbMat, nGoldCost
end

function PlayerDiscData:GetMaxMatCost(nId, tbMat, mapMat)
  local nMatExp = mapMat.nExpValue
  local nMaxExp = self:GetMaxLevelExp(nId)
  local nHasExp = self:GetMatExp(tbMat)
  local nCount = math.ceil((nMaxExp - nHasExp) / nMatExp)
  return nCount
end

function PlayerDiscData:GetMatExp(tbMat)
  local nTotalExp = 0
  for _, mapMat in pairs(tbMat) do
    nTotalExp = nTotalExp + mapMat.nExpValue * mapMat.nCost
  end
  return nTotalExp
end

function PlayerDiscData:GetLevelDataAndCostByMat(nId, tbMat)
  local mapDisc = self._mapDisc[nId]
  local nMatExp = self:GetMatExp(tbMat)
  local nExpPerGold = self.tbExpPerGold[mapDisc.nRarity]
  local nGoldCost = nMatExp * nExpPerGold
  local nTotalExp = nMatExp + mapDisc.nExp
  local nUpgradeGroupId = mapDisc.nStrengthenGroupId
  local nStartLevel = mapDisc.nLevel
  local nMaxLevel = mapDisc.nMaxLv
  local nTargetLevel = nStartLevel
  for i = nStartLevel, nMaxLevel - 1 do
    local nUpgradeId = nUpgradeGroupId * 1000 + i + 1
    local mapUpgrade = ConfigTable.GetData("DiscStrengthen", nUpgradeId, true)
    local nExp = 0
    if mapUpgrade then
      nExp = mapUpgrade.Exp
    end
    if nTotalExp >= nExp then
      nTotalExp = nTotalExp - nExp
      nTargetLevel = nTargetLevel + 1
    else
      break
    end
  end
  if nTargetLevel == nMaxLevel then
    nGoldCost = nGoldCost - nTotalExp * nExpPerGold
    nMatExp = nMatExp - nTotalExp
    nTotalExp = 0
  end
  local mapLevelData = {
    nLevel = nTargetLevel,
    nExp = math.ceil(nTotalExp),
    nMaxLevel = nMaxLevel,
    nMaxExp = self:GetMaxExp(nUpgradeGroupId, nTargetLevel),
    nMatExp = nMatExp
  }
  return mapLevelData, nGoldCost
end

function PlayerDiscData:CalUpgradeExp(nUpgradeGroupId, nStartLevel, nTargetLevel, nStartExp)
  local nTotalExp = 0
  for i = nStartLevel, nTargetLevel - 1 do
    local nUpgradeId = nUpgradeGroupId * 1000 + i + 1
    local mapUpgrade = ConfigTable.GetData("DiscStrengthen", nUpgradeId, true)
    local nExp = 0
    if mapUpgrade then
      nExp = mapUpgrade.Exp
    end
    nTotalExp = nTotalExp + nExp
  end
  nTotalExp = nTotalExp - nStartExp
  return nTotalExp
end

function PlayerDiscData:GetMaxExp(nUpgradeGroupId, nLevel)
  local nUpgradeId = nUpgradeGroupId * 1000 + nLevel + 1
  local mapUpgrade = ConfigTable.GetData("DiscStrengthen", nUpgradeId, true)
  if not mapUpgrade then
    return 0
  end
  local nExp = mapUpgrade.Exp
  return nExp
end

function PlayerDiscData:CalCostProportion(nTarget, tbMatType, tbHas)
  local nTypeCount = #tbMatType
  
  local function GetProportionedSum(tbProportioned)
    local nSum = 0
    for i = 1, nTypeCount do
      nSum = nSum + tbMatType[i] * tbProportioned[i]
    end
    return nSum
  end
  
  local tbCost = tbHas
  local nMinTarget = GetProportionedSum(tbHas)
  if nTarget >= nMinTarget then
    return tbHas
  end
  local tbSumOfTypeFollowing = {}
  tbSumOfTypeFollowing[nTypeCount + 1] = 0
  for i = nTypeCount, 1, -1 do
    local nCurTypeSum = tbMatType[i] * tbHas[i]
    tbSumOfTypeFollowing[i] = nCurTypeSum + tbSumOfTypeFollowing[i + 1]
  end
  
  local function GetLargeFaceValue(tbCost1, tbCost2)
    for i = 1, #tbCost1 do
      if tbCost1[i] > tbCost2[i] then
        return tbCost1
      elseif tbCost1[i] < tbCost2[i] then
        return tbCost2
      end
    end
    return tbCost1
  end
  
  local function Proportion(tbProportioned, nCurMatType, nRemain)
    if nCurMatType > nTypeCount or nRemain <= 0 then
      local nSum = GetProportionedSum(tbProportioned)
      if nSum >= nTarget then
        if nSum < nMinTarget then
          nMinTarget = nSum
          tbCost = tbProportioned
        elseif nSum == nMinTarget then
          tbCost = GetLargeFaceValue(tbCost, tbProportioned)
        end
      end
    else
      local nMaxUse = math.ceil(nRemain / tbMatType[nCurMatType])
      nMaxUse = math.min(nMaxUse, tbHas[nCurMatType])
      local nMinUse = math.max(nMaxUse - 1, 0)
      for i = nMaxUse, nMinUse, -1 do
        local tbCopy = {
          table.unpack(tbProportioned)
        }
        tbCopy[nCurMatType] = i
        local nSum = GetProportionedSum(tbCopy)
        if nSum > nMinTarget then
          return
        end
        local nNextRemain = nRemain - i * tbMatType[nCurMatType]
        Proportion(tbCopy, nCurMatType + 1, nNextRemain)
      end
    end
  end
  
  local tbProportioned = {}
  for i = 1, nTypeCount do
    tbProportioned[i] = 0
  end
  Proportion(tbProportioned, 1, nTarget)
  return tbCost
end

function PlayerDiscData:CalUpgradeMat(nTargetExp)
  local tbMatType, tbHas = {}, {}
  for _, value in ipairs(self.tbItemExp) do
    table.insert(tbMatType, value.nExpValue)
    table.insert(tbHas, PlayerData.Item:GetItemCountByID(value.nItemId))
  end
  local tbCostCount = self:CalCostProportion(nTargetExp, tbMatType, tbHas)
  local tbMat = {}
  for nIndex, value in ipairs(self.tbItemExp) do
    table.insert(tbMat, {
      nItemId = value.nItemId,
      nExpValue = value.nExpValue,
      nCost = tbCostCount[nIndex]
    })
  end
  return tbMat
end

function PlayerDiscData:GetDiscIdList()
  local tbDisc = {}
  for nId, _ in pairs(self._mapDisc) do
    table.insert(tbDisc, nId)
  end
  return tbDisc
end

function PlayerDiscData:SendDiscStrengthenReq(nId, tbMat, callback)
  if self._mapDisc[nId] == nil then
    printError(string.format("星盘不存在, id为: %d", nId))
    return
  end
  local tbItems = {}
  for _, mapMat in pairs(tbMat) do
    if mapMat.nCost > 0 then
      table.insert(tbItems, {
        Id = 0,
        Qty = mapMat.nCost,
        Tid = mapMat.nItemId
      })
    end
  end
  local msgData = {Id = nId, Items = tbItems}
  
  local function successCallback(_, mapMainData)
    self:UpdateDiscData(nId, {
      Level = mapMainData.Level,
      Exp = mapMainData.Exp
    })
    callback()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.disc_strengthen_req, msgData, nil, successCallback)
end

function PlayerDiscData:SendDiscPromoteReq(nId, callback)
  if self._mapDisc[nId] == nil then
    printError(string.format("星盘不存在, id为: %d", nId))
    return
  end
  
  local function successCallback(_, mapMainData)
    self:UpdateDiscData(nId, {
      Phase = mapMainData.Phase
    })
    self:UpdateStoryReddot(self._mapDisc[nId])
    self:UpdateAvgReddot(self._mapDisc[nId])
    callback()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.disc_promote_req, {Id = nId}, nil, successCallback)
end

function PlayerDiscData:SendDiscLimitBreakReq(nId, nCount, callback)
  if self._mapDisc[nId] == nil then
    printError(string.format("星盘不存在, id为: %d", nId))
    return
  end
  
  local function successCallback(_, mapMainData)
    self:UpdateDiscData(nId, {
      Star = mapMainData.Star
    })
    self:UpdateBreakLimitReddot(self._mapDisc[nId])
    callback()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.disc_limit_break_req, {Id = nId, Qty = nCount}, nil, successCallback)
end

function PlayerDiscData:SendAllDiscLimitBreakReq(callback)
  local function successCallback(_, mapMainData)
    for _, mapData in ipairs(mapMainData.LimitBreaks) do
      self:UpdateDiscData(mapData.Id, {
        Star = mapData.Star
      })
      self:UpdateBreakLimitReddot(self._mapDisc[mapData.Id])
    end
    callback()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.disc_all_limit_break_req, {}, nil, successCallback)
end

function PlayerDiscData:SendDiscReadRewardReceiveReq(nId, nType, callback)
  if self._mapDisc[nId] == nil then
    printError(string.format("星盘不存在, id为: %d", nId))
    return
  end
  local msgData = {Id = nId, ReadType = nType}
  
  local function successCallback(_, mapMainData)
    if nType == AllEnum.DiscReadType.DiscStory then
      self:UpdateDiscData(nId, {Read = true})
      self:UpdateStoryReddot(self._mapDisc[nId])
      UTILS.OpenReceiveByChangeInfo(mapMainData)
    elseif nType == AllEnum.DiscReadType.DiscAvg then
      self:UpdateDiscData(nId, {Avg = true})
      self:UpdateAvgReddot(self._mapDisc[nId])
    end
    if callback then
      callback(mapMainData)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.disc_read_reward_receive_req, msgData, nil, successCallback)
end

function PlayerDiscData:SendPlayerMusicSetReq(nId, callback)
  local function successCallback(_, mapMainData)
    self:CacheBGMDisc(nId)
    
    callback()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.player_music_set_req, {Value = nId}, nil, successCallback)
end

function PlayerDiscData:CacheBGMDisc(nId)
  self.nBGMDisc = nId
  if nId == 0 then
    WwiseAudioMgr.DiscUIBgm = ""
    return
  end
  local mapCfg = ConfigTable.GetData("DiscIP", nId)
  if not mapCfg then
    WwiseAudioMgr.DiscUIBgm = ""
    return
  end
  WwiseAudioMgr.DiscUIBgm = mapCfg.VoFile
end

function PlayerDiscData:CacheDiscData(tbData)
  for nId, _ in pairs(self._mapDisc) do
    self._mapDisc[nId] = nil
  end
  self:CreateNewDisc(tbData)
end

function PlayerDiscData:CreateNewDisc(tbData)
  if tbData == nil then
    return
  end
  for _, mapDisc in ipairs(tbData) do
    if self._mapDisc[mapDisc.Id] == nil then
      self:CreateDiscData(mapDisc)
    else
      printError(string.format("星盘唯一Id重复, 唯一Id: %d", mapDisc.Id))
    end
  end
end

function PlayerDiscData:UpdateDiscData(nId, mapData)
  if self._mapDisc[nId] == nil then
    printLog(string.format("该星盘不存在/是新星盘, 唯一Id: %d", nId))
    self:CreateDiscData(mapData)
  else
    self._mapDisc[nId]:ParseServerData(mapData)
  end
end

function PlayerDiscData:CreateDiscData(mapDisc)
  local discData = DiscData.new(mapDisc)
  local nId = discData.nId
  self._mapDisc[nId] = discData
  self:UpdateStoryReddot(discData)
  self:UpdateAvgReddot(discData)
  self:UpdateBreakLimitReddot(discData)
end

function PlayerDiscData:UpdateStoryReddot(mapDisc)
  local mapCfg = ConfigTable.GetData("Disc", mapDisc.nId)
  local nLimit = ConfigTable.GetConfigNumber("DiscStoryReadLimit")
  if mapCfg ~= nil and mapCfg.Visible then
    RedDotManager.SetValid(RedDotDefine.Disc_SideB_Read, {
      mapDisc.nId
    }, mapDisc.bRead == false and nLimit <= mapDisc.nPhase)
  end
end

function PlayerDiscData:UpdateAvgReddot(mapDisc)
  local mapCfg = ConfigTable.GetData("Disc", mapDisc.nId)
  local mapIPCfg = ConfigTable.GetData("DiscIP", mapDisc.nId)
  local nLimit = ConfigTable.GetConfigNumber("DiscAVGStoryReadLimit")
  if mapCfg ~= nil and mapCfg.Visible and mapIPCfg ~= nil then
    RedDotManager.SetValid(RedDotDefine.Disc_SideB_Avg, {
      mapDisc.nId
    }, mapIPCfg.AvgId ~= "" and mapDisc.bAvgRead == false and nLimit <= mapDisc.nPhase)
  end
end

function PlayerDiscData:UpdateBreakLimitReddot(mapDisc)
  local mapCfg = ConfigTable.GetData("Disc", mapDisc.nId)
  if mapCfg ~= nil and mapCfg.Visible then
    local _, nMatCount = self:GetBreakLimitMat(mapDisc.nId)
    RedDotManager.SetValid(RedDotDefine.Disc_BreakBtn, {
      mapDisc.nId
    }, 0 < nMatCount and mapDisc.nStar < mapDisc.nMaxStar)
  end
end

function PlayerDiscData:UpdateBreakLimitRedDotByItem(mapChange)
  for _, v in ipairs(mapChange) do
    local nId = self.ItemToDisc[v.Tid]
    if nId and self._mapDisc[nId] and v.Qty > 0 then
      self:UpdateBreakLimitReddot(self._mapDisc[nId])
    end
  end
end

function PlayerDiscData:CreateTrialDisc(tbTrialId)
  self._mapTrialDisc = {}
  for _, nTrialId in ipairs(tbTrialId) do
    local mapCfg = ConfigTable.GetData("TrialDisc", nTrialId)
    if mapCfg == nil then
      printError("体验星盘数据没有找到：" .. nTrialId)
      return
    end
    local discData = self:GenerateLocalDiscData(mapCfg.DiscId, 0, mapCfg.Level, mapCfg.Phase, mapCfg.Star)
    self._mapTrialDisc[nTrialId] = discData
  end
end

function PlayerDiscData:GetTrialDiscById(nId)
  if not nId then
    return
  end
  if self._mapTrialDisc == nil or self._mapTrialDisc[nId] == nil then
    printLog(string.format("该星盘不存在或新获得, 唯一Id: %d", nId))
    return
  end
  return self._mapTrialDisc[nId]
end

function PlayerDiscData:DeleteTrialDisc()
  self._mapTrialDisc = {}
end

function PlayerDiscData:CalcTrialEffectInBuild(nTrialId, tbSecondarySkill)
  local discData = self._mapTrialDisc[nTrialId]
  local tbEffectId = {}
  if discData == nil then
    return tbEffectId
  end
  
  local function add(tbEfId)
    if not tbEfId then
      return
    end
    for _, nEfId in pairs(tbEfId) do
      if type(nEfId) == "number" and 0 < nEfId then
        table.insert(tbEffectId, {nEfId, 0})
      end
    end
  end
  
  local mapMainCfg = ConfigTable.GetData("MainSkill", discData.nMainSkillId)
  if mapMainCfg then
    add(mapMainCfg.EffectId)
  end
  for _, v in ipairs(tbSecondarySkill) do
    local mapSubCfg = ConfigTable.GetData("SecondarySkill", v)
    if mapSubCfg and table.indexof(discData.tbSubSkillGroupId, mapSubCfg.GroupId) > 0 then
      add(mapSubCfg.EffectId)
    end
  end
  return tbEffectId
end

function PlayerDiscData:CalcTrialInfoInBuild(nTrialId, tbSecondarySkill)
  local discData = self._mapTrialDisc[nTrialId]
  local discInfo = CS.Lua2CSharpInfo_DiscInfo()
  if discData == nil then
    return discInfo
  end
  local tbSkillInfo = {}
  for _, v in ipairs(tbSecondarySkill) do
    local mapSubCfg = ConfigTable.GetData("SecondarySkill", v, true)
    if mapSubCfg and table.indexof(discData.tbSubSkillGroupId, mapSubCfg.GroupId) > 0 then
      local skillInfo = CS.Lua2CSharpInfo_DiscSkillInfo()
      skillInfo.skillId = v
      skillInfo.skillLevel = mapSubCfg.Level
      table.insert(tbSkillInfo, skillInfo)
    end
  end
  local mapMainCfg = ConfigTable.GetData("MainSkill", discData.nMainSkillId, true)
  if mapMainCfg then
    local skillInfo = CS.Lua2CSharpInfo_DiscSkillInfo()
    skillInfo.skillId = discData.nMainSkillId
    skillInfo.skillLevel = 1
    table.insert(tbSkillInfo, skillInfo)
  end
  discInfo.discId = discData.nId
  discInfo.discScript = discData.sSkillScript
  discInfo.skillInfos = tbSkillInfo
  discInfo.discLevel = discData.nLevel
  return discInfo
end

function PlayerDiscData:CreateLimitedTrialDisc(tbTrialId)
  for _, nTrialId in ipairs(tbTrialId) do
    local mapCfg = ConfigTable.GetData("TrialDisc", nTrialId)
    if mapCfg == nil then
      printError("限时试用星盘数据没有找到：" .. nTrialId)
      return
    end
    local discData = self:GenerateLocalDiscData(mapCfg.DiscId, 0, mapCfg.Level, mapCfg.Phase, mapCfg.Star)
    self._mapLimitedTrialDisc[nTrialId] = discData
  end
end

function PlayerDiscData:GetLimitedTrialDiscById(nId)
  if not nId then
    return
  end
  if self._mapLimitedTrialDisc == nil or self._mapLimitedTrialDisc[nId] == nil then
    printLog(string.format("该限时试用星盘不存在, 唯一Id: %d", nId))
    return
  end
  return self._mapLimitedTrialDisc[nId]
end

function PlayerDiscData:DeleteLimitedTrialDisc()
  self._mapLimitedTrialDisc = {}
end

function PlayerDiscData:CalcLimitedTrialEffectInBuild(nTrialId, tbSecondarySkill)
  local discData = self._mapLimitedTrialDisc[nTrialId]
  local tbEffectId = {}
  if discData == nil then
    return tbEffectId
  end
  
  local function add(tbEfId)
    if not tbEfId then
      return
    end
    for _, nEfId in pairs(tbEfId) do
      if type(nEfId) == "number" and 0 < nEfId then
        table.insert(tbEffectId, {nEfId, 0})
      end
    end
  end
  
  local mapMainCfg = ConfigTable.GetData("MainSkill", discData.nMainSkillId)
  if mapMainCfg then
    add(mapMainCfg.EffectId)
  end
  for _, v in ipairs(tbSecondarySkill) do
    local mapSubCfg = ConfigTable.GetData("SecondarySkill", v)
    if mapSubCfg and table.indexof(discData.tbSubSkillGroupId, mapSubCfg.GroupId) > 0 then
      add(mapSubCfg.EffectId)
    end
  end
  return tbEffectId
end

function PlayerDiscData:CalcLimitedTrialInfoInBuild(nTrialId, tbSecondarySkill)
  local discData = self._mapLimitedTrialDisc[nTrialId]
  local discInfo = CS.Lua2CSharpInfo_DiscInfo()
  if discData == nil then
    return discInfo
  end
  local tbSkillInfo = {}
  for _, v in ipairs(tbSecondarySkill) do
    local mapSubCfg = ConfigTable.GetData("SecondarySkill", v, true)
    if mapSubCfg and table.indexof(discData.tbSubSkillGroupId, mapSubCfg.GroupId) > 0 then
      local skillInfo = CS.Lua2CSharpInfo_DiscSkillInfo()
      skillInfo.skillId = v
      skillInfo.skillLevel = mapSubCfg.Level
      table.insert(tbSkillInfo, skillInfo)
    end
  end
  local mapMainCfg = ConfigTable.GetData("MainSkill", discData.nMainSkillId, true)
  if mapMainCfg then
    local skillInfo = CS.Lua2CSharpInfo_DiscSkillInfo()
    skillInfo.skillId = discData.nMainSkillId
    skillInfo.skillLevel = 1
    table.insert(tbSkillInfo, skillInfo)
  end
  discInfo.discId = discData.nId
  discInfo.discScript = discData.sSkillScript
  discInfo.skillInfos = tbSkillInfo
  discInfo.discLevel = discData.nLevel
  return discInfo
end

function PlayerDiscData:GetRankDetailDisc(nId)
  if not nId then
    return
  end
  if not nId then
    printError("GenerateLocalDiscData Failed!")
    return
  end
  local mapDisc = {}
  mapDisc.Id = nId
  mapDisc.Exp = 0
  mapDisc.Level = 1
  mapDisc.Phase = 0
  mapDisc.Star = 0
  mapDisc.Read = false
  local discData = DiscData.new(mapDisc)
  return discData
end

local tbSortNameTextCfg = {
  "CharList_Sort_Toggle_Level",
  "CharList_Sort_Toggle_Rare",
  "CharList_Sort_Toggle_Time"
}
local tbSortType = {
  [1] = AllEnum.SortType.Level,
  [2] = AllEnum.SortType.Rarity,
  [3] = AllEnum.SortType.Time,
  [100] = AllEnum.SortType.ElementType,
  [101] = AllEnum.SortType.Id
}
local tbDefaultSortField = {
  "nLevel",
  "nRarity",
  "nEET",
  "nId"
}

function PlayerDiscData:GetDiscSortNameTextCfg()
  return tbSortNameTextCfg
end

function PlayerDiscData:GetDiscSortType()
  return tbSortType
end

function PlayerDiscData:GetDiscSortField()
  return tbDefaultSortField
end

return PlayerDiscData
