class = var_0_10000

local var_0_0 = "PtAwardLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "ActivitybonusWindow_btnVariant"
end

function var_0_1.init(arg_2_0)
	PtAwardWindow = var_1_10001
	arg_2_0.window = var_1_10001.New(arg_2_0._tf, arg_2_0)

	function arg_2_0.window.Hide()
		local var_3_0 = arg_2_0

		var_0.Hide(var_3_0)

		return
	end

	local var_2_0 = arg_2_0._tf

	arg_2_0.btn_banned = var_1.Find(var_2_0, "window/btn_banned")

	local var_2_1 = arg_2_0._tf

	arg_2_0.btn_get = var_1.Find(var_2_1, "window/btn_get")

	local var_2_2 = arg_2_0._tf

	arg_2_0.btn_got = var_1.Find(var_2_2, "window/btn_got")

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.btn_get

	local function var_4_2()
		local var_5_0 = arg_4_0.contextData.ptData
		local var_5_1, var_5_2 = var_0.GetResProgress(var_5_0)
		local var_5_3 = arg_4_0
		local var_5_4 = var_3.emit

		ActivityMediator = var_2_10005

		var_5_4(var_5_3, var_2_10005.EVENT_PT_OPERATION, {
			cmd = 1,
			activity_id = var_0:GetId(),
			arg1 = var_5_2
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10005)
	arg_4_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_6_0)
	local var_6_0 = arg_6_0.window

	var_1.Show(var_6_0, arg_6_0.contextData.ptData)

	local var_6_1 = arg_6_0.contextData.ptData
	local var_6_2 = var_1.CanGetAward(var_6_1)

	setActive = var_6_1

	var_6_1(arg_6_0.btn_get, var_6_2)

	setActive = var_6_1

	var_6_1(arg_6_0.btn_banned, not var_6_2)

	return
end

function var_0_1.Hide(arg_7_0)
	arg_7_0:closeView()

	return
end

function var_0_1.willExit(arg_8_0)
	if arg_8_0.window then
		local var_8_0 = arg_8_0.window

		var_1.Dispose(var_8_0)

		arg_8_0.window = nil
	end

	return
end

return var_0_1
