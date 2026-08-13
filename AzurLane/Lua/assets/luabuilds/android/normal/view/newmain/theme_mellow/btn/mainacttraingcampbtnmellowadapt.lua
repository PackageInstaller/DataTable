class = var_0_10000

local var_0_0 = "MainActTraingCampBtnMellowAdapt"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainDifferentStyleSpActBtnAdapt"))

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
		"COMMANDER_MANUAL"
	}, function(arg_3_0)
		TechnologyConst = var_2_10001

		local var_3_0, var_3_1 = var_2_10001.isTecActOn()

		setActive = var_2_10003

		local var_3_2 = arg_3_0

		getProxy = var_2_10005
		CommanderManualProxy = var_2_10006

		local var_3_3 = var_2_10005(var_2_10006)
		local var_3_4

		if not var_5.ShouldShowTaskOrGuideTip(var_3_3) then
			var_3_4 = var_3_1
		end

		var_2_10003(var_3_2, var_3_4)

		return
	end)

	local var_2_2 = arg_2_0._tf

	var_1.SetAsFirstSibling(var_2_2)

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
