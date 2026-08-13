class = var_0_10000

local var_0_0 = "BaseTotalRewardPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "BaseTotalRewardPanel"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.window = var_1.Find(var_2_0, "Window")

	local var_2_1 = arg_2_0.window

	arg_2_0.boxView = var_1.Find(var_2_1, "Layout/Box/ScrollView")

	local var_2_2 = arg_2_0.window

	arg_2_0.emptyTip = var_1.Find(var_2_2, "Layout/Box/EmptyTip")
	setText = var_1

	local var_2_3 = arg_2_0.emptyTip

	i18n = var_4

	var_1(var_2_3, var_4("autofight_rewards_none"))

	setText = var_1

	local var_2_4 = arg_2_0.window

	var_1(var_3.Find(var_2_4, "Fixed/top/bg/obtain/title"), arg_2_0.contextData.title)

	setText = var_1

	local var_2_5 = arg_2_0.window

	var_1(var_3.Find(var_2_5, "Fixed/top/bg/obtain/title/title_en"), arg_2_0.contextData.subTitle)

	setText = var_1

	local var_2_6 = arg_2_0.window
	local var_2_7 = var_3.Find(var_2_6, "Fixed/ButtonGO/pic")

	i18n = var_4

	var_1(var_2_7, var_4("autofight_onceagain"))

	setText = var_1

	local var_2_8 = arg_2_0.window
	local var_2_9 = var_3.Find(var_2_8, "Fixed/ButtonExit/pic")

	i18n = var_4

	var_1(var_2_9, var_4("autofight_leave"))

	return
end

function var_0_1.didEnter(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)
	arg_3_0:UpdateView()

	return
end

function var_0_1.willExit(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_0, arg_4_0._tf)

	return
end

function var_0_1.UpdateView(arg_5_0)
	local var_5_0 = arg_5_0.contextData

	onButton = var_1_10002

	local var_5_1 = arg_5_0
	local var_5_2 = arg_5_0._tf

	var_1_10002(var_5_1, var_5.Find(var_5_2, "BG"), function()
		existCall = var_2_10000

		var_2_10000(var_5_0.onClose)

		local var_6_0 = arg_5_0

		var_0.closeView(var_6_0)

		return
	end)

	return
end

function var_0_1.HandleShowMsgBox(arg_7_0, arg_7_1)
	pg = var_1_10002

	local var_7_0 = var_1_10002.MsgboxMgr.GetInstance()

	var_2.ShowMsgBox(var_7_0, arg_7_1)

	return
end

return var_0_1
