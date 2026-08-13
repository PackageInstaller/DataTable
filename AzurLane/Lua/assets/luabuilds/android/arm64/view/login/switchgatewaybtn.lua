class = var_0_10000

local var_0_0 = var_0_10000("SwitchGatewayBtn")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tr = arg_1_1
	arg_1_0._go = arg_1_1.gameObject
	setActive = var_2

	var_2(arg_1_0._go, false)

	return
end

function var_0_0.Flush(arg_2_0)
	getProxy = var_1_10001
	UserProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)
	local var_2_1 = var_1.ShowGatewaySwitcher(var_2_0)

	setActive = var_1_10002

	var_1_10002(arg_2_0._go, var_2_1)

	if var_2_1 then
		arg_2_0:RegistSwicher()
	end

	return
end

function var_0_0.RegistSwicher(arg_3_0)
	getProxy = var_1_10001
	UserProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)
	local var_3_1 = var_1.getLastLoginUser(var_3_0)

	onButton = var_1_10003

	local var_3_2
	local var_3_3 = arg_3_0._go

	local function var_3_4()
		pg = var_2_10000

		local var_4_0 = var_2_10000.m02
		local var_4_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_4_2 = var_2_10003.SERVER_INTERCOMMECTION
		local var_4_3 = {
			user = var_3_1
		}
		local var_4_4 = var_0

		var_4_3.platform = var_5.GetReversePlatform(var_4_4)

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_3_2, var_3_3, var_3_4, var_1_10008)

	arg_3_0.isRegist = true

	return
end

function var_0_0.Dispose(arg_5_0)
	if arg_5_0.isRegist then
		removeOnButton = var_1

		var_1(arg_5_0._go)

		arg_5_0.isRegist = nil
	end

	return
end

return var_0_0
