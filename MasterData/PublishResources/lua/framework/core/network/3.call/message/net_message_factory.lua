_class("NetMessageFactory", Singleton)
NetMessageFactory = NetMessageFactory

function NetMessageFactory:Constructor()
  self.msgObjs = {}
end

function NetMessageFactory:RegisterMessage(msg)
  if self.msgObjs[msg.clsid] then
    Log.fatal("NetMessageFactory:RegisterMessage duplicated clsid class ", msg._className, " clsid ", msg.clsid)
  end
  self.msgObjs[msg.clsid] = msg
end

function NetMessageFactory:RegisterEvents()
  Log.debug("RegisterEvents")
  for k, v in pairs(self.msgObjs) do
    NetCallerLua.RegisterEvents(v.clsid, v:EventType(), v:Encrypt(), v:Reliable(), v._className)
  end
end

function NetMessageFactory:CreateMessageWithId(clsid)
  local msg = self.msgObjs[clsid]
  if msg then
    return msg:New()
  else
    Log.fatal("unknown message with clsid: ", clsid)
  end
end

function NetMessageFactory:CreateMessage(type, ...)
  return type:New()
end
