_class("GameRecorder", Object)
GameRecorder = GameRecorder
GameRecordAction = {
  StartMatch = 1,
  UIInput = 2,
  TouchInput = 3,
  NetInput = 4,
  MatchResult = 5
}
_enum("GameRecordAction", GameRecordAction)

function GameRecorder:Constructor()
  self._record = nil
  self._lastPoint = nil
  self._disableRecoder = true
end

function GameRecorder:Dispose()
  self._record = nil
end

function GameRecorder:StartRecord()
  if self._disableRecoder then
    return
  end
  Log.debug("GameRecorder:StartRecord() ---------------")
  self._record = {}
  self._startTime = GameGlobal:GetInstance():GetCurrentTime()
  local dir = EngineGameHelper.StoragePath .. "GameRecordLog/"
  App.MakeDir(dir)
  self._filePath = dir .. "GameRecordLog" .. os.date("%y%m%d%H%M%S") .. ".lua"
end

function GameRecorder:StopRecord()
  if self._disableRecoder then
    return
  end
  Log.debug("GameRecorder:StopRecord() ---------------")
  local file = io.open(self._filePath, "w")
  local out = echo(self._record)
  file:write(out)
  io.close(file)
  self._record = nil
end

function GameRecorder:RecordAction(action, params)
  if self._disableRecoder then
    return
  end
  local isAutoFighting = BattleStatHelper.GetAutoFightStat()
  if isAutoFighting then
    return
  end
  if action == GameRecordAction.TouchInput and params.input == "Dragging" then
    if params.hitPoint == self._lastPoint then
      return
    else
      self._lastPoint = params.hitPoint
    end
  end
  local t = self._record
  t[#t + 1] = {
    time = GameGlobal:GetInstance():GetCurrentTime() - self._startTime,
    action = action,
    actionName = GetEnumKey("GameRecordAction", action)
  }
  table.append(t[#t], params)
end
