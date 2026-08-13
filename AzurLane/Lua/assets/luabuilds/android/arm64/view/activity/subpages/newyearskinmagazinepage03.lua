class = var_0_10000

local var_0_0 = "NewYearSkinMagazinePage03"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_1, "page/items")

	local var_1_2 = arg_1_0.bg

	arg_1_0.rtTask = var_1.Find(var_1_2, "page/task")

	local var_1_3 = arg_1_0.rtTask

	arg_1_0.countTF = var_1.Find(var_1_3, "count")

	local var_1_4 = arg_1_0.rtTask

	arg_1_0.rtAward = var_1.Find(var_1_4, "IconTpl")

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

local var_0_2 = 176
local var_0_3 = 893

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

	arg_4_0.index = #arg_4_0.taskList

	for iter_4_0 = 1, #arg_4_0.taskList do
		local var_4_1 = arg_4_0.taskProxy
		local var_4_2 = var_5.getTaskVO(var_4_1, arg_4_0.taskList[iter_4_0])

		if not var_5.isReceive(var_4_2) then
			arg_4_0.index = iter_4_0

			break
		end
	end

	for iter_4_1 = 1, arg_4_0.items.childCount do
		local var_4_3 = arg_4_0.items
		local var_4_4 = var_5.GetChild(var_4_3, iter_4_1 - 1)
		local var_4_5 = var_5.GetComponent

		typeof = var_1_10009
		LayoutElement = var_1_10011

		local var_4_6 = var_4_5(var_4_4, var_1_10009(var_1_10011))
		local var_4_7

		if iter_4_1 ~= arg_4_0.index or not var_0_3 then
			var_4_7 = var_0_2
		end

		var_4_6.preferredWidth = var_4_7
		setImageAlpha = var_4_6

		local var_4_8 = var_5:Find("window/Image")

		var_1_10009 = iter_4_1 == arg_4_0.index and 0 or 1

		var_4_6(var_4_8, var_1_10009)

		setImageAlpha = var_4_6

		var_4_6(var_5:Find("window/main"), 1)

		onButton = var_4_6

		local var_4_9 = arg_4_0

		var_1_10009 = var_5

		local function var_4_10()
			local var_5_0 = arg_4_0

			var_0.SelectPage(var_5_0, iter_4_1)

			return
		end

		SFX_PANEL = var_1_10011

		var_4_6(var_4_9, var_1_10009, var_4_10, var_1_10011)
	end

	local var_4_11 = arg_4_0.taskProxy
	local var_4_12 = var_1.getTaskVO(var_4_11, arg_4_0.taskList[arg_4_0.index])
	local var_4_13 = {}

	unpack = var_4_11

	local var_4_14, var_4_15, var_4_16 = var_4_11(var_4_12:getConfig("award_display")[1])

	var_4_13.count = var_4_16
	var_4_13.id = var_4_15
	var_4_13.type = var_4_14
	updateDrop = var_4_14

	var_4_14(arg_4_0.rtAward, var_4_13)

	onButton = var_4_14

	local var_4_17 = arg_4_0
	local var_4_18 = arg_4_0.rtAward
	local var_4_19 = var_6.Find(var_4_18, "get")

	local function var_4_20()
		local var_6_0 = arg_4_0
		local var_6_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_6_2 = var_2_10003.ON_TASK_SUBMIT
		local var_6_3 = arg_4_0.taskProxy

		var_6_1(var_6_0, var_6_2, var_4.getTaskVO(var_6_3, arg_4_0.taskList[arg_4_0.index]))

		return
	end

	SFX_CONFIRM = var_4_18

	var_4_14(var_4_17, var_4_19, var_4_20, var_4_18)

	onButton = var_4_14

	var_4_14(arg_4_0, arg_4_0.rtAward, function()
		local var_7_0 = arg_4_0
		local var_7_1 = var_0.emit

		BaseUI = var_2_10003

		var_7_1(var_7_0, var_2_10003.ON_DROP, var_4_13)

		return
	end)

	local var_4_21 = arg_4_0.activity

	if var_3.getConfig(var_4_21, "config_client").firstStory then
		pg = var_4_15

		local var_4_22 = var_4_15.NewStoryMgr.GetInstance()

		var_4.Play(var_4_22, var_3)
	end

	return
end

function var_0_1.OnUpdateFlush(arg_8_0)
	local var_8_0 = 0
	local var_8_1 = {}

	ipairs = var_1_10003

	for iter_8_0, iter_8_1 in var_1_10003(arg_8_0.taskList) do
		tobool = var_1_10008

		local var_8_2 = arg_8_0.taskProxy

		var_8_1[iter_8_1] = var_1_10008(var_10.getFinishTaskById(var_8_2, iter_8_1))

		if var_8_1[iter_8_1] then
			var_8_0 = var_8_0 + 1
		end

		setActive = var_1_10008

		local var_8_3 = arg_8_0.items
		local var_8_4 = var_10.GetChild(var_8_3, iter_8_0 - 1)

		var_1_10008(var_10.Find(var_8_4, "window/got"), var_8_1[iter_8_1])
	end

	if arg_8_0.usedCnt ~= var_8_0 then
		arg_8_0.usedCnt = var_8_0

		local var_8_5 = arg_8_0.activity

		var_8_5.data1 = arg_8_0.usedCnt
		getProxy = var_4
		ActivityProxy = iter_8_0

		local var_8_6 = var_4(iter_8_0)

		var_4.updateActivity(var_8_6, var_8_5)
	end

	arg_8_0:RefreshData()

	setText = var_3

	var_3(arg_8_0.countTF, arg_8_0.remainCnt)

	local var_8_7 = var_8_1[arg_8_0.taskList[arg_8_0.index]]

	setActive = var_4

	local var_8_8 = arg_8_0.rtAward

	var_4(var_6.Find(var_8_8, "got"), var_8_7)

	setActive = var_4

	local var_8_9 = arg_8_0.rtAward

	var_4(var_6.Find(var_8_9, "get"), arg_8_0.remainCnt > 0 and not var_8_7)

	local var_8_10 = arg_8_0.activity
	local var_8_11 = var_4.getConfig(var_8_10, "config_client").story

	ipairs = var_5

	for iter_8_2, iter_8_3 in var_5(arg_8_0.taskList) do
		local var_8_12 = arg_8_0.taskProxy

		if var_10.getFinishTaskById(var_8_12, iter_8_3) then
			checkExist = var_1_10011

			if var_1_10011(var_8_11, {
				iter_8_2
			}, {
				1
			}) then
				pg = var_1_10011

				local var_8_13 = var_1_10011.NewStoryMgr.GetInstance()

				var_1_10011.Play(var_8_13, var_8_11[iter_8_2][1])
			end
		end
	end

	return
end

function var_0_1.SelectPage(arg_9_0, arg_9_1)
	if arg_9_0.index == arg_9_1 then
		return
	end

	arg_9_0.index = arg_9_1
	ipairs = var_2

	local var_9_0

	if not arg_9_0.LTList then
		var_9_0 = {}
	end

	for iter_9_0, iter_9_1 in var_2(var_9_0) do
		LeanTween = var_1_10007

		var_1_10007.cancel(iter_9_1)
	end

	arg_9_0.LTList = {}

	for iter_9_2 = 1, arg_9_0.items.childCount do
		local var_9_1 = arg_9_0.items
		local var_9_2 = var_6.GetChild(var_9_1, iter_9_2 - 1)
		local var_9_3 = var_6.GetComponent

		typeof = var_1_10010
		LayoutElement = var_1_10012

		local var_9_4 = var_9_3(var_9_2, var_1_10010(var_1_10012))

		var_1_10010 = var_6

		local var_9_5 = var_6.Find(var_1_10010, "window/Image")
		local var_9_6 = var_6:Find("window/main")

		var_1_10010 = var_9_4.preferredWidth

		local var_9_7

		if iter_9_2 ~= arg_9_1 or not var_0_3 then
			var_9_7 = var_0_2
		end

		if var_1_10010 ~= var_9_7 then
			math = var_1_10012
			var_1_10012 = var_1_10012.abs(var_9_7 - var_1_10010) / 2000
			table = var_1_10013
			var_1_10013 = var_1_10013.insert

			local var_9_8 = arg_9_0.LTList

			LeanTween = var_1_10016
			var_1_10016 = var_1_10016.value
			go = var_1_10018
			var_1_10018 = var_1_10016(var_1_10018(var_6), var_1_10010, var_9_7, var_1_10012)
			var_1_10016 = var_1_10016.setEase
			LeanTweenType = var_19
			var_1_10018 = var_1_10016(var_1_10018, var_19.easeOutSine)
			var_1_10016 = var_1_10016.setOnUpdate
			System = var_19

			var_1_10013(var_9_8, var_1_10016(var_1_10018, var_19.Action_float(function(arg_10_0)
				var_9_4.preferredWidth = arg_10_0

				return
			end)).uniqueId)

			table = var_1_10013
			var_1_10013 = var_1_10013.insert

			local var_9_9 = arg_9_0.LTList

			LeanTween = var_1_10016
			var_1_10018 = var_1_10016.alpha(var_6:Find("window/Image"), iter_9_2 == arg_9_1 and 0 or 1, var_1_10012)
			var_1_10016 = var_1_10016.setEase
			LeanTweenType = var_19

			var_1_10013(var_9_9, var_1_10016(var_1_10018, var_19.easeOutSine).uniqueId)
		end
	end

	local var_9_10 = arg_9_0.taskProxy
	local var_9_11 = var_2.getTaskVO(var_9_10, arg_9_0.taskList[arg_9_0.index])
	local var_9_12 = {}

	unpack = var_9_10

	local var_9_13, var_9_14, var_9_15 = var_9_10(var_9_11:getConfig("award_display")[1])

	var_9_12.count = var_9_15
	var_9_12.id = var_9_14
	var_9_12.type = var_9_13
	updateDrop = var_9_13

	var_9_13(arg_9_0.rtAward, var_9_12)

	local var_9_16 = var_9_11:isReceive()

	setActive = var_9_14

	local var_9_17 = arg_9_0.rtAward

	var_9_14(var_7.Find(var_9_17, "got"), var_9_16)

	setActive = var_9_14

	local var_9_18 = arg_9_0.rtAward

	var_9_14(var_7.Find(var_9_18, "get"), arg_9_0.remainCnt > 0 and not var_9_16)

	setActive = var_9_14

	var_9_14(arg_9_0.rtTask, false)

	setActive = var_9_14

	var_9_14(arg_9_0.rtTask, true)

	return
end

function var_0_1.OnDestroy(arg_11_0)
	ipairs = var_1_10001

	local var_11_0

	if not arg_11_0.LTList then
		var_11_0 = {}
	end

	for iter_11_0, iter_11_1 in var_1_10001(var_11_0) do
		LeanTween = var_1_10006

		var_1_10006.cancel(iter_11_1)
	end

	return
end

return var_0_1
