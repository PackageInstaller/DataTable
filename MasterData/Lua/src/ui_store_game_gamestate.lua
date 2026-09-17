local this = {}

function this:init()
  self.super.init(self)
  self.data = {
    serverList = {},
    isEntered = false,
    serverToken = nil
  }
end

function this:getServers()
end

function this:getServerById(serverId)
end

function this:getServerToken()
  return self.data.serverToken
end

return this
