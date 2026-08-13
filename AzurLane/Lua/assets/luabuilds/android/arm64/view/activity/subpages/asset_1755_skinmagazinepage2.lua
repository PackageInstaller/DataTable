class = var_0_10000

local var_0_0 = "SkinMagazinePage2"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

var_0_1.EXPAND_WIDTH = 973
var_0_1.CLOSE_WIDTH = 216
var_0_1.DURATION_PARAMETER = 2500
var_0_1.TIP_KEY = "SkinMagazinePage2_tip"

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.items = var_1.Find(var_1_0, "AD/items")

	local var_1_1 = arg_1_0._tf

	arg_1_0.countTf = var_1.Find(var_1_1, "AD/task/count")

	local var_1_2 = arg_1_0._tf

	arg_1_0.awardTf = var_1.Find(var_1_2, "AD/task/IconTpl")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10003
	arg_2_0.taskProxy = var_1_10001(var_1_10003)

	local var_2_0 = arg_2_0.activity

	arg_2_0.taskList = var_1.getConfig(var_2_0, "config_data")
	arg_2_0.totalCnt = #arg_2_0.taskList

	return
end

function var_0_1.RefreshData(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.TimeMgr.GetInstance()
	local var_3_1 = var_1.DiffDay
	local var_3_2 = arg_3_0.activity
	local var_3_3 = var_3_1(var_3_0, var_5.getStartTime(var_3_2), var_1:GetServerTime()) + 1
	local var_3_4 = arg_3_0.activity

	arg_3_0.unlockCnt = var_3_3 * var_3.getConfig(var_3_4, "config_id")
	math = var_2
	arg_3_0.unlockCnt = var_2.min(arg_3_0.unlockCnt, arg_3_0.totalCnt)
	arg_3_0.remainCnt = arg_3_0.usedCnt >= arg_3_0.totalCnt and 0 or arg_3_0.unlockCnt - arg_3_0.usedCnt

	return
end

function var_0_1.OnFirstFlush(arg_4_0)
	local var_4_0 = arg_4_0.activity

	arg_4_0.usedCnt = var_1.getData1(var_4_0)

	arg_4_0:RefreshData()

	setText = var_1

	local var_4_1 = arg_4_0.awardTf
	local var_4_2 = var_3.Find(var_4_1, "get/tip/Text")

	i18n = var_1_10004

	var_1(var_4_2, var_1_10004(var_0_1.TIP_KEY))

	arg_4_0.index = #arg_4_0.taskList

	for iter_4_0 = 1, #arg_4_0.taskList do
		local var_4_3 = arg_4_0.taskProxy
		local var_4_4 = var_5.getTaskVO(var_4_3, arg_4_0.taskList[iter_4_0])

		if not var_5.isReceive(var_4_4) then
			arg_4_0.index = iter_4_0

			break
		end
	end

	for iter_4_1 = 1, arg_4_0.items.childCount do
		local var_4_5 = arg_4_0.items
		local var_4_6 = var_5.GetChild(var_4_5, iter_4_1 - 1)
		local var_4_7 = var_5.GetComponent

		typeof = var_1_10009
		LayoutElement = var_1_10011

		local var_4_8 = var_4_7(var_4_6, var_1_10009(var_1_10011))
		local var_4_9

		if iter_4_1 ~= arg_4_0.index or not var_0_1.EXPAND_WIDTH then
			var_4_9 = var_0_1.CLOSE_WIDTH
		end

		var_4_8.preferredWidth = var_4_9
		setImageAlpha = var_4_8

		local var_4_10 = var_5:Find("close")

		var_1_10009 = iter_4_1 == arg_4_0.index and 0 or 1

		var_4_8(var_4_10, var_1_10009)

		onButton = var_4_8

		local var_4_11 = arg_4_0

		var_1_10009 = var_5

		local function var_4_12()
			local var_5_0 = arg_4_0

			var_0.SelectItem(var_5_0, iter_4_1)

			return
		end

		SFX_PANEL = var_1_10011

		var_4_8(var_4_11, var_1_10009, var_4_12, var_1_10011)
	end

	arg_4_0:UpdateDrop()

	local var_4_13 = arg_4_0.activity

	if var_1.getConfig(var_4_13, "config_client").firstStory then
		playStory = var_2

		var_2(var_1)
	end

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	local var_6_0 = 0
	local var_6_1 = {}

	ipairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(arg_6_0.taskList) do
		tobool = var_1_10008

		local var_6_2 = arg_6_0.taskProxy

		var_6_1[iter_6_1] = var_1_10008(var_10.getFinishTaskById(var_6_2, iter_6_1))

		if var_6_1[iter_6_1] then
			var_6_0 = var_6_0 + 1
		end

		setActive = var_1_10008

		local var_6_3 = arg_6_0.items
		local var_6_4 = var_10.GetChild(var_6_3, iter_6_0 - 1)

		var_1_10008(var_10.Find(var_6_4, "got"), var_6_1[iter_6_1])
	end

	if arg_6_0.usedCnt ~= var_6_0 then
		arg_6_0.usedCnt = var_6_0

		local var_6_5 = arg_6_0.activity

		var_6_5.data1 = arg_6_0.usedCnt
		getProxy = var_4
		ActivityProxy = iter_6_0

		local var_6_6 = var_4(iter_6_0)

		var_4.updateActivity(var_6_6, var_6_5)
	end

	arg_6_0:RefreshData()

	setText = var_3

	var_3(arg_6_0.countTf, arg_6_0.remainCnt)

	local var_6_7 = var_6_1[arg_6_0.taskList[arg_6_0.index]]

	setActive = var_4

	local var_6_8 = arg_6_0.awardTf

	var_4(var_6.Find(var_6_8, "got"), var_6_7)

	setActive = var_4

	local var_6_9 = arg_6_0.awardTf

	var_4(var_6.Find(var_6_9, "get"), arg_6_0.remainCnt > 0 and not var_6_7)

	local var_6_10 = arg_6_0.activity
	local var_6_11 = var_4.getConfig(var_6_10, "config_client").story

	ipairs = var_5

	for iter_6_2, iter_6_3 in var_5(arg_6_0.taskList) do
		local var_6_12 = arg_6_0.taskProxy

		if var_10.getFinishTaskById(var_6_12, iter_6_3) then
			checkExist = var_1_10011

			if var_1_10011(var_6_11, {
				iter_6_2
			}, {
				1
			}) then
				playStory = var_1_10011

				var_1_10011(var_6_11[iter_6_2][1])
			end
		end
	end

	return
end

function var_0_1.SelectItem(arg_7_0, arg_7_1)
	if arg_7_0.index == arg_7_1 then
		return
	end

	arg_7_0.index = arg_7_1
	ipairs = var_2

	local var_7_0

	if not arg_7_0.LTList then
		var_7_0 = {}
	end

	for iter_7_0, iter_7_1 in var_2(var_7_0) do
		LeanTween = var_1_10007

		var_1_10007.cancel(iter_7_1)
	end

	arg_7_0.LTList = {}

	for iter_7_2 = 1, arg_7_0.items.childCount do
		local var_7_1 = arg_7_0.items
		local var_7_2 = var_6.GetChild(var_7_1, iter_7_2 - 1)
		local var_7_3 = var_6.GetComponent

		typeof = var_1_10010
		LayoutElement = var_1_10012

		local var_7_4 = var_7_3(var_7_2, var_1_10010(var_1_10012)).preferredWidth
		local var_7_5

		if iter_7_2 ~= arg_7_1 or not var_0_1.EXPAND_WIDTH then
			var_7_5 = var_0_1.CLOSE_WIDTH
		end

		if var_7_4 ~= var_7_5 then
			math = var_1_10010
			var_1_10010 = var_1_10010.abs(var_7_5 - var_7_4) / var_0_1.DURATION_PARAMETER
			table = var_11

			local var_7_6 = var_11.insert
			local var_7_7 = arg_7_0.LTList

			LeanTween = var_1_10014
			var_1_10014 = var_1_10014.value
			go = var_1_10016
			var_1_10016 = var_1_10014(var_1_10016(var_6), var_7_4, var_7_5, var_1_10010)
			var_1_10014 = var_1_10014.setEase
			LeanTweenType = var_17
			var_1_10016 = var_1_10014(var_1_10016, var_17.easeOutSine)
			var_1_10014 = var_1_10014.setOnUpdate
			System = var_17

			var_7_6(var_7_7, var_1_10014(var_1_10016, var_17.Action_float(function(arg_8_0)
				var_0.preferredWidth = arg_8_0

				return
			end)).uniqueId)

			table = var_7_6

			local var_7_8 = var_7_6.insert
			local var_7_9 = arg_7_0.LTList

			LeanTween = var_1_10014
			var_1_10016 = var_1_10014.alpha(var_6:Find("close"), iter_7_2 == arg_7_1 and 0 or 1, var_1_10010)
			var_1_10014 = var_1_10014.setEase
			LeanTweenType = var_17

			var_7_8(var_7_9, var_1_10014(var_1_10016, var_17.easeOutSine).uniqueId)
		end
	end

	arg_7_0:UpdateDrop()

	return
end

function var_0_1.UpdateDrop(arg_9_0)
	local var_9_0 = arg_9_0.taskProxy
	local var_9_1 = var_1.getTaskVO(var_9_0, arg_9_0.taskList[arg_9_0.index])
	local var_9_2 = {}

	unpack = var_9_0

	local var_9_3, var_9_4, var_9_5 = var_9_0(var_9_1:getConfig("award_display")[1])

	var_9_2.count = var_9_5
	var_9_2.id = var_9_4
	var_9_2.type = var_9_3
	updateDrop = var_9_3

	var_9_3(arg_9_0.awardTf, var_9_2)

	onButton = var_9_3

	local var_9_6 = arg_9_0
	local var_9_7 = arg_9_0.awardTf
	local var_9_8 = var_6.Find(var_9_7, "get")

	local function var_9_9()
		local var_10_0 = arg_9_0
		local var_10_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_10_1(var_10_0, var_2_10003.ON_TASK_SUBMIT, var_9_1)

		return
	end

	SFX_CONFIRM = var_9_7

	var_9_3(var_9_6, var_9_8, var_9_9, var_9_7)

	onButton = var_9_3

	var_9_3(arg_9_0, arg_9_0.awardTf, function()
		local var_11_0 = arg_9_0
		local var_11_1 = var_0.emit

		BaseUI = var_2_10003

		var_11_1(var_11_0, var_2_10003.ON_DROP, var_9_2)

		return
	end)

	local var_9_10 = var_9_1:isReceive()

	setActive = var_9_4

	local var_9_11 = arg_9_0.awardTf

	var_9_4(var_6.Find(var_9_11, "got"), var_9_10)

	setActive = var_9_4

	local var_9_12 = arg_9_0.awardTf

	var_9_4(var_6.Find(var_9_12, "get"), arg_9_0.remainCnt > 0 and not var_9_10)

	return
end

function var_0_1.OnDestroy(arg_12_0)
	ipairs = var_1_10001

	local var_12_0

	if not arg_12_0.LTList then
		var_12_0 = {}
	end

	for iter_12_0, iter_12_1 in var_1_10001(var_12_0) do
		LeanTween = var_1_10006

		var_1_10006.cancel(iter_12_1)
	end

	return
end

return var_0_1
