_class("MatchNetworkService", INetworkService)

function MatchNetworkService:Constructor(world)
  self._world = world
  self._runningPosition = self._world:GetRunningPosition()
  if self._runningPosition == WorldRunPostion.AtClient then
    self._matchModule = GameGlobal.GetModule(MatchModule)
    self._checkCommand = false
  else
    local serverWorld = self._world
    self._coreGameLogic = serverWorld:GetCoreGameLogic()
    self._checkCommand = true
  end
end

function MatchNetworkService:ReceiveMessage(ev)
  if self._checkCommand and not is_table_string(ev.cmd) then
    Log.error("command is not echo table! ", ev.cmd)
    return
  end
  local ok, cmd = xpcall(ohce, function()
    Log.error("command invalid! ", ev.cmd)
  end, ev.cmd)
  if ok then
    local commands = ArrayList:New()
    commands:PushBack(cmd)
    self._world:WorldHandleCommands(commands)
  end
end

function MatchNetworkService:ClientHandleCommands(commands)
  self._world:WorldHandleCommands(commands)
end

function MatchNetworkService:SendMessage(msg)
  if self._runningPosition == WorldRunPostion.AtClient then
    self._matchModule:Push(msg)
  else
    local playerPstID = self._world.BW_WorldInfo:GetPlayerPstID()
    self._coreGameLogic:SendEvent(msg, playerPstID)
  end
end

function MatchNetworkService:SendCommandsMessage(commands)
  if commands:Size() == 0 then
    return
  end
  if self._runningPosition == WorldRunPostion.AtClient then
    self:ClientHandleCommands(commands)
  end
  for i = 1, commands:Size() do
    local cmd = commands:GetAt(i)
    local msg = cmd:ToNetMessage()
    self:SendMessage(msg)
  end
end
