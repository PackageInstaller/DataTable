class = var_0_10000

local var_0_0 = "USDefTaskWindowView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.Load(arg_1_0)
	findTF = var_1_10001
	arg_1_0._tf = var_1_10001(arg_1_0._parentTf, "USDefTaskWindow")
	go = var_1
	arg_1_0._go = var_1(arg_1_0._tf)
	pg = var_1

	var_1.DelegateInfo.New(arg_1_0)
	arg_1_0:OnInit()

	return
end

function var_0_1.Destroy(arg_2_0)
	arg_2_0:Hide()

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0:initData()
	arg_3_0:initUI()
	arg_3_0:updateProgress()
	arg_3_0:updateTaskList()
	arg_3_0:Show()

	return
end

function var_0_1.OnDestroy(arg_4_0)
	return
end

function var_0_1.initData(arg_5_0)
	local var_5_0 = arg_5_0.contextData
	local var_5_1 = var_1.getConfig(var_5_0, "config_client")[1]

	Clone = var_1_10002
	pg = var_4
	arg_5_0.taskIDList = var_1_10002(var_4.task_data_template[var_5_1].target_id)
	getProxy = var_2
	TaskProxy = var_4
	arg_5_0.taskProxy = var_2(var_4)
	arg_5_0.taskVOList = {}
	ipairs = var_2

	for iter_5_0, iter_5_1 in var_2(arg_5_0.taskIDList) do
		local var_5_2 = arg_5_0.taskProxy
		local var_5_3 = var_7.getTaskVO(var_5_2, iter_5_1)

		table = var_1_10008

		var_1_10008.insert(arg_5_0.taskVOList, var_5_3)
	end

	return
end

function var_0_1.initUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.bg = var_1.Find(var_6_0, "BG")

	local var_6_1 = arg_6_0._tf

	arg_6_0.curNumTextTF = var_1.Find(var_6_1, "ProgressPanel/CurNumText")

	local var_6_2 = arg_6_0._tf

	arg_6_0.totalNumText = var_1.Find(var_6_2, "ProgressPanel/TotalNumText")

	local var_6_3 = arg_6_0._tf

	arg_6_0.taskTpl = var_1.Find(var_6_3, "TaskTpl")

	local var_6_4 = arg_6_0._tf

	arg_6_0.taskContainer = var_1.Find(var_6_4, "TaskList/Viewport/Content")
	UIItemList = var_1
	arg_6_0.taskList = var_1.New(arg_6_0.taskContainer, arg_6_0.taskTpl)
	onButton = var_1

	local var_6_5 = arg_6_0
	local var_6_6 = arg_6_0.bg

	local function var_6_7()
		local var_7_0 = arg_6_0

		var_0.Destroy(var_7_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_6_5, var_6_6, var_6_7, var_1_10006)

	return
end

function var_0_1.updateProgress(arg_8_0)
	local var_8_0 = #arg_8_0.taskIDList
	local var_8_1 = 0

	ipairs = var_1_10003

	for iter_8_0, iter_8_1 in var_1_10003(arg_8_0.taskVOList) do
		if iter_8_1:getTaskStatus() >= 1 then
			var_8_1 = var_8_1 + 1
		end
	end

	setText = var_3

	local var_8_2 = arg_8_0.curNumTextTF

	string = iter_8_0

	var_3(var_8_2, iter_8_0.format("%2d", var_8_1))

	setText = var_3

	local var_8_3 = arg_8_0.totalNumText

	string = var_6

	var_3(var_8_3, var_6.format("%2d", var_8_0))

	return
end

function var_0_1.updateTaskList(arg_9_0)
	local var_9_0 = arg_9_0.taskList

	var_1.make(var_9_0, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			arg_10_1 = arg_10_1 + 1

			local var_10_0 = arg_9_0.taskVOList[arg_10_1]
			local var_10_1 = arg_10_2:Find("IndexText")
			local var_10_2 = arg_10_2:Find("TaskIndexText")
			local var_10_3 = arg_10_2:Find("DescText")
			local var_10_4 = arg_10_2
			local var_10_5 = arg_10_2.Find(var_10_4, "ItemBG/Icon")
			local var_10_6 = arg_10_2
			local var_10_7 = arg_10_2.Find(var_10_6, "ItemBG/Finished")

			setText = var_10_4

			local var_10_8 = var_10_1

			string = var_2_10012

			var_10_4(var_10_8, var_2_10012.format("%02d", arg_10_1))

			setText = var_10_4

			local var_10_9 = var_10_2
			local var_10_10 = "TASK-"

			string = var_2_10013

			var_10_4(var_10_9, var_10_10 .. var_2_10013.format("%02d", arg_10_1))

			local var_10_11 = var_10_0
			local var_10_12 = var_10_0.getConfig(var_10_11, "desc")

			setText = var_10_6

			var_10_6(var_10_3, var_10_12)

			tonumber = var_10_6

			local var_10_13 = var_10_0
			local var_10_14 = var_10_6(var_10_0.getConfig(var_10_13, "target_id"))

			pg = var_10_11

			if not var_10_11.ship_data_statistics[var_10_14] then
				var_10_14 = 205054
			end

			pg = var_11

			local var_10_15 = var_11.ship_data_statistics[var_10_14].skin_id

			pg = var_12

			local var_10_16 = var_12.ship_skin_template[var_10_15].painting

			LoadImageSpriteAsync = var_13

			var_13("SquareIcon/" .. var_10_16, var_10_5)

			local var_10_17 = var_10_0:getTaskStatus()

			setActive = var_10_13

			var_10_13(var_10_7, var_10_17 >= 1)
		end

		return
	end)

	local var_9_1 = arg_9_0.taskList

	var_1.align(var_9_1, #arg_9_0.taskIDList)

	return
end

return var_0_1
