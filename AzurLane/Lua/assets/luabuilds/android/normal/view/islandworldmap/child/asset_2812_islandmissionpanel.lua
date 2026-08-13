class = var_0_10000

local var_0_0 = var_0_10000("IslandMissionPanel")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	onButton = var_1_10003

	local var_1_0 = arg_1_0._event

	findTF = var_1_10005

	local var_1_1 = var_1_10005(arg_1_0._tf, "ad/confirm")

	local function var_1_2()
		local var_2_0 = arg_1_0

		var_0.onClickConfirm(var_2_0)

		return
	end

	SFX_CONFIRM = var_7

	var_1_10003(var_1_0, var_1_1, var_1_2, var_7)

	return
end

function var_0_0.setData(arg_3_0, arg_3_1)
	arg_3_0.buildType = arg_3_1

	return
end

function var_0_0.onClickConfirm(arg_4_0)
	arg_4_0:setActive(false)

	return
end

function var_0_0.setActive(arg_5_0, arg_5_1)
	setActive = var_1_10002

	var_1_10002(arg_5_0._tf, arg_5_1)

	return
end

function var_0_0.dispose(arg_6_0)
	return
end

return var_0_0
