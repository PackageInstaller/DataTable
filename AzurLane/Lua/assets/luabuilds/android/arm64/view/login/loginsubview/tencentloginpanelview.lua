local var_0_0 = class("TencentLoginPanelView", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "TencentLoginPanelView"
end

function var_0_0.OnLoaded(arg_2_0)
	return
end

function var_0_0.SetShareData(arg_3_0, arg_3_1)
	arg_3_0.shareData = arg_3_1

	return
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.tencentPanel = arg_4_0._tf
	arg_4_0.wxLoginBtn = arg_4_0.tencentPanel:Find("wx_login")
	arg_4_0.qqLoginBtn = arg_4_0.tencentPanel:Find("qq_login")

	arg_4_0:InitEvent()

	return
end

function var_0_0.InitEvent(arg_5_0)
	onButton(arg_5_0, arg_5_0.qqLoginBtn, function()
		pg.SdkMgr.GetInstance():LoginSdk(1)

		return
	end)
	onButton(arg_5_0, arg_5_0.wxLoginBtn, function()
		pg.SdkMgr.GetInstance():LoginSdk(2)

		return
	end)

	return
end

function var_0_0.OnDestroy(arg_8_0)
	return
end

return var_0_0
