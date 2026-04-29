_class("DummyServer", Object)
DummyServer = DummyServer

function DummyServer:Constructor()
  self.messages = ArrayList:New()
  self.network = nil
end

function DummyServer:SetNetworkService(network)
  self.network = network
end

function DummyServer:ReceiveMessage(networkMessage)
  self.messages:PushBack(networkMessage)
end

function DummyServer:BroadcastMessage()
  for i = 1, self.messages:Size() do
    local msg = self.messages:GetAt(i)
    self.network:ReceiveMessage(msg)
  end
  self.messages:Clear()
end

function DummyServer:Update(deltaTimeMS)
  self:BroadcastMessage()
end
