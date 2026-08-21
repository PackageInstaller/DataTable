_staticClass("NetCallerRegister")

function NetCallerRegister:RegCallers(callCenter)
  callCenter:AddCallerLua(NetCallerBulletin, "bulletin")
  callCenter:AddCallerLua(NetCallerGateway, "gateway")
  callCenter:AddCallerLua(NetCallerGame, "game")
  callCenter:AddCallerLua(NetCallerMatch, "match")
  callCenter:AddCallerLua(NetCallerRoom, "room")
  callCenter:AddCallerLua(NetCallerGMTool, "gm_proxy")
end
