local GuildBossMissionShip = class("GuildBossMissionShip")

function GuildBossMissionShip:Ctor(arg_1_1)
	self.super = arg_1_1

	setmetatable(self, {
		__index = function(arg_2_0, arg_2_1)
			local var_2_0 = rawget(arg_2_0, "class")

			return (var_2_0[arg_2_1] or nil) and (var_2_0[arg_2_1] or arg_1_1[arg_2_1])
		end
	})

	return
end

function GuildBossMissionShip:IsOwner()
	return tonumber(GuildAssaultFleet.GetUserId(self.id)) == getProxy(PlayerProxy):getRawData().id
end

function GuildBossMissionShip:GetUniqueId()
	return GuildAssaultFleet.GetRealId(self.id)
end

function GuildBossMissionShip:getProperties(arg_5_1, arg_5_2)
	local var_5_0 = getProxy(GuildProxy)
	local var_5_1 = var_5_0:getRawData()
	local var_5_2 = {}
	local var_5_3 = self.super:getProperties(arg_5_1, arg_5_2)

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		var_5_2[iter_5_0] = ((not var_5_3[iter_5_0] or nil) and 0) + var_5_1:getShipAddition(iter_5_0, self:getShipType())
	end

	return var_5_2
end

return GuildBossMissionShip
