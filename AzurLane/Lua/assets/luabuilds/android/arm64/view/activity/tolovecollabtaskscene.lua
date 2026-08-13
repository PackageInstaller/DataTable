class = var_0_10000

local var_0_0 = "ToLoveCollabTaskScene"

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
	return "ToLoveCollabTaskPage"
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
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.bg

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)
	arg_3_0:Show()

	pg = var_1

	local var_3_6 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_6, arg_3_0._tf)

	return
end

function var_0_1.Show(arg_6_0)
	arg_6_0:UpdateTaskData()

	arg_6_0.canGetTaskVOs = {}
	arg_6_0.canGetTaskIds = {}

	arg_6_0:sort(arg_6_0.taskVOs)
	arg_6_0:UpdateList(arg_6_0.taskVOs)

	Canvas = var_1

	var_1.ForceUpdateCanvases()

	return
end

function var_0_1.sort(arg_7_0, arg_7_1)
	local var_7_0 = {}

	arg_7_0.canGetAward = false
	pairs = var_3

	for iter_7_0, iter_7_1 in var_3(arg_7_1) do
		if iter_7_1:getTaskStatus() == 1 then
			table = var_8

			var_8.insert(var_7_0, iter_7_1)

			table = var_8

			var_8.insert(arg_7_0.canGetTaskVOs, iter_7_1)

			table = var_8

			var_8.insert(arg_7_0.canGetTaskIds, iter_7_1.id)

			arg_7_0.canGetAward = true
		end
	end

	pairs = var_3

	for iter_7_2, iter_7_3 in var_3(arg_7_1) do
		if iter_7_3:getTaskStatus() == 0 then
			table = var_8

			var_8.insert(var_7_0, iter_7_3)
		end
	end

	pairs = var_3

	for iter_7_4, iter_7_5 in var_3(arg_7_1) do
		if iter_7_5:getTaskStatus() == 2 then
			table = var_8

			var_8.insert(var_7_0, iter_7_5)
		end
	end

	arg_7_0.taskVOs = var_7_0

	return
end

function var_0_1.UpdateList(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.UIlist

	var_2.make(var_8_0, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			local var_9_0 = arg_8_1[arg_9_1 + 1]
			local var_9_1 = arg_8_0
			local var_9_2, var_9_3 = var_4.getTaskProgress(var_9_1, var_9_0)
			local var_9_4 = arg_8_0
			local var_9_5, var_9_6 = var_6.getTaskTarget(var_9_4, var_9_0)

			math = var_9_4

			local var_9_7 = var_9_4.min(var_9_2, var_9_5)

			setText = var_8

			local var_9_8 = arg_9_2:Find("frame/desc")
			local var_9_9 = var_9_0
			local var_9_10 = var_9_0.getConfig(var_9_9, "desc")
			local var_9_11 = " ("

			tostring = var_9_9

			var_8(var_9_8, var_9_10 .. var_9_11 .. var_9_9(var_9_7) .. "/" .. var_9_6 .. ")")

			local var_9_12 = arg_9_2:Find("frame/slider")
			local var_9_13 = var_8.GetComponent

			typeof = var_11
			Slider = var_13
			var_9_13(var_9_12, var_11(var_13)).value = var_9_7 / var_9_5

			local var_9_14 = arg_9_2:Find("frame/awards")
			local var_9_15 = var_9.GetChild(var_9_14, 0)
			local var_9_16 = arg_8_0

			var_11.updateAwards(var_9_16, var_9_0:getConfig("award_display"), var_9, var_9_15)

			local var_9_17 = arg_9_2:Find("frame/go_btn")
			local var_9_18 = arg_9_2:Find("frame/get_btn")
			local var_9_19 = arg_9_2:Find("frame/got_btn")
			local var_9_20 = arg_9_2:Find("frame/bg_go")
			local var_9_21 = arg_9_2
			local var_9_22 = arg_9_2.Find(var_9_21, "frame/bg_get")
			local var_9_23 = arg_9_2:Find("frame/bg_got")

			setActive = var_9_21

			var_9_21(var_9_17, var_9_0:getTaskStatus() == 0)

			setActive = var_9_21

			var_9_21(var_9_20, var_9_0:getTaskStatus() == 0)

			setActive = var_9_21

			var_9_21(var_9_18, var_9_0:getTaskStatus() == 1)

			setActive = var_9_21

			var_9_21(var_9_22, var_9_0:getTaskStatus() == 1)

			setActive = var_9_21

			var_9_21(var_9_19, var_9_0:getTaskStatus() == 2)

			setActive = var_9_21

			local var_9_24 = var_9_23
			local var_9_25 = var_9_0

			var_9_21(var_9_24, var_9_0.getTaskStatus(var_9_25) == 2)

			onButton = var_9_21

			local var_9_26 = arg_8_0
			local var_9_27 = var_9_17

			local function var_9_28()
				local var_10_0 = arg_8_0
				local var_10_1 = var_0.emit

				ToLoveCollabTaskMediator = var_3_10003

				var_10_1(var_10_0, var_3_10003.ON_TASK_GO, var_9_0)

				return
			end

			SFX_PANEL = var_9_25

			var_9_21(var_9_26, var_9_27, var_9_28, var_9_25)

			onButton = var_9_21

			local var_9_29 = arg_8_0
			local var_9_30 = var_9_18

			local function var_9_31()
				local var_11_0 = arg_8_0

				var_0.checkAwardOverFlow(var_11_0, {
					var_9_0
				}, function()
					local var_12_0 = arg_8_0
					local var_12_1 = var_0.emit

					ToLoveCollabTaskMediator = var_4_10003

					var_12_1(var_12_0, var_4_10003.ON_TASK_SUBMIT, var_9_0)

					return
				end)

				return
			end

			SFX_PANEL = var_9_25

			var_9_21(var_9_29, var_9_30, var_9_31, var_9_25)
		end

		return
	end)

	local var_8_1 = arg_8_0.UIlist

	var_2.align(var_8_1, #arg_8_1)

	if arg_8_0.canGetAward then
		setActive = var_2

		var_2(arg_8_0.getBtn, true)

		onButton = var_2

		local var_8_2 = arg_8_0
		local var_8_3 = arg_8_0.getBtn

		local function var_8_4()
			local var_13_0 = arg_8_0

			var_0.checkAwardOverFlow(var_13_0, arg_8_0.canGetTaskVOs, function()
				local var_14_0 = arg_8_0
				local var_14_1 = var_0.emit

				ToLoveCollabTaskMediator = var_3_10003

				var_14_1(var_14_0, var_3_10003.ON_TASK_SUBMIT_ONESTEP, arg_8_0.canGetTaskIds)

				return
			end)

			return
		end

		SFX_PANEL = var_1_10007

		var_2(var_8_2, var_8_3, var_8_4, var_1_10007)
	else
		setActive = var_2

		var_2(arg_8_0.getBtn, false)

		removeOnButton = var_2

		var_2(arg_8_0.getBtn)
	end

	return
end

function var_0_1.checkAwardOverFlow(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {}
	local var_15_1 = {}

	pairs = var_1_10005

	for iter_15_0, iter_15_1 in var_1_10005(arg_15_1) do
		var_1_10010 = iter_15_1:getConfig("award_display")
		ipairs = var_1_10011

		for iter_15_2, iter_15_3 in var_1_10011(var_1_10010) do
			local var_15_2 = iter_15_3
			local var_15_3 = false

			pairs = var_1_10018

			for iter_15_4, iter_15_5 in var_1_10018(var_15_1) do
				if iter_15_5[1] == var_15_2[1] and iter_15_5[2] == var_15_2[2] then
					var_15_3 = true
					iter_15_5[3] = iter_15_5[3] + var_15_2[3]

					break
				end
			end

			if not var_15_3 then
				table = var_1_10018

				var_1_10018.insert(var_15_1, {
					var_15_2[1],
					var_15_2[2],
					var_15_2[3]
				})
			end
		end
	end

	getProxy = var_5
	PlayerProxy = var_7

	local var_15_4 = var_5(var_7)
	local var_15_5 = var_5.getRawData(var_15_4)

	pg = var_7

	local var_15_6 = var_7.gameset.urpt_chapter_max.description[1]

	LOCK_UR_SHIP = var_15_4

	if var_15_4 then
		var_15_4 = 0
	else
		getProxy = var_15_4
		BagProxy = var_1_10010

		local var_15_7 = var_15_4(var_1_10010)

		var_15_4 = var_15_4.GetLimitCntById(var_15_7, var_15_6)
	end

	Task = iter_15_1

	local var_15_8, var_15_9 = iter_15_1.StaticJudgeOverflow(var_15_5.gold, var_15_5.oil, var_15_4, true, true, var_15_1)

	if var_15_8 then
		table = var_11

		var_11.insert(var_15_0, function(arg_16_0)
			pg = var_2_10001

			local var_16_0 = var_2_10001.MsgboxMgr.GetInstance()
			local var_16_1 = var_1.ShowMsgBox
			local var_16_2 = {}

			MSGBOX_TYPE_ITEM_BOX = var_2_10005
			var_16_2.type = var_2_10005
			i18n = var_2_10005
			var_16_2.content = var_2_10005("award_max_warning")
			var_16_2.items = var_15_9
			var_16_2.onYes = arg_16_0

			var_16_1(var_16_0, var_16_2)

			return
		end)
	end

	seriesAsync = var_11

	var_11(var_15_0, arg_15_2)

	return
end

function var_0_1.updateAwards(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	_ = var_1_10004

	local var_17_0 = var_1_10004.slice(arg_17_1, 1, 3)

	for iter_17_0 = arg_17_2.childCount, #var_17_0 - 1 do
		cloneTplTo = var_1_10010

		var_1_10010(arg_17_3, arg_17_2)
	end

	local var_17_1 = arg_17_2.childCount

	for iter_17_1 = 1, var_17_1 do
		local var_17_2 = arg_17_2
		local var_17_3 = arg_17_2.GetChild(var_17_2, iter_17_1 - 1)
		local var_17_4 = iter_17_1 <= #var_17_0

		setActive = var_17_2

		var_17_2(var_17_3, var_17_4)

		if var_17_4 then
			local var_17_5 = var_17_0[iter_17_1]
			local var_17_6 = {
				type = var_17_5[1],
				id = var_17_5[2],
				count = var_17_5[3]
			}

			updateDrop = var_14

			var_14(var_17_3:Find("mask"), var_17_6)

			local var_17_7 = var_17_6.type

			DROP_TYPE_EQUIPMENT_SKIN = var_15

			if var_17_7 == var_15 then
				setActive = var_17_7

				var_17_7(var_17_3:Find("specialFrame"), true)
			else
				setActive = var_17_7

				var_17_7(var_17_3:Find("specialFrame"), false)
			end

			onButton = var_17_7

			local var_17_8 = arg_17_0
			local var_17_9 = var_17_3

			local function var_17_10()
				local var_18_0 = arg_17_0
				local var_18_1 = var_0.emit

				BaseUI = var_2_10003

				var_18_1(var_18_0, var_2_10003.ON_DROP, var_17_6)

				return
			end

			SFX_PANEL = var_19

			var_17_7(var_17_8, var_17_9, var_17_10, var_19)
		end
	end

	return
end

function var_0_1.UpdateTaskData(arg_19_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_19_0 = var_1_10001(var_1_10003)
	local var_19_1 = var_1.getActivityById

	ActivityConst = var_1_10004

	local var_19_2 = var_19_1(var_19_0, var_1_10004.TOLOVE_TASK_ID)

	arg_19_0.taskVOs = {}

	if var_19_2 and not var_19_2:isEnd() then
		local var_19_3 = var_19_2:getConfig("config_data")

		pairs = var_19_0

		for iter_19_0, iter_19_1 in var_19_0(var_19_3) do
			table = var_1_10008
			var_1_10008 = var_1_10008.insert

			local var_19_4 = arg_19_0.taskVOs

			getProxy = var_1_10011
			TaskProxy = var_1_10013
			var_1_10013 = var_1_10011(var_1_10013)

			var_1_10008(var_19_4, var_1_10011.getTaskVO(var_1_10013, iter_19_1))
		end
	end

	return
end

function var_0_1.getTaskProgress(arg_20_0, arg_20_1)
	ipairs = var_1_10002

	for iter_20_0, iter_20_1 in var_1_10002(var_0_2) do
		if iter_20_1[1] == arg_20_1:getConfig("type") and iter_20_1[2] == arg_20_1:getConfig("sub_type") then
			local var_20_0 = arg_20_1:getProgress() / 1000

			string = var_8

			local var_20_1 = var_8.format("%.2d", arg_20_1:getProgress() / 1000)

			return
		end
	end

	local var_20_2 = arg_20_1:getProgress()

	tostring = var_3

	local var_20_3 = var_3(arg_20_1:getProgress())
end

function var_0_1.getTaskTarget(arg_21_0, arg_21_1)
	ipairs = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10002(var_0_2) do
		if iter_21_1[1] == arg_21_1:getConfig("type") and iter_21_1[2] == arg_21_1:getConfig("sub_type") then
			local var_21_0 = arg_21_1:getConfig("target_num") / 1000

			string = var_8

			local var_21_1 = var_8.format("%.2d", arg_21_1:getConfig("target_num") / 1000)

			return
		end
	end

	local var_21_2 = arg_21_1:getConfig("target_num")

	tostring = var_3

	local var_21_3 = var_3(arg_21_1:getConfig("target_num"))
end

function var_0_1.willExit(arg_22_0)
	pg = var_1_10001

	local var_22_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_22_0, arg_22_0._tf)

	return
end

return var_0_1
