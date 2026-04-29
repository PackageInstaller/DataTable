_class("TestStartupParam", Object)
TestStartupParam = TestStartupParam

function TestStartupParam:Constructor()
  self._taskTicketArray = {}
  self._currentTaskIndex = 0
end

function TestStartupParam:AddTask(missionID, formationOption)
  local ticket = {missionID = missionID}
  if type(formationOption) == "table" and 0 < #formationOption then
    local formations = {}
    for optionIndex, raw in ipairs(formationOption) do
      local options = string.split(raw, ",")
      if not options or #options < 6 then
        Log.error(self._className, string.format("invalid formation option on %s: missing one or more argument(s): %s", tostring(optionIndex), tostring(raw)))
        return
      end
      local petBuildData = TestRobotPetBuildData:New(table.unpack(options))
      petBuildData:SanityFix()
      table.insert(formations, petBuildData)
    end
  end
  table.insert(self._taskTicketArray, ticket)
end

function TestStartupParam:GetCurrentTask()
  return self._taskTicketArray[self._currentTaskIndex]
end

function TestStartupParam:TickTaskTicketIndex()
  self._currentTaskIndex = self._currentTaskIndex + 1
end

function TestStartupParam:GetProgressRawPercentage()
  return self._currentTaskIndex / #self._taskTicketArray
end
