local PlayerVoiceData = class("PlayerVoiceData")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local TimerManager = require("GameCore.Timer.TimerManager")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local ClientManager = CS.ClientManager.Instance
local LocalData = require("GameCore.Data.LocalData")
local TN = AllEnum.Actor2DType.Normal
local TF = AllEnum.Actor2DType.FullScreen
local board_click_time = ConfigTable.GetConfigNumber("HFCtimer")
local board_click_max_count = ConfigTable.GetConfigNumber("HFCcounter")
local board_click_free_time = ConfigTable.GetConfigNumber("Hangtimer")
local npc_board_click_time = ConfigTable.GetConfigNumber("NpcHFCtimer")
local npc_board_click_max_count = ConfigTable.GetConfigNumber("NpcHFCcounter")
local npc_board_click_free_time = ConfigTable.GetConfigNumber("NpcHangtimer")
local board_free_trigger_none = 0
local board_free_trigger_hang = 1
local board_free_trigger_ex_hang = 2
local charFavorLevelClickVoice = {
  [1] = {nLevel = 10, sClickVoiceKey = "affchat1"},
  [2] = {nLevel = 15, sClickVoiceKey = "affchat2"},
  [3] = {nLevel = 20, sClickVoiceKey = "affchat3"},
  [4] = {nLevel = 25, sClickVoiceKey = "affchat4"},
  [5] = {nLevel = 30, sClickVoiceKey = "affchat5"}
}
local charFavorLevelUnlockVoice = {
  {nLevel = 10, sUnlockVoiceKey = "afflv1"},
  {nLevel = 15, sUnlockVoiceKey = "afflv2"},
  {nLevel = 25, sUnlockVoiceKey = "afflv3"},
  {nLevel = 30, sUnlockVoiceKey = "afflv4"}
}

function PlayerVoiceData:Init()
  self.bFirstEnterGame = true
  self.bNpc = false
  self.nNpcId = 0
  self.nNPCSkinId = 0
  self.bStartBoardClickTimer = false
  self._bBoardFreeTimerPaused = false
  self.nContinuousClickCount = 0
  self.nBoardClickTime = 0
  self.nBoardFreeTime = 0
  self.nVoiceDuration = 0
  self.nCurVoiceId = nil
  self.nTriggerFreeVoiceState = board_free_trigger_none
  self.boardClickTimer = nil
  self.boardFreeTimer = nil
  self.boardPlayTimer = nil
  self.tbHolidayVoice = {}
  self.tbHolidayVoiceKey = {}
  EventManager.Add(EventId.UIOperate, self, self.OnEvent_UIOperate)
  EventManager.Add(EventId.AvgVoiceDuration, self, self.OnEvent_AvgVoiceDuration)
  EventManager.Add(EventId.IsNewDay, self, self.OnEvent_NewDay)
  self:InitConfig()
end

function PlayerVoiceData:UnInit()
  EventManager.Remove(EventId.UIOperate, self, self.OnEvent_UIOperate)
  EventManager.Remove(EventId.AvgVoiceDuration, self, self.OnEvent_AvgVoiceDuration)
  EventManager.Remove(EventId.IsNewDay, self, self.OnEvent_NewDay)
end

function PlayerVoiceData:InitConfig()
  local function foreachVoiceControl(line)
    if line.dateTrigger and line.date ~= "" then
      local tbParam = string.split(line.date, ".")
      
      local year, month, day = 0
      if #tbParam == 3 then
        year = tonumber(tbParam[1])
        month = tonumber(tbParam[2])
        day = tonumber(tbParam[3])
      else
        month = tonumber(tbParam[1])
        day = tonumber(tbParam[2])
      end
      table.insert(self.tbHolidayVoice, {
        voiceKey = line.Id,
        date = {
          year = year,
          month = month,
          day = day
        }
      })
    end
  end
  
  ForEachTableLine(ConfigTable.Get("CharacterVoiceControl"), foreachVoiceControl)
end

function PlayerVoiceData:PlayCharVoice(voiceKey, nCharId, nSkinId, bNpc)
  if nil ~= voiceKey then
    local tbVoiceKey = {}
    if type(voiceKey) ~= "table" then
      table.insert(tbVoiceKey, voiceKey)
    else
      tbVoiceKey = voiceKey
    end
    nSkinId = nSkinId or 0
    if nCharId ~= 0 then
      if nSkinId == 0 then
        if bNpc then
          local mapNpcCfg = ConfigTable.GetData("BoardNPC", nCharId)
          if mapNpcCfg ~= nil then
            nSkinId = mapNpcCfg.DefaultSkinId
          end
        else
          nSkinId = PlayerData.Char:GetCharSkinId(nCharId)
        end
      end
    else
      nSkinId = 0
    end
    local nVoiceId = WwiseAudioMgr:WwiseVoice_Play(nCharId, tbVoiceKey, nil, nSkinId, tbVoiceKey)
    if nil ~= nVoiceId and nVoiceId ~= 0 then
      self.nCurVoiceId = nVoiceId
    end
    return nVoiceId
  end
end

function PlayerVoiceData:StopCharVoice()
  if nil ~= self.nCurVoiceId and self.nCurVoiceId ~= 0 then
    local mapVoDirectoryData = ConfigTable.GetData("VoDirectory", self.nCurVoiceId)
    if mapVoDirectoryData ~= nil then
      local tbCfg = ConfigTable.GetData("CharacterVoiceControl", mapVoDirectoryData.votype)
      if nil ~= tbCfg then
        WwiseAudioMgr:WwiseVoice_Stop(tbCfg.voPlayer - 1)
      end
    end
    self.nCurVoiceId = 0
  end
end

function PlayerVoiceData:CheckHoliday()
  self.tbHolidayVoiceKey = {}
  local nServerTimeStamp = ClientManager.serverTimeStamp
  local nYear = tonumber(os.date("%Y", nServerTimeStamp))
  local nMonth = tonumber(os.date("%m", nServerTimeStamp))
  local nDay = tonumber(os.date("%d", nServerTimeStamp))
  for _, v in ipairs(self.tbHolidayVoice) do
    if v.date.year ~= 0 then
      if v.date.year == nYear and v.date.month == nMonth and v.date.day == nDay then
        table.insert(self.tbHolidayVoiceKey, v.voiceKey)
      end
    elseif v.date.month == nMonth and v.date.day == nDay then
      table.insert(self.tbHolidayVoiceKey, v.voiceKey)
    end
  end
end

function PlayerVoiceData:CheckBirthday()
  local nServerTimeStamp = ClientManager.serverTimeStamp
  local nYear = tonumber(os.date("%Y", nServerTimeStamp))
  local nMonth = tonumber(os.date("%m", nServerTimeStamp))
  local nDay = tonumber(os.date("%d", nServerTimeStamp))
  local curBoardCharId = PlayerData.Board:GetCurBoardCharID()
  local mapCharDesc = ConfigTable.GetData("CharacterDes", curBoardCharId)
  if nil ~= mapCharDesc and mapCharDesc.Birthday ~= "" then
    local tbParam = string.split(mapCharDesc.Birthday, ".")
    if #tbParam == 3 then
      if nYear == tonumber(tbParam[1]) and nMonth == tonumber(tbParam[2]) and nDay == tonumber(tbParam[3]) then
        return true
      end
    elseif nMonth == tonumber(tbParam[1]) and nDay == tonumber(tbParam[2]) then
      return true
    end
  end
  return false
end

local function getBoardClickTime(bNpc)
  return bNpc and npc_board_click_time or board_click_time
end

local function getBoardClickMaxCount(bNpc)
  return bNpc and npc_board_click_max_count or board_click_max_count
end

local function getBoardClickFreeTime(bNpc)
  return bNpc and npc_board_click_free_time or board_click_free_time
end

function PlayerVoiceData:GetCurBoardCharIdAndSkinId()
  local curBoardCharId, curSkinId = 0, 0
  local curBoardData = PlayerData.Board:GetCurBoardData()
  if curBoardData ~= nil and curBoardData:GetType() == GameEnum.handbookType.SKIN then
    curBoardCharId = curBoardData:GetCharId()
    curSkinId = curBoardData:GetSkinId()
    local curActor2DType = Actor2DManager.GetCurrentActor2DType()
    local mapCharCfg = ConfigTable.GetData_Character(curBoardCharId)
    if mapCharCfg ~= nil and mapCharCfg.DefaultSkinId ~= curSkinId and curActor2DType == TF then
      local mapSkinCfg1 = ConfigTable.GetData("CharacterSkin", mapCharCfg.DefaultSkinId)
      if mapSkinCfg1 ~= nil then
        local mapSkinCfg2 = ConfigTable.GetData("CharacterSkin", curSkinId)
        if mapSkinCfg2 ~= nil and mapSkinCfg2.CharacterCG == mapSkinCfg1.CharacterCG then
          curSkinId = mapCharCfg.DefaultSkinId
        end
      end
    end
  end
  return curBoardCharId, curSkinId
end

function PlayerVoiceData:StartBoardFreeTimer(nNpcId, nSkinId)
  if nNpcId ~= nil or self.bNpc then
    self.bNpc = true
    if nNpcId ~= nil then
      self.nNpcId = nNpcId
    end
    if nSkinId ~= nil then
      self.nNPCSkinId = nSkinId
    end
  else
    self.bNpc = false
    self.nNpcId = 0
    self.nNPCSkinId = 0
  end
  self.bStartBoardClickTimer = true
  if self._bBoardFreeTimerPaused then
    return
  end
  if nil == self.boardFreeTimer and self.nTriggerFreeVoiceState ~= board_free_trigger_ex_hang then
    self.boardFreeTimer = TimerManager.Add(0, 0.1, self, self.CheckBoardFree, true, true, false)
  end
end

function PlayerVoiceData:CheckBoardFree()
  if self._bBoardFreeTimerPaused then
    return
  end
  self.nBoardFreeTime = self.nBoardFreeTime + 0.1
  if self.nBoardFreeTime >= getBoardClickFreeTime(self.bNpc) then
    self:ResetBoardFreeTimer()
    if self.nTriggerFreeVoiceState == board_free_trigger_none then
      self.nTriggerFreeVoiceState = board_free_trigger_hang
      self:PlayBoardFreeVoice()
    elseif self.nTriggerFreeVoiceState == board_free_trigger_hang then
      self.nTriggerFreeVoiceState = board_free_trigger_ex_hang
      self:PlayBoardFreeLongTimeVoice()
    end
  end
end

function PlayerVoiceData:PauseBoardFreeTimer()
  self._bBoardFreeTimerPaused = true
  self:ResetBoardFreeTimer()
  self:ResetBoardPlayTimer()
end

function PlayerVoiceData:ResumeBoardFreeTimer()
  if not self._bBoardFreeTimerPaused then
    return
  end
  self._bBoardFreeTimerPaused = false
  if self.bStartBoardClickTimer then
    self:StartBoardFreeTimer()
  end
end

function PlayerVoiceData:ResetBoardFreeTimer()
  if nil ~= self.boardFreeTimer then
    TimerManager.Remove(self.boardFreeTimer, false)
  end
  self.boardFreeTimer = nil
  self.nBoardFreeTime = 0
end

function PlayerVoiceData:StartBoardPlayTimer()
  if self._bBoardFreeTimerPaused then
    return
  end
  if nil == self.boardPlayTimer then
    self.boardPlayTimer = TimerManager.Add(1, self.nVoiceDuration, nil, function()
      self:StartBoardFreeTimer()
    end, true, true, false)
  end
end

function PlayerVoiceData:ResetBoardPlayTimer()
  if nil ~= self.boardPlayTimer then
    TimerManager.Remove(self.boardPlayTimer, false)
  end
  self.boardPlayTimer = nil
  self.nVoiceDuration = 0
end

function PlayerVoiceData:PlayBoardSelectVoice(nCharId, nSkinId)
  local sVoiceKey = "greet"
  self:PlayCharVoice(sVoiceKey, nCharId, nSkinId)
end

function PlayerVoiceData:PlayMainViewOpenVoice()
  local curBoardCharId, curSkinId = self:GetCurBoardCharIdAndSkinId()
  local bPlayFirst = false
  local tbVoiceKey = {}
  if curBoardCharId ~= nil and curBoardCharId ~= 0 then
    self:CheckHoliday()
    local nServerTimeStamp = ClientManager.serverTimeStamp
    local nHour = tonumber(os.date("%H", nServerTimeStamp))
    
    local function getIndex(nHour)
      if 6 <= nHour and nHour < 12 then
        return 1, "greetmorn"
      elseif 12 <= nHour and nHour < 18 then
        return 2, "greetnoon"
      else
        return 3, "greetnight"
      end
    end
    
    local nIndex, sKey = getIndex(nHour)
    if true == self.bFirstEnterGame then
      tbVoiceKey = {sKey}
      self.bFirstEnterGame = false
    else
      tbVoiceKey = {sKey, "greet"}
    end
    if 0 < #self.tbHolidayVoiceKey then
      for _, v in ipairs(self.tbHolidayVoiceKey) do
        table.insert(tbVoiceKey, v)
      end
    end
    if self:CheckBirthday() then
      table.insert(tbVoiceKey, "birth")
    end
    self:PlayCharVoice(tbVoiceKey, curBoardCharId, curSkinId)
  end
end

function PlayerVoiceData:CheckContinuousClick()
  self.nBoardClickTime = self.nBoardClickTime + 0.1
  local nTime = getBoardClickTime(self.bNpc)
  if nTime < self.nBoardClickTime then
    self:ResetBoardClickTimer()
  end
end

function PlayerVoiceData:ResetBoardClickTimer()
  if nil ~= self.boardClickTimer then
    TimerManager.Remove(self.boardClickTimer, false)
  end
  self.boardClickTimer = nil
  self.nBoardClickTime = 0
  self.nContinuousClickCount = 0
end

function PlayerVoiceData:PlayBoardClickVoice()
  self.bNpc = false
  self.nNpcId = 0
  self.nNPCSkinId = 0
  if 0 == self.nBoardClickTime and nil == self.boardClickTimer then
    self.boardClickTimer = TimerManager.Add(0, 0.1, self, self.CheckContinuousClick, true, true, false)
  end
  self.nContinuousClickCount = self.nContinuousClickCount + 1
  local curBoardCharId, curSkinId = self:GetCurBoardCharIdAndSkinId()
  if curBoardCharId ~= nil and curBoardCharId ~= 0 then
    local tbVoiceKey = {}
    if self.nContinuousClickCount > getBoardClickMaxCount(self.bNpc) then
      table.insert(tbVoiceKey, "hfc")
      self:ResetBoardClickTimer()
    else
      table.insert(tbVoiceKey, "posterchat")
      local curActor2DType = Actor2DManager.GetCurrentActor2DType()
      if curActor2DType == TN then
        table.insert(tbVoiceKey, "standee")
      elseif curActor2DType == TF then
        table.insert(tbVoiceKey, "fullscreen")
      end
      local mapData = PlayerData.Char:GetCharAffinityData(curBoardCharId)
      if nil ~= mapData then
        local nLevel = mapData.Level
        for _, v in ipairs(charFavorLevelClickVoice) do
          if nLevel >= v.nLevel then
            table.insert(tbVoiceKey, v.sClickVoiceKey)
          end
        end
      end
    end
    if 0 < #self.tbHolidayVoiceKey then
      for _, v in ipairs(self.tbHolidayVoiceKey) do
        table.insert(tbVoiceKey, v)
      end
    end
    if self:CheckBirthday() then
      table.insert(tbVoiceKey, "birth")
    end
    local nVoiceId = self:PlayCharVoice(tbVoiceKey, curBoardCharId, curSkinId)
    if nil ~= nVoiceId and 0 ~= nVoiceId then
      PlayerData.Quest:SendClientEvent(GameEnum.questCompleteCondClient.InteractL2D)
    end
  end
end

function PlayerVoiceData:PlayBoardNPCClickVoice(nNpcId, nSkinId, sClickVoiceKey)
  self.bNpc = true
  self.nNpcId = nNpcId
  self.nNPCSkinId = nSkinId or 0
  if 0 == self.nBoardClickTime and nil == self.boardClickTimer then
    self.boardClickTimer = TimerManager.Add(0, 0.1, self, self.CheckContinuousClick, true, true, false)
  end
  self.nContinuousClickCount = self.nContinuousClickCount + 1
  local curBoardCharId = nNpcId
  if nil ~= curBoardCharId then
    local tbVoiceKey = {}
    if self.nContinuousClickCount > getBoardClickMaxCount(self.bNpc) then
      table.insert(tbVoiceKey, "hfc_npc")
      self:ResetBoardClickTimer()
    else
      local sKey = "posterchat_npc"
      if sClickVoiceKey then
        sKey = sClickVoiceKey
      end
      table.insert(tbVoiceKey, sKey)
    end
    self:PlayCharVoice(tbVoiceKey, curBoardCharId, self.nNPCSkinId, true)
  end
end

function PlayerVoiceData:PlayBoardFreeVoice()
  local curBoardCharId, curSkinId, sVoiceKey
  if not self.bNpc then
    curBoardCharId, curSkinId = self:GetCurBoardCharIdAndSkinId()
    sVoiceKey = "hang"
  else
    curBoardCharId = self.nNpcId
    curSkinId = self.nNPCSkinId
    sVoiceKey = "hang_npc"
  end
  if curBoardCharId ~= nil and curBoardCharId ~= 0 then
    self:PlayCharVoice(sVoiceKey, curBoardCharId, curSkinId, self.bNpc)
  end
end

function PlayerVoiceData:PlayBoardFreeLongTimeVoice()
  local curBoardCharId, curSkinId, sVoiceKey
  if not self.bNpc then
    curBoardCharId, curSkinId = self:GetCurBoardCharIdAndSkinId()
    sVoiceKey = "exhang"
  else
    curBoardCharId = self.nNpcId
    curSkinId = self.nNPCSkinId
    sVoiceKey = "exhang_npc"
  end
  if curBoardCharId ~= nil and curBoardCharId ~= 0 then
    self:PlayCharVoice(sVoiceKey, curBoardCharId, curSkinId, self.bNpc)
  end
end

function PlayerVoiceData:GetNPCGreetTimeVoiceKey()
  local sTimeVoice = ""
  local nServerTimeStamp = ClientManager.serverTimeStamp
  local nHour = tonumber(os.date("%H", nServerTimeStamp))
  if 6 <= nHour and nHour < 12 then
    sTimeVoice = "greetmorn_npc"
  elseif 12 <= nHour and nHour < 18 then
    sTimeVoice = "greetnoon_npc"
  else
    sTimeVoice = "greetnight_npc"
  end
  return sTimeVoice
end

function PlayerVoiceData:PlayBattleResultVoice(tbChar, bWin)
  local nIndex = math.random(1, #tbChar)
  local nCharId = tbChar[nIndex]
  local sVoiceKey = bWin and "win" or "lose"
  self:PlayCharVoice(sVoiceKey, nCharId)
end

function PlayerVoiceData:CheckPlayGiftVoice(nLevel, nLastLevel)
  local bPlay = true
  if nLastLevel ~= nLevel then
    for i = 1, #charFavorLevelUnlockVoice do
      if charFavorLevelUnlockVoice[i] ~= nil and nLastLevel < charFavorLevelUnlockVoice[i].nLevel and nLevel >= charFavorLevelUnlockVoice[i].nLevel then
        bPlay = false
        break
      end
    end
  end
  return bPlay
end

function PlayerVoiceData:PlayCharFavourUpVoice(nCharId, nLastFavourLevel)
  local nVoiceId
  local mapData = PlayerData.Char:GetCharAffinityData(nCharId)
  if nil ~= mapData then
    local nLevel = mapData.Level
    local sVoiceKey = ""
    for i = 1, #charFavorLevelUnlockVoice do
      if charFavorLevelUnlockVoice[i] ~= nil and nLastFavourLevel < charFavorLevelUnlockVoice[i].nLevel and nLevel >= charFavorLevelUnlockVoice[i].nLevel then
        sVoiceKey = charFavorLevelUnlockVoice[i].sUnlockVoiceKey
      end
    end
    if sVoiceKey ~= "" then
      nVoiceId = self:PlayCharVoice(sVoiceKey, nCharId)
    end
  end
  return nVoiceId
end

function PlayerVoiceData:ClearTimer()
  self:ResetBoardPlayTimer()
  self:ResetBoardFreeTimer()
  self:ResetBoardClickTimer()
  self.bStartBoardClickTimer = false
  self.bNpc = false
  self.nNpcId = 0
  self.nNPCSkinId = 0
end

function PlayerVoiceData:OnEvent_UIOperate()
  self.nBoardFreeTime = 0
  self.nTriggerFreeVoiceState = board_free_trigger_none
  if self.bStartBoardClickTimer and self.nVoiceDuration == 0 then
    self:StartBoardFreeTimer()
  end
end

function PlayerVoiceData:OnEvent_AvgVoiceDuration(nDuration)
  if self._bBoardFreeTimerPaused then
    return
  end
  self:ResetBoardPlayTimer()
  self.nVoiceDuration = nDuration
  if self.bStartBoardClickTimer and self.nTriggerFreeVoiceState ~= board_free_trigger_ex_hang then
    self:ResetBoardFreeTimer()
    self:StartBoardPlayTimer()
  end
end

function PlayerVoiceData:OnEvent_NewDay()
  self:CheckHoliday()
end

return PlayerVoiceData
