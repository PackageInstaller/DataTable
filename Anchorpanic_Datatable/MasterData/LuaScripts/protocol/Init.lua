module("protocol.Init", package.seeall)

function init()
    _G.Protocol = {}
    local protocolList = {
        "AccountProtocol",
        "BattleProtocol",
        "PlayerProtocol",
        "SysProtocol",
        "BagProtocol",
        "MailProtocol",
        "HeroProtocol",
        "PveProtocol",
        "DupProtocol",
        "WelfareProtocol",
        "FriendProtocol",
        "ForcesProtocol",
        "MainExploreProtocol",
        "GuildProtocol"
    }
    
    LuaUtil:reRequire("protocol/ProtocolType")
	for _, file in pairs(protocolList) do
		registerProtocol(file)
	end
end

function registerProtocol(protocolName)
    local _protocol = LuaUtil:reRequire(string.format("protocol/%s", protocolName))
    for protoName, template in pairs(_protocol) do
        local prefix = protoName:sub(1, 3)
        if prefix == "CS_" or prefix == "SC_" then
            local packetId = template[1]
            assert(type(packetId) == "number", protoName .. " Invalid packetId")
            assert(Protocol[protoName] == nil, protoName .. " Already exist")
            Protocol[protoName] = template;
        end
    end
end

return _M
