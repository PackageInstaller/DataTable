local var_0_0 = class("LiquorFloorTaskScene", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "LiquorFloorTaskUI"
end

function var_0_0.init(arg_2_0)
	onButton(arg_2_0, arg_2_0.uiBgBtn, function()
		arg_2_0:closeView()

		return
	end)
	onButton(arg_2_0, arg_2_0.uiCloseBtn, function()
		arg_2_0:closeView()

		return
	end, SFX_CANCEL)
	setText(arg_2_0.uiTitleText, i18n("LiquorFloorTaskUI_title"))

	arg_2_0.itemList = {}
	arg_2_0.uiLScroll = GetComponent(arg_2_0.uiScroll, "LScrollRect")
	arg_2_0.onInitItemHandler = handler(arg_2_0, arg_2_0.OnInitItem)
	arg_2_0.onUpdateItemHandler = handler(arg_2_0, arg_2_0.OnUpdateItem)
	arg_2_0.uiLScroll.onInitItem = arg_2_0.onInitItemHandler
	arg_2_0.uiLScroll.onUpdateItem = arg_2_0.onUpdateItemHandler

	return
end

function var_0_0.didEnter(arg_5_0)
	arg_5_0:BlurView()
	arg_5_0:RefreshUI()

	return
end

function var_0_0.willExit(arg_6_0)
	arg_6_0:UnBlurView()

	arg_6_0.uiLScroll.onInitItem = nil
	arg_6_0.uiLScroll.onUpdateItem = nil
	arg_6_0.onInitItemHandler = nil
	arg_6_0.onUpdateItemHandler = nil

	return
end

function var_0_0.BlurView(arg_7_0)
	arg_7_0:BlurPanel(arg_7_0._tf)

	return
end

function var_0_0.UnBlurView(arg_8_0)
	arg_8_0:UnOverlayPanel(arg_8_0._tf)

	return
end

function var_0_0.GetTaskList(arg_9_0)
	local var_9_9000
	local var_9_0 = getProxy(TaskProxy)
	local var_9_1 = getProxy(ActivityProxy).getActivityById(var_9_9000, arg_9_0.contextData.activityID):getConfig("config_client").taskActivityID
	local var_9_2 = getProxy(ActivityProxy):getActivityById(var_9_1)
	local var_9_3 = getProxy(TaskProxy)

	for iter_9_0, iter_9_1 in ipairs(pg.activity_template[var_9_1].config_data) do
		table.insert({}, var_9_3:getTaskVO(iter_9_1))
	end

	return {}
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.taskList = arg_10_0:GetTaskList()

	arg_10_0:Sort(arg_10_0.taskList)
	arg_10_0.uiLScroll:SetTotalCount(#arg_10_0.taskList)

	return
end

function var_0_0.OnInitItem(arg_11_0, arg_11_1)
	arg_11_0.itemList[arg_11_1] = LiquorFloorTaskItem.New(tf(arg_11_1), arg_11_0)

	return
end

function var_0_0.OnUpdateItem(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.itemList[arg_12_2] == nil then
		arg_12_0:OnInitItem(arg_12_2)
	end

	arg_12_0.itemList[arg_12_2]:SetData(arg_12_0.taskList[arg_12_1 + 1])

	return
end

function var_0_0.Sort(arg_13_0)
	local function var_13_0(arg_14_0, arg_14_1, arg_14_2)
		return (function(arg_15_0)
			for iter_15_0, iter_15_1 in ipairs(arg_14_2) do
				if arg_15_0 == iter_15_1 then
					return iter_15_0
				end
			end

			return
		end)(arg_14_0) < (function(arg_15_0)
			for iter_15_0, iter_15_1 in ipairs(arg_14_2) do
				if arg_15_0 == iter_15_1 then
					return iter_15_0
				end
			end

			return
		end)(arg_14_1)
	end

	table.sort(arg_13_0.taskList, function(arg_16_0, arg_16_1)
		local var_16_0 = arg_16_0:getTaskStatus()
		local var_16_1 = arg_16_1:getTaskStatus()

		if var_16_0 == var_16_1 then
			return arg_16_0.id < arg_16_1.id
		end

		return var_13_0(var_16_0, var_16_1, {
			1,
			0,
			2,
			-1
		})
	end)

	return
end

return var_0_0
