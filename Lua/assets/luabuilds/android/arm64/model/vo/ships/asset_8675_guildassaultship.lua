local GuildAssaultShip = class("GuildAssaultShip", import(".CheckCustomNameShip"))

function GuildAssaultShip:IsOwner()
	return tonumber(GuildAssaultFleet.GetUserId(self.id)) == getProxy(PlayerProxy):getRawData().id
end

function GuildAssaultShip:GetUniqueId()
	return GuildAssaultFleet.GetRealId(self.id)
end

function GuildAssaultShip:ConverteFromShip()
	return setmetatable({}, {
		__index = function(arg_4_0, arg_4_1)
			return (GuildAssaultShip[arg_4_1] or nil) and (GuildAssaultShip[arg_4_1] or self[arg_4_1])
		end
	})
end

return GuildAssaultShip
