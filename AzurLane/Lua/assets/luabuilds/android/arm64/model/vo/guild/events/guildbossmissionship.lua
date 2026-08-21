local var_0_0 = class("GuildBossMissionShip")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.super = arg_1_1

	setmetatable(arg_1_0, {
		__index = function(arg_2_0, arg_2_1)
			local var_2_0 = rawget(arg_2_0, "class")

			if var_2_0[arg_2_1] then
				return var_2_0[arg_2_1] or arg_1_1[arg_2_1]
			end
		end
	})

	return
end

function var_0_0.IsOwner(arg_3_0)
	local var_3_0 = getProxy(PlayerProxy)

	return tonumber(GuildAssaultFleet.GetUserId(arg_3_0.id)) == var_3_0:getRawData().id
end

function var_0_0.GetUniqueId(arg_4_0)
	return GuildAssaultFleet.GetRealId(arg_4_0.id)
end

function var_0_0.getProperties(arg_5_0, arg_5_1, arg_5_2)
	local var_5_9000
	local var_5_0 = getProxy(GuildProxy)
	local var_5_1 = var_5_0.getRawData(var_5_9000)
	local var_5_2 = arg_5_0.super:getProperties(arg_5_1, arg_5_2)

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		local var_5_3 = var_5_1:getShipAddition(iter_5_0, arg_5_0:getShipType())
		local var_5_4 = var_5_2[iter_5_0] or 0

		;({})[iter_5_0] = var_5_4 + var_5_3
	end

	return {}
end

return var_0_0
