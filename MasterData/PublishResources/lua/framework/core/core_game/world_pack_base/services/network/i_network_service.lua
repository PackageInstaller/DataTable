_class("INetworkService", Object)
INetworkService = INetworkService

function INetworkService:ReceiveMessage(recMsg)
  error("Need Override INetworkService:ReceiveMessage")
end

function INetworkService:SendMessage(sendMsg)
  error("Need Override INetworkService:SendMessage")
end

function INetworkService:SendCommandsMessage(commands)
  error("Need Override INetworkService:SendCommandsMessage")
end

NetworkMode = {StandAlone = 1, Networks = 2}
_enum("NetworkMode", NetworkMode)
