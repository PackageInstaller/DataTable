_class("LuaAppEvent", Object)
LuaAppEvent = LuaAppEvent
LuaEventType = LuaEventType

function LuaAppEvent:EventType()
end

function LuaAppEvent:Encrypt()
end

function LuaAppEvent:Reliable()
end

_class("CPushEvent", LuaAppEvent)
CPushEvent = CPushEvent

function CPushEvent:EventType()
  return LuaEventType.LMT_PushEvent
end

function CPushEvent:Encrypt()
  return true
end

function CPushEvent:Reliable()
  return true
end

_class("CCallEvent", LuaAppEvent)
CCallEvent = CCallEvent

function CCallEvent:Encrypt()
  return true
end

function CCallEvent:Reliable()
  return true
end

function CCallEvent:Constructor()
  self.flag = 0
end

_class("CCallRequestEvent", CCallEvent)
CCallRequestEvent = CCallRequestEvent

function CCallRequestEvent:EventType()
  return LuaEventType.LMT_CallRequestEvent
end

_class("CCallReplyEvent", CCallEvent)
CCallReplyEvent = CCallReplyEvent

function CCallReplyEvent:EventType()
  return LuaEventType.LMT_CallReplyEvent
end

_class("CSvrPushEvent", CPushEvent)
CSvrPushEvent = CSvrPushEvent

function CSvrPushEvent:EventType()
  return LuaEventType.LMT_SvrPushEvent
end

function CSvrPushEvent:Reliable()
  return true
end

_class("CCliPushEvent", CPushEvent)
CCliPushEvent = CCliPushEvent

function CCliPushEvent:EventType()
  return LuaEventType.LMT_CliPushEvent
end

function CCliPushEvent:Reliable()
  return true
end

_class("CMatchPushEvent", CPushEvent)
CMatchPushEvent = CMatchPushEvent

function CMatchPushEvent:EventType()
  return LuaEventType.LMT_MatchPushEvent
end

function CMatchPushEvent:Encrypt()
  return true
end

function CMatchPushEvent:Reliable()
  return true
end
