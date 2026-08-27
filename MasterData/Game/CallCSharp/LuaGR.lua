LuaGR = {}

function LuaGR.MsgCenterBroadcast(eventType, ...)
  MsgCenter:Broadcast(eventType, ...)
end

function LuaGR.RequireAndNew(name)
  return require(name).New()
end

function LuaGR.CS_GM_GMOperation(id, param)
  local network = NetworkManager:GetNetwork(NetworkTypeID.GM)
  network:CS_GM_GMOperation(id, param)
end
