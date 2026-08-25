local E = require("ejoysdk_lua.ejoysdk")
local JSON = require("ejoysdk_lua.libs.lunajson")
local lz4 = require("lz4")
local cmsgpack = require("cmsgpack")
local RECORD_STEP_TIME = 2
local TimeUtil = CS.Framework.TimeUtil
local BattleReplayPlayer, Super = System.NewClass("BattleReplayPlayer")

function BattleReplayPlayer:ctor(battleUuid, watchUid, speed)
  Super.ctor(self)
  self._battleUuid = battleUuid
  self._battleEngineUuid = nil
  self.watchUid = watchUid
  self._isReady = false
  self._isPlaying = false
  self._isPause = false
  self._isDownloading = false
  self._isDownloaded = false
  self.replayData = nil
  self.recordZipList = nil
  self.recordUnZipList = nil
  self._playedRecordIndex = 0
  self.playSpeed = speed or 1
  self._extraScale = 1
  self._tickTimeDelta = 0.1
  self._curTime = 0
  self._replayStartTime = 0
  self._updateTimer = nil
end

function BattleReplayPlayer:GetRecordOssUrl(objName)
  local url
  if PlayerDataUtils.IsJpZone() then
    url = "https://z1j-warreport.oss-ap-northeast-1.aliyuncs.com"
  else
    local serverDomain = SdkMgr.Instance:GetServerDomain() or ""
    if string.find(serverDomain, "sialiagames") then
      url = "https://z1g-warreport.sialiagamesinc.com.tw"
    else
      url = "https://z1g-warreport.qookkagames.com"
    end
  end
  if not objName then
    do return string.format, "%s/BattleReplay_%s.json", url end
    return string.format, "%s/BattleReplay_%s.json", url, self._battleUuid
  else
    do return string.format, "%s/%s", url end
    return string.format, "%s/%s", url, objName
  end
end

function BattleReplayPlayer:Play()
  bg.replayPlayer = self
  if self._updateTimer then
    return
  end
  self._updateTimer = TimerManager.Instance:CreateTimer(self._tickTimeDelta, -1, System.fn(self, self.Update))
end

function BattleReplayPlayer:SetPause(isPause)
  self._isPause = isPause
  if bg.battleRender and bg.battleRender.recordMgr then
    local state = isPause and bc.BattleRecordPlayState.Pause or bc.BattleRecordPlayState.Play
    bg.battleRender.recordMgr:SetRecordState(state, 999)
  end
end

function BattleReplayPlayer:SetPauseDelay(delay)
  self._pauseedTime = os.time() + delay
end

function BattleReplayPlayer:Stop()
  bg.replayPlayer = nil
  self:CloseWaitPanel()
  self:ClearDownloadTimeoutTimer()
  if self._updateTimer then
    print("-----------stop update", debug.traceback())
    TimerManager.Instance:StopTimer(self._updateTimer)
    self._updateTimer = nil
    EventMgr.Instance.BattleReplayStop:Dispatch()
  end
  self.replayData = nil
  self.recordZipList = nil
  self.recordUnZipList = nil
end

function BattleReplayPlayer:SetSpeed(speed)
  self.playSpeed = speed
end

function BattleReplayPlayer:Update()
  if not (self._isReady and self.replayData) or not self.recordZipList then
    return
  end
  if self._isPause then
    return
  end
  if self._pauseedTime and os.time() < self._pauseedTime then
    return
  end
  if not self._isPlaying then
    self:_EnterReplayBattle()
  end
  if not BattleManager.Instance.isBattleResReady then
    return
  end
  local timeScale = TimeUtil.GetTimeScale()
  local timeDelta = self._tickTimeDelta * self.playSpeed * self._extraScale * timeScale
  self._curTime = self._curTime + timeDelta
  local curPlayTime = self._curTime + self._replayStartTime
  self:CheckMaxBout()
  if self._isPause then
    return
  end
  local record = self:GetRecord(self._playedRecordIndex + 1)
  if not record then
    return
  end
  if curPlayTime < record.time then
    if not self:IsCanPlayNext() then
      return
    end
    local nextRecordDelay = record.time - curPlayTime
    local stepTime = RECORD_STEP_TIME
    if nextRecordDelay > stepTime then
      self._curTime = self._curTime + nextRecordDelay - stepTime
    end
    return
  end
  local msgId, msgData = record.msgId, record.msgData
  if msgId == BattleCommand.rd_BattleInstantCut then
    msgId = BattleCommand.rd_BattleCut
  elseif msgId == BattleCommand.rd_CommandResult then
    msgId = BattleCommand.rd_BattleCut
    record.msgData.realMsgId = BattleCommand.rd_CommandResult
    record.msgData.time = record.time
    msgData = {
      battleEngineUuid = self._battleEngineUuid,
      frameList = {
        [1] = record.msgData
      }
    }
  end
  BattleManager.Instance:OnReceiveBattleCommand(msgId, msgData)
  self._playedRecordIndex = self._playedRecordIndex + 1
  self:CheckNextRecord(self:GetRecord(self._playedRecordIndex + 1))
  return
end

function BattleReplayPlayer:CheckNextRecord(record)
  if not record then
    return
  end
  if record.msgId == BattleCommand.rd_CommandResult then
    local msgData = record.msgData
    if msgData.msgId == BattleCommand.lg_ExtraBout and msgData.isEnterExtraBout then
      self:SetPauseDelay(1.5)
    end
    if msgData.msgId == BattleCommand.lg_BoutEnd and msgData.isExtraBout then
      self:SetPauseDelay(1.5)
    end
  end
end

function BattleReplayPlayer:IsCanPlayNext()
  if self:IsPVPSelectInitCardPanel() then
    return true
  end
  if bg.battleRender and bg.battleRender.recordMgr then
    local isStopTick = bg.battleRender.recordMgr:IsStopTick()
    return not isStopTick
  end
  return true
end

function BattleReplayPlayer:SetExtraScale(scale)
  self._extraScale = scale
end

function BattleReplayPlayer:IsPVPSelectInitCardPanel()
  if UIManager.Instance:GetWindow(Urls.PvPOtherSelectInitCardPanel) then
    return true
  end
  if UIManager.Instance:GetWindow(Urls.PvPSelectInitCardPanel) then
    return true
  end
end

function BattleReplayPlayer:CheckMaxBout()
  if bg.battleDataCenter then
    local curBout = bg.battleDataCenter:GetCurBout() or 0
    if curBout >= 25 then
      self:SetPause(true)
      Alert.Show("PVEReplayMaxRounds", nil, function()
        self:Stop()
      end)
    end
  end
end

function BattleReplayPlayer:_EnterReplayBattle()
  if self._isPlaying then
    return
  end
  local battleData = self.replayData and self.replayData.battleDat
  if not battleData then
    return
  end
  StageExitPanelManager.Instance:Clear()
  self._isPlaying = true
  battleData.svrRunBattle = false
  battleData.isReplay = true
  battleData.watchPlayerUid = self.watchUid
  bg.isReplay = true
  UIManager.Instance:CloseAllExcept()
  BattleManager.Instance:EnterBattle(battleData)
  if self._firstRecord then
    BattleManager.Instance:OnReceiveBattleCommand(self._firstRecord.msgId, self._firstRecord.msgData)
    self._firstRecord = nil
  end
  bg.battleDataCenter.isInit = true
  self:CloseWaitPanel()
  if bg.isPVP then
    PvpController.Instance:ReqOnWatchPvpReplay(self._battleUuid, -1)
  else
    local stageId = battleData.stageId
    if stageId then
      local stageGroupTid = CopyDataUtils.GetStageGroupId(stageId)
      if stageGroupTid then
        PvpController.Instance:ReqOnWatchPvpReplay(self._battleUuid, stageGroupTid)
      end
    end
  end
  EventMgr.Instance.BattleReplayStart:Dispatch()
end

function BattleReplayPlayer:DownloadRecord()
  if self._isDownloading then
    return
  end
  self._isDownloading = true
  self:CreateDownloadTimeoutTimer()
  self:GetOssHeaderAndDownload()
  self:ShowWaitPanel()
end

function BattleReplayPlayer:ShowWaitPanel()
  local title = LT.Text("ReplayLoadingTitle")
  local content = LT.Text("ReplayLoadingTips")
  UIManager.Instance:Reopen(Urls.BattleReplayWaitPanel, title, content, function()
    UIManager.Instance:CloseByUrl(Urls.PVEReplayBattlePanel)
    UIManager.Instance:CloseByUrl(Urls.PVPReplayBattlePanel)
  end)
end

function BattleReplayPlayer:CloseWaitPanel()
  UIManager.Instance:CloseByUrl(Urls.BattleReplayWaitPanel)
end

function BattleReplayPlayer:GetOssHeaderAndDownload()
  local startTime = os.clock()
  ProtoManager.Instance:ReqServer("GameRequest", "GetOSSHeader", function(data, errcode)
    Logger.Proto("GetOSSheader", table.tostring(data))
    Logger.Info("请求OssHeader时间", os.clock() - startTime)
    if not data or not data.header then
      return
    end
    local ossUrl = self:GetRecordOssUrl(data.objName)
    local downloadStartTime = os.clock()
    E.HTTP.get(ossUrl, {
      headers = data.header
    }, function(resp)
      Logger.Info("下载战斗录像时间", os.clock() - downloadStartTime)
      self:DealDownloadContent(resp)
    end)
  end, function()
  end, self._battleUuid)
end

function BattleReplayPlayer:LoadFromLocalFile(filePath)
  if not filePath or "" == filePath then
    self:PlayFailed("文件路径为空")
    return
  end
  local file, err = io.open(filePath, "r")
  if not file then
    self:PlayFailed(string.format("无法打开文件: %s", err or filePath))
    return
  end
  local content = file:read("*a")
  file:close()
  if not content or "" == content then
    self:PlayFailed(string.format("文件为空: %s", filePath))
    return
  end
  self:DealReplayContent(content)
end

function BattleReplayPlayer:DealDownloadContent(resp)
  self._isDownloading = false
  self:ClearDownloadTimeoutTimer()
  if resp.status ~= 200 then
    Logger.Warn("oss download content failed", table.tostring(resp))
    self:PlayFailed(resp.status)
    return
  end
  local content = resp.body
  self:DealReplayContent(content)
end

function BattleReplayPlayer:DealReplayContent(content)
  local startTime = os.clock()
  local test = JSON.decode(content)
  if not test then
    self:PlayFailed("JSON 解析失败")
    return
  end
  local compStr = test.compStr
  if not compStr then
    self:PlayFailed("录像格式错误(缺少 compStr)")
    return
  end
  local decompressedData = lz4.decompress(compStr)
  if not decompressedData then
    self:PlayFailed(LT.Text("解压缩失败"))
    return
  end
  local unpackedData = cmsgpack.unpack(decompressedData)
  if not unpackedData then
    self:PlayFailed(LT.Text("解压缩失败"))
    return
  end
  self.replayData = unpackedData
  self.recordZipList = unpackedData.recordZips
  self.recordUnZipList = self:UnZipList(unpackedData.recordZips)
  self._isReady = true
  self._isDownloaded = true
  local firstRecord = table.remove(self.recordUnZipList, 1)
  self._firstRecord = firstRecord
  self._battleEngineUuid = firstRecord and firstRecord.msgData.battleEngineUuid
  Logger.Info("BattleReplayData FirstRecord:", table.tostring(firstRecord))
  self._replayStartTime = firstRecord and firstRecord.time
  Logger.Info("解压战斗录像时间", os.clock() - startTime)
  EventMgr.Instance.BattleReplayDownload:Dispatch()
end

function BattleReplayPlayer:GetRecord(recordIndex)
  return self.recordUnZipList[recordIndex]
end

function BattleReplayPlayer:UnZipList(recordZips)
  local unZippedRecords = {}
  for zipIndex, list in ipairs(recordZips) do
    local decompressedData = lz4.decompress(self.recordZipList[zipIndex])
    local unZipData = cmsgpack.unpack(decompressedData)
    for i, data in ipairs(unZipData) do
      table.insert(unZippedRecords, data)
    end
  end
  return unZippedRecords
end

function BattleReplayPlayer:SaveRecordList(unpackedData)
  local unZippedRecords = {}
  local recordZips = unpackedData.recordZips
  for zipIndex, list in ipairs(recordZips) do
    print("-------------------zipIndex and index of count", zipIndex, #list)
    local decompressedData = lz4.decompress(self.recordZipList[zipIndex])
    local unZipData = cmsgpack.unpack(decompressedData)
    for i, data in ipairs(unZipData) do
      table.insert(unZippedRecords, data)
    end
  end
  unpackedData.unZippedRecord = unZippedRecords
end

function BattleReplayPlayer:CreateDownloadTimeoutTimer()
  self:ClearDownloadTimeoutTimer()
  local timeOut = DT.GetOriginalConstant("ReplayDownloadTime", 20)
  self._timeoutTimer = TimerManager.Instance:CreateTimer(timeOut, 0, nil, function()
    self:PlayFailed(LT.Text("TimeoutText"))
  end)
end

function BattleReplayPlayer:ClearDownloadTimeoutTimer()
  if self._timeoutTimer then
    TimerManager.Instance:StopTimer(self._timeoutTimer)
    self._timeoutTimer = nil
  end
end

function BattleReplayPlayer:PlayFailed(errorCode)
  local tipsCfg = DT.TipsType.PVEReplayErrorTips
  Alert.ShowStr(string.format("%s(%s)", tipsCfg.Desc, errorCode))
  EventMgr.Instance.BattleReplayFailed:Dispatch()
end

return BattleReplayPlayer
