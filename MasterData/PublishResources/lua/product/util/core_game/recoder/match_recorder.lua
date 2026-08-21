_class("MatchRecorder", Object)
MatchRecorder = MatchRecorder

function MatchRecorder:Constructor()
  self._record = nil
  self._disableRecord = true
end

function MatchRecorder:Dispose()
  self._record = nil
end

function MatchRecorder:GetRecord()
  local t = self._record
  self._record = nil
  return t
end

function MatchRecorder:RecoredStartMatch(time, matchEnterData)
  if self._disableRecord then
    return
  end
  self._record = {}
  self._startTime = time
  local t = self._record
  t[#t + 1] = {
    time = 0,
    ts = os.date("%X") .. Log.currentPlayerInfo,
    action = GameRecordAction.StartMatch,
    actionName = "StartMatch",
    match_enter_data = matchEnterData
  }
end

function MatchRecorder:RecordCommand(time, cmd)
  if not self._record then
    return
  end
  local t = self._record
  t[#t + 1] = {
    time = time - self._startTime,
    ts = os.date("%X") .. Log.currentPlayerInfo,
    action = GameRecordAction.NetInput,
    actionName = "NetInput",
    cmd = cmd
  }
end
