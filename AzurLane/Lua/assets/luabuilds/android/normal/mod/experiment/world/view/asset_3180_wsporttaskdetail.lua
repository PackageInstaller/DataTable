class = var_0_10000

local var_0_0 = "WSPortTaskDetail"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseEntity"))

var_0_1.Fields = {
	onCancel = "function",
	task = "table",
	transform = "userdata"
}

function var_0_1.Setup(arg_1_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.New(arg_1_0)
	arg_1_0:Init()

	return
end

function var_0_1.Dispose(arg_2_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_2_0)
	arg_2_0:Clear()

	return
end

function var_0_1.Init(arg_3_0)
	local var_3_0 = arg_3_0.transform

	onButton = var_1_10002

	local var_3_1 = arg_3_0
	local var_3_2 = var_3_0

	local function var_3_3()
		arg_3_0.onCancel()

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10002(var_3_1, var_3_2, var_3_3, var_1_10006)

	onButton = var_1_10002

	local var_3_4 = arg_3_0
	local var_3_5 = var_3_0:Find("top/btnBack")

	local function var_3_6()
		arg_3_0.onCancel()

		return
	end

	SFX_CANCEL = var_6

	var_1_10002(var_3_4, var_3_5, var_3_6, var_6)

	return
end

function var_0_1.UpdateTask(arg_6_0, arg_6_1)
	arg_6_0.task = arg_6_1

	local var_6_0 = arg_6_0.transform

	setText = var_1_10003

	var_1_10003(var_6_0:Find("window/desc"), arg_6_1.config.description)

	local var_6_1 = arg_6_1:GetDisplayDrops()
	local var_6_2 = var_6_0:Find("window/scrollview/list")
	local var_6_3 = var_6_0
	local var_6_4 = var_6_0.Find(var_6_3, "window/scrollview/item")

	UIItemList = var_6_3

	local var_6_5 = var_6_3.New(var_6_2, var_6_4)

	var_6.make(var_6_5, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = var_6_1[arg_7_1 + 1]

			updateDrop = var_4

			var_4(arg_7_2, var_7_0)

			setScrollText = var_4

			var_4(arg_7_2:Find("name_mask/name"), var_7_0:getConfig("name"))
		end

		return
	end)
	var_6:align(#var_6_1)

	return
end

return var_0_1
