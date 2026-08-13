class = var_0_10000

local var_0_0 = "MainActRefluxBtnMellowAdapt"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainDifferentStyleSpActBtnAdapt"))

function var_0_1.GetContainer(arg_1_0)
	local var_1_0 = arg_1_0.root

	return var_1.Find(var_1_0, "left/list")
end

function var_0_1.OnRegister(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.redDotUI = var_1.Find(var_2_0, "tip")
	pg = var_1

	local var_2_1 = var_1.EasyRedDotMgr.GetInstance()

	var_1.RegisterRedDot(var_2_1, arg_2_0.redDotUI, {
		"ACT_RETURN"
	}, function(arg_3_0)
		setActive = var_2_10001

		local var_3_0 = arg_3_0

		RefluxTaskView = var_2_10004

		local var_3_1

		if not var_2_10004.isAnyTaskCanGetAward() then
			RefluxPTView = var_3_1

			if not var_3_1.isAnyPTCanGetAward() then
				RefluxShopView = var_3_1
				var_3_1 = var_3_1.isShowRedPot()
			end
		end

		var_2_10001(var_3_0, var_3_1)

		return
	end)

	return
end

function var_0_1.OnClear(arg_4_0)
	if arg_4_0.redDotUI then
		pg = var_1

		local var_4_0 = var_1.EasyRedDotMgr.GetInstance()

		var_1.UnRegisterRedDot(var_4_0, arg_4_0.redDotUI)

		arg_4_0.redDotUI = nil
	end

	return
end

return var_0_1
