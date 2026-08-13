class = var_0_10000

local var_0_0 = "MainActNewServerBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseSpcailActBtn"))

function var_0_1.GetContainer(arg_1_0)
	local var_1_0 = arg_1_0.root.parent

	return var_1.Find(var_1_0, "link_top/layout")
end

function var_0_1.InShowTime(arg_2_0)
	NewServerCarnivalScene = var_1_10001

	return var_1_10001.isShow()
end

function var_0_1.GetUIName(arg_3_0)
	return "MainUINewServerBtn"
end

function var_0_1.OnClick(arg_4_0)
	local var_4_0 = arg_4_0.event
	local var_4_1 = var_1.emit

	NewMainMediator = var_1_10003

	local var_4_2 = var_1_10003.GO_SCENE

	SCENE = var_1_10004

	var_4_1(var_4_0, var_4_2, var_1_10004.NEW_SERVER_CARNIVAL)

	return
end

function var_0_1.OnRegister(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.redDotUI = var_1.Find(var_5_0, "tip")
	pg = var_1

	local var_5_1 = var_1.EasyRedDotMgr.GetInstance()

	var_1.RegisterRedDot(var_5_1, arg_5_0.redDotUI, {
		"NEW_SERVER"
	}, function(arg_6_0)
		setActive = var_2_10001

		local var_6_0 = arg_6_0

		NewServerCarnivalScene = var_2_10003

		var_2_10001(var_6_0, var_2_10003.isTip())

		return
	end)

	return
end

function var_0_1.OnClear(arg_7_0)
	if arg_7_0.redDotUI then
		pg = var_1

		local var_7_0 = var_1.EasyRedDotMgr.GetInstance()

		var_1.UnRegisterRedDot(var_7_0, arg_7_0.redDotUI)

		arg_7_0.redDotUI = nil
	end

	return
end

return var_0_1
