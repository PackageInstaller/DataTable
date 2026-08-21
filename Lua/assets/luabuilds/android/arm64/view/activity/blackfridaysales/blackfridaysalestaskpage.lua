local var_0_0 = class("BlackFridaySalesTaskPage", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "BlackFridaySalesTaskPage"
end

var_0_0.TYPE_ALL = 1
var_0_0.TYPE_DAILY = 2
var_0_0.TYPE_TARGET = 3
var_0_0.TXT_DESC = 1
var_0_0.TXT_CURRENT_NUM = 2
var_0_0.TXT_TARGET_NUM = 3

function var_0_0.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:addListener()
	arg_2_0:onUpdateTask()

	return
end

function var_0_0.initData(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_TASKS))) do
		if iter_3_1:getConfig("config_client").blackFriday then
			arg_3_0.activity = iter_3_1

			break
		end
	end

	arg_3_0.taskGroupList = arg_3_0.activity:getConfig("config_client").taskGroup
	arg_3_0.taskProxy = getProxy(TaskProxy)
	arg_3_0.page = var_0_0.TYPE_ALL

	return
end

function var_0_0.initUI(arg_4_0)
	arg_4_0.getAllBtn = arg_4_0._tf:Find("get_all")
	arg_4_0.extendTpl = arg_4_0._tf:Find("extend_tpl")
	arg_4_0.content = arg_4_0._tf:Find("view/content")
	arg_4_0.taskGroupItemList = UIItemList.New(arg_4_0.content, arg_4_0.content:Find("tpl"))

	setActive(arg_4_0.getAllBtn, false)

	return
end

function var_0_0.addListener(arg_5_0)
	onButton(arg_5_0, arg_5_0.getAllBtn, function()
		arg_5_0:emit(BlackFridaySalesMediator.TASK_SUBMIT_ONESTEP, arg_5_0.finishVOList)

		return
	end, SFX_PANEL)
	arg_5_0.taskGroupItemList:make(function(arg_7_0, arg_7_1, arg_7_2)
		arg_7_1 = arg_7_1 + 1

		if arg_7_0 == UIItemList.EventUpdate then
			arg_5_0:updateTaskGroup(arg_7_2, arg_7_1)
		end

		return
	end)

	return
end

function var_0_0.updateTaskGroup(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1:Find("info")
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.showVOGroup[arg_8_2]) do
		if not iter_8_1:isReceive() then
			table.insert(var_8_1, iter_8_1)
		end
	end

	triggerToggle(var_8_0, false)

	local var_8_2 = #var_8_1 > 0 and table.remove(var_8_1, 1) or arg_8_0.showVOGroup[arg_8_2][#arg_8_0.showVOGroup[arg_8_2]]

	SetCompomentEnabled(var_8_0, typeof(Toggle), #var_8_1 > 0)
	arg_8_0:updateTaskDisplay(var_8_0, var_8_2)
	setActive(var_8_0:Find("toggle_mark"), #var_8_1 > 0)

	local var_8_3 = var_8_2:getTaskStatus()

	GetOrAddComponent(arg_8_1, typeof(CanvasGroup)).alpha = var_8_3 == 2 and 0.5 or 1

	setActive(var_8_0:Find("mask"), var_8_3 == 2)
	setActive(var_8_0:Find("bg/receive"), var_8_3 == 1)
	onToggle(arg_8_0, var_8_0, function(arg_9_0)
		if arg_9_0 then
			local var_9_0 = UIItemList.New(arg_8_1:Find("content"), arg_8_0.extendTpl)

			var_9_0:make(function(arg_10_0, arg_10_1, arg_10_2)
				arg_10_1 = arg_10_1 + 1

				if arg_10_0 == UIItemList.EventUpdate then
					arg_8_0:updateTaskDisplay(arg_10_2, var_8_1[arg_10_1])
				end

				return
			end)
			var_9_0:align(#var_8_1)
			scrollTo(arg_8_0.content, 0, 1 - (arg_8_2 - 1) / (#arg_8_0.showVOGroup + #var_8_1 - 4))
		else
			removeAllChildren(arg_8_1:Find("content"))
		end

		return
	end)

	return
end

function var_0_0.updateTaskDisplay(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2:getProgress()
	local var_11_1 = arg_11_2:getConfig("target_num")

	setSlider(arg_11_1:Find("Slider"), 0, var_11_1, var_11_0)

	local var_11_2 = arg_11_2:getConfig("award_display")[1]

	updateDrop(arg_11_1:Find("IconTpl"), {
		type = var_11_2[1],
		id = var_11_2[2],
		count = var_11_2[3]
	})
	onButton(arg_11_0, arg_11_1:Find("IconTpl"), function()
		arg_11_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	local var_11_3 = arg_11_2:getTaskStatus()

	setActive(arg_11_1:Find("go"), var_11_3 == 0)
	setActive(arg_11_1:Find("get"), var_11_3 == 1)
	setActive(arg_11_1:Find("got"), var_11_3 == 2)
	setText(arg_11_1:Find("desc"), setColorStr(arg_11_2:getConfig("desc"), arg_11_0:getColor(var_0_0.TXT_DESC, var_11_3)))
	setText(arg_11_1:Find("Slider/Text"), setColorStr(var_11_0, arg_11_0:getColor(var_0_0.TXT_CURRENT_NUM, var_11_3)) .. setColorStr("/" .. var_11_1, arg_11_0:getColor(var_0_0.TXT_TARGET_NUM, var_11_3)))
	onButton(arg_11_0, arg_11_1:Find("go"), function()
		arg_11_0:emit(BlackFridaySalesMediator.TASK_GO, arg_11_2)

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_1:Find("get"), function()
		arg_11_0:emit(BlackFridaySalesMediator.TASK_SUBMIT, arg_11_2)

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.getColor(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == var_0_0.TXT_DESC then
		return arg_15_2 == 1 and "#393a3c" or "#ffffff"
	elseif arg_15_1 == var_0_0.TXT_CURRENT_NUM then
		return "#30ec80"
	elseif arg_15_1 == var_0_0.TXT_TARGET_NUM then
		return "#393a3c"
	end

	return
end

function var_0_0.filterAll(arg_16_0)
	arg_16_0.taskVOGroup = underscore.map(arg_16_0.taskGroupList, function(arg_17_0)
		return underscore.map(arg_17_0, function(arg_18_0)
			assert(arg_16_0.taskProxy:getTaskVO(arg_18_0), "without this task:" .. arg_18_0)

			return arg_16_0.taskProxy:getTaskVO(arg_18_0)
		end)
	end)
	arg_16_0.showVOGroup = arg_16_0.taskVOGroup

	return
end

function var_0_0.updataTaskList(arg_19_0)
	table.sort(arg_19_0.showVOGroup, CompareFuncs({
		function(arg_20_0)
			for iter_20_0, iter_20_1 in ipairs(arg_20_0) do
				if iter_20_1:getTaskStatus() == 1 then
					return 0
				end
			end

			return underscore.all(arg_20_0, function(arg_21_0)
				return arg_21_0:isReceive()
			end) and 2 or 1
		end,
		function(arg_22_0)
			return arg_22_0[1].id
		end
	}))
	arg_19_0.taskGroupItemList:align(#arg_19_0.showVOGroup)

	return
end

function var_0_0.onUpdateTask(arg_23_0)
	arg_23_0:filterAll()
	arg_23_0:updataTaskList()
	arg_23_0:updataGetAllBtn()

	return
end

function var_0_0.updataGetAllBtn(arg_24_0)
	return
end

function var_0_0.isTip(arg_25_0)
	if arg_25_0.finishVOList then
		return #arg_25_0.finishVOList > 0
	else
		local var_25_0

		for iter_25_0, iter_25_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_TASKS))) do
			if iter_25_1:getConfig("config_client").blackFriday then
				var_25_0 = iter_25_1

				break
			end
		end

		if var_25_0 and not var_25_0:isEnd() then
			local var_25_1 = getProxy(TaskProxy)

			for iter_25_2, iter_25_3 in ipairs(var_25_0:getConfig("config_client").taskGroup) do
				for iter_25_4, iter_25_5 in ipairs(iter_25_3) do
					assert(var_25_1:getTaskVO(iter_25_5), "without this task:" .. iter_25_5)

					local var_25_2 = var_25_1:getTaskVO(iter_25_5)

					if var_25_2:getTaskStatus() == 1 then
						return true
					end
				end
			end
		end

		return false
	end

	return
end

function var_0_0.OnDestroy(arg_26_0)
	return
end

return var_0_0
