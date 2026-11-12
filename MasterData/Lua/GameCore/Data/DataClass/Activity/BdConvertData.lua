local ActivityDataBase = require("GameCore.Data.DataClass.Activity.ActivityDataBase")
local BdConvertData = class("BdConvertData", ActivityDataBase)
local LocalData = require("GameCore.Data.LocalData")
local RapidJson = require("rapidjson")
local RedDotManager = require("GameCore.RedDot.RedDotManager")
local ClientManager = CS.ClientManager.Instance

function BdConvertData:Init()
  self:InitData()
  self:AddListeners()
end

function BdConvertData:InitData()
  self.allQuestData = {}
  self.bdCfgData = nil
  self.tbBdData = {}
  self.AllBuild = {}
  self:InitBuildRank()
end

function BdConvertData:UpdateStatus()
end

function BdConvertData:AddListeners()
end

function BdConvertData:GetActConfig()
  self.actCfgData = ConfigTable.GetData("BdConvertControl", self.nActId)
  return self.actCfgData
end

function BdConvertData:GetBdConvertConfig()
  return self.bdCfgData
end

function BdConvertData:CreateBuildData(mapBuildMsg)
  if nil ~= self.AllBuild[mapBuildMsg.Id] then
    printLog(string.format("编队信息重复！！！id= [%s]", mapBuildMsg.Id))
  end
  local mapBuildData = {
    nBuildId = mapBuildMsg.Brief.Id,
    sName = mapBuildMsg.Brief.Name,
    tbChar = {},
    nScore = mapBuildMsg.Brief.Score,
    mapRank = self:CalBuildRank(mapBuildMsg.Brief.Score),
    bLock = mapBuildMsg.Brief.Lock,
    bPreference = mapBuildMsg.Brief.Preference,
    bDetail = false,
    tbDisc = mapBuildMsg.Brief.DiscIds,
    tbSecondarySkill = mapBuildMsg.Detail.ActiveSecondaryIds,
    tbPotentials = {},
    tbNotes = {},
    nTowerId = mapBuildMsg.Brief.StarTowerId
  }
  for i = 1, 3 do
    table.insert(mapBuildData.tbChar, {
      nTid = mapBuildMsg.Brief.Chars[i].CharId,
      nPotentialCount = mapBuildMsg.Brief.Chars[i].PotentialCnt
    })
  end
  mapBuildData.tbDisc = mapBuildMsg.Brief.DiscIds
  self.AllBuild[mapBuildMsg.Brief.Id] = mapBuildData
  for _, v in ipairs(mapBuildMsg.Detail.Potentials) do
    local potentialCfg = ConfigTable.GetData("Potential", v.PotentialId)
    if potentialCfg then
      local nCharId = potentialCfg.CharId
      if nil == self.AllBuild[mapBuildMsg.Brief.Id].tbPotentials[nCharId] then
        self.AllBuild[mapBuildMsg.Brief.Id].tbPotentials[nCharId] = {}
      end
      table.insert(self.AllBuild[mapBuildMsg.Brief.Id].tbPotentials[nCharId], {
        nPotentialId = v.PotentialId,
        nLevel = v.Level
      })
    end
  end
  local tbNotes = {}
  for _, v in pairs(mapBuildMsg.Detail.SubNoteSkills) do
    tbNotes[v.Tid] = v.Qty
  end
  self.AllBuild[mapBuildMsg.Brief.Id].tbNotes = tbNotes
  self.AllBuild[mapBuildMsg.Brief.Id].bDetail = true
end

function BdConvertData:CalBuildRank(nScore)
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

function BdConvertData:InitBuildRank()
  self._tbBuildRank = {}
  
  local function foreach(line)
    self._tbBuildRank[line.Id] = line
  end
  
  ForEachTableLine(DataTable.StarTowerBuildRank, foreach)
  self._nBuildRankCount = #self._tbBuildRank
end

function BdConvertData:GetAllBuildByOpId(nOptionId)
  local contentCfg = ConfigTable.GetData("BdConvertContent", nOptionId)
  if contentCfg == nil then
    return nil
  end
  local tbBuild = {}
  for _, mapData in pairs(self.AllBuild) do
    local bResult = true
    for _, conditionId in ipairs(contentCfg.ConvertConditionList) do
      local bPass = self:CheckBuildData(mapData, conditionId)
      if not bPass then
        bResult = false
        break
      end
    end
    if bResult then
      table.insert(tbBuild, mapData)
    end
  end
  return tbBuild
end

function BdConvertData:CheckBuildData(mapData, nCondId)
  local condiCfg = ConfigTable.GetData("BdConvertCondition", nCondId)
  if condiCfg == nil then
    return false
  end
  local bResult = false
  local nBdRequest = condiCfg.Cond
  if nBdRequest == GameEnum.BdRequest.BdMaxLevel then
    bResult = mapData.nScore >= condiCfg.CondParams[1]
  elseif nBdRequest == GameEnum.BdRequest.BdNoteAllKindNum then
    local nNoteCount = 0
    if mapData.tbNotes ~= nil then
      for _, value in pairs(mapData.tbNotes) do
        nNoteCount = nNoteCount + value
      end
    end
    bResult = nNoteCount >= condiCfg.CondParams[1]
  elseif nBdRequest == GameEnum.BdRequest.BdNoteOneKindNum then
    if mapData.tbNotes ~= nil then
      local noteId = condiCfg.CondParams[1]
      local noteCount = mapData.tbNotes[noteId] or 0
      bResult = noteCount >= condiCfg.CondParams[2]
    end
  elseif nBdRequest == GameEnum.BdRequest.BdPotentialNum then
    if mapData.tbChar ~= nil then
      local nPotentialCount = 0
      for _, value in ipairs(mapData.tbChar) do
        nPotentialCount = nPotentialCount + value.nPotentialCount
      end
      bResult = nPotentialCount >= condiCfg.CondParams[1]
    end
  elseif nBdRequest == GameEnum.BdRequest.BdPotentialLevelNum then
    if mapData.tbPotentials ~= nil then
      local nPotentialCount = 0
      for _, charData in pairs(mapData.tbPotentials) do
        for _, value in ipairs(charData) do
          if value.nLevel >= condiCfg.CondParams[2] then
            nPotentialCount = nPotentialCount + 1
          end
        end
      end
      bResult = nPotentialCount >= condiCfg.CondParams[1]
    end
  elseif nBdRequest == GameEnum.BdRequest.BdMainCharElementNum then
    if mapData.tbChar ~= nil then
      local mainCharId = mapData.tbChar[1].nTid
      local charCfg = ConfigTable.GetData("Character", mainCharId)
      if charCfg ~= nil then
        for _, value in ipairs(condiCfg.CondParams) do
          if charCfg.EET == value then
            bResult = true
            break
          end
        end
      end
    end
  elseif nBdRequest == GameEnum.BdRequest.BdCharElementNum then
    if mapData.tbChar ~= nil then
      local nCount = 0
      for _, charData in ipairs(mapData.tbChar) do
        local charCfg = ConfigTable.GetData("Character", charData.nTid)
        if charCfg ~= nil and charCfg.EET == condiCfg.CondParams[2] then
          nCount = nCount + 1
        end
      end
      bResult = nCount >= condiCfg.CondParams[1]
    end
  elseif nBdRequest == GameEnum.BdRequest.BdCharJobNum then
    if mapData.tbChar ~= nil then
      local nCount = 0
      for _, charData in ipairs(mapData.tbChar) do
        local charCfg = ConfigTable.GetData("Character", charData.nTid)
        if charCfg ~= nil and charCfg.Class == condiCfg.CondParams[2] then
          nCount = nCount + 1
        end
      end
      bResult = nCount >= condiCfg.CondParams[1]
    end
  elseif nBdRequest == GameEnum.BdRequest.BdActivateSkillLevelNum then
    if mapData.tbSecondarySkill ~= nil then
      local nCount = 0
      for _, skillId in ipairs(mapData.tbSecondarySkill) do
        local skillCfg = ConfigTable.GetData("SecondarySkill", skillId)
        if skillCfg ~= nil and skillCfg.Level >= condiCfg.CondParams[2] then
          nCount = nCount + 1
        end
      end
      bResult = nCount >= condiCfg.CondParams[1]
    end
  elseif nBdRequest == GameEnum.BdRequest.BdAllCharElement and mapData.tbChar ~= nil then
    local bSameEET = true
    local nTeampEET
    for _, charData in ipairs(mapData.tbChar) do
      local charCfg = ConfigTable.GetData("Character", charData.nTid)
      if charCfg ~= nil then
        if nTeampEET == nil then
          nTeampEET = charCfg.EET
        end
        if nTeampEET ~= charCfg.EET then
          bSameEET = false
          break
        end
      end
    end
    if not bSameEET then
      bResult = false
    else
      for _, value in ipairs(condiCfg.CondParams) do
        if nTeampEET == value then
          bResult = true
          break
        end
      end
    end
  end
  return bResult
end

function BdConvertData:ChangeBuildLock(nBuildId, bLock, callback)
  self:RequestChangeBuildLock(nBuildId, bLock, callback)
end

function BdConvertData:RefreshBdConvertData(actId, msgData)
  self:InitData()
  self.nActId = actId
  self.bdCfgData = ConfigTable.GetData("BdConvert", self.nActId)
  for _, optionId in ipairs(self.bdCfgData.OptionList) do
    local optionData = ConfigTable.GetData("BdConvertContent", optionId)
    if optionData ~= nil then
      self:UpdateBdData({
        nId = optionId,
        nCurSub = 0,
        nMaxSub = optionData.MaxSub,
        bIsOpen = true
      })
    end
  end
  for _, contentData in ipairs(msgData.Contents) do
    local optionData = ConfigTable.GetData("BdConvertContent", contentData.Id)
    if optionData ~= nil then
      self:UpdateBdData({
        nId = contentData.Id,
        nCurSub = contentData.Num,
        nMaxSub = optionData.MaxSub,
        bIsOpen = true
      })
    end
  end
  
  local function foreach_questTable(data)
    if data.GroupId == self.bdCfgData.RewardGroup then
      self:UpdateQuest({
        nId = data.Id,
        nState = AllEnum.ActQuestStatus.UnComplete,
        nCur = 0,
        nMax = data.CompleteCondParams[2]
      })
    end
  end
  
  ForEachTableLine(DataTable.BdConvertRewardGroup, foreach_questTable)
  local nCur = 0
  local nMax = 0
  for _, quest in pairs(msgData.Quests) do
    if self:QuestStateServer2Client(quest.Status) == AllEnum.ActQuestStatus.UnComplete then
      nCur = quest.Progress[1].Cur
      nMax = quest.Progress[1].Max
    else
      local questCfg = ConfigTable.GetData("BdConvertRewardGroup", quest.Id)
      if questCfg ~= nil then
        nMax = questCfg.CompleteCondParams[2]
        nCur = nMax
        self:UpdateQuest({
          nId = quest.Id,
          nState = self:QuestStateServer2Client(quest.Status),
          nCur = nCur,
          nMax = nMax
        })
      end
    end
  end
  self:RefreshRedDot()
end

function BdConvertData:GetBuildCount()
  local nCount = 0
  for _, data in pairs(self.AllBuild) do
    if data ~= nil then
      nCount = nCount + 1
    end
  end
  return nCount
end

function BdConvertData:CheckBuildsData()
  local bResult = false
  if not PlayerData.Build:CheckHasBuild() then
    bResult = true
  else
    local function callback(tbBuildId, _)
      if #tbBuildId ~= self:GetBuildCount() then
        bResult = false
      else
        for _, buildId in ipairs(tbBuildId) do
          if self.AllBuild[buildId] == nil then
            bResult = false
            break
          end
        end
      end
    end
    
    PlayerData.Build:GetAllBuildBriefData(callback)
  end
  return bResult
end

function BdConvertData:UpdateBdData(bdData)
  self.tbBdData[bdData.nId] = bdData
end

function BdConvertData:GetAllBdData()
  return self.tbBdData
end

function BdConvertData:GetBdDataBy(id)
  return self.tbBdData[id]
end

function BdConvertData:SubmitBuild(mapDataList)
end

function BdConvertData:UpdateQuest(questData)
  local questConfig = ConfigTable.GetData("BdConvertRewardGroup", questData.nId)
  if questConfig == nil then
    return
  end
  if self.allQuestData == nil then
    self.allQuestData = {}
  end
  self.allQuestData[questData.nId] = questData
  RedDotManager.SetValid(RedDotDefine.Activity_BdConvert_Quest, questData.nId, questData.nState == AllEnum.ActQuestStatus.Complete)
  EventManager.Hit("BdConvertQuestUpdate")
end

function BdConvertData:GetAllQuestCount()
  local nResult = 0
  for _, _ in pairs(self.allQuestData) do
    nResult = nResult + 1
  end
  return nResult
end

function BdConvertData:GetAllReceivedCount()
  local nResult = 0
  for _, quest in pairs(self.allQuestData) do
    if quest.nState == AllEnum.ActQuestStatus.Received then
      nResult = nResult + 1
    end
  end
  return nResult
end

function BdConvertData:GetQuestIdList()
  local questIdList = {}
  for _, data in pairs(self.allQuestData) do
    table.insert(questIdList, data.nId)
  end
  
  local function sortFunc(a, b)
    local aData = self:GetQuestDataById(a)
    local bData = self:GetQuestDataById(b)
    if aData ~= nil and bData ~= nil and aData.nState ~= bData.nState then
      return aData.nState < bData.nState
    end
    return a < b
  end
  
  table.sort(questIdList, sortFunc)
  return questIdList
end

function BdConvertData:GetQuestDataById(nId)
  return self.allQuestData[nId]
end

function BdConvertData:GetScore()
  local nItemId = self.bdCfgData.ScoreItemId
  return PlayerData.Item:GetItemCountByID(nItemId)
end

function BdConvertData:QuestStateServer2Client(nStatus)
  if nStatus == 0 then
    return AllEnum.ActQuestStatus.UnComplete
  elseif nStatus == 1 then
    return AllEnum.ActQuestStatus.Complete
  else
    return AllEnum.ActQuestStatus.Received
  end
end

function BdConvertData:RefreshQuestData(questData)
  local nCur = 0
  local nMax = 0
  if self:QuestStateServer2Client(questData.Status) == AllEnum.ActQuestStatus.UnComplete then
    nCur = questData.Progress[1].Cur
    nMax = questData.Progress[1].Max
  else
    local questCfg = ConfigTable.GetData("BdConvertRewardGroup", questData.Id)
    if questCfg == nil then
      return
    end
    nMax = questCfg.CompleteCondParams[2]
    nCur = nMax
  end
  self:UpdateQuest({
    nId = questData.Id,
    nState = self:QuestStateServer2Client(questData.Status),
    nCur = nCur,
    nMax = nMax
  })
  self:RefreshRedDot()
end

function BdConvertData:CheckHasComQuest()
  local bHasCompleteQuest = false
  for _, questData in pairs(self.allQuestData) do
    if questData.nState == AllEnum.ActQuestStatus.Complete then
      bHasCompleteQuest = true
      break
    end
  end
  return bHasCompleteQuest
end

function BdConvertData:RefreshRedDot()
  if not self:GetPlayState() then
    return
  end
  local bReddot = false
  for _, questData in pairs(self.allQuestData) do
    bReddot = bReddot or questData.nState == AllEnum.ActQuestStatus.Complete
    if bReddot then
      RedDotManager.SetValid(RedDotDefine.Activity_Tab, self.nActId, bReddot)
      return
    end
  end
  RedDotManager.SetValid(RedDotDefine.Activity_Tab, self.nActId, false)
end

function BdConvertData:RequestReceiveQuest(callback)
  local bHasCompleteQuest = self:CheckHasComQuest()
  if not bHasCompleteQuest then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("BdConvert_NoComQuest"))
    return
  end
  local mapMsg = {
    Value = self.nActId
  }
  
  local function cb(_, mapMsgData)
    for _, questId in pairs(mapMsgData.Ids) do
      local config = ConfigTable.GetData("BdConvertRewardGroup", questId)
      if config ~= nil then
        local data = {
          nId = questId,
          nState = AllEnum.ActQuestStatus.Received,
          nCur = config.CompleteCondParams[2],
          nMax = config.CompleteCondParams[2]
        }
        self:UpdateQuest(data)
      end
    end
    self:RefreshRedDot()
    UTILS.OpenReceiveByChangeInfo(mapMsgData.Change)
    if callback ~= nil then
      callback()
    end
    EventManager.Hit("BdConvertQuestReceived")
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.build_convert_group_reward_receive_req, mapMsg, nil, cb)
end

function BdConvertData:RequestSubmitBuild(nContentId, tbBuildId)
  local mapMsg = {
    ActivityId = self.nActId,
    BuildIds = tbBuildId,
    ContentId = nContentId
  }
  
  local function cb(_, mapMsgData)
    for _, buildId in ipairs(tbBuildId) do
      self.AllBuild[buildId] = nil
    end
    PlayerData.Build:DeleteBuildByActivity(tbBuildId)
    local optionData = ConfigTable.GetData("BdConvertContent", nContentId)
    if optionData ~= nil then
      self:UpdateBdData({
        nId = nContentId,
        nCurSub = mapMsgData.Number,
        nMaxSub = optionData.MaxSub,
        bIsOpen = true
      })
    end
    if mapMsgData.AwardItems ~= nil then
      local tbReward = {}
      for _, reward in ipairs(mapMsgData.AwardItems) do
        table.insert(tbReward, {
          id = reward.Tid,
          rewardType = AllEnum.RewardType.Three,
          count = reward.Qty,
          nHasCount = PlayerData.Item:GetItemCountByID(reward.Tid)
        })
      end
      EventManager.Hit("BdConvert_ShowReward", mapMsgData.AwardItems, optionData.Icon)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.build_convert_submit_req, mapMsg, nil, cb)
end

function BdConvertData:RequestAllBuildData(callback)
  local mapMsg = {}
  
  local function cb(_, mapMsgData)
    self.AllBuild = {}
    for _, buildData in pairs(mapMsgData.Details) do
      self:CreateBuildData(buildData)
    end
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.build_convert_detail_list_get_req, mapMsg, nil, cb)
end

function BdConvertData:RequestChangeBuildLock(nBuildId, bLock, callback)
  local msg = {BuildId = nBuildId, Lock = bLock}
  
  local function callBack()
    self.AllBuild[nBuildId].bLock = bLock
    if callback ~= nil then
      callback()
    end
  end
  
  if PlayerData.Build:CheckHasBuild() then
    PlayerData.Build:ChangeBuildLock(nBuildId, bLock, callBack)
  else
    HttpNetHandler.SendMsg(NetMsgId.Id.star_tower_build_lock_unlock_req, msg, nil, callBack)
  end
end

return BdConvertData
