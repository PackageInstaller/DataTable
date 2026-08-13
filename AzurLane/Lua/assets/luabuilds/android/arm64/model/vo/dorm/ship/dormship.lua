class = var_0_10000

local var_0_0 = var_0_10000("DormShip")

var_0_0.FLOOR_1 = 1
var_0_0.FLOOR_2 = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.floor = arg_1_1.floor

	local var_1_0

	if not arg_1_1.pop_icon then
		var_1_0 = 0
	end

	arg_1_0.moneny = var_1_0

	local var_1_1

	if not arg_1_1.pop_intimacy then
		var_1_1 = 0
	end

	arg_1_0.intimacy = var_1_1

	return
end

function var_0_0.IsSameFloor(arg_2_0, arg_2_1)
	return arg_2_0.floor == arg_2_1
end

function var_0_0.AddmoneyAndIntimacy(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.moneny = arg_3_1
	arg_3_0.intimacy = arg_3_2

	return
end

function var_0_0.GetInimacy(arg_4_0)
	return arg_4_0.intimacy
end

function var_0_0.HasMoneyOrIntimacy(arg_5_0)
	local var_5_0

	if not arg_5_0:HasMoney() then
		var_5_0 = arg_5_0:HasIntimacy()
	end

	return var_5_0
end

function var_0_0.HasMoney(arg_6_0)
	return arg_6_0.moneny > 0
end

function var_0_0.GetMoney(arg_7_0)
	return arg_7_0.moneny
end

function var_0_0.HasIntimacy(arg_8_0)
	return arg_8_0.intimacy > 0
end

function var_0_0.GetIntimacy(arg_9_0)
	return arg_9_0.intimacy
end

function var_0_0.ClearMoneyAndIntimacy(arg_10_0)
	arg_10_0:ClearMoney()
	arg_10_0:ClearIntimacy()

	return
end

function var_0_0.ClearMoney(arg_11_0)
	arg_11_0.moneny = 0

	return
end

function var_0_0.ClearIntimacy(arg_12_0)
	arg_12_0.intimacy = 0

	return
end

function var_0_0.IsSame(arg_13_0, arg_13_1)
	return arg_13_0.id == arg_13_1
end

function var_0_0.ToBayShip(arg_14_0)
	getProxy = var_1_10001
	BayProxy = var_1_10003

	local var_14_0 = var_1_10001(var_1_10003)

	return (var_1.RawGetShipById(var_14_0, arg_14_0.id))
end

return var_0_0
