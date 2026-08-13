class = var_0_10000

local var_0_0 = "MainBasePanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.contextData = arg_1_3
	arg_1_0.btns = arg_1_0:GetBtns()

	arg_1_0:Register()

	return
end

function var_0_1.Init(arg_2_0)
	ipairs = var_1_10001

	for iter_2_0, iter_2_1 in var_1_10001(arg_2_0.btns) do
		onButton = var_1_10006

		local var_2_0 = arg_2_0
		local var_2_1 = iter_2_1:GetTarget()

		local function var_2_2()
			local var_3_0 = iter_2_1

			var_0.OnClick(var_3_0)

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_2_0, var_2_1, var_2_2, var_1_10010)
		iter_2_1:Flush(true)
	end

	return
end

function var_0_1.Register(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.bind

	PlayerProxy = var_1_10003

	var_4_1(var_4_0, var_1_10003.UPDATED, function(arg_5_0)
		local var_5_0 = arg_4_0

		var_1.Refresh(var_5_0)

		return
	end)

	return
end

function var_0_1.Refresh(arg_6_0)
	ipairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0.btns) do
		iter_6_1:Flush(false)
	end

	return
end

function var_0_1.Dispose(arg_7_0)
	var_0_1.super.Dispose(arg_7_0)

	ipairs = var_1

	for iter_7_0, iter_7_1 in var_1(arg_7_0.btns) do
		iter_7_1:Dispose()
	end

	arg_7_0.btns = {}

	arg_7_0:OnDispose()

	return
end

function var_0_1.GetBtns(arg_8_0)
	return {}
end

function var_0_1.OnDispose(arg_9_0)
	return
end

return var_0_1
