class = var_0_10000

local var_0_0 = "SixYearUsTaskScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))
local var_0_2 = {
	{
		6,
		9004
	},
	{
		16,
		1006
	}
}
local var_0_3 = 65011

function var_0_1.getUIName(arg_1_0)
	return "SixYearUsTaskPage"
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

			local var_10_1 = arg_9_0
			local var_10_2, var_10_3 = var_4.getTaskProgress(var_10_1, var_10_0)
			local var_10_4 = arg_9_0
			local var_10_5, var_10_6 = var_6.getTaskTarget(var_10_4, var_10_0)

			math = var_10_4

			local var_10_7 = var_10_4.min(var_10_2, var_10_5)

			setText = var_8

			var_8(arg_10_2:Find("frame/progress"), var_10_3 .. "/" .. var_10_6)

			local var_10_8 = arg_10_2:Find("frame/slider")
			local var_10_9 = var_8.GetComponent

			typeof = var_11
			Slider = var_13
			var_10_9(var_10_8, var_11(var_13)).value = var_10_7 / var_10_5

			local var_10_10 = arg_10_2:Find("frame/awards")
			local var_10_11 = var_9.GetChild(var_10_10, 0)
			local var_10_12 = arg_9_0

			var_11.updateAwards(var_10_12, var_10_0:getConfig("award_display"), var_9, var_10_11)

			local var_10_13 = arg_10_2:Find("frame/go_btn")
			local var_10_14 = arg_10_2:Find("frame/get_btn")
			local var_10_15 = arg_10_2:Find("frame/got_btn")

			if var_10_0:getTaskStatus() == 0 then
				setActive = var_14

				var_14(var_10_13, true)

				setActive = var_14

				var_14(var_10_14, false)

				setActive = var_14

				var_14(var_10_15, false)
			elseif var_10_0:getTaskStatus() == 1 then
				setActive = var_14

				var_14(var_10_13, false)

				setActive = var_14

				var_14(var_10_14, true)

				setActive = var_14

				var_14(var_10_15, false)
			elseif var_10_0:getTaskStatus() == 2 then
				setActive = var_14

				var_14(var_10_13, false)

				setActive = var_14

				var_14(var_10_14, false)

				setActive = var_14

				var_14(var_10_15, true)
			end

			onButton = var_14

			local var_10_16 = arg_9_0
			local var_10_17 = var_10_13

			local function var_10_18()
				local var_11_0 = arg_9_0
				local var_11_1 = var_0.emit

				SixYearUsTaskMediator = var_3_10003

				var_11_1(var_11_0, var_3_10003.ON_TASK_GO, var_10_0)

				return
			end

			SFX_PANEL = var_2_10019

			var_14(var_10_16, var_10_17, var_10_18, var_2_10019)

			onButton = var_14

			local var_10_19 = arg_9_0
			local var_10_20 = var_10_14

			local function var_10_21()
				local var_12_0 = arg_9_0

				var_0.checkAwardOverFlow(var_12_0, {
					var_10_0
				}, function()
					local var_13_0 = arg_9_0
					local var_13_1 = var_0.emit

					SixYearUsTaskMediator = var_4_10003

					var_13_1(var_13_0, var_4_10003.ON_TASK_SUBMIT, var_10_0)

					return
				end)

				return
			end

			SFX_PANEL = var_2_10019

			var_14(var_10_19, var_10_20, var_10_21, var_2_10019)
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
			local var_14_0 = arg_9_0

			var_0.checkAwardOverFlow(var_14_0, arg_9_0.canGetTaskVOs, function()
				local var_15_0 = arg_9_0
				local var_15_1 = var_0.emit

				SixYearUsTaskMediator = var_3_10003

				var_15_1(var_15_0, var_3_10003.ON_TASK_SUBMIT_ONESTEP, arg_9_0.canGetTaskIds)

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

function var_0_1.checkAwardOverFlow(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = {}
	local var_16_1 = {}

	pairs = var_1_10005

	for iter_16_0, iter_16_1 in var_1_10005(arg_16_1) do
		local var_16_2 = iter_16_1:getConfig("award_display")

		ipairs = var_1_10011

		for iter_16_2, iter_16_3 in var_1_10011(var_16_2) do
			local var_16_3 = iter_16_3
			local var_16_4 = false

			pairs = var_1_10018

			for iter_16_4, iter_16_5 in var_1_10018(var_16_1) do
				if iter_16_5[1] == var_16_3[1] and iter_16_5[2] == var_16_3[2] then
					var_16_4 = true
					iter_16_5[3] = iter_16_5[3] + var_16_3[3]

					break
				end
			end

			if not var_16_4 then
				table = var_1_10018

				var_1_10018.insert(var_16_1, {
					var_16_3[1],
					var_16_3[2],
					var_16_3[3]
				})
			end
		end
	end

	local var_16_5 = 0

	ipairs = var_6

	for iter_16_6, iter_16_7 in var_6(var_16_1) do
		if iter_16_7[2] == var_0_3 then
			var_16_5 = iter_16_7[3]
		end
	end

	getProxy = var_6
	ActivityProxy = var_8

	local var_16_6 = var_6(var_8)
	local var_16_7 = var_6.getActivityByType

	ActivityConst = iter_16_6

	local var_16_8 = var_16_7(var_16_6, iter_16_6.ACTIVITY_TYPE_TOWN)
	local var_16_9, var_16_10 = var_6.IsOverGold(var_16_8, var_16_5)
	local var_16_11
	local var_16_12

	if var_16_9 then
		var_16_12 = {
			id = var_0_3
		}
		DROP_TYPE_VITEM = var_10
		var_16_12.type = var_10

		local var_16_13 = "<color=#FF5C5CFF>"

		math = var_1_10011
		var_16_12.count = var_16_13 .. var_1_10011.abs(var_16_10) .. "</color>"
		var_16_11 = var_16_12
	end

	getProxy = var_16_12
	PlayerProxy = var_1_10011

	local var_16_14 = var_16_12(var_1_10011)
	local var_16_15 = var_9.getRawData(var_16_14)

	pg = var_1_10011

	local var_16_16 = var_1_10011.gameset.urpt_chapter_max.description[1]

	LOCK_UR_SHIP = var_16_14

	if var_16_14 then
		var_16_14 = 0
	else
		getProxy = var_16_14
		BagProxy = iter_16_2

		local var_16_17 = var_16_14(iter_16_2)

		var_16_14 = var_16_14.GetLimitCntById(var_16_17, var_16_16)
	end

	Task = var_1_10013

	local var_16_18, var_16_19 = var_1_10013.StaticJudgeOverflow(var_16_15.gold, var_16_15.oil, var_16_14, true, true, var_16_1)

	var_16_19 = var_16_19 or {}

	if var_16_11 then
		table = var_15

		var_15.insert(var_16_19, var_16_11)
	end

	if var_16_18 or var_16_9 then
		table = var_15

		var_15.insert(var_16_0, function(arg_17_0)
			pg = var_2_10001

			local var_17_0 = var_2_10001.MsgboxMgr.GetInstance()
			local var_17_1 = var_1.ShowMsgBox
			local var_17_2 = {}

			MSGBOX_TYPE_ITEM_BOX = var_2_10005
			var_17_2.type = var_2_10005
			i18n = var_2_10005
			var_17_2.content = var_2_10005("award_max_warning")
			var_17_2.items = var_16_19
			var_17_2.onYes = arg_17_0

			var_17_1(var_17_0, var_17_2)

			return
		end)
	end

	seriesAsync = var_15

	var_15(var_16_0, arg_16_2)

	return
end

function var_0_1.updateAwards(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	_ = var_1_10004

	local var_18_0 = var_1_10004.slice(arg_18_1, 1, 3)

	for iter_18_0 = arg_18_2.childCount, #var_18_0 - 1 do
		cloneTplTo = var_1_10010

		var_1_10010(arg_18_3, arg_18_2)
	end

	local var_18_1 = arg_18_2.childCount

	for iter_18_1 = 1, var_18_1 do
		local var_18_2 = arg_18_2
		local var_18_3 = arg_18_2.GetChild(var_18_2, iter_18_1 - 1)
		local var_18_4 = iter_18_1 <= #var_18_0

		setActive = var_18_2

		var_18_2(var_18_3, var_18_4)

		if var_18_4 then
			local var_18_5 = var_18_0[iter_18_1]
			local var_18_6 = {
				type = var_18_5[1],
				id = var_18_5[2],
				count = var_18_5[3]
			}

			updateDrop = var_14

			var_14(var_18_3:Find("mask"), var_18_6)

			local var_18_7 = var_18_6.type

			DROP_TYPE_EQUIPMENT_SKIN = var_15

			if var_18_7 == var_15 then
				setActive = var_18_7

				var_18_7(var_18_3:Find("specialFrame"), true)
			else
				setActive = var_18_7

				var_18_7(var_18_3:Find("specialFrame"), false)
			end

			onButton = var_18_7

			local var_18_8 = arg_18_0
			local var_18_9 = var_18_3

			local function var_18_10()
				local var_19_0 = arg_18_0
				local var_19_1 = var_0.emit

				BaseUI = var_2_10003

				var_19_1(var_19_0, var_2_10003.ON_DROP, var_18_6)

				return
			end

			SFX_PANEL = var_19

			var_18_7(var_18_8, var_18_9, var_18_10, var_19)
		end
	end

	return
end

function var_0_1.UpdateTaskData(arg_20_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_20_0 = var_1_10001(var_1_10003)
	local var_20_1 = var_1.getActivityById

	ActivityConst = var_1_10004

	local var_20_2 = var_20_1(var_20_0, var_1_10004.SIX_YEAR_US_TASK_ACT_ID)

	getProxy = var_1_10002
	ActivityProxy = var_4

	local var_20_3 = var_1_10002(var_4)
	local var_20_4 = var_2.getActivityById

	ActivityConst = var_1_10005

	local var_20_5 = var_20_4(var_20_3, var_1_10005.SIX_YEAR_US_TASK_2_ACT_ID)

	arg_20_0.taskVOs = {}

	if var_20_2 and not var_20_2:isEnd() then
		local var_20_6 = var_20_2:getConfig("config_data")

		pairs = var_20_3

		for iter_20_0, iter_20_1 in var_20_3(var_20_6) do
			table = var_1_10009
			var_1_10009 = var_1_10009.insert

			local var_20_7 = arg_20_0.taskVOs

			getProxy = var_1_10012
			TaskProxy = var_1_10014
			var_1_10014 = var_1_10012(var_1_10014)

			var_1_10009(var_20_7, var_1_10012.getTaskVO(var_1_10014, iter_20_1))
		end
	end

	if var_20_5 and not var_20_5:isEnd() then
		local var_20_8 = var_20_5:getConfig("config_data")

		pairs = var_20_3

		for iter_20_2, iter_20_3 in var_20_3(var_20_8) do
			table = var_1_10009
			var_1_10009 = var_1_10009.insert

			local var_20_9 = arg_20_0.taskVOs

			getProxy = var_1_10012
			TaskProxy = var_1_10014
			var_1_10014 = var_1_10012(var_1_10014)

			var_1_10009(var_20_9, var_1_10012.getTaskVO(var_1_10014, iter_20_3))
		end
	end

	return
end

function var_0_1.getTaskProgress(arg_21_0, arg_21_1)
	ipairs = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10002(var_0_2) do
		if iter_21_1[1] == arg_21_1:getConfig("type") and iter_21_1[2] == arg_21_1:getConfig("sub_type") then
			local var_21_0 = arg_21_1:getProgress() / 1000

			string = var_8

			local var_21_1 = var_8.format("%.2d", arg_21_1:getProgress() / 1000)

			return
		end
	end

	local var_21_2 = arg_21_1:getProgress()

	tostring = var_3

	local var_21_3 = var_3(arg_21_1:getProgress())
end

function var_0_1.getTaskTarget(arg_22_0, arg_22_1)
	ipairs = var_1_10002

	for iter_22_0, iter_22_1 in var_1_10002(var_0_2) do
		if iter_22_1[1] == arg_22_1:getConfig("type") and iter_22_1[2] == arg_22_1:getConfig("sub_type") then
			local var_22_0 = arg_22_1:getConfig("target_num") / 1000

			string = var_8

			local var_22_1 = var_8.format("%.2d", arg_22_1:getConfig("target_num") / 1000)

			return
		end
	end

	local var_22_2 = arg_22_1:getConfig("target_num")

	tostring = var_3

	local var_22_3 = var_3(arg_22_1:getConfig("target_num"))
end

function var_0_1.willExit(arg_23_0)
	pg = var_1_10001

	local var_23_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_23_0, arg_23_0._tf)

	return
end

return var_0_1
