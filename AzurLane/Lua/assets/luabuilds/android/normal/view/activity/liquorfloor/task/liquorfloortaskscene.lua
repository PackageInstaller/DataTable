class = var_0_10000

local var_0_0 = "LiquorFloorTaskScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "LiquorFloorTaskUI"
end

function var_0_1.init(arg_2_0)
	onButton = var_1_10001

	var_1_10001(arg_2_0, arg_2_0.uiBgBtn, function()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end)

	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.uiCloseBtn

	local function var_2_2()
		local var_4_0 = arg_2_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10005)

	setText = var_1_10001

	local var_2_3 = arg_2_0.uiTitleText

	i18n = var_2_1

	var_1_10001(var_2_3, var_2_1("LiquorFloorTaskUI_title"))

	arg_2_0.itemList = {}
	GetComponent = var_1
	arg_2_0.uiLScroll = var_1(arg_2_0.uiScroll, "LScrollRect")
	handler = var_1
	arg_2_0.onInitItemHandler = var_1(arg_2_0, arg_2_0.OnInitItem)
	handler = var_1
	arg_2_0.onUpdateItemHandler = var_1(arg_2_0, arg_2_0.OnUpdateItem)
	arg_2_0.uiLScroll.onInitItem = arg_2_0.onInitItemHandler
	arg_2_0.uiLScroll.onUpdateItem = arg_2_0.onUpdateItemHandler

	return
end

function var_0_1.didEnter(arg_5_0)
	arg_5_0:BlurView()
	arg_5_0:RefreshUI()

	return
end

function var_0_1.willExit(arg_6_0)
	arg_6_0:UnBlurView()

	arg_6_0.uiLScroll.onInitItem = nil
	arg_6_0.uiLScroll.onUpdateItem = nil
	arg_6_0.onInitItemHandler = nil
	arg_6_0.onUpdateItemHandler = nil

	return
end

function var_0_1.BlurView(arg_7_0)
	arg_7_0:BlurPanel(arg_7_0._tf)

	return
end

function var_0_1.UnBlurView(arg_8_0)
	arg_8_0:UnOverlayPanel(arg_8_0._tf)

	return
end

function var_0_1.GetTaskList(arg_9_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10002

	local var_9_0 = var_1_10001(var_1_10002)

	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_9_1 = var_1_10002(var_1_10003)
	local var_9_2 = var_2.getActivityById(var_9_1, arg_9_0.contextData.activityID)
	local var_9_3 = var_2.getConfig(var_9_2, "config_client").taskActivityID

	getProxy = var_9_2
	ActivityProxy = var_5

	local var_9_4 = var_9_2(var_5)
	local var_9_5 = var_4.getActivityById(var_9_4, var_9_3)

	pg = var_9_4

	local var_9_6 = var_9_4.activity_template[var_9_3].config_data
	local var_9_7 = {}

	getProxy = var_1_10007
	TaskProxy = var_1_10008

	local var_9_8 = var_1_10007(var_1_10008)

	ipairs = var_1_10008

	for iter_9_0, iter_9_1 in var_1_10008(var_9_6) do
		table = var_1_10013

		var_1_10013.insert(var_9_7, var_9_8:getTaskVO(iter_9_1))
	end

	return var_9_7
end

function var_0_1.RefreshUI(arg_10_0)
	arg_10_0.taskList = arg_10_0:GetTaskList()

	arg_10_0:Sort(arg_10_0.taskList)

	local var_10_0 = arg_10_0.uiLScroll

	var_1.SetTotalCount(var_10_0, #arg_10_0.taskList)

	return
end

function var_0_1.OnInitItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.itemList

	LiquorFloorTaskItem = var_1_10003

	local var_11_1 = var_1_10003.New

	tf = var_1_10004
	var_11_0[arg_11_1] = var_11_1(var_1_10004(arg_11_1), arg_11_0)

	return
end

function var_0_1.OnUpdateItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0

	if arg_12_0.itemList[arg_12_2] == nil then
		arg_12_0:OnInitItem(arg_12_2)

		var_12_0 = arg_12_0.itemList[arg_12_2]
	end

	local var_12_1 = arg_12_0.taskList[arg_12_1 + 1]

	var_12_0:SetData(var_12_1)

	return
end

function var_0_1.Sort(arg_13_0)
	local function var_13_0(arg_14_0, arg_14_1, arg_14_2)
		return (function(arg_15_0)
			ipairs = var_3_10001

			for iter_15_0, iter_15_1 in var_3_10001(arg_14_2) do
				if arg_15_0 == iter_15_1 then
					return iter_15_0
				end
			end

			return
		end)(arg_14_0) < var_3(arg_14_1)
	end

	table = var_1_10002

	var_1_10002.sort(arg_13_0.taskList, function(arg_16_0, arg_16_1)
		if arg_16_0:getTaskStatus() == arg_16_1:getTaskStatus() then
			return arg_16_0.id < arg_16_1.id
		end

		return var_13_0(var_2, var_3, {
			1,
			0,
			2,
			-1
		})
	end)

	return
end

return var_0_1
