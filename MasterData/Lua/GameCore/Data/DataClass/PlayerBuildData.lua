local LocalData = require("GameCore.Data.LocalData")
local ConfigData = require("GameCore.Data.ConfigData")
local RapidJson = require("rapidjson")
local PlayerBuildData = class("PlayerBuildData")
local newDayTime = UTILS.GetDayRefreshTimeOffset()

function PlayerBuildData:Init()
  self._MapBuildData = {}
  self._MapLimitedTrialBuildData = {}
  self._tbLimitedTrialBuildId = {}
  self._sLimitedTrialBuildCacheKey = nil
  self.hasData = false
  self:InitBuildRank()
end

function PlayerBuildData:InitBuildRank()
  self._tbBuildRank = {}
  
  local function foreach(line)
    self._tbBuildRank[line.Id] = line
  end
  
  ForEachTableLine(DataTable.StarTowerBuildRank, foreach)
  self._nBuildRankCount = #self._tbBuildRank
end

function PlayerBuildData:GetBuildRank()
  return self._tbBuildRank
end

function PlayerBuildData:GetBuildData(nBuildId)
  if nBuildId == nil then
    return nil
  end
  if self._MapBuildData[nBuildId] ~= nil then
    return self._MapBuildData[nBuildId]
  end
  if self._MapLimitedTrialBuildData[nBuildId] ~= nil then
    return self._MapLimitedTrialBuildData[nBuildId]
  end
  if self._mapTrialBuild ~= nil and self._mapTrialBuild.nBuildId == nBuildId then
    return self._mapTrialBuild
  end
end

function PlayerBuildData:GetBuildSourceByData(mapBuildData)
  return mapBuildData and mapBuildData.nBuildSource or AllEnum.BuildSource.Normal
end

function PlayerBuildData:PrioritizeLimitedTrialBuilds(tbBuildData, funcGetPriority)
  local mapGroups = {}
  for nIndex, mapBuild in ipairs(tbBuildData) do
    local mapCharCfg = ConfigTable.GetData_Character(mapBuild.tbChar[1].nTid)
    local nPriority = funcGetPriority and funcGetPriority(mapBuild) or 0
    local sGroupKey = table.concat({
      mapBuild.mapRank.Level,
      mapCharCfg.EET,
      nPriority
    }, ":")
    local mapGroup = mapGroups[sGroupKey]
    if mapGroup == nil then
      mapGroup = {
        tbIndices = {},
        tbLimitedTrial = {},
        tbOther = {}
      }
      mapGroups[sGroupKey] = mapGroup
    end
    table.insert(mapGroup.tbIndices, nIndex)
    if self:GetBuildSourceByData(mapBuild) == AllEnum.BuildSource.LimitedTrial then
      table.insert(mapGroup.tbLimitedTrial, mapBuild)
    else
      table.insert(mapGroup.tbOther, mapBuild)
    end
  end
  for _, mapGroup in pairs(mapGroups) do
    local nLimitedTrialCount = #mapGroup.tbLimitedTrial
    if 0 < nLimitedTrialCount then
      for nIndex, nListIndex in ipairs(mapGroup.tbIndices) do
        if nIndex <= nLimitedTrialCount then
          tbBuildData[nListIndex] = mapGroup.tbLimitedTrial[nIndex]
        else
          tbBuildData[nListIndex] = mapGroup.tbOther[nIndex - nLimitedTrialCount]
        end
      end
    end
  end
end

function PlayerBuildData:GetBuildDiscByData(mapBuildData, nDiscId)
  if mapBuildData == nil or nDiscId == nil or nDiscId == 0 then
    return nil
  end
  local nBuildSource = self:GetBuildSourceByData(mapBuildData)
  if nBuildSource == AllEnum.BuildSource.LimitedTrial then
    return PlayerData.Disc:GetLimitedTrialDiscById(nDiscId)
  elseif nBuildSource == AllEnum.BuildSource.Trial or mapBuildData.bTrial == true then
    return PlayerData.Disc:GetTrialDiscById(nDiscId)
  end
  local mapDisc = PlayerData.Disc:GetDiscById(nDiscId)
  if mapDisc == nil and mapBuildData.bRankPreview == true and ConfigTable.GetData("Disc", nDiscId) ~= nil and ConfigTable.GetData_Item(nDiscId) ~= nil then
    mapDisc = PlayerData.Disc:GetRankDetailDisc(nDiscId)
  end
  return mapDisc
end

function PlayerBuildData:GetBuildSource(nBuildId)
  return self:GetBuildSourceByData(self:GetBuildData(nBuildId))
end

function PlayerBuildData:IsTrialBuild(nBuildId)
  return self:GetBuildSource(nBuildId) == AllEnum.BuildSource.Trial
end

function PlayerBuildData:IsLimitedTrialBuild(nBuildId)
  return self:GetBuildSource(nBuildId) == AllEnum.BuildSource.LimitedTrial
end

function PlayerBuildData:IsUseTrialRuntime(nBuildId)
  local nSource = self:GetBuildSource(nBuildId)
  return nSource == AllEnum.BuildSource.Trial or nSource == AllEnum.BuildSource.LimitedTrial
end

function PlayerBuildData:IsBuildEditable(nBuildId)
  return self:GetBuildSource(nBuildId) == AllEnum.BuildSource.Normal
end

function PlayerBuildData:FilterEditableBuildIds(tbBuildId)
  local tbRet = {}
  if type(tbBuildId) ~= "table" then
    return tbRet
  end
  for _, nBuildId in ipairs(tbBuildId) do
    if self:IsBuildEditable(nBuildId) then
      table.insert(tbRet, nBuildId)
    end
  end
  return tbRet
end

function PlayerBuildData:IsLimitedTrialBuildActivityOpen()
  return PlayerData.Reengagement ~= nil and PlayerData.Reengagement:GetActIsOpen()
end

function PlayerBuildData:IsLimitedTrialBuildAllowedType(nType)
  if nType == AllEnum.RegionBossFormationType.ScoreBoss or nType == AllEnum.RegionBossFormationType.ScoreBoss_GM or nType == AllEnum.RegionBossFormationType.JointDrill or nType == AllEnum.RegionBossFormationType.JointDrill_2 then
    return false
  end
  return true
end

function PlayerBuildData:IsLimitedTrialBuildValid(nBuildId, nType)
  if not self:IsLimitedTrialBuildActivityOpen() or not self:IsLimitedTrialBuildAllowedType(nType) then
    return false
  end
  local tbBuildId = PlayerData.Reengagement:GetLimitedTrialBuildList() or {}
  return table.indexof(tbBuildId, nBuildId) > 0
end

function PlayerBuildData:CreateBuildBriefData(mapBuildBriefMsg)
  if nil ~= self._MapBuildData[mapBuildBriefMsg.Id] then
    printLog(string.format("编队信息重复！！！id= [%s]", mapBuildBriefMsg.Id))
  end
  local mapBuildData = {
    nBuildId = mapBuildBriefMsg.Id,
    nBuildSource = AllEnum.BuildSource.Normal,
    sName = mapBuildBriefMsg.Name,
    tbChar = {},
    nScore = mapBuildBriefMsg.Score,
    mapRank = self:CalBuildRank(mapBuildBriefMsg.Score),
    bLock = mapBuildBriefMsg.Lock,
    bPreference = mapBuildBriefMsg.Preference,
    bDetail = false,
    tbDisc = {},
    tbSecondarySkill = {},
    tbPotentials = {},
    tbNotes = {},
    nTowerId = mapBuildBriefMsg.StarTowerId,
    nModifierState = AllEnum.BuildModifierState.NotModified
  }
  for i = 1, 3 do
    table.insert(mapBuildData.tbChar, {
      nTid = mapBuildBriefMsg.Chars[i].CharId,
      nPotentialCount = mapBuildBriefMsg.Chars[i].PotentialCnt
    })
  end
  mapBuildData.tbDisc = mapBuildBriefMsg.DiscIds
  self._MapBuildData[mapBuildBriefMsg.Id] = mapBuildData
end

function PlayerBuildData:CreateBuildDetailData(nBuildId, mapBuildDetailMsg)
  if nil == mapBuildDetailMsg or nil == next(mapBuildDetailMsg) then
    return
  end
  if nil == self._MapBuildData[nBuildId] then
    printLog(string.format("找不到编队信息！！！id= [%s]", nBuildId))
    return
  end
  self._MapBuildData[nBuildId].tbSecondarySkill = mapBuildDetailMsg.ActiveSecondaryIds
  for _, v in ipairs(mapBuildDetailMsg.Potentials) do
    local potentialCfg = ConfigTable.GetData("Potential", v.PotentialId)
    if potentialCfg then
      local nCharId = potentialCfg.CharId
      if nil == self._MapBuildData[nBuildId].tbPotentials[nCharId] then
        self._MapBuildData[nBuildId].tbPotentials[nCharId] = {}
      end
      table.insert(self._MapBuildData[nBuildId].tbPotentials[nCharId], {
        nPotentialId = v.PotentialId,
        nLevel = v.Level
      })
    end
  end
  local tbNotes = {}
  for _, v in pairs(mapBuildDetailMsg.SubNoteSkills) do
    tbNotes[v.Tid] = v.Qty
  end
  self._MapBuildData[nBuildId].tbNotes = tbNotes
  self._MapBuildData[nBuildId].nModifierState = mapBuildDetailMsg.ModifierState
  self._MapBuildData[nBuildId].bDetail = true
end

function PlayerBuildData:RefreshBuildInfo(mapBuildInfo)
  if nil == mapBuildInfo or nil == mapBuildInfo.Brief then
    return
  end
  local mapBuildBriefMsg = mapBuildInfo.Brief
  local nBuildId = mapBuildBriefMsg.Id
  if nil == self._MapBuildData[nBuildId] then
    printLog(string.format("找不到编队信息，无法刷新！！！id= [%s]", nBuildId))
    return
  end
  local mapBuildData = self._MapBuildData[nBuildId]
  mapBuildData.sName = mapBuildBriefMsg.Name
  mapBuildData.nScore = mapBuildBriefMsg.Score
  mapBuildData.mapRank = self:CalBuildRank(mapBuildBriefMsg.Score)
  mapBuildData.bLock = mapBuildBriefMsg.Lock
  mapBuildData.bPreference = mapBuildBriefMsg.Preference
  mapBuildData.nTowerId = mapBuildBriefMsg.StarTowerId
  mapBuildData.tbDisc = mapBuildBriefMsg.DiscIds
  if mapBuildInfo.Detail ~= nil then
  end
  local tbChar = {}
  for i = 1, 3 do
    table.insert(tbChar, {
      nTid = mapBuildBriefMsg.Chars[i].CharId,
      nPotentialCount = mapBuildBriefMsg.Chars[i].PotentialCnt
    })
  end
  mapBuildData.tbChar = tbChar
  mapBuildData.tbPotentials = {}
  self:CreateBuildDetailData(nBuildId, mapBuildInfo.Detail)
end

function PlayerBuildData:GetAllBuildBriefData(callback)
  if not self.hasData then
    self:NetMsg_GetBuildBriefData(self.GetBuildBriefDataCallback, callback)
    return false
  end
  self:GetBuildBriefDataCallback(callback)
  return true
end

function PlayerBuildData:GetBuildCount(callback)
  if not self.hasData then
    self:NetMsg_GetBuildBriefData(self.GetBuildCountCallBack, callback)
    return false
  end
  self:GetBuildCountCallBack(callback)
  return true
end

function PlayerBuildData:GetBuildDetailData(callback, nBuildId)
  local mapBuildData = self:GetBuildData(nBuildId)
  if mapBuildData ~= nil and self:GetBuildSourceByData(mapBuildData) ~= AllEnum.BuildSource.Normal then
    if callback then
      callback(mapBuildData)
    end
    return true
  end
  if self._MapBuildData[nBuildId] == nil then
    if self.hasData then
      printWarn("没有该id的build，大概率已被分解：" .. nBuildId)
      if callback then
        callback()
      end
      return false
    end
    
    local function callBack()
      self:GetBuildDetailData(callback, nBuildId)
    end
    
    self:NetMsg_GetBuildBriefData(self.GetBuildBriefDataCallback, callBack)
    return false
  end
  if not self._MapBuildData[nBuildId].bDetail then
    self:NetMsg_GetBuildDetailData(nBuildId, self.GetBuildDetailDataCallback, callback, nBuildId)
    return false
  end
  self:GetBuildDetailDataCallback(callback, nBuildId)
  return true
end

function PlayerBuildData:ChangeBuildName(nBuildId, sName, callback)
  if not self:IsBuildEditable(nBuildId) then
    if callback then
      callback()
    end
    return
  end
  self:NetMsg_ChangeBuildName(nBuildId, sName, callback)
end

function PlayerBuildData:ChangeBuildLock(nBuildId, bLock, callback)
  if not self:IsBuildEditable(nBuildId) then
    if callback then
      callback()
    end
    return
  end
  self:NetMsg_ChangeBuildLock(nBuildId, bLock, callback)
end

function PlayerBuildData:DeleteBuild(tbBuildId, callback, cbClose)
  tbBuildId = self:FilterEditableBuildIds(tbBuildId)
  if #tbBuildId == 0 then
    if callback then
      callback()
    end
    return
  end
  self:NetMsg_BuildDelete(tbBuildId, callback, cbClose)
end

function PlayerBuildData:DeleteBuildByActivity(tbBuildId)
  for _, bBuildId in ipairs(tbBuildId) do
    self._MapBuildData[bBuildId] = nil
  end
end

function PlayerBuildData:SetBuildPreference(tbCheckInIds, tbCheckOutIds, callback)
  tbCheckInIds = self:FilterEditableBuildIds(tbCheckInIds)
  tbCheckOutIds = self:FilterEditableBuildIds(tbCheckOutIds)
  if #tbCheckInIds == 0 and #tbCheckOutIds == 0 then
    if callback then
      callback()
    end
    return
  end
  self:NetMsg_BuildPreference(tbCheckInIds, tbCheckOutIds, callback)
end

function PlayerBuildData:SaveBuild(nBuildID, bDelete, bLock, bPreference, sName, callback)
  if not self:IsBuildEditable(nBuildID) then
    if callback then
      callback()
    end
    return
  end
  self:NetMsg_SaveBuild(nBuildID, bDelete, bLock, bPreference, sName, callback)
end

function PlayerBuildData:ModifyBuildNote(nBuildId, tbNoteChange, callback)
  local mapBuildData = self:GetBuildData(nBuildId)
  local nModifierState = mapBuildData and mapBuildData.nModifierState
  local bNoteModifiable = nModifierState == AllEnum.BuildModifierState.NotModified or nModifierState == AllEnum.BuildModifierState.PotentialModified
  if not bNoteModifiable then
    if callback then
      callback(false)
    end
    return
  end
  local msg = {
    BuildId = nBuildId,
    NoteChange = {Items = tbNoteChange}
  }
  
  local function callBack(_, mapMainData)
    self:RefreshBuildInfo(mapMainData.Info)
    if callback ~= nil then
      callback(mapMainData.Change)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.star_tower_build_note_modify_req, msg, nil, callBack)
end

function PlayerBuildData:ModifyBuildPotential(nBuildId, tbPotentialChange, callback)
  local mapBuildData = self:GetBuildData(nBuildId)
  local nModifierState = mapBuildData and mapBuildData.nModifierState
  local bPotentialModifiable = nModifierState == AllEnum.BuildModifierState.NotModified or nModifierState == AllEnum.BuildModifierState.NoteModified
  if not bPotentialModifiable then
    if callback then
      callback(false)
    end
    return
  end
  local msg = {
    BuildId = nBuildId,
    PotentialChange = {Items = tbPotentialChange}
  }
  
  local function callBack(_, mapMainData)
    self:RefreshBuildInfo(mapMainData.Info)
    if callback ~= nil then
      callback(mapMainData.Change)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.star_tower_build_potential_modify_req, msg, nil, callBack)
end

function PlayerBuildData:CheckHasBuild()
  return next(self._MapBuildData) ~= nil
end

function PlayerBuildData:CalBuildCharacterAttrBattle(nBuildId, nCharId, nTrialId, stActorInfo, bMainChar, tbDiscId)
  local nSource = self:GetBuildSource(nBuildId)
  if nSource == AllEnum.BuildSource.LimitedTrial then
    return PlayerData.Char:CalCharacterLimitedTrialAttrBattle(nTrialId, stActorInfo, bMainChar, tbDiscId, nBuildId)
  elseif nSource == AllEnum.BuildSource.Trial then
    return PlayerData.Char:CalCharacterTrialAttrBattle(nTrialId, stActorInfo, bMainChar, tbDiscId, nBuildId)
  end
  return PlayerData.Char:CalCharacterAttrBattle(nCharId, stActorInfo, bMainChar, tbDiscId, nBuildId)
end

function PlayerBuildData:GetBuildDiscInfoInBuild(nBuildId, nDiscId, tbSecondarySkill)
  local nSource = self:GetBuildSource(nBuildId)
  if nSource == AllEnum.BuildSource.LimitedTrial then
    return PlayerData.Disc:CalcLimitedTrialInfoInBuild(nDiscId, tbSecondarySkill)
  elseif nSource == AllEnum.BuildSource.Trial then
    return PlayerData.Disc:CalcTrialInfoInBuild(nDiscId, tbSecondarySkill)
  end
  return PlayerData.Disc:CalcDiscInfoInBuild(nDiscId, tbSecondarySkill)
end

function PlayerBuildData:GetBuildEnhancedPotential(nBuildId, nCharId, nTrialId)
  local nSource = self:GetBuildSource(nBuildId)
  if nSource == AllEnum.BuildSource.LimitedTrial then
    return PlayerData.Talent:GetLimitedTrialEnhancedPotential(nTrialId) or {}
  elseif nSource == AllEnum.BuildSource.Trial then
    return PlayerData.Talent:GetTrialEnhancedPotential(nTrialId) or {}
  end
  return PlayerData.Char:GetCharEnhancedPotential(nCharId) or {}
end

function PlayerBuildData:GetBuildFateTalent(nBuildId, nCharId, nTrialId)
  local nSource = self:GetBuildSource(nBuildId)
  if nSource == AllEnum.BuildSource.LimitedTrial then
    return PlayerData.Talent:GetLimitedTrialFateTalent(nTrialId)
  elseif nSource == AllEnum.BuildSource.Trial then
    return PlayerData.Talent:GetTrialFateTalent(nTrialId)
  end
  return PlayerData.Talent:GetFateTalent(nCharId)
end

function PlayerBuildData:GetBuildAllEft(nBuildId)
  local ret = {}
  local mapBuildData = self:GetBuildData(nBuildId)
  local nBuildSource = self:GetBuildSourceByData(mapBuildData)
  if nBuildSource == AllEnum.BuildSource.LimitedTrial then
    return self:GetLimitedTrialBuildAllEft(nBuildId)
  elseif nBuildSource == AllEnum.BuildSource.Trial then
    return self:GetTrialBuildAllEft()
  end
  if mapBuildData == nil or not mapBuildData.bDetail then
    print("没有对应build 或未获取该build详细数据")
    return ret
  end
  local mapCharEffect = {}
  local mapPotentialAddLevel = {}
  for _, mapChar in ipairs(mapBuildData.tbChar) do
    mapCharEffect[mapChar.nTid] = {}
    mapCharEffect[mapChar.nTid][AllEnum.EffectType.Affinity] = PlayerData.Char:CalcAffinityEffect(mapChar.nTid)
    mapCharEffect[mapChar.nTid][AllEnum.EffectType.Talent] = PlayerData.Char:CalcTalentEffect(mapChar.nTid)
    mapCharEffect[mapChar.nTid][AllEnum.EffectType.Equipment] = PlayerData.Equipment:GetCharEquipmentEffect(mapChar.nTid)
    mapPotentialAddLevel[mapChar.nTid] = PlayerData.Char:GetCharEnhancedPotential(mapChar.nTid)
  end
  for nCharId, tbPerk in pairs(mapBuildData.tbPotentials) do
    for _, mapPerkInfo in ipairs(tbPerk) do
      local nPotentialId = mapPerkInfo.nPotentialId
      local nPotentialCount = mapPerkInfo.nLevel
      if mapPotentialAddLevel[nCharId] ~= nil and mapPotentialAddLevel[nCharId][nPotentialId] ~= nil then
        nPotentialCount = nPotentialCount + mapPotentialAddLevel[nCharId][nPotentialId]
      end
      if mapCharEffect[nCharId][AllEnum.EffectType.Potential] == nil then
        mapCharEffect[nCharId][AllEnum.EffectType.Potential] = {}
      end
      local mapPotentialCfgData = ConfigTable.GetData("Potential", nPotentialId)
      if mapPotentialCfgData == nil then
        printError("Potential CfgData Missing:" .. nPotentialId)
      else
        mapCharEffect[nCharId][AllEnum.EffectType.Potential][nPotentialId] = {
          {},
          nPotentialCount
        }
        if mapPotentialCfgData.EffectId1 ~= 0 then
          table.insert(mapCharEffect[nCharId][AllEnum.EffectType.Potential][nPotentialId][1], mapPotentialCfgData.EffectId1)
        end
        if mapPotentialCfgData.EffectId2 ~= 0 then
          table.insert(mapCharEffect[nCharId][AllEnum.EffectType.Potential][nPotentialId][1], mapPotentialCfgData.EffectId2)
        end
        if mapPotentialCfgData.EffectId3 ~= 0 then
          table.insert(mapCharEffect[nCharId][AllEnum.EffectType.Potential][nPotentialId][1], mapPotentialCfgData.EffectId3)
        end
        if mapPotentialCfgData.EffectId4 ~= 0 then
          table.insert(mapCharEffect[nCharId][AllEnum.EffectType.Potential][nPotentialId][1], mapPotentialCfgData.EffectId4)
        end
      end
    end
  end
  local mapDiscEffect = {}
  for nIndex, nDiscId in ipairs(mapBuildData.tbDisc) do
    if nIndex <= 3 then
      local tbDiscEft = PlayerData.Disc:CalcDiscEffectInBuild(nDiscId, mapBuildData.tbSecondarySkill)
      mapDiscEffect[nDiscId] = tbDiscEft
    end
  end
  local tbNoteInfo, mapNoteEffect = {}, {}
  for i, v in pairs(mapBuildData.tbNotes) do
    local noteInfo = CS.Lua2CSharpInfo_NoteInfo()
    noteInfo.noteId = i
    noteInfo.noteCount = v
    table.insert(tbNoteInfo, noteInfo)
    local mapCfg = ConfigTable.GetData("SubNoteSkill", i)
    if mapCfg then
      local tbEft = {}
      for _, nEftId in pairs(mapCfg.EffectId) do
        table.insert(tbEft, {nEftId, v})
      end
      mapNoteEffect[i] = tbEft
    end
  end
  return mapCharEffect, mapDiscEffect, mapNoteEffect, tbNoteInfo
end

function PlayerBuildData:GetBuildAttrBase(nBuildId, bTrial, nBuildSource)
  local ret = {}
  local mapBuildData
  if nBuildSource == AllEnum.BuildSource.LimitedTrial then
    mapBuildData = self._MapLimitedTrialBuildData[nBuildId]
  elseif bTrial then
    mapBuildData = self:GetTrialBuild(nBuildId)
  else
    mapBuildData = self:GetBuildData(nBuildId)
  end
  if mapBuildData == nil or not mapBuildData.bDetail then
    print("没有对应build 或未获取该build详细数据")
    return ret
  end
  local tbAttrList = {}
  for _, v in ipairs(AllEnum.AttachAttr) do
    tbAttrList[v.sKey] = {
      Key = v.sKey,
      Value = 0,
      CfgValue = 0
    }
  end
  local mapRank = mapBuildData.mapRank
  local nAttrId = UTILS.GetBuildAttributeId(mapRank.AttrBaseGroupId, mapRank.Level)
  if 0 < nAttrId then
    local mapAttribute = ConfigTable.GetData_Attribute(tostring(nAttrId))
    if mapAttribute then
      for _, v in ipairs(AllEnum.AttachAttr) do
        local nParamValue = mapAttribute[v.sKey] or 0
        local nValue = v.bPercent and nParamValue * ConfigData.IntFloatPrecision * 100 or nParamValue
        tbAttrList[v.sKey] = {
          Key = v.sKey,
          Value = nValue,
          CfgValue = nParamValue
        }
      end
    end
  end
  return tbAttrList
end

function PlayerBuildData:CalBuildRank(nScore)
  local nMin = 1
  local nMax = self._nBuildRankCount
  local mapRank = self._tbBuildRank[1]
  while nMin <= nMax do
    local nMiddle = math.floor((nMin + nMax) / 2)
    if nMiddle == self._nBuildRankCount or nScore >= self._tbBuildRank[nMiddle].MinGrade and nScore < self._tbBuildRank[nMiddle + 1].MinGrade then
      mapRank = self._tbBuildRank[nMiddle]
      break
    elseif nScore < self._tbBuildRank[nMiddle].MinGrade then
      nMax = nMiddle - 1
    else
      nMin = nMiddle + 1
    end
  end
  return mapRank
end

function PlayerBuildData:CheckCoinMax(nCoin, confirmDelete)
  local nLimit = PlayerData.StarTower:GetStarTowerRewardLimit()
  local nCur = PlayerData.StarTower:GetStarTowerTicket()
  
  local function confirm()
    if confirmDelete ~= nil and type(confirmDelete) == "function" then
      confirmDelete()
    end
  end
  
  if nLimit < nCoin + nCur then
    local TipsTime = LocalData.GetPlayerLocalData("Build_Tips_Time")
    local _tipDay = 0
    if TipsTime ~= nil then
      _tipDay = tonumber(TipsTime)
    end
    local curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
    local fixedTimeStamp = curTimeStamp + newDayTime * 3600
    local nYear = tonumber(os.date("!%Y", fixedTimeStamp))
    local nMonth = tonumber(os.date("!%m", fixedTimeStamp))
    local nDay = tonumber(os.date("!%d", fixedTimeStamp))
    local nowD = nYear * 366 + nMonth * 31 + nDay
    if nowD == _tipDay then
      confirm()
    else
      local isSelectAgain = false
      
      local function confirmCallback()
        if isSelectAgain then
          local _curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
          local _fixedTimeStamp = _curTimeStamp + newDayTime * 3600
          local _nYear = tonumber(os.date("!%Y", _fixedTimeStamp))
          local _nMonth = tonumber(os.date("!%m", _fixedTimeStamp))
          local _nDay = tonumber(os.date("!%d", _fixedTimeStamp))
          local _nowD = _nYear * 366 + _nMonth * 31 + _nDay
          LocalData.SetPlayerLocalData("Build_Tips_Time", tostring(_nowD))
        end
        confirm()
      end
      
      local function againCallback(isSelect)
        isSelectAgain = isSelect
      end
      
      local msg = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = ConfigTable.GetUIText("BUILD_11"),
        callbackConfirm = confirmCallback,
        callbackAgain = againCallback,
        bBlur = false
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    end
  else
    confirm()
  end
end

function PlayerBuildData:CacheRogueBuild(mapBuildInfo)
  self:CreateBuildBriefData(mapBuildInfo.Brief)
  self:CreateBuildDetailData(mapBuildInfo.Brief.Id, mapBuildInfo.Detail)
end

function PlayerBuildData:GetBuildBriefDataCallback(callBack)
  local ret = {}
  for _, mapBuild in pairs(self._MapBuildData) do
    table.insert(ret, mapBuild)
  end
  callBack(ret, self._MapBuildData)
end

function PlayerBuildData:GetBuildDetailDataCallback(callBack, nBuildId)
  callBack(self._MapBuildData[nBuildId])
end

function PlayerBuildData:GetBuildCountCallBack(callBack)
  local ret = 0
  for _, _ in pairs(self._MapBuildData) do
    ret = ret + 1
  end
  callBack(ret)
end

function PlayerBuildData:NetMsg_GetBuildBriefData(func, ...)
  local arg = {
    ...
  }
  
  local function MsgCallBack(_, msgData)
    self.hasData = true
    for _, mapBuild in ipairs(msgData.Briefs) do
      self:CreateBuildBriefData(mapBuild)
    end
    func(self, table.unpack(arg))
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.star_tower_build_brief_list_get_req, {}, nil, MsgCallBack)
end

function PlayerBuildData:NetMsg_GetBuildDetailData(nBuildId, func, ...)
  local arg = {
    ...
  }
  
  local function MsgCallBack(_, msgData)
    self._MapBuildData[nBuildId].tbSecondarySkill = msgData.Detail.ActiveSecondaryIds
    for _, v in ipairs(msgData.Detail.Potentials) do
      local potentialCfg = ConfigTable.GetData("Potential", v.PotentialId)
      if potentialCfg then
        local nCharId = potentialCfg.CharId
        if nil == self._MapBuildData[nBuildId].tbPotentials[nCharId] then
          self._MapBuildData[nBuildId].tbPotentials[nCharId] = {}
        end
        table.insert(self._MapBuildData[nBuildId].tbPotentials[nCharId], {
          nPotentialId = v.PotentialId,
          nLevel = v.Level
        })
      end
    end
    local tbNotes = {}
    for _, v in pairs(msgData.Detail.SubNoteSkills) do
      tbNotes[v.Tid] = v.Qty
    end
    self._MapBuildData[nBuildId].tbNotes = tbNotes
    self._MapBuildData[nBuildId].bDetail = true
    self._MapBuildData[nBuildId].nModifierState = msgData.Detail.ModifierState
    func(self, table.unpack(arg))
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.star_tower_build_detail_get_req, {BuildId = nBuildId}, nil, MsgCallBack)
end

function PlayerBuildData:NetMsg_ChangeBuildName(nBuildId, sName, callback)
  local msg = {BuildId = nBuildId, Name = sName}
  
  local function callBack()
    self._MapBuildData[nBuildId].sName = sName
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.star_tower_build_name_set_req, msg, nil, callBack)
end

function PlayerBuildData:NetMsg_ChangeBuildLock(nBuildId, bLock, callback)
  local msg = {BuildId = nBuildId, Lock = bLock}
  
  local function callBack()
    self._MapBuildData[nBuildId].bLock = bLock
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.star_tower_build_lock_unlock_req, msg, nil, callBack)
end

function PlayerBuildData:NetMsg_BuildDelete(tbBuildId, callback, cbClose)
  local msg = {BuildIds = tbBuildId}
  
  local function callBack(_, mapMainData)
    for _, bBuildId in ipairs(tbBuildId) do
      self._MapBuildData[bBuildId] = nil
    end
    UTILS.OpenReceiveByChangeInfo(mapMainData.Change, cbClose)
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.star_tower_build_delete_req, msg, nil, callBack)
end

function PlayerBuildData:NetMsg_BuildPreference(tbCheckInIds, tbCheckOutIds, callback)
  local msg = {CheckInIds = tbCheckInIds, CheckOutIds = tbCheckOutIds}
  
  local function callBack()
    for _, bBuildId in ipairs(tbCheckInIds) do
      self._MapBuildData[bBuildId].bPreference = true
    end
    for _, bBuildId in ipairs(tbCheckOutIds) do
      self._MapBuildData[bBuildId].bPreference = false
    end
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.star_tower_build_preference_set_req, msg, nil, callBack)
end

function PlayerBuildData:NetMsg_SaveBuild(nBuildID, bDelete, bLock, bPreference, sName, callback)
  local msg = {}
  msg.Delete = bDelete
  msg.Lock = bLock
  msg.Preference = bPreference
  msg.BuildName = sName
  
  local function callBack(_, mapMainData)
    if callback ~= nil then
      if bDelete then
        self._MapBuildData[nBuildID] = nil
      else
        self._MapBuildData[nBuildID].bLock = bLock
        self._MapBuildData[nBuildID].bPreference = bPreference
        self._MapBuildData[nBuildID].sName = sName
      end
      callback(mapMainData.Change)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.star_tower_build_whether_save_req, msg, nil, callBack)
end

function PlayerBuildData:CreateLimitedTrialBuild(nTrialId)
  local mapTrialData = ConfigTable.GetData("TrialBuild", nTrialId)
  if mapTrialData == nil then
    printError("限时试用编组数据没有找到：" .. nTrialId)
    return
  end
  local mapBuildData = {
    nBuildId = nTrialId,
    nBuildSource = AllEnum.BuildSource.LimitedTrial,
    sName = mapTrialData.Name,
    tbChar = {},
    nScore = mapTrialData.Score,
    mapRank = self:CalBuildRank(mapTrialData.Score),
    bLock = false,
    bPreference = false,
    bDetail = true,
    tbDisc = {},
    tbSecondarySkill = {},
    tbPotentials = {},
    tbNotes = {},
    nTowerId = mapTrialData.StarTowerId or 0,
    nModifierState = AllEnum.BuildModifierState.CannotModify
  }
  local tbCharTrialId = {}
  local tbCharPotentialCount = {}
  for _, v in ipairs(mapTrialData.Char) do
    table.insert(mapBuildData.tbChar, {
      nTrialId = v,
      nTid = 0,
      nPotentialCount = 0
    })
    table.insert(tbCharTrialId, v)
  end
  mapBuildData.tbDisc = mapTrialData.Disc
  mapBuildData.tbSecondarySkill = mapTrialData.ActiveSecondaryIds
  local tbPotentials = decodeJson(mapTrialData.Potential)
  for _, v in pairs(tbPotentials) do
    local potentialCfg = ConfigTable.GetData("Potential", v.Tid)
    if potentialCfg then
      local nCharId = potentialCfg.CharId
      if not mapBuildData.tbPotentials[nCharId] then
        mapBuildData.tbPotentials[nCharId] = {}
      end
      tbCharPotentialCount[nCharId] = (tbCharPotentialCount[nCharId] or 0) + v.Level
      table.insert(mapBuildData.tbPotentials[nCharId], {
        nPotentialId = v.Tid,
        nLevel = v.Level
      })
    end
  end
  local tbNoteJson = decodeJson(mapTrialData.Note)
  local tbNotes = {}
  for _, v in pairs(tbNoteJson) do
    tbNotes[v.Id] = v.Qty
  end
  mapBuildData.tbNotes = tbNotes
  PlayerData.Char:CreateLimitedTrialChar(tbCharTrialId)
  PlayerData.Disc:CreateLimitedTrialDisc(mapTrialData.Disc)
  for k, v in pairs(mapBuildData.tbChar) do
    local mapTrialChar = PlayerData.Char:GetLimitedTrialCharById(v.nTrialId)
    mapBuildData.tbChar[k].nTid = mapTrialChar ~= nil and mapTrialChar.nId or 0
    mapBuildData.tbChar[k].nPotentialCount = tbCharPotentialCount[mapBuildData.tbChar[k].nTid] or 0
  end
  self._MapLimitedTrialBuildData[nTrialId] = mapBuildData
  if 0 >= table.indexof(self._tbLimitedTrialBuildId, nTrialId) then
    table.insert(self._tbLimitedTrialBuildId, nTrialId)
  end
  return mapBuildData
end

function PlayerBuildData:ClearLimitedTrialBuildCache()
  self._MapLimitedTrialBuildData = {}
  self._tbLimitedTrialBuildId = {}
  self._sLimitedTrialBuildCacheKey = nil
  PlayerData.Char:DeleteLimitedTrialChar()
  PlayerData.Disc:DeleteLimitedTrialDisc()
end

function PlayerBuildData:RefreshLimitedTrialBuildCache(tbTrialBuildId)
  self:ClearLimitedTrialBuildCache()
  if type(tbTrialBuildId) ~= "table" then
    return
  end
  self._sLimitedTrialBuildCacheKey = table.concat(tbTrialBuildId, ",")
  for _, nTrialId in ipairs(tbTrialBuildId) do
    self:CreateLimitedTrialBuild(nTrialId)
  end
end

function PlayerBuildData:SyncLimitedTrialBuildCache()
  local tbTrialBuildId = {}
  if self:IsLimitedTrialBuildActivityOpen() then
    tbTrialBuildId = PlayerData.Reengagement:GetLimitedTrialBuildList() or {}
  end
  local sKey = table.concat(tbTrialBuildId, ",")
  if self._sLimitedTrialBuildCacheKey == sKey then
    return
  end
  self:RefreshLimitedTrialBuildCache(tbTrialBuildId)
end

function PlayerBuildData:GetActiveLimitedTrialBuilds(nType, bIncludeUnsupported)
  local tbRet = {}
  local mapRet = {}
  self:SyncLimitedTrialBuildCache()
  if not self:IsLimitedTrialBuildActivityOpen() then
    return tbRet, mapRet
  end
  if not bIncludeUnsupported and not self:IsLimitedTrialBuildAllowedType(nType) then
    return tbRet, mapRet
  end
  for _, nBuildId in ipairs(self._tbLimitedTrialBuildId) do
    local mapBuildData = self._MapLimitedTrialBuildData[nBuildId]
    if mapBuildData ~= nil then
      table.insert(tbRet, mapBuildData)
      mapRet[nBuildId] = mapBuildData
    end
  end
  return tbRet, mapRet
end

function PlayerBuildData:GetSelectableBuildBriefData(callback, nType, bIncludeUnsupported)
  local function onGetBuildBrief(tbBuildData, mapAllBuild)
    local tbRet = {}
    
    local mapRet = {}
    for _, mapBuildData in ipairs(tbBuildData) do
      table.insert(tbRet, mapBuildData)
    end
    for nBuildId, mapBuildData in pairs(mapAllBuild) do
      mapRet[nBuildId] = mapBuildData
    end
    local tbLimitedBuild, mapLimitedBuild = self:GetActiveLimitedTrialBuilds(nType, bIncludeUnsupported)
    for _, mapBuildData in ipairs(tbLimitedBuild) do
      table.insert(tbRet, mapBuildData)
    end
    for nBuildId, mapBuildData in pairs(mapLimitedBuild) do
      mapRet[nBuildId] = mapBuildData
    end
    if callback then
      callback(tbRet, mapRet)
    end
  end
  
  return self:GetAllBuildBriefData(onGetBuildBrief)
end

function PlayerBuildData:CreateTrialBuild(nTrialId)
  self._mapTrialBuild = {}
  local mapTrialData = ConfigTable.GetData("TrialBuild", nTrialId)
  if mapTrialData == nil then
    printError("试用编组数据没有找到：" .. nTrialId)
    return
  end
  self._mapTrialBuild = {
    nBuildId = nTrialId,
    nBuildSource = AllEnum.BuildSource.Trial,
    sName = mapTrialData.Name,
    tbChar = {},
    nScore = mapTrialData.Score,
    mapRank = self:CalBuildRank(mapTrialData.Score),
    bLock = false,
    bPreference = false,
    bDetail = true,
    tbDisc = {},
    tbSecondarySkill = {},
    tbPotentials = {},
    tbNotes = {},
    nTowerId = mapTrialData.StarTowerId or 0,
    nModifierState = AllEnum.BuildModifierState.CannotModify,
    bTrial = true
  }
  local tbCharTrialId = {}
  local tbCharPotentialCount = {}
  for _, v in ipairs(mapTrialData.Char) do
    table.insert(self._mapTrialBuild.tbChar, {
      nTrialId = v,
      nTid = 0,
      nPotentialCount = 0
    })
    table.insert(tbCharTrialId, v)
  end
  self._mapTrialBuild.tbDisc = mapTrialData.Disc
  self._mapTrialBuild.tbSecondarySkill = mapTrialData.ActiveSecondaryIds
  local tbPotentials = decodeJson(mapTrialData.Potential)
  for _, v in pairs(tbPotentials) do
    local potentialCfg = ConfigTable.GetData("Potential", v.Tid)
    if potentialCfg then
      local nCharId = potentialCfg.CharId
      if not self._mapTrialBuild.tbPotentials[nCharId] then
        self._mapTrialBuild.tbPotentials[nCharId] = {}
      end
      tbCharPotentialCount[nCharId] = (tbCharPotentialCount[nCharId] or 0) + v.Level
      table.insert(self._mapTrialBuild.tbPotentials[nCharId], {
        nPotentialId = v.Tid,
        nLevel = v.Level
      })
    end
  end
  local tbNoteJson = decodeJson(mapTrialData.Note)
  local tbNotes = {}
  for _, v in pairs(tbNoteJson) do
    tbNotes[v.Id] = v.Qty
  end
  self._mapTrialBuild.tbNotes = tbNotes
  PlayerData.Char:CreateTrialChar(tbCharTrialId)
  PlayerData.Disc:CreateTrialDisc(mapTrialData.Disc)
  for k, v in pairs(self._mapTrialBuild.tbChar) do
    local mapTrialChar = PlayerData.Char:GetTrialCharById(v.nTrialId)
    self._mapTrialBuild.tbChar[k].nTid = mapTrialChar ~= nil and mapTrialChar.nId or 0
    self._mapTrialBuild.tbChar[k].nPotentialCount = tbCharPotentialCount[self._mapTrialBuild.tbChar[k].nTid] or 0
  end
  return self._mapTrialBuild
end

function PlayerBuildData:DeleteTrialBuild()
  self._mapTrialBuild = {}
  PlayerData.Char:DeleteTrialChar()
  PlayerData.Disc:DeleteTrialDisc()
end

function PlayerBuildData:GetTrialBuild(nTrialId)
  if self._mapTrialBuild then
    if self._mapTrialBuild.nBuildId == nTrialId then
      return self._mapTrialBuild
    else
      self:DeleteTrialBuild()
    end
  end
  return self:CreateTrialBuild(nTrialId)
end

function PlayerBuildData:GetTrialBuildAllEftByData(mapBuildData, fnGetTalentEffect, fnGetEnhancedPotential, fnCalcDiscEffect, sLogName)
  local ret = {}
  if mapBuildData == nil or not mapBuildData.bDetail then
    print("没有对应build 或未获取该build详细数据")
    return ret
  end
  local mapCharEffect = {}
  local mapTalentAddLevel = {}
  for _, mapChar in ipairs(mapBuildData.tbChar) do
    mapCharEffect[mapChar.nTid] = {}
    mapCharEffect[mapChar.nTid][AllEnum.EffectType.Talent] = fnGetTalentEffect(mapChar.nTrialId)
    mapTalentAddLevel[mapChar.nTid] = fnGetEnhancedPotential(mapChar.nTrialId)
  end
  local tbCharIdToTrial = {}
  for _, mapChar in ipairs(mapBuildData.tbChar) do
    tbCharIdToTrial[mapChar.nTid] = mapChar.nTrialId
  end
  for nCharId, tbPerk in pairs(mapBuildData.tbPotentials) do
    if tbCharIdToTrial[nCharId] then
      for _, mapPerkInfo in ipairs(tbPerk) do
        local nPotentialId = mapPerkInfo.nPotentialId
        local nPotentialCount = mapPerkInfo.nLevel
        if mapTalentAddLevel[nCharId] ~= nil and mapTalentAddLevel[nCharId][nPotentialId] ~= nil then
          nPotentialCount = nPotentialCount + mapTalentAddLevel[nCharId][nPotentialId]
        end
        if mapCharEffect[nCharId][AllEnum.EffectType.Potential] == nil then
          mapCharEffect[nCharId][AllEnum.EffectType.Potential] = {}
        end
        local mapPotentialCfgData = ConfigTable.GetData("Potential", nPotentialId)
        if mapPotentialCfgData == nil then
          printError("Potential CfgData Missing:" .. nPotentialId)
        else
          mapCharEffect[nCharId][AllEnum.EffectType.Potential][nPotentialId] = {
            {},
            nPotentialCount
          }
          if mapPotentialCfgData.EffectId1 ~= 0 then
            table.insert(mapCharEffect[nCharId][AllEnum.EffectType.Potential][nPotentialId][1], mapPotentialCfgData.EffectId1)
          end
          if mapPotentialCfgData.EffectId2 ~= 0 then
            table.insert(mapCharEffect[nCharId][AllEnum.EffectType.Potential][nPotentialId][1], mapPotentialCfgData.EffectId2)
          end
          if mapPotentialCfgData.EffectId3 ~= 0 then
            table.insert(mapCharEffect[nCharId][AllEnum.EffectType.Potential][nPotentialId][1], mapPotentialCfgData.EffectId3)
          end
          if mapPotentialCfgData.EffectId4 ~= 0 then
            table.insert(mapCharEffect[nCharId][AllEnum.EffectType.Potential][nPotentialId][1], mapPotentialCfgData.EffectId4)
          end
        end
      end
    else
      printError((sLogName or "体验build") .. "内，有多余角色的潜能" .. nCharId)
    end
  end
  local mapDiscEffect = {}
  for nIndex, nTrialDiscId in ipairs(mapBuildData.tbDisc) do
    if nIndex <= 3 then
      local tbDiscEft = fnCalcDiscEffect(nTrialDiscId, mapBuildData.tbSecondarySkill)
      mapDiscEffect[nTrialDiscId] = tbDiscEft
    end
  end
  local tbNoteInfo, mapNoteEffect = {}, {}
  for i, v in pairs(mapBuildData.tbNotes) do
    local noteInfo = CS.Lua2CSharpInfo_NoteInfo()
    noteInfo.noteId = i
    noteInfo.noteCount = v
    table.insert(tbNoteInfo, noteInfo)
    local mapCfg = ConfigTable.GetData("SubNoteSkill", i)
    if mapCfg then
      local tbEft = {}
      for _, nEftId in pairs(mapCfg.EffectId) do
        table.insert(tbEft, {nEftId, v})
      end
      mapNoteEffect[i] = tbEft
    end
  end
  return mapCharEffect, mapDiscEffect, mapNoteEffect, tbNoteInfo
end

function PlayerBuildData:GetLimitedTrialBuildAllEft(nBuildId)
  return self:GetTrialBuildAllEftByData(self._MapLimitedTrialBuildData[nBuildId], function(nTrialId)
    return PlayerData.Talent:GetLimitedTrialTalentEffect(nTrialId)
  end, function(nTrialId)
    return PlayerData.Talent:GetLimitedTrialEnhancedPotential(nTrialId)
  end, function(nTrialDiscId, tbSecondarySkill)
    return PlayerData.Disc:CalcLimitedTrialEffectInBuild(nTrialDiscId, tbSecondarySkill)
  end, "限时试用build")
end

function PlayerBuildData:GetTrialBuildAllEft()
  return self:GetTrialBuildAllEftByData(self._mapTrialBuild, function(nTrialId)
    return PlayerData.Talent:GetTrialTalentEffect(nTrialId)
  end, function(nTrialId)
    return PlayerData.Talent:GetTrialEnhancedPotential(nTrialId)
  end, function(nTrialDiscId, tbSecondarySkill)
    return PlayerData.Disc:CalcTrialEffectInBuild(nTrialDiscId, tbSecondarySkill)
  end, "体验build")
end

function PlayerBuildData:SetBuildReportInfo(nBuildId)
  local mapDetailData = self:GetBuildData(nBuildId)
  if mapDetailData == nil or not mapDetailData.bDetail then
    printError("No Build Detail Data")
    return
  end
  local tbNotes = {}
  for nTid, nQty in pairs(mapDetailData.tbNotes) do
    table.insert(tbNotes, {nTid, nQty})
  end
  local tbSkills = mapDetailData.tbSecondarySkill
  local tbDiscData = {}
  for _, nDiscId in ipairs(mapDetailData.tbDisc) do
    local stBuildDisc = CS.BuildDiscData()
    stBuildDisc.discId = nDiscId
    local mapDiscData = PlayerData.Disc:GetDiscById(nDiscId)
    if mapDiscData ~= nil then
      stBuildDisc.level = mapDiscData.nLevel
      stBuildDisc.breakCount = mapDiscData.nStar
      stBuildDisc.advance = mapDiscData.nPhase
    end
    table.insert(tbDiscData, stBuildDisc)
  end
  local tbCharData = {}
  for _, mapChar in ipairs(mapDetailData.tbChar) do
    local stBuildCharData = CS.BuildCharData()
    stBuildCharData.charId = mapChar.nTid
    local tbEquipment = PlayerData.Equipment:GetCharEquipmentEffect(mapChar.nTid)
    stBuildCharData.equipmentEffects = tbEquipment
    local tbPotentials = {}
    if mapDetailData.tbPotentials[mapChar.nTid] ~= nil then
      for _, mapPotential in ipairs(mapDetailData.tbPotentials[mapChar.nTid]) do
        table.insert(tbPotentials, {
          mapPotential.nPotentialId,
          mapPotential.nLevel
        })
      end
    end
    stBuildCharData.potentialIds = tbPotentials
    table.insert(tbCharData, stBuildCharData)
  end
  
  local function fnStringKeyMap(map)
    local tb = {}
    if map == nil then
      return tb
    end
    for k, v in pairs(map) do
      tb[tostring(k)] = v
    end
    return tb
  end
  
  local mapEncode = {}
  for k, v in pairs(mapDetailData) do
    mapEncode[k] = v
  end
  mapEncode.tbPotentials = fnStringKeyMap(mapDetailData.tbPotentials)
  mapEncode.tbNotes = fnStringKeyMap(mapDetailData.tbNotes)
  NovaAPI.SetBuildReportInfo(RapidJson.encode(mapEncode), mapDetailData.sName or "", tbCharData, tbDiscData, tbSkills, tbNotes)
end

return PlayerBuildData
