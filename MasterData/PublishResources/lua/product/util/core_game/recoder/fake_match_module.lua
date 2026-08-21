require("game_module")
_class("FakeMatchModule", GameModule)
FakeMatchModule = FakeMatchModule

function FakeMatchEnterCoreGame(t)
  local md = GameGlobal.GetModule(FakeMatchModule)
  md:EnterCoreGame(t)
end

function FakeMatchModule:Constructor()
  self._record = nil
  self._startTime = nil
  self._running = false
end

function FakeMatchModule:Dispose()
  self:ClearMatchEnterData()
end

function FakeMatchModule:ClearMatchEnterData()
  self._record = nil
  self._startTime = nil
  self._running = false
end

function FakeMatchModule:GetRecord()
  return self._record
end

function FakeMatchModule:GetMatchStartTime()
  return self._startTime
end

function FakeMatchModule:IsRunning()
  return self._running
end

function FakeMatchModule:EnterCoreGame(record)
  GameGlobal:GetInstance():SetOfflineMatch(true)
  self._record = record
  self._startTime = GameGlobal:GetInstance():GetCurrentTime()
  self._running = true
  for i, v in ipairs(record) do
    if v.action == GameRecordAction.StartMatch then
      local enterData = table_to_class(v.match_enter_data)
      GameGlobal.GetModule(MatchModule):SetMatchEnterData(enterData)
    end
  end
  GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Battle_Loading)
end

function FakeMatchModule:ExitCoreGame()
  self:ClearMatchEnterData()
  GameGlobal:GetInstance():SetOfflineMatch(false)
end
