require("main_world")
_class("ClientWorld", MainWorld)
ClientWorld = ClientWorld

function ClientWorld:Constructor(worldInfo)
  self._networkMode = worldInfo.network_mode
  if self._networkMode == NetworkMode.StandAlone then
    self.DummyServer = DummyServer:New()
  end
  self._runningPosition = WorldRunPostion.AtClient
  self._aiLogger = AILogger:New(self)
  if EDITOR then
    self._aiDebugModule = GameGlobal.GetModule(AIDebugModule)
  end
end

function ClientWorld:EnterWorld()
  ClientWorld.super.EnterWorld(self)
  local sev_network = self.BW_Services:GetService("Network")
  if self._networkMode == NetworkMode.StandAlone then
    local server = self.DummyServer
    server:SetNetworkService(sev_network)
    sev_network:SetDummyServer(server)
  end
end

function ClientWorld:EventDispatcher()
  return GameGlobal.EventDispatcher()
end

function ClientWorld:IDGenerator()
  return GameGlobal.GameEventListenerIDGenerator()
end

function ClientWorld:UpdateWorld(deltaTimeMS)
  ClientWorld.super.UpdateWorld(self, deltaTimeMS)
  if self.DummyServer ~= nil then
    self.DummyServer:Update(deltaTimeMS)
  end
end

function ClientWorld:GetWorldTimer()
  return GameGlobal.Timer()
end

function ClientWorld:IsDevelopEnv()
  return Log.loglevel < ELogLevel.None
end

function ClientWorld:GetAILogger()
  return self._aiLogger
end

function ClientWorld:GetAIDebugModule()
  return self._aiDebugModule
end
