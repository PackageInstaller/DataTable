class = var_0_10000

local var_0_0 = "ChildishnessSchoolTaskPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "ChildishnessSchoolTaskPage"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.bg = var_1.Find(var_2_0, "bg")

	local var_2_1 = arg_2_0._tf

	arg_2_0.scrollPanel = var_1.Find(var_2_1, "window/panel")
	UIItemList = var_1

	local var_2_2 = var_1.New
	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_3.Find(var_2_3, "window/panel/list")
	local var_2_5 = arg_2_0._tf

	arg_2_0.UIlist = var_2_2(var_2_4, var_4.Find(var_2_5, "window/panel/list/Tasktpl"))

	local var_2_6 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_6, "window/top/btnBack")

	local var_2_7 = arg_2_0._tf

	arg_2_0.getBtn = var_1.Find(var_2_7, "window/btn_get")

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.closeBtn

	local function var_3_2()
		local var_4_0 = arg_3_0.anim

		var_0.Play(var_4_0, "anim_kinder_schoolPT_out")

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.bg

	local function var_3_5()
		local var_5_0 = arg_3_0.anim

		var_0.Play(var_5_0, "anim_kinder_schoolPT_out")

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)
	arg_3_0:Show()

	local var_3_6 = arg_3_0._tf
	local var_3_7 = var_1.GetComponent

	typeof = var_3_4
	Animation = var_1_10006
	arg_3_0.anim = var_3_7(var_3_6, var_3_4(var_1_10006))

	local var_3_8 = arg_3_0.anim
	local var_3_9 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_3_0.animEvent = var_3_9(var_3_8, var_4(var_1_10006))

	local var_3_10 = arg_3_0.animEvent

	var_1.SetEndEvent(var_3_10, function()
		local var_6_0 = arg_3_0

		var_0.closeView(var_6_0)

		return
	end)

	pg = var_1

	local var_3_11 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_11, arg_3_0._tf)

	return
end

function var_0_1.Show(arg_7_0)
	arg_7_0:UpdateTaskData()

	arg_7_0.canGetTaskVOs = {}
	arg_7_0.canGetTaskIds = {}

	arg_7_0:sort(arg_7_0.taskVOs)
	arg_7_0:UpdateList(arg_7_0.taskVOs)

	Canvas = var_1

	var_1.ForceUpdateCanvases()

	return
end

function var_0_1.sort(arg_8_0, arg_8_1)
	local var_8_0 = {}

	arg_8_0.canGetAward = false
	pairs = var_3

	for iter_8_0, iter_8_1 in var_3(arg_8_1) do
		if iter_8_1:getTaskStatus() == 1 then
			table = var_8

			var_8.insert(var_8_0, iter_8_1)

			table = var_8

			var_8.insert(arg_8_0.canGetTaskVOs, iter_8_1)

			table = var_8

			var_8.insert(arg_8_0.canGetTaskIds, iter_8_1.id)

			arg_8_0.canGetAward = true
		end
	end

	pairs = var_3

	for iter_8_2, iter_8_3 in var_3(arg_8_1) do
		if iter_8_3:getTaskStatus() == 0 then
			table = var_8

			var_8.insert(var_8_0, iter_8_3)
		end
	end

	pairs = var_3

	for iter_8_4, iter_8_5 in var_3(arg_8_1) do
		if iter_8_5:getTaskStatus() == 2 then
			table = var_8

			var_8.insert(var_8_0, iter_8_5)
		end
	end

	arg_8_0.taskVOs = var_8_0

	return
end

function var_0_1.UpdateList(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.UIlist

	var_2.make(var_9_0, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = arg_9_1[arg_10_1 + 1]

			setText = var_4

			var_4(arg_10_2:Find("frame/desc"), var_10_0:getConfig("desc"))

			local var_10_1 = var_10_0
			local var_10_2 = var_10_0.getProgress(var_10_1)
			local var_10_3 = var_10_0:getConfig("target_num")

			math = var_10_1

			local var_10_4 = var_10_1.min(var_10_2, var_10_3)

			setText = var_6

			var_6(arg_10_2:Find("frame/progress"), var_10_4 .. "/" .. var_10_3)

			local var_10_5 = arg_10_2:Find("frame/slider")
			local var_10_6 = var_6.GetComponent

			typeof = var_9
			Slider = var_11
			var_10_6(var_10_5, var_9(var_11)).value = var_10_4 / var_10_3

			local var_10_7 = arg_10_2:Find("frame/awards")
			local var_10_8 = var_7.GetChild(var_10_7, 0)
			local var_10_9 = arg_9_0

			var_9.updateAwards(var_10_9, var_10_0:getConfig("award_display"), var_7, var_10_8)

			local var_10_10 = arg_10_2:Find("frame/go_btn")
			local var_10_11 = arg_10_2:Find("frame/get_btn")
			local var_10_12 = arg_10_2:Find("frame/got_btn")

			if var_10_0:getTaskStatus() == 0 then
				setActive = var_12

				var_12(var_10_10, true)

				setActive = var_12

				var_12(var_10_11, false)

				setActive = var_12

				var_12(var_10_12, false)
			elseif var_10_0:getTaskStatus() == 1 then
				setActive = var_12

				var_12(var_10_10, false)

				setActive = var_12

				var_12(var_10_11, true)

				setActive = var_12

				var_12(var_10_12, false)
			elseif var_10_0:getTaskStatus() == 2 then
				setActive = var_12

				var_12(var_10_10, false)

				setActive = var_12

				var_12(var_10_11, false)

				setActive = var_12

				var_12(var_10_12, true)
			end

			onButton = var_12

			local var_10_13 = arg_9_0
			local var_10_14 = var_10_10

			local function var_10_15()
				local var_11_0 = arg_9_0
				local var_11_1 = var_0.emit

				ChildishnessSchoolTaskMediator = var_3_10003

				var_11_1(var_11_0, var_3_10003.ON_TASK_GO, var_10_0)

				return
			end

			SFX_PANEL = var_2_10017

			var_12(var_10_13, var_10_14, var_10_15, var_2_10017)

			onButton = var_12

			local var_10_16 = arg_9_0
			local var_10_17 = var_10_11

			local function var_10_18()
				local var_12_0 = arg_9_0
				local var_12_1 = var_0.emit

				ChildishnessSchoolTaskMediator = var_3_10003

				var_12_1(var_12_0, var_3_10003.ON_TASK_SUBMIT, var_10_0)

				return
			end

			SFX_PANEL = var_2_10017

			var_12(var_10_16, var_10_17, var_10_18, var_2_10017)
		end

		return
	end)

	local var_9_1 = arg_9_0.UIlist

	var_2.align(var_9_1, #arg_9_1)

	if arg_9_0.canGetAward then
		setActive = var_2

		var_2(arg_9_0.getBtn, true)

		onButton = var_2

		local var_9_2 = arg_9_0
		local var_9_3 = arg_9_0.getBtn

		local function var_9_4()
			local var_13_0 = {}
			local var_13_1 = {}

			pairs = var_2_10002

			for iter_13_0, iter_13_1 in var_2_10002(arg_9_0.canGetTaskVOs) do
				var_2_10007 = iter_13_1:getConfig("award_display")
				ipairs = var_2_10008

				for iter_13_2, iter_13_3 in var_2_10008(var_2_10007) do
					local var_13_2 = iter_13_3
					local var_13_3 = false

					pairs = var_2_10015

					for iter_13_4, iter_13_5 in var_2_10015(var_13_1) do
						if iter_13_5[1] == var_13_2[1] and iter_13_5[2] == var_13_2[2] then
							var_13_3 = true
							iter_13_5[3] = iter_13_5[3] + var_13_2[3]

							break
						end
					end

					if not var_13_3 then
						table = var_2_10015

						var_2_10015.insert(var_13_1, var_13_2)
					end
				end
			end

			getProxy = var_2
			PlayerProxy = var_4

			local var_13_4 = var_2(var_4)
			local var_13_5 = var_2.getRawData(var_13_4)

			pg = var_4

			local var_13_6 = var_4.gameset.urpt_chapter_max.description[1]

			LOCK_UR_SHIP = var_13_4

			if var_13_4 then
				var_13_4 = 0
			else
				getProxy = var_13_4
				BagProxy = var_2_10007

				local var_13_7 = var_13_4(var_2_10007)

				var_13_4 = var_13_4.GetLimitCntById(var_13_7, var_13_6)
			end

			Task = iter_13_1

			local var_13_8, var_13_9 = iter_13_1.StaticJudgeOverflow(var_13_5.gold, var_13_5.oil, var_13_4, true, true, var_13_1)

			if var_13_8 then
				table = var_8

				var_8.insert(var_13_0, function(arg_14_0)
					pg = var_3_10001

					local var_14_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_14_1 = var_1.ShowMsgBox
					local var_14_2 = {}

					MSGBOX_TYPE_ITEM_BOX = var_3_10005
					var_14_2.type = var_3_10005
					i18n = var_3_10005
					var_14_2.content = var_3_10005("award_max_warning")
					var_14_2.items = var_13_9
					var_14_2.onYes = arg_14_0

					var_14_1(var_14_0, var_14_2)

					return
				end)
			end

			seriesAsync = var_8

			var_8(var_13_0, function()
				local var_15_0 = arg_9_0
				local var_15_1 = var_0.emit

				ChildishnessSchoolTaskMediator = var_3_10003

				local var_15_2 = var_3_10003.ON_TASK_SUBMIT_ONESTEP

				ActivityConst = var_3_10004

				var_15_1(var_15_0, var_15_2, var_3_10004.ALVIT_TASK_ACT_ID, arg_9_0.canGetTaskIds)

				return
			end)

			return
		end

		SFX_PANEL = var_1_10007

		var_2(var_9_2, var_9_3, var_9_4, var_1_10007)
	else
		setActive = var_2

		var_2(arg_9_0.getBtn, false)

		removeOnButton = var_2

		var_2(arg_9_0.getBtn)
	end

	return
end

function var_0_1.updateAwards(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	_ = var_1_10004

	local var_16_0 = var_1_10004.slice(arg_16_1, 1, 3)

	for iter_16_0 = arg_16_2.childCount, #var_16_0 - 1 do
		cloneTplTo = var_1_10010

		var_1_10010(arg_16_3, arg_16_2)
	end

	local var_16_1 = arg_16_2.childCount

	for iter_16_1 = 1, var_16_1 do
		local var_16_2 = arg_16_2
		local var_16_3 = arg_16_2.GetChild(var_16_2, iter_16_1 - 1)
		local var_16_4 = iter_16_1 <= #var_16_0

		setActive = var_16_2

		var_16_2(var_16_3, var_16_4)

		if var_16_4 then
			local var_16_5 = var_16_0[iter_16_1]
			local var_16_6 = {
				type = var_16_5[1],
				id = var_16_5[2],
				count = var_16_5[3]
			}

			updateDrop = var_14

			var_14(var_16_3:Find("mask"), var_16_6)

			local var_16_7 = var_16_6.type

			DROP_TYPE_EQUIPMENT_SKIN = var_15

			if var_16_7 == var_15 then
				setActive = var_16_7

				var_16_7(var_16_3:Find("specialFrame"), true)
			else
				setActive = var_16_7

				var_16_7(var_16_3:Find("specialFrame"), false)
			end

			onButton = var_16_7

			local var_16_8 = arg_16_0
			local var_16_9 = var_16_3

			local function var_16_10()
				local var_17_0 = arg_16_0
				local var_17_1 = var_0.emit

				BaseUI = var_2_10003

				var_17_1(var_17_0, var_2_10003.ON_DROP, var_16_6)

				return
			end

			SFX_PANEL = var_19

			var_16_7(var_16_8, var_16_9, var_16_10, var_19)
		end
	end

	return
end

function var_0_1.UpdateTaskData(arg_18_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_18_0 = var_1_10001(var_1_10003)
	local var_18_1 = var_1.getActivityById

	ActivityConst = var_1_10004

	local var_18_2 = var_18_1(var_18_0, var_1_10004.ALVIT_TASK_ACT_ID)

	arg_18_0.taskVOs = {}

	local var_18_3 = var_18_2:getConfig("config_data")

	pairs = var_18_0

	for iter_18_0, iter_18_1 in var_18_0(var_18_3) do
		table = var_1_10008
		var_1_10008 = var_1_10008.insert

		local var_18_4 = arg_18_0.taskVOs

		getProxy = var_1_10011
		TaskProxy = var_1_10013
		var_1_10013 = var_1_10011(var_1_10013)

		var_1_10008(var_18_4, var_1_10011.getTaskVO(var_1_10013, iter_18_1))
	end

	return
end

function var_0_1.willExit(arg_19_0)
	pg = var_1_10001

	local var_19_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_19_0, arg_19_0._tf)

	return
end

return var_0_1
