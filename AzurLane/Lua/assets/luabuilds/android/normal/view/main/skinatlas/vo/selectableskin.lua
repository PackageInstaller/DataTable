class = var_0_10000

local var_0_0 = var_0_10000("SelectableSkin")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.skinId = arg_1_1.id
	arg_1_0.isTimeLimit = arg_1_1.isTimeLimit
	getProxy = var_2
	ShipSkinProxy = var_1_10003

	local var_1_0 = var_2(var_1_10003)

	arg_1_0.own = var_2.hasSkin(var_1_0, arg_1_0.skinId)

	return
end

function var_0_0.IsTimeLimit(arg_2_0)
	return arg_2_0.isTimeLimit
end

function var_0_0.OwnSkin(arg_3_0)
	return arg_3_0.own
end

function var_0_0.ToShipSkin(arg_4_0)
	ShipSkin = var_1_10001

	return var_1_10001.New({
		id = arg_4_0.skinId
	})
end

function var_0_0.GetTimeLimitWeight(arg_5_0)
	return arg_5_0:IsTimeLimit() and 1 or 0
end

function var_0_0.GetOwnWeight(arg_6_0)
	return arg_6_0:OwnSkin() and 0 or 1
end

return var_0_0
