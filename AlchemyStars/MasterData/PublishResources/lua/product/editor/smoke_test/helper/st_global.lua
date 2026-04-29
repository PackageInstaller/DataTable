if not EDITOR then
  return
end

function TestRobotStartup(rawParam)
  local tmodule = GameGlobal.GetModule(TestRobotModule)
  tmodule:StartAutoTestTask(rawParam)
end

function ST_ExceptionHandler(message)
  local stModule = GameGlobal.GetModule(TestRobotModule)
  stModule:Exception_DeclareExceptionThrew(message)
end

function sttraceon(tag)
end

function sttrace(msg)
end

function sttraceoff()
end
