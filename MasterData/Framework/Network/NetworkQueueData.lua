local NetworkQueueData = class("NetworkQueueData")

function NetworkQueueData:InitNetworkQueueData(...)
  self.datas = {
    ...
  }
end

function NetworkQueueData:ResetNetworkQueueData()
  table.clearmap(self.datas)
end

return NetworkQueueData
