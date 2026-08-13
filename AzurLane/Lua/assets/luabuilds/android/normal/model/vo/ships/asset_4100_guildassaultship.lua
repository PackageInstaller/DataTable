class = var_0_10000

local var_0_0 = "GuildAssaultShip"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CheckCustomNameShip"))

function var_0_1.IsOwner(arg_1_0)
	tonumber = var_1_10001
	GuildAssaultFleet = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002.GetUserId(arg_1_0.id))

	getProxy = var_2
	PlayerProxy = var_3

	local var_1_1 = var_2(var_3)

	return var_1_0 == var_2.getRawData(var_1_1).id
end

function var_0_1.GetUniqueId(arg_2_0)
	GuildAssaultFleet = var_1_10001

	return var_1_10001.GetRealId(arg_2_0.id)
end

function var_0_1.ConverteFromShip(arg_3_0)
	setmetatable = var_1_10001

	return var_1_10001({}, {
		__index = function(arg_4_0, arg_4_1)
			local var_4_0

			if not var_0_1[arg_4_1] or not var_0_1[arg_4_1] then
				var_4_0 = arg_3_0[arg_4_1]
			end

			return var_4_0
		end
	})
end

return var_0_1
