class = var_0_10000

local var_0_0 = "MainActDelegationBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseSpcailActBtn"))

function var_0_1.GetContainer(arg_1_0)
	local var_1_0 = arg_1_0.root.parent

	return var_1.Find(var_1_0, "eventPanel")
end

function var_0_1.InShowTime(arg_2_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)
	local var_2_1 = var_1.getActivityById

	ActivityConst = var_1_10003

	local var_2_2

	if not var_2_1(var_2_0, var_1_10003.RYZA_TASK) or not var_1:getConfig("config_client").hide_main_btn then
		var_2_2 = nil
	end

	return var_1 and not var_1:isEnd() and var_2_2 ~= 1
end

function var_0_1.GetUIName(arg_3_0)
	return "MainActDelegationBtn"
end

function var_0_1.OnClick(arg_4_0)
	local var_4_0 = arg_4_0.event
	local var_4_1 = var_1.emit

	NewMainMediator = var_1_10003

	local var_4_2 = var_1_10003.GO_SCENE

	SCENE = var_1_10004

	var_4_1(var_4_0, var_4_2, var_1_10004.RYZA_TASK)

	return
end

function var_0_1.OnInit(arg_5_0)
	setAnchoredPosition = var_1_10001

	var_1_10001(arg_5_0._tf, {
		x = 200,
		y = 220
	})

	return
end

function var_0_1.OnRegister(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.redDotUI = var_1.Find(var_6_0, "tip")
	pg = var_1

	local var_6_1 = var_1.EasyRedDotMgr.GetInstance()

	var_1.RegisterRedDot(var_6_1, arg_6_0.redDotUI, {
		"RYZA_TASK"
	}, function(arg_7_0)
		setActive = var_2_10001

		local var_7_0 = arg_7_0

		getProxy = var_2_10003
		ActivityTaskProxy = var_2_10004

		local var_7_1 = var_2_10003(var_2_10004)
		local var_7_2 = var_3.getActTaskTip

		ActivityConst = var_2_10005

		var_2_10001(var_7_0, var_7_2(var_7_1, var_2_10005.RYZA_TASK))

		return
	end)

	return
end

function var_0_1.OnClear(arg_8_0)
	if arg_8_0.redDotUI then
		pg = var_1

		local var_8_0 = var_1.EasyRedDotMgr.GetInstance()

		var_1.UnRegisterRedDot(var_8_0, arg_8_0.redDotUI)

		arg_8_0.redDotUI = nil
	end

	return
end

return var_0_1
