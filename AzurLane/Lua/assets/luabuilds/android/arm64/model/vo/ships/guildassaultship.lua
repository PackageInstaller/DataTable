local var_0_0 = class("GuildAssaultShip", import(".CheckCustomNameShip"))

function var_0_0.IsOwner(arg_1_0)
	local var_1_0 = getProxy(PlayerProxy)

	return tonumber(GuildAssaultFleet.GetUserId(arg_1_0.id)) == var_1_0:getRawData().id
end

function var_0_0.GetUniqueId(arg_2_0)
	return GuildAssaultFleet.GetRealId(arg_2_0.id)
end

function var_0_0.ConverteFromShip(arg_3_0)
	return setmetatable({}, {
		__index = function(arg_4_0, arg_4_1)
			if var_0_0[arg_4_1] then
				return var_0_0[arg_4_1] or arg_3_0[arg_4_1]
			end
		end
	})
end

return var_0_0
