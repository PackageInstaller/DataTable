class = var_0_10000

local var_0_0 = "TencentLoginPanelView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "TencentLoginPanelView"
end

function var_0_1.OnLoaded(arg_2_0)
	return
end

function var_0_1.SetShareData(arg_3_0, arg_3_1)
	arg_3_0.shareData = arg_3_1

	return
end

function var_0_1.OnInit(arg_4_0)
	arg_4_0.tencentPanel = arg_4_0._tf

	local var_4_0 = arg_4_0.tencentPanel

	arg_4_0.wxLoginBtn = var_1.Find(var_4_0, "wx_login")

	local var_4_1 = arg_4_0.tencentPanel

	arg_4_0.qqLoginBtn = var_1.Find(var_4_1, "qq_login")

	arg_4_0:InitEvent()

	return
end

function var_0_1.InitEvent(arg_5_0)
	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.qqLoginBtn, function()
		pg = var_2_10000

		local var_6_0 = var_2_10000.SdkMgr.GetInstance()

		var_0.LoginSdk(var_6_0, 1)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.wxLoginBtn, function()
		pg = var_2_10000

		local var_7_0 = var_2_10000.SdkMgr.GetInstance()

		var_0.LoginSdk(var_7_0, 2)

		return
	end)

	return
end

function var_0_1.OnDestroy(arg_8_0)
	return
end

return var_0_1
