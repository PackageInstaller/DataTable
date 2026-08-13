class = var_0_10000

local var_0_0 = "ShrineBuffView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "ShrineBuff"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:Show()
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:updateView()

	return
end

function var_0_1.OnDestroy(arg_3_0)
	arg_3_0.contextData.onClose()

	arg_3_0.lockBackPress = false

	return
end

function var_0_1.initData(arg_4_0)
	arg_4_0.lockBackPress = true

	return
end

function var_0_1.initUI(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.bg = var_1.Find(var_5_0, "BG")

	local var_5_1 = arg_5_0._tf

	arg_5_0.backBtn = var_1.Find(var_5_1, "BackBtn")

	local var_5_2 = arg_5_0._tf

	arg_5_0.buffListTF = var_1.Find(var_5_2, "Main/BuffList")

	for iter_5_0 = 1, 3 do
		local var_5_3 = arg_5_0.buffListTF
		local var_5_4 = var_5.GetChild(var_5_3, iter_5_0 - 1)

		onButton = var_1_10006

		local var_5_5 = arg_5_0
		local var_5_6 = var_5_4

		local function var_5_7()
			arg_5_0.contextData.onSelect(iter_5_0)

			local var_6_0 = arg_5_0

			var_0.Destroy(var_6_0)

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_5_5, var_5_6, var_5_7, var_1_10011)
	end

	onButton = var_1

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0.backBtn

	local function var_5_10()
		local var_7_0 = arg_5_0

		var_0.Destroy(var_7_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_5_8, var_5_9, var_5_10, var_1_10006)

	return
end

function var_0_1.updateView(arg_8_0)
	return
end

return var_0_1
