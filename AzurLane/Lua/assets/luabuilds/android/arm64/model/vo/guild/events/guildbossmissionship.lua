class = var_0_10000

local var_0_0 = var_0_10000("GuildBossMissionShip")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.super = arg_1_1
	setmetatable = var_1_10002

	var_1_10002(arg_1_0, {
		__index = function(arg_2_0, arg_2_1)
			rawget = var_2_10002

			local var_2_0

			if not var_2_10002(arg_2_0, "class")[arg_2_1] or not var_2[arg_2_1] then
				var_2_0 = arg_1_1[arg_2_1]
			end

			return var_2_0
		end
	})

	return
end

function var_0_0.IsOwner(arg_3_0)
	tonumber = var_1_10001
	GuildAssaultFleet = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003.GetUserId(arg_3_0.id))

	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_3_1 = var_1_10002(var_1_10004)

	return var_3_0 == var_2.getRawData(var_3_1).id
end

function var_0_0.GetUniqueId(arg_4_0)
	GuildAssaultFleet = var_1_10001

	return var_1_10001.GetRealId(arg_4_0.id)
end

function var_0_0.getProperties(arg_5_0, arg_5_1, arg_5_2)
	getProxy = var_1_10003
	GuildProxy = var_1_10005

	local var_5_0 = var_1_10003(var_1_10005)
	local var_5_1 = var_3.getRawData(var_5_0)
	local var_5_2 = {}
	local var_5_3 = arg_5_0.super
	local var_5_4 = var_5.getProperties(var_5_3, arg_5_1, arg_5_2)

	pairs = var_1_10006

	for iter_5_0, iter_5_1 in var_1_10006(var_5_4) do
		local var_5_5 = var_5_1:getShipAddition(iter_5_0, arg_5_0:getShipType())
		local var_5_6

		if not var_5_4[iter_5_0] then
			var_5_6 = 0
		end

		var_5_2[iter_5_0] = var_5_6 + var_5_5
	end

	return var_5_2
end

return var_0_0
