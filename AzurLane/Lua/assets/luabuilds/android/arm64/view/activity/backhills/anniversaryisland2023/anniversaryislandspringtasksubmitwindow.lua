class = var_0_10000

local var_0_0 = "AnniversaryIslandSpringTaskSubmitWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AnniversaryIslandSpringTaskSubmitWindow"
end

function var_0_1.init(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_3.Find(var_2_0, "Content/Tips")

	i18n = var_1_10004

	var_1_10001(var_2_1, var_1_10004("sub_item_warning"))

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	var_1_10001(var_3_0, var_4.Find(var_3_1, "BG"), function()
		local var_4_0 = arg_3_0

		var_0.onBackPressed(var_4_0)

		return
	end)

	onButton = var_1_10001

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0._tf
	local var_3_4 = var_4.Find(var_3_3, "Content/Cancel")

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.onBackPressed(var_5_0)

		return
	end

	SFX_CANCEL = var_3_3

	var_1_10001(var_3_2, var_3_4, var_3_5, var_3_3)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0._tf
	local var_3_8 = var_4.Find(var_3_7, "Content/Submit")

	local function var_3_9()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		AnniversaryIslandSpringTask2023Mediator = var_2_10003

		var_6_1(var_6_0, var_2_10003.SUBMIT_TASK)

		return
	end

	SFX_CONFIRM = var_3_7

	var_1_10001(var_3_6, var_3_8, var_3_9, var_3_7)

	local var_3_10 = arg_3_0.contextData.task
	local var_3_11 = {}
	local var_3_12 = {}

	tonumber = var_3_8
	var_3_12.type = var_3_8(var_3_10:getConfig("target_id"))
	tonumber = var_4
	var_3_12.id = var_4(var_3_10:getConfig("target_id_2"))
	var_3_12.count = var_3_10:getConfig("target_num")
	var_3_11[1] = var_3_12
	UIItemList = var_3_12

	local var_3_13 = var_3_12.StaticAlign
	local var_3_14 = arg_3_0._tf
	local var_3_15 = var_5.Find(var_3_14, "Content/Icons")
	local var_3_16 = arg_3_0._tf
	local var_3_17 = var_6.Find(var_3_16, "Content/Icons")

	var_3_13(var_3_15, var_6.GetChild(var_3_17, 0), #var_3_11, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_7_0 = var_3_11[arg_7_1 + 1]

		updateDrop = var_4

		var_4(arg_7_2:Find("Mask/IconTpl"), var_7_0)

		onButton = var_4

		var_4(arg_3_0, arg_7_2, function()
			local var_8_0 = var_7_0.type

			DROP_TYPE_WORKBENCH_DROP = var_3_10001

			if var_8_0 == var_3_10001 then
				local var_8_1 = arg_3_0
				local var_8_2 = var_0.emit

				WorkBenchItemDetailMediator = var_3_10003
				var_3_10003 = var_3_10003.SHOW_DETAIL
				WorkBenchItem = var_3_10004

				var_8_2(var_8_1, var_3_10003, var_3_10004.New({
					configId = var_7_0.id,
					count = var_7_0.count
				}))
			else
				local var_8_3 = arg_3_0
				local var_8_4 = var_0.emit

				BaseUI = var_3_10003

				var_8_4(var_8_3, var_3_10003.ON_DROP, var_7_0)
			end

			return
		end)

		return
	end)

	return
end

function var_0_1.willExit(arg_9_0)
	return
end

return var_0_1
