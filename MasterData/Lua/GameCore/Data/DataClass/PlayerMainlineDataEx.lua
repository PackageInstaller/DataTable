local RapidJson = require("rapidjson")
local ClientManager = CS.ClientManager
local PlayerMainlineDataEx = class("PlayerMainlineDataEx")

function PlayerMainlineDataEx:Init()
  EventManager.Add(EventId.SendMsgEnterBattle, self, self.OnEvent_EnterMainline)
  self._mapStar = {}
  self._mapChapters = {}
  self._nSelectId = 0
  self._tbCharId = nil
  self.nCurTeamIndex = 1
  self._mainlineData = nil
  self:ProcessMainlineData()
  self._mainlineLevel = nil
  self.bUseOldMainline = false
end

function PlayerMainlineDataEx:CacheMainline(mapData, Chapters)
  for k, v in pairs(mapData) do
    local mapMainline = ConfigTable.GetData_Mainline(v.Id)
    if mapMainline ~= nil then
      local nChapterId = mapMainline.ChapterId
      if self._mapStar[nChapterId] == nil then
        self._mapStar[nChapterId] = {}
      end
      local b1 = 1
      local b2 = 2
      local b3 = 4
      local t1 = v.Star & b1 > 0
      local t2 = v.Star & b2 > 0
      local t3 = v.Star & b3 > 0
      local nStar = self.CalStar(v.Star)
      self._mapStar[nChapterId][v.Id] = {
        nStar = nStar,
        tbTarget = {
          t1,
          t2,
          t3
        }
      }
    end
  end
  if Chapters ~= nil then
    for _, v in pairs(Chapters) do
      self._mapChapters[v.Id] = v.Idx
    end
  end
  self:UpdateRewardRedDot()
end

function PlayerMainlineDataEx:IsMainlineChapterUnlock(nChapterId)
  local mapMainlineData = ConfigTable.GetData("Chapter", nChapterId)
  if not self.bUseOldMainline then
    mapMainlineData = ConfigTable.GetData("StoryChapter", nChapterId)
  end
  if mapMainlineData == nil then
    return false
  end
  local nWorldClass = mapMainlineData.WorldClass
  local nCurWorldClass = PlayerData.Base:GetWorldClass()
  if nWorldClass > nCurWorldClass then
    return false
  end
  local tbPrevId
  if self.bUseOldMainline then
    tbPrevId = mapMainlineData.PrevMainlines
  else
    tbPrevId = mapMainlineData.PrevStories
  end
  for _, nPrevId in ipairs(tbPrevId) do
    local mapMainline = ConfigTable.GetData_Mainline(nPrevId)
    local nPrevIdChapter = mapMainline.ChapterId
    if self._mapStar[nPrevIdChapter] == nil or self._mapStar[nPrevIdChapter][nPrevId] == nil or self._mapStar[nPrevIdChapter][nPrevId].nStar == 0 then
      return false
    end
  end
  return true
end

function PlayerMainlineDataEx:IsMainlineLevelUnlock(nLevelId)
  local mapMainlineData = ConfigTable.GetData_Mainline(nLevelId)
  if mapMainlineData == nil then
    return false
  end
  local tbPrevId = mapMainlineData.Prev
  for __, nPrevId in ipairs(tbPrevId) do
    local mapMainline = ConfigTable.GetData_Mainline(nPrevId)
    if mapMainline == nil then
      return false
    end
    if self._mapStar[mapMainline.ChapterId] == nil or self._mapStar[mapMainline.ChapterId][nPrevId] == nil or self._mapStar[mapMainline.ChapterId][nPrevId].nStar == 0 then
      return false
    end
  end
  local bCoinUnlock = self._mapStar[mapMainlineData.ChapterId] ~= nil and self._mapStar[mapMainlineData.ChapterId][nLevelId] ~= nil
  return true, bCoinUnlock
end

function PlayerMainlineDataEx:GetChapterStars(nChapterId)
  local ret = 0
  local ret1 = 0
  if self._mapStar[nChapterId] == nil then
    return ret
  end
  for mainlinId, mapChapterStar in pairs(self._mapStar[nChapterId]) do
    local mapData = ConfigTable.GetData_Mainline(mainlinId)
    local nStar = mapChapterStar.nStar
    if mapData.AvgId == "" then
      ret = ret + nStar
    end
    ret1 = ret1 + nStar
  end
  return ret, ret1
end

function PlayerMainlineDataEx:GetChapterTotalStar(nChapterId)
  local ret = 0
  for _, _ in pairs(self._mainlineData[nChapterId]) do
    ret = ret + 3
  end
  return ret
end

function PlayerMainlineDataEx:GetChapterAward(nChapterId)
  if self._mapChapters[nChapterId] == nil then
    return 0
  end
  return self._mapChapters[nChapterId]
end

function PlayerMainlineDataEx:GetMianlineLevelStar(nLevelId)
  local mapMainlinData = ConfigTable.GetData_Mainline(nLevelId)
  if nil == mapMainlinData then
    return 0, {
      false,
      false,
      false
    }
  end
  local nChapterId = mapMainlinData.ChapterId
  if self._mapStar[nChapterId] == nil then
    return 0, {
      false,
      false,
      false
    }
  end
  if self._mapStar[nChapterId][nLevelId] == nil then
    return 0, {
      false,
      false,
      false
    }
  end
  return self._mapStar[nChapterId][nLevelId].nStar, self._mapStar[nChapterId][nLevelId].tbTarget
end

function PlayerMainlineDataEx:ProcessMainlineData()
  self._mainlineData = {}
  
  local function forEachTableMainline(mapData)
    local nChapter = mapData.ChapterId
    if self._mainlineData[nChapter] == nil then
      self._mainlineData[nChapter] = {}
    end
    if self._mainlineData[nChapter][mapData.Id] == nil then
      self._mainlineData[nChapter][mapData.Id] = {}
    end
    self._mainlineData[nChapter][mapData.Id].data = mapData
    self._mainlineData[nChapter][mapData.Id].Prev = mapData.Prev
    for _, prevId in pairs(mapData.Prev) do
      local mapPrevData = ConfigTable.GetData_Mainline(prevId)
      if mapPrevData ~= nil then
        local nChapterPrev = mapPrevData.ChapterId
        if self._mainlineData[nChapterPrev] == nil then
          self._mainlineData[nChapterPrev] = {}
        end
        if self._mainlineData[nChapterPrev][prevId] == nil then
          self._mainlineData[nChapterPrev][prevId] = {}
        end
        if self._mainlineData[nChapterPrev][prevId].After == nil then
          self._mainlineData[nChapterPrev][prevId].After = {}
        end
        table.insert(self._mainlineData[nChapterPrev][prevId].After, mapData.Id)
        table.sort(self._mainlineData[nChapterPrev][prevId].After)
      end
    end
  end
  
  ForEachTableLine(DataTable.Mainline, forEachTableMainline)
end

function PlayerMainlineDataEx:GetAllMainlineChapter(nChapterId)
  local ret = {}
  local idx = 1
  local retIdx
  
  local function forEachTableChapter(mapData)
    if nil ~= nChapterId and nChapterId == mapData.Id then
      retIdx = idx
    end
    local isUnlock = self:IsMainlineChapterUnlock(mapData.Id)
    local nStar, nAvgStar = self:GetChapterStars(mapData.Id)
    local nAwardIdx = self:GetChapterAward(mapData.Id)
    local TotalStar = self:GetChapterTotalStar(mapData.Id)
    table.insert(ret, {
      nId = mapData.Id,
      nStar = nStar,
      bUnlock = isUnlock,
      nAwardIdx = nAwardIdx,
      bComplete = TotalStar == nAvgStar
    })
    idx = idx + 1
  end
  
  ForEachTableLine(DataTable.Chapter, forEachTableChapter)
  return ret, retIdx
end

function PlayerMainlineDataEx:GetAllLevelByChapter(nChapterId)
  if self._mainlineData[nChapterId] == nil then
    printError("没有章节数据：" .. nChapterId)
    return {}
  end
  local tbId = {}
  local mapId = {}
  local ret = {}
  for nId, _ in pairs(self._mainlineData[nChapterId]) do
    table.insert(tbId, nId)
    mapId[nId] = false
  end
  table.sort(tbId)
  
  local function AddMainline(nId)
    if nId == nil then
      return
    end
    if mapId[nId] == nil or mapId[nId] == true then
      return
    end
    local levelData = ConfigTable.GetData_Mainline(nId)
    if levelData == nil then
      printError("关卡数据不存在" .. nId)
      return
    end
    local ChapterId = levelData.ChapterId
    local nStar, tbTarget = self:GetMianlineLevelStar(nId)
    table.insert(ret, {
      nId = nId,
      nStar = nStar,
      tbTarget = tbTarget,
      bUnlock = self:IsMainlineLevelUnlock(nId)
    })
    mapId[nId] = true
    if self._mainlineData[ChapterId][nId] == nil then
      return
    end
    local tbAfter = self._mainlineData[ChapterId][nId].After
    if tbAfter == nil then
      return
    end
    for _, nLevelId in ipairs(tbAfter) do
      AddMainline(nLevelId)
    end
  end
  
  local function isStartLevel(nMainline)
    local mapMainline = ConfigTable.GetData_Mainline(nMainline)
    if mapMainline == nil then
      return false
    end
    local mapChapter = ConfigTable.GetData("Chapter", mapMainline.ChapterId)
    local tbPrevMainlines = mapChapter.PrevMainlines
    if mapMainline.Prev == nil or #mapMainline.Prev == 0 or 0 < table.indexof(mapMainline.Prev, tbPrevMainlines[1]) then
      return true
    else
      return false
    end
  end
  
  for _, nId in ipairs(tbId) do
    if isStartLevel(nId) then
      AddMainline(nId)
    end
  end
  return ret
end

function PlayerMainlineDataEx:GetBanedCharId()
  if type(self._nSelectId) == "number" and self._nSelectId > 0 then
    local data = ConfigTable.GetData_Mainline(self._nSelectId)
    if data ~= nil then
      if type(data.CharBanned) == "table" then
        return data.CharBanned
      else
        return nil
      end
    else
      return nil
    end
  else
    return nil
  end
end

function PlayerMainlineDataEx:GetBeforeBattleAvg()
  local sAvgId = ConfigTable.GetData_Mainline(self._nSelectId).BeforeAvgId
  if sAvgId == "" then
    return false
  end
  return sAvgId
end

function PlayerMainlineDataEx.CalStar(nOrigin)
  nOrigin = (nOrigin & 1431655765) + (nOrigin >> 1 & 1431655765)
  nOrigin = (nOrigin & 858993459) + (nOrigin >> 2 & 858993459)
  nOrigin = (nOrigin & 252645135) + (nOrigin >> 4 & 252645135)
  nOrigin = nOrigin * 16843009 >> 24
  return nOrigin
end

function PlayerMainlineDataEx:GetAfterBattleAvg()
  if not self.bUseOldMainline then
    return false
  end
  local sAvgId = ConfigTable.GetData_Mainline(self._nSelectId).AfterAvgId
  if sAvgId == "" then
    return false
  end
  return sAvgId
end

function PlayerMainlineDataEx:GetCurChapter()
  if self._nSelectId == 0 then
    local curChapter = 1
    
    local function forEachChapter(mapData)
      if self:IsMainlineChapterUnlock(mapData.Id) and curChapter < mapData.Id then
        curChapter = mapData.Id
      end
    end
    
    ForEachTableLine(DataTable.Chapter, forEachChapter)
    return curChapter
  else
    local mapMainline = ConfigTable.GetData_Mainline(self._nSelectId)
    if mapMainline == nil then
      return 1
    end
    return mapMainline.ChapterId
  end
end

function PlayerMainlineDataEx:GetChapterCount()
  local count = 0
  if self.bUseOldMainline then
    local function forEachChapter(mapData)
      count = count + 1
    end
    
    ForEachTableLine(DataTable.Chapter, forEachChapter)
  else
    local function forEachChapter(mapData)
      count = count + 1
    end
    
    ForEachTableLine(DataTable.StoryChapter, forEachChapter)
  end
  return count
end

function PlayerMainlineDataEx:GetSelectId()
  return self._nSelectId
end

function PlayerMainlineDataEx:GetCurLevelChar()
  if self._mainlineLevel ~= nil and self._mainlineLevel.tbChar ~= nil then
    return self._mainlineLevel.tbChar
  end
  return {}
end

function PlayerMainlineDataEx:EnterTest(nMainlineId, nTeamId)
  if self._mainlineLevel ~= nil then
    printError("当前关卡level不为空2")
    return
  end
  if type(ConfigTable.GetData_Mainline(nMainlineId).AvgId) == "string" and ConfigTable.GetData_Mainline(nMainlineId).AvgId ~= "" then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("MainlineData_Avg")
    })
    return
  end
  local tbCharId = PlayerData.Team:GetTeamCharId(nTeamId)
  self._nSelectId = nMainlineId
  PlayerData.nCurGameType = AllEnum.WorldMapNodeType.Mainline
  if #tbCharId == 0 then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("MainlineData_FormationError")
    })
    return
  end
  local luaClass = require("Game.Editor.MainlineLevel.MainlineEditor")
  if luaClass == nil then
    return
  end
  self._mainlineLevel = luaClass
  if type(self._mainlineLevel.Init) == "function" then
    self._mainlineLevel:Init(self, nMainlineId, nTeamId, {}, {})
  end
end

function PlayerMainlineDataEx:EnterMainlineEditor(nMainlineId, tbTeamCharId, tbTalentSkillAI, tbDisc, tbNote, tbSkinId)
  if self._mainlineLevel ~= nil then
    printError("当前关卡level不为空1")
    return
  end
  local luaClass = require("Game.Editor.MainlineLevel.MainlineEditor")
  if luaClass == nil then
    return
  end
  self._mainlineLevel = luaClass
  if type(self._mainlineLevel.InitBootConfig) == "function" then
    self._mainlineLevel:InitBootConfig(self, nMainlineId, tbTeamCharId, {}, {}, tbTalentSkillAI, tbDisc, tbNote, tbSkinId)
  end
end

function PlayerMainlineDataEx:EnterPreviewEditor(nLevelType, nLevelId, bView, nStarTowerFloorSetId, nPrefabID, nPrefabExtension, nPlayType, nSceneMir)
  if self._mainlineLevel ~= nil then
    printError("当前关卡level不为空1")
    return
  end
  local luaClass = require("Game.Adventure.MainlineLevel.PreviewLevel")
  if luaClass == nil then
    return
  end
  self._mainlineLevel = luaClass
  if type(self._mainlineLevel.Init) == "function" then
    self._mainlineLevel:Init(nLevelType, nLevelId, bView, nStarTowerFloorSetId, nPrefabID, nPrefabExtension, nPlayType, nSceneMir, self)
  end
end

function PlayerMainlineDataEx:EnterTestBattleComboClipEditor(nMainlineId, tbTeamCharId, tbTalentSkillAI, tbDisc, tbNote, tbSkinId)
  if self._mainlineLevel ~= nil then
    printError("当前关卡level不为空1")
    return
  end
  local luaClass = require("Game.Editor.MainlineLevel.BattleTestComboClipEditor")
  if luaClass == nil then
    return
  end
  self._mainlineLevel = luaClass
  if type(self._mainlineLevel.InitBootConfig) == "function" then
    self._mainlineLevel:InitBootConfig(self, nMainlineId, tbTeamCharId, {}, {}, tbTalentSkillAI, tbDisc, tbNote, tbSkinId)
  end
end

function PlayerMainlineDataEx:LevelEnd()
  PlayerData.Char:DeleteTrialChar()
  if type(self._mainlineLevel.UnBindEvent) == "function" then
    self._mainlineLevel:UnBindEvent()
  end
  self._mainlineLevel = nil
end

function PlayerMainlineDataEx:UpdateMainlineStar(nMainlineId, nStar)
  local mapMainline = ConfigTable.GetData_Mainline(nMainlineId)
  local nChapter = mapMainline.ChapterId
  if self._mapStar[nChapter] == nil then
    self._mapStar[nChapter] = {}
  end
  local sumStar = self.CalStar(nStar)
  local b1 = 1
  local b2 = 2
  local b3 = 4
  local t1 = 0 < nStar & b1
  local t2 = 0 < nStar & b2
  local t3 = 0 < nStar & b3
  local tbTarget = {
    t1,
    t2,
    t3
  }
  if 0 < sumStar and (self._mapStar[nChapter][nMainlineId] == nil or self._mapStar[nChapter][nMainlineId].nStar == 0) then
    PlayerData.Base:CheckNewFuncUnlockMainlinePass(nMainlineId)
  end
  self._mapStar[nChapter][nMainlineId] = {nStar = sumStar, tbTarget = tbTarget}
  self:UpdateRewardRedDot()
end

function PlayerMainlineDataEx:UpdateMainlineChapterReward(chapterId, nIdx)
  self._mapChapters[chapterId] = nIdx
  self:UpdateRewardRedDot()
end

function PlayerMainlineDataEx:OnEvent_EnterMainline(nTeamId)
  local mapMainline = ConfigTable.GetData_Mainline(self._nSelectId)
  if mapMainline == nil then
    return
  end
  local nStar = 0
  if self._mapStar[mapMainline.ChapterId] ~= nil and self._mapStar[mapMainline.ChapterId][self._nSelectId] ~= nil then
    nStar = self._mapStar[mapMainline.ChapterId][self._nSelectId].nStar
  end
  if (nStar == nil or nStar == 0 or mapMainline.Energy < 1) and PlayerData.Base:CheckEnergyEnough(self._nSelectId) == false then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("MainlineData_Energy")
    })
    return
  end
  self:NetMsg_EnterMainline(self._nSelectId, nTeamId, nil)
end

function PlayerMainlineDataEx:NetMsg_GetMainlineAward(nChapterId, callback, rewardIdx)
  local function msgCallback(_, mapMsgData)
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
    
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    self._mapChapters[nChapterId] = rewardIdx
    if callback ~= nil then
      callback(mapMsgData.Items, mapMsgData.Change)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.chapter_reward_receive_req, {Value = nChapterId}, nil, msgCallback)
end

function PlayerMainlineDataEx:NetMsg_EnterMainline(nMainlineId, nTeamIdx, callback)
  if self._mainlineLevel ~= nil then
    printError("当前关卡level不为空3")
    return
  end
  
  local function msgCallback(_, mapMsgData)
    if callback ~= nil then
      callback(mapMsgData)
    end
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    local mapMainline = ConfigTable.GetData_Mainline(nMainlineId)
    if mapMainline == nil then
      printError("主线数据不存在：" .. nMainlineId)
      return
    end
    if mapMainline.AvgId ~= nil and mapMainline.AvgId ~= "" then
      local luaClass = require("Game.Adventure.MainlineLevel.MainlineAvgLevel")
      if luaClass == nil then
        return
      end
      self._mainlineLevel = luaClass
      if type(self._mainlineLevel.Init) == "function" then
        self._mainlineLevel:Init(self, nMainlineId)
      end
    else
      local luaClass = require("Game.Adventure.MainlineLevel.MainlineBattleLevel")
      if luaClass == nil then
        return
      end
      self._mainlineLevel = luaClass
      if type(self._mainlineLevel.Init) == "function" then
        self._mainlineLevel:Init(self, nMainlineId, nTeamIdx, mapMsgData.OpenMinChests, mapMsgData.OpenMaxChests)
      end
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.mainline_apply_req, {ID = nMainlineId, FormationId = nTeamIdx}, nil, msgCallback)
end

function PlayerMainlineDataEx:NetMsg_UnlockMainline(nMainlineId, callback)
  local msg = {Value = nMainlineId}
  
  local function msgCallback()
    local mapMainline = ConfigTable.GetData_Mainline(nMainlineId)
    if mapMainline ~= nil then
      if self._mapStar[mapMainline.ChapterId] == nil then
        self._mapStar[mapMainline.ChapterId] = {}
      end
      self._mapStar[mapMainline.ChapterId][nMainlineId] = {}
      self._mapStar[mapMainline.ChapterId][nMainlineId].nStar = 0
      self._mapStar[mapMainline.ChapterId][nMainlineId].tbTarget = {
        false,
        false,
        false
      }
    else
      printError("Mainline Data Missing:" .. nMainlineId)
    end
    if type(callback) == "function" then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.mainline_unlock_req, msg, nil, msgCallback)
end

function PlayerMainlineDataEx:EnterPrologue()
  if self._mainlineLevel ~= nil then
    printError("当前关卡level不为空3")
    return
  end
  PlayerData.nCurGameType = AllEnum.WorldMapNodeType.Prologue
  local luaClass = require("Game.Adventure.MainlineLevel.MainlinePrologueLevel")
  if luaClass == nil then
    return
  end
  self._mainlineLevel = luaClass
  if type(self._mainlineLevel.Init) == "function" then
    self._mainlineLevel:Init(self)
  end
end

function PlayerMainlineDataEx:UpdateRewardRedDot()
  for chapterId, v in pairs(self._mapStar) do
    local allStar = 0
    local canReceive = false
    for id, data in pairs(v) do
      local mapData = ConfigTable.GetData_Mainline(id)
      if mapData.AvgId == "" then
        allStar = allStar + data.nStar
      end
    end
    local chapterCfg = ConfigTable.GetData("Chapter", chapterId)
    if nil ~= chapterCfg then
      local tbReward = decodeJson(chapterCfg.CompleteRewards)
      local tbSortReward = {}
      for star, reward in pairs(tbReward) do
        table.insert(tbSortReward, {
          nStar = tonumber(star)
        })
      end
      table.sort(tbSortReward, function(a, b)
        return a.nStar < b.nStar
      end)
      local receivedRewardIdx = self._mapChapters[chapterId] or 0
      for idx, v in ipairs(tbSortReward) do
        if allStar >= v.nStar and idx > receivedRewardIdx then
          canReceive = true
          break
        end
      end
    end
    RedDotManager.SetValid(RedDotDefine.Map_MainLine_Reward, chapterId, canReceive)
  end
end

return PlayerMainlineDataEx
