class = var_0_10000

local var_0_0 = "VotingResulitAwardPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinMagazineTemplatePage"))

var_0_1.EXPAND_WIDTH = 973
var_0_1.CLOSE_WIDTH = 216
var_0_1.DURATION_PARAMETER = 2500

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.items = var_1.Find(var_1_0, "AD/items")
	arg_1_0.dicLT = {}

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10002
	arg_2_0.taskProxy = var_1_10001(var_1_10002)

	local var_2_0 = arg_2_0.activity

	arg_2_0.taskList = var_1.getConfig(var_2_0, "config_data")
	arg_2_0.totalCnt = #arg_2_0.taskList
	underscore = var_1
	arg_2_0.usedCnt = var_1.reduce(arg_2_0.taskList, 0, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0.taskProxy

		return arg_3_0 + (var_2.getFinishTaskById(var_3_0, arg_3_1) and 1 or 0)
	end)

	local var_2_1 = arg_2_0.activity
	local var_2_2

	if var_1.getData1(var_2_1) ~= arg_2_0.usedCnt then
		var_2_2 = arg_2_0.activity
		var_2_2.data1 = arg_2_0.usedCnt
		getProxy = var_2
		ActivityProxy = var_3

		local var_2_3 = var_2(var_3)

		var_2.updateActivity(var_2_3, var_2_2)

		return true
	end

	pg = var_2_2

	local var_2_4 = var_2_2.TimeMgr.GetInstance()
	local var_2_5 = var_1.DiffDay
	local var_2_6 = arg_2_0.activity
	local var_2_7 = var_2_5(var_2_4, var_4.getStartTime(var_2_6), var_1:GetServerTime()) + 1
	local var_2_8 = arg_2_0.activity

	arg_2_0.unlockCnt = var_2_7 * var_3.getConfig(var_2_8, "config_id")
	math = var_2
	arg_2_0.unlockCnt = var_2.min(arg_2_0.unlockCnt, arg_2_0.totalCnt)
	arg_2_0.remainCnt = arg_2_0.usedCnt >= arg_2_0.totalCnt and 0 or arg_2_0.unlockCnt - arg_2_0.usedCnt

	return
end

function var_0_1.OnFirstFlush(arg_4_0)
	local var_4_0 = arg_4_0.activity

	arg_4_0.usedCnt = var_1.getData1(var_4_0)
	ipairs = var_1

	for iter_4_0, iter_4_1 in var_1(arg_4_0.taskList) do
		local var_4_1 = arg_4_0.items
		local var_4_2 = var_6.GetChild(var_4_1, iter_4_0 - 1)

		onButton = var_4_1

		local var_4_3 = arg_4_0
		local var_4_4 = var_4_2:Find("close")

		local function var_4_5()
			if arg_4_0.index == iter_4_0 then
				return
			end

			local var_5_0 = arg_4_0

			var_0.UpdateDisplay(var_5_0, iter_4_0)

			return
		end

		SFX_PANEL = var_11

		var_4_1(var_4_3, var_4_4, var_4_5, var_11)

		local var_4_6 = arg_4_0.taskProxy
		local var_4_7 = var_7.getTaskVO(var_4_6, iter_4_1)

		Drop = var_4_6

		local var_4_8 = var_4_6.Create(var_4_7:getConfig("award_display")[1])

		ipairs = var_9

		for iter_4_2, iter_4_3 in var_9({
			"close",
			"expand"
		}) do
			local var_4_9 = var_4_2
			local var_4_10 = var_4_2.Find(var_4_9, iter_4_3 .. "/IconTpl")

			updateDrop = var_4_9

			var_4_9(var_4_10, var_4_8)

			setText = var_4_9

			local var_4_11 = var_4_10
			local var_4_12 = var_4_10.Find(var_4_11, "get/tip/Text")

			i18n = var_4_11

			var_4_9(var_4_12, var_4_11("voting_page_reward"))

			onButton = var_4_9

			local var_4_13 = arg_4_0
			local var_4_14 = var_4_10

			local function var_4_15()
				local var_6_0 = arg_4_0
				local var_6_1 = var_0.emit

				BaseUI = var_2_10002

				var_6_1(var_6_0, var_2_10002.ON_DROP, var_4_8)

				return
			end

			SFX_PANEL = var_1_10019

			var_4_9(var_4_13, var_4_14, var_4_15, var_1_10019)

			onButton = var_4_9

			local var_4_16 = arg_4_0
			local var_4_17 = var_4_10:Find("get")

			local function var_4_18()
				local var_7_0 = arg_4_0
				local var_7_1 = var_0.emit

				ActivityMediator = var_2_10002

				var_7_1(var_7_0, var_2_10002.ON_TASK_SUBMIT, var_4_7)

				return
			end

			SFX_CONFIRM = var_1_10019

			var_4_9(var_4_16, var_4_17, var_4_18, var_1_10019)
		end
	end

	arg_4_0:UpdateDisplay(1)

	local var_4_19 = arg_4_0.activity

	if var_1.getConfig(var_4_19, "config_client").firstStory then
		playStory = var_4_19

		var_4_19(var_1)
	end

	return
end

function var_0_1.OnUpdateFlush(arg_8_0)
	ipairs = var_1_10001

	for iter_8_0, iter_8_1 in var_1_10001(arg_8_0.taskList) do
		local var_8_0 = arg_8_0.taskProxy
		local var_8_1 = var_6.getTaskVO(var_8_0, iter_8_1)

		ipairs = var_8_0

		for iter_8_2, iter_8_3 in var_8_0({
			"close",
			"expand"
		}) do
			local var_8_2 = arg_8_0.items
			local var_8_3 = var_12.GetChild(var_8_2, iter_8_0 - 1)
			local var_8_4 = var_12.Find(var_8_3, iter_8_3 .. "/IconTpl")

			setActive = var_8_3

			var_8_3(var_8_4:Find("get"), arg_8_0.remainCnt > 0 and not var_8_1:isReceive())

			setActive = var_8_3

			var_8_3(var_8_4:Find("got"), var_8_1:isReceive())
		end
	end

	return
end

function var_0_1.UpdateDisplay(arg_9_0, arg_9_1)
	arg_9_0.index = arg_9_1

	for iter_9_0 = 1, #arg_9_0.taskList do
		local var_9_0 = arg_9_0.items
		local var_9_1 = var_6.GetChild(var_9_0, iter_9_0 - 1)
		local var_9_2 = var_6.GetComponent

		typeof = var_1_10009
		LayoutElement = var_1_10010

		local var_9_3 = var_9_2(var_9_1, var_1_10009(var_1_10010))

		setActive = var_9_1
		var_1_10010 = var_6
		var_1_10009 = var_6.Find(var_1_10010, "expand/IconTpl")
		var_1_10010 = iter_9_0 == arg_9_0.index

		var_9_1(var_1_10009, var_1_10010)

		var_9_3.flexibleWidth = iter_9_0 == arg_9_0.index and 1 or -1

		if iter_9_0 == arg_9_0.index then
			var_9_3.preferredWidth = var_0_1.EXPAND_WIDTH
			setActive = var_8
			var_1_10010 = var_6

			var_8(var_6.Find(var_1_10010, "close"), false)
		else
			local var_9_4 = {}

			if var_9_3.preferredWidth ~= var_0_1.CLOSE_WIDTH then
				if arg_9_0.dicLT[iter_9_0] then
					LeanTween = var_1_10009

					var_1_10009.cancel(arg_9_0.dicLT[iter_9_0])

					var_1_10009 = arg_9_0.dicLT
					var_1_10009[iter_9_0] = nil
				end

				table = var_1_10009

				var_1_10009.insert(var_9_4, function(arg_10_0)
					local var_10_0 = arg_9_0.dicLT
					local var_10_1 = iter_9_0

					LeanTween = var_2_10003

					local var_10_2 = var_2_10003.value

					go = var_2_10004

					local var_10_3 = var_2_10004(var_0)
					local var_10_4 = var_9_3.preferredWidth
					local var_10_5 = arg_9_0.CLOSE_WIDTH

					math = var_2_10007

					local var_10_6 = var_10_2(var_10_3, var_10_4, var_10_5, var_2_10007.abs(var_9_3.preferredWidth - arg_9_0.CLOSE_WIDTH) / arg_9_0.DURATION_PARAMETER)
					local var_10_7 = var_3.setEase

					LeanTweenType = var_10_4

					local var_10_8 = var_10_7(var_10_6, var_10_4.easeOutSine)
					local var_10_9 = var_3.setOnUpdate

					System = var_5

					local var_10_10 = var_10_9(var_10_8, var_5.Action_float(function(arg_11_0)
						var_9_3.preferredWidth = arg_11_0

						return
					end))
					local var_10_11 = var_3.setOnComplete

					System = var_5
					var_10_0[var_10_1] = var_10_11(var_10_10, var_5.Action(arg_10_0)).uniqueId

					return
				end)
			end

			seriesAsync = var_1_10009

			var_1_10009(var_9_4, function()
				local var_12_0 = arg_9_0.dicLT

				var_12_0[iter_9_0] = nil
				setActive = var_12_0

				local var_12_1 = var_0

				var_12_0(var_1.Find(var_12_1, "close"), true)

				return
			end)
		end
	end

	return
end

function var_0_1.OnDestroy(arg_13_0)
	pairs = var_1_10001

	for iter_13_0, iter_13_1 in var_1_10001(arg_13_0.dicLT) do
		LeanTween = var_1_10006

		var_1_10006.cancel(iter_13_1)
	end

	return
end

return var_0_1
