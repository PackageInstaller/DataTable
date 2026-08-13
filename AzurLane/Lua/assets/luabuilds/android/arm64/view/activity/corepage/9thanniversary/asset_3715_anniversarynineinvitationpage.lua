class = var_0_10000

local var_0_0 = "AnniversaryNineInvitationPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.rtMarks = var_1.Find(var_1_0, "AD/progress/items")

	local var_1_1 = arg_1_0._tf

	arg_1_0.rtFinish = var_1.Find(var_1_1, "AD/award/got")

	local var_1_2 = arg_1_0._tf

	arg_1_0.rtBtns = var_1.Find(var_1_2, "AD/btn_list")

	local var_1_3 = arg_1_0.rtBtns

	arg_1_0.goBtn = var_1.Find(var_1_3, "go")

	local var_1_4 = arg_1_0.rtBtns

	arg_1_0.getBtn = var_1.Find(var_1_4, "get")

	local var_1_5 = arg_1_0.rtBtns

	arg_1_0.gotBtn = var_1.Find(var_1_5, "got")

	local var_1_6 = arg_1_0.rtBtns

	arg_1_0.red = var_1.Find(var_1_6, "red")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	arg_2_0.curDay = 0
	getProxy = var_1
	TaskProxy = var_1_10003
	arg_2_0.taskProxy = var_1(var_1_10003)
	underscore = var_1

	local var_2_0 = var_1.flatten
	local var_2_1 = arg_2_0.activity

	arg_2_0.taskGroup = var_2_0(var_3.getConfig(var_2_1, "config_data"))
	table = var_1
	arg_2_0.lastTaskId = var_1.remove(arg_2_0.taskGroup)

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.goBtn

	local function var_3_2()
		local var_4_0 = arg_3_0.coreActivityUI

		if var_0.GetActivityIdByPageClass(var_4_0, "AnniversaryNineGamePage") then
			local var_4_1 = arg_3_0.coreActivityUI

			var_1.verifyTabs(var_4_1, var_0)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.getBtn

	local function var_3_5()
		if arg_3_0.finalTaskVO then
			local var_5_0 = arg_3_0.finalTaskVO

			if var_0.getTaskStatus(var_5_0) == 1 then
				local var_5_1 = arg_3_0
				local var_5_2 = var_0.emit

				ActivityMediator = var_2_10003

				var_5_2(var_5_1, var_2_10003.ON_TASK_SUBMIT, arg_3_0.finalTaskVO)
			end
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	for iter_6_0 = 1, #arg_6_0.taskGroup do
		local var_6_0 = arg_6_0.taskProxy

		if var_5.getTaskVO(var_6_0, arg_6_0.taskGroup[iter_6_0]) and var_5:getTaskStatus() == 1 then
			local var_6_1 = arg_6_0
			local var_6_2 = arg_6_0.emit

			ActivityMediator = var_1_10009

			var_6_2(var_6_1, var_1_10009.ON_TASK_SUBMIT, var_5)

			return
		end
	end

	arg_6_0:RefreshTaskState()
	arg_6_0:RefreshProgress()
	arg_6_0:RefreshButtons()

	return
end

function var_0_1.RefreshTaskState(arg_7_0)
	local var_7_0 = arg_7_0.taskProxy

	arg_7_0.finalTaskVO = var_1.getTaskVO(var_7_0, arg_7_0.lastTaskId)
	math = var_1

	local var_7_1 = var_1.max(arg_7_0.activity.data3, 1)

	underscore = var_1_10002
	arg_7_0.finishCount = var_7_1 - (var_1_10002.all(arg_7_0.taskGroup, function(arg_8_0)
		local var_8_0 = arg_7_0.taskProxy

		return not var_1.getTaskVO(var_8_0, arg_8_0) or var_1:isReceive()
	end) and 0 or 1)

	return
end

function var_0_1.RefreshProgress(arg_9_0)
	local var_9_0 = arg_9_0.rtMarks.childCount

	math = var_1_10002

	local var_9_1 = var_1_10002.min(arg_9_0.finishCount, var_9_0)

	for iter_9_0 = 1, var_9_0 do
		local var_9_2 = arg_9_0.rtMarks
		local var_9_3 = var_7.GetChild(var_9_2, iter_9_0 - 1)

		setActive = var_1_10008

		var_1_10008(var_9_3:Find("mark"), iter_9_0 <= var_9_1)
	end

	return
end

function var_0_1.RefreshButtons(arg_10_0)
	if arg_10_0.finalTaskVO then
		local var_10_0 = arg_10_0.finalTaskVO
		local var_10_1

		if not var_1.getTaskStatus(var_10_0) then
			var_10_1 = 0
		end

		local var_10_2 = var_10_1 == 1
		local var_10_3 = var_10_1 == 2

		setActive = var_1_10004

		var_1_10004(arg_10_0.goBtn, var_10_1 == 0)

		if var_10_2 then
			onButton = var_1_10004

			local var_10_4 = arg_10_0
			local var_10_5 = arg_10_0.getBtn

			local function var_10_6()
				if arg_10_0.finalTaskVO then
					local var_11_0 = arg_10_0.finalTaskVO

					if var_0.getTaskStatus(var_11_0) == 1 then
						local var_11_1 = arg_10_0
						local var_11_2 = var_0.emit

						ActivityMediator = var_2_10003

						var_11_2(var_11_1, var_2_10003.ON_TASK_SUBMIT, arg_10_0.finalTaskVO)
					end
				end

				return
			end

			SFX_PANEL = var_1_10009

			var_1_10004(var_10_4, var_10_5, var_10_6, var_1_10009)
		end

		setActive = var_1_10004

		var_1_10004(arg_10_0.getBtn, var_10_2)

		setActive = var_1_10004

		var_1_10004(arg_10_0.red, var_10_2)

		setActive = var_1_10004

		var_1_10004(arg_10_0.gotBtn, var_10_3)

		setActive = var_1_10004

		var_1_10004(arg_10_0.rtFinish, var_10_3)

		return
	end
end

return var_0_1
