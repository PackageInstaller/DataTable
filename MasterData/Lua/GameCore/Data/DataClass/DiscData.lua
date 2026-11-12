local ConfigData = require("GameCore.Data.ConfigData")
local DiscData = class("DiscData")

function DiscData:ctor(mapDisc)
  self.nId = nil
  self.sName = nil
  self.sDesc = nil
  self.nRarity = nil
  self.sIcon = nil
  self.bRead = nil
  self.bAvgRead = nil
  self.nCreateTime = nil
  self.nEET = nil
  self.tbTag = nil
  self.nLevel = nil
  self.nMaxLv = nil
  self.nStrengthenGroupId = nil
  self.nAttrBaseGroupId = nil
  self.nAttrExtraGroupId = nil
  self.mapAttrBase = nil
  self.mapAttrExtra = nil
  self.nExp = nil
  self.nPhase = nil
  self.nMaxPhase = nil
  self.nPromoteGroupId = nil
  self.nPromoteGoldReq = nil
  self.tbPromoteItemInfoReq = nil
  self.bUnlockL2D = nil
  self.nStar = nil
  self.nMaxStar = nil
  self.nTransformItemId = nil
  self.mapMaxStarTransformItem = nil
  self.nMainSkillGroupId = nil
  self.nMainSkillId = nil
  self.tbSubSkillGroupId = nil
  self.sSkillScript = nil
  self.tbSubNoteSkills = nil
  self.tbSkillNeedNote = nil
  self.nSubNoteSkillGroupId = nil
  self.nSubNoteSkillId = nil
  self.tbShowNote = nil
  self.mapReadReward = nil
  self.mapAvgReward = nil
  self:Parse(mapDisc)
end

function DiscData:Parse(mapDisc)
  self.nId = mapDisc.Id
  local mapItemCfgData = ConfigTable.GetData_Item(mapDisc.Id)
  if not mapItemCfgData then
    printError("星盘Id有误, 道具表中未找到数据, Id: " .. tostring(mapDisc.Id))
    return
  end
  local mapDiscCfgData = ConfigTable.GetData("Disc", mapDisc.Id)
  if mapDiscCfgData == nil then
    printError("星盘Id有误, 未找到配置表数据, Id: " .. tostring(mapDisc.Id))
    return
  end
  self:ParseConfigData(mapItemCfgData, mapDiscCfgData)
  self:ParseServerData(mapDisc)
end

function DiscData:ParseConfigData(mapItemCfgData, mapDiscCfgData)
  self.sName = mapItemCfgData.Title
  self.sDesc = mapItemCfgData.Desc
  self.nRarity = mapItemCfgData.Rarity
  self.sIcon = mapItemCfgData.Icon
  self.nEET = mapDiscCfgData.EET
  self.tbTag = mapDiscCfgData.Tags
  self.nStrengthenGroupId = mapDiscCfgData.StrengthenGroupId
  self.nAttrBaseGroupId = mapDiscCfgData.AttrBaseGroupId
  self.nAttrExtraGroupId = mapDiscCfgData.AttrExtraGroupId
  self.nPromoteGroupId = mapDiscCfgData.PromoteGroupId
  self:ParseMaxPhase()
  self.nTransformItemId = mapDiscCfgData.TransformItemId
  self.mapMaxStarTransformItem = mapDiscCfgData.MaxStarTransformItem
  self.nMaxStar = PlayerData.Disc:GetDiscMaxStar(self.nRarity)
  self.nMainSkillGroupId = mapDiscCfgData.MainSkillGroupId
  self.tbSubSkillGroupId = {}
  if mapDiscCfgData.SecondarySkillGroupId1 > 0 then
    table.insert(self.tbSubSkillGroupId, mapDiscCfgData.SecondarySkillGroupId1)
  end
  if 0 < mapDiscCfgData.SecondarySkillGroupId2 then
    table.insert(self.tbSubSkillGroupId, mapDiscCfgData.SecondarySkillGroupId2)
  end
  self.sSkillScript = mapDiscCfgData.SkillScript
  self.nSubNoteSkillGroupId = mapDiscCfgData.SubNoteSkillGroupId
  self.tbSkillNeedNote = {}
  local mapNote = {}
  for _, nSkillGroupId in ipairs(self.tbSubSkillGroupId) do
    local tbGroup = CacheTable.GetData("_SecondarySkill", nSkillGroupId)
    if tbGroup and tbGroup[1] then
      local tbActiveNote = decodeJson(tbGroup[1].NeedSubNoteSkills)
      if tbActiveNote ~= nil then
        for k, v in pairs(tbActiveNote) do
          local nNoteId = tonumber(k)
          local nNoteCount = tonumber(v)
          if nNoteId ~= nil and nNoteCount ~= nil then
            if mapNote[nNoteId] == nil then
              mapNote[nNoteId] = 0
            end
            mapNote[nNoteId] = nNoteCount > mapNote[nNoteId] and nNoteCount or mapNote[nNoteId]
          end
        end
      end
    end
  end
  for nNoteId, nCount in pairs(mapNote) do
    table.insert(self.tbSkillNeedNote, {nId = nNoteId, nCount = nCount})
  end
  self.mapReadReward = {
    nId = mapDiscCfgData.ReadReward[1],
    nCount = mapDiscCfgData.ReadReward[2]
  }
  self.mapAvgReward = {
    nId = mapDiscCfgData.AVGReadReward[1],
    nCount = mapDiscCfgData.AVGReadReward[2]
  }
end

function DiscData:ParseMaxPhase()
  self.nMaxPhase = self.nMaxPhase or 0
  
  local function foreachDiscPromoteLimit(mapData)
    if mapData.Rarity == self.nRarity and tonumber(mapData.Phase) > self.nMaxPhase then
      self.nMaxPhase = tonumber(mapData.Phase)
    end
  end
  
  ForEachTableLine(DataTable.DiscPromoteLimit, foreachDiscPromoteLimit)
end

function DiscData:ParseServerData(mapDisc)
  if not mapDisc then
    printError("DiscData ParseServerData Failed")
    return
  end
  local bPhaseChange, bStarChange = false, false
  if mapDisc.Phase ~= nil then
    bPhaseChange = self.nPhase ~= mapDisc.Phase
  end
  if mapDisc.Star ~= nil then
    bStarChange = self.nStar ~= mapDisc.Star
  end
  if mapDisc.Exp ~= nil then
    self.nExp = mapDisc.Exp
  end
  if mapDisc.Level ~= nil then
    self.nLevel = mapDisc.Level
  end
  if mapDisc.Phase ~= nil then
    self.nPhase = mapDisc.Phase
  end
  if mapDisc.Star ~= nil then
    self.nStar = mapDisc.Star
  end
  if mapDisc.Read ~= nil then
    self.bRead = mapDisc.Read
  end
  if mapDisc.Avg ~= nil then
    self.bAvgRead = mapDisc.Avg
  end
  if mapDisc.CreateTime ~= nil then
    self.nCreateTime = mapDisc.CreateTime
  end
  self:UpdateMaxLv()
  self:UpdateAttr()
  if bPhaseChange then
    self:UpdatePromoteGoldCountReq()
    self:UpdatePromoteItemInfoReq()
    self:UpdateNoteData()
    self:UpdateUnlockData()
  end
  if bStarChange then
    self:UpdateMainSkillData()
  end
end

function DiscData:UpdateMaxLv()
  self.nMaxLv = self.nMaxLv or 1
  
  local function foreachDiscPromoteLimit(mapData)
    if mapData.Rarity == self.nRarity and tonumber(mapData.Phase) == self.nPhase and tonumber(mapData.Phase) == self.nPhase then
      self.nMaxLv = tonumber(mapData.MaxLevel)
    end
  end
  
  ForEachTableLine(DataTable.DiscPromoteLimit, foreachDiscPromoteLimit)
end

function DiscData:UpdateAttr()
  self.mapAttrBase, self.mapAttrExtra = {}, {}
  for _, v in ipairs(AllEnum.AttachAttr) do
    self.mapAttrExtra[v.sKey] = {
      Key = v.sKey,
      Value = 0,
      CfgValue = 0
    }
  end
  if 0 < self.nStar and 0 < self.nAttrExtraGroupId then
    local nExtraId = UTILS.GetDiscExtraAttributeId(self.nAttrExtraGroupId, self.nStar)
    local mapExtra = ConfigTable.GetData("DiscExtraAttribute", tostring(nExtraId))
    if mapExtra and type(mapExtra) == "table" then
      for _, v in ipairs(AllEnum.AttachAttr) do
        local nParamValue = mapExtra[v.sKey] or 0
        self.mapAttrExtra[v.sKey] = {
          Key = v.sKey,
          Value = v.bPercent and nParamValue * ConfigData.IntFloatPrecision * 100 or nParamValue,
          CfgValue = mapExtra[v.sKey] or 0
        }
      end
    end
  end
  local nAttrBaseId = UTILS.GetDiscAttributeId(self.nAttrBaseGroupId, self.nPhase, self.nLevel)
  local mapAttribute = ConfigTable.GetData_Attribute(tostring(nAttrBaseId))
  if type(mapAttribute) == "table" then
    for _, v in ipairs(AllEnum.AttachAttr) do
      local nParamValue = mapAttribute[v.sKey] or 0
      local nValue = v.bPercent and nParamValue * ConfigData.IntFloatPrecision * 100 or nParamValue
      self.mapAttrBase[v.sKey] = {
        Key = v.sKey,
        Value = nValue + self.mapAttrExtra[v.sKey].Value,
        CfgValue = nParamValue + self.mapAttrExtra[v.sKey].CfgValue
      }
    end
  else
    printError("星盘属性配置错误：" .. nAttrBaseId)
    for _, v in ipairs(AllEnum.AttachAttr) do
      self.mapAttrBase[v.sKey] = {
        Key = v.sKey,
        Value = 0,
        CfgValue = 0
      }
    end
  end
end

function DiscData:UpdatePromoteGoldCountReq()
  if self.nMaxPhase == self.nPhase then
    self.nPromoteGoldReq = 0
    return
  end
  if self.nPromoteGroupId == 0 then
    printError("无星盘进阶组" .. self.nId)
    self.nPromoteGoldReq = 0
    return
  end
  local nDiscPromoteId = self.nPromoteGroupId * 1000 + (self.nPhase + 1)
  local mapCfgData = ConfigTable.GetData("DiscPromote", nDiscPromoteId)
  self.nPromoteGoldReq = 0
  if type(mapCfgData) == "table" then
    self.nPromoteGoldReq = mapCfgData.ExpenseGold
  end
end

function DiscData:UpdatePromoteItemInfoReq()
  if self.nMaxPhase == self.nPhase then
    self.tbPromoteItemInfoReq = {}
    return
  end
  if not self.tbPromoteItemInfoReq then
    self.tbPromoteItemInfoReq = {}
  end
  for index, _ in pairs(self.tbPromoteItemInfoReq) do
    self.tbPromoteItemInfoReq[index] = nil
  end
  if self.nPromoteGroupId == 0 then
    printError("无星盘进阶组" .. self.nId)
    return
  end
  local nDiscPromoteId = self.nPromoteGroupId * 1000 + (self.nPhase + 1)
  local mapCfgData = ConfigTable.GetData("DiscPromote", nDiscPromoteId)
  if type(mapCfgData) == "table" then
    for i = 1, 4 do
      local item = {}
      local nItemId = mapCfgData[string.format("ItemId%d", i)]
      local nItemNum = mapCfgData[string.format("Num%d", i)]
      if type(nItemId) == "number" and type(nItemNum) == "number" and 0 < nItemId and 0 < nItemNum then
        item.nItemId = nItemId
        item.nItemNum = nItemNum
        table.insert(self.tbPromoteItemInfoReq, item)
      end
    end
  end
end

function DiscData:UpdateMainSkillData()
  if self.nMainSkillGroupId <= 0 then
    return
  end
  local mapGroup = CacheTable.GetData("_MainSkill", self.nMainSkillGroupId)
  if mapGroup then
    local mapCfg = mapGroup[self.nStar + 1]
    if not mapCfg then
      printError("MainSkill缺失配置,GroupId:" .. self.nMainSkillGroupId .. " Level:" .. self.nStar + 1)
      return
    end
    self.nMainSkillId = mapCfg.Id
  end
end

function DiscData:UpdateNoteData()
  self.tbSubNoteSkills = {}
  self.tbShowNote = {}
  if self.nSubNoteSkillGroupId <= 0 then
    return
  end
  local mapGroup = CacheTable.GetData("_SubNoteSkillPromoteGroup", self.nSubNoteSkillGroupId)
  if not mapGroup then
    return
  end
  local nCurPhase = self.nPhase
  local mapCfg
  while type(nCurPhase) == "number" and 0 <= nCurPhase do
    mapCfg = mapGroup[nCurPhase]
    if mapCfg then
      self.nSubNoteSkillId = mapCfg.Id
      break
    else
      nCurPhase = nCurPhase - 1
    end
  end
  if not mapCfg then
    return
  end
  local tbNote = decodeJson(mapCfg.SubNoteSkills)
  for k, v in pairs(tbNote) do
    local nNoteId = tonumber(k)
    local nNoteCount = tonumber(v)
    if nNoteId then
      table.insert(self.tbSubNoteSkills, {nId = nNoteId, nCount = nNoteCount})
      table.insert(self.tbShowNote, nNoteId)
    end
  end
end

function DiscData:UpdateUnlockData()
  self.bUnlockL2D = false
  if self.nRarity == GameEnum.itemRarity.SSR then
    local nLimit = ConfigTable.GetConfigNumber("DiscL2dUnlock")
    if nLimit <= self.nPhase then
      self.bUnlockL2D = true
    end
  end
end

function DiscData:CheckSubSkillActive(tbNote, mapCfg)
  local tbActiveNote = decodeJson(mapCfg.NeedSubNoteSkills)
  local tbNoteAble = {}
  for k, v in pairs(tbActiveNote) do
    local nNoteId = tonumber(k)
    local nNoteCount = tonumber(v)
    if nNoteId then
      tbNoteAble[nNoteId] = false
      local nHas = tbNote[nNoteId]
      if nHas and nNoteCount <= nHas then
        tbNoteAble[nNoteId] = true
      end
    end
  end
  local bActive = true
  for _, v in pairs(tbNoteAble) do
    if v == false then
      bActive = false
      break
    end
  end
  if bActive and next(tbNoteAble) ~= nil then
    return true
  end
  return false
end

function DiscData:GetAllSubSkill(tbNote)
  local tbSkill = {}
  for _, nSubSkillGroupId in pairs(self.tbSubSkillGroupId) do
    local tbGroup = CacheTable.GetData("_SecondarySkill", nSubSkillGroupId)
    if tbGroup then
      local nCurLayer = 1
      local nMaxLayer = #tbGroup
      for i = nMaxLayer, 1, -1 do
        if tbGroup[i] then
          local bActive = self:CheckSubSkillActive(tbNote, tbGroup[i])
          if bActive then
            nCurLayer = i
            break
          end
        end
      end
      if tbGroup[nCurLayer] then
        table.insert(tbSkill, tbGroup[nCurLayer].Id)
      end
    end
  end
  return tbSkill
end

function DiscData:GetSubSkillMaxLevel(nSubSkillGroupId)
  local tbGroup = CacheTable.GetData("_SecondarySkill", nSubSkillGroupId)
  if not tbGroup then
    return 0
  end
  local nMaxLayer = #tbGroup
  return nMaxLayer
end

function DiscData:GetSubSkillLevel(nSubSkillGroupId, tbNote)
  local tbGroup = CacheTable.GetData("_SecondarySkill", nSubSkillGroupId)
  if not tbGroup then
    return 0, 0
  end
  local nCurLayer = 0
  local nMaxLayer = #tbGroup
  for i = nMaxLayer, 1, -1 do
    if tbGroup[i] then
      local bActive = self:CheckSubSkillActive(tbNote, tbGroup[i])
      if bActive then
        nCurLayer = i
        break
      end
    end
  end
  return nCurLayer, nMaxLayer
end

function DiscData:GetSkillEffect(tbNote)
  local tbEffectId = {}
  
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
  
  local mapMainCfg = ConfigTable.GetData("MainSkill", self.nMainSkillId)
  if mapMainCfg then
    add(mapMainCfg.EffectId)
  end
  for _, nSubSkillGroupId in pairs(self.tbSubSkillGroupId) do
    local tbGroup = CacheTable.GetData("_SecondarySkill", nSubSkillGroupId)
    if tbGroup then
      local nMaxLayer = #tbGroup
      for i = nMaxLayer, 1, -1 do
        if tbGroup[i] then
          local bActive = self:CheckSubSkillActive(tbNote, tbGroup[i])
          if bActive then
            add(tbGroup[i].EffectId)
            break
          end
        end
      end
    end
  end
  return tbEffectId
end

function DiscData:GetDiscInfo(tbNote)
  local tbSkillInfo = {}
  local skillInfoMain = CS.Lua2CSharpInfo_DiscSkillInfo()
  skillInfoMain.skillId = self.nMainSkillId
  skillInfoMain.skillLevel = 1
  table.insert(tbSkillInfo, skillInfoMain)
  for _, nSubSkillGroupId in pairs(self.tbSubSkillGroupId) do
    local tbGroup = CacheTable.GetData("_SecondarySkill", nSubSkillGroupId)
    if tbGroup then
      local nLayer = 0
      local nSubSkillId = tbGroup[1].Id
      local nMaxLayer = #tbGroup
      for i = nMaxLayer, 1, -1 do
        if tbGroup[i] then
          local bActive = self:CheckSubSkillActive(tbNote, tbGroup[i])
          if bActive then
            nLayer = i
            nSubSkillId = tbGroup[i].Id
            break
          end
        end
      end
      if 0 < nLayer then
        local skillInfo = CS.Lua2CSharpInfo_DiscSkillInfo()
        skillInfo.skillId = nSubSkillId
        skillInfo.skillLevel = nLayer
        table.insert(tbSkillInfo, skillInfo)
      end
    end
  end
  local discInfo = CS.Lua2CSharpInfo_DiscInfo()
  discInfo.discId = self.nId
  discInfo.discScript = self.sSkillScript
  discInfo.skillInfos = tbSkillInfo
  discInfo.discLevel = self.nLevel
  return discInfo
end

return DiscData
