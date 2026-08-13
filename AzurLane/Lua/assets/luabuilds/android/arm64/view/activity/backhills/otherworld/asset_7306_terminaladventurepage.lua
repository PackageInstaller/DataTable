class = var_0_10000

local var_0_0 = "TerminalAdventurePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

ActivityConst = var_0_10001
var_0_1.BIND_PT_ACT_ID = var_0_10001.OTHER_WORLD_TERMINAL_PT_ID
ActivityConst = var_1
var_0_1.BIND_TASK_ACT_ID = var_1.OTHER_WORLD_TERMINAL_TASK_ID

function var_0_1.getUIName(arg_1_0)
	return "TerminalAdventurePage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	tostring = var_1_10002
	OtherworldTerminalLayer = var_1_10004
	var_2_0.name = var_1_10002(var_1_10004.PAGE_ADVENTURE)

	local var_2_1 = arg_2_0._tf

	arg_2_0.levelTF = var_1.Find(var_2_1, "frame/level")
	setText = var_1

	local var_2_2 = arg_2_0.levelTF
	local var_2_3 = var_3.Find(var_2_2, "title/content/Text")

	i18n = var_4

	var_1(var_2_3, var_4("adventure_award_title"))

	setText = var_1

	local var_2_4 = arg_2_0.levelTF
	local var_2_5 = var_3.Find(var_2_4, "progress/title")

	i18n = var_4

	var_1(var_2_5, var_4("adventure_progress_title"))

	setText = var_1

	local var_2_6 = arg_2_0.levelTF
	local var_2_7 = var_3.Find(var_2_6, "lv")

	i18n = var_4

	var_1(var_2_7, var_4("adventure_lv_title"))

	local var_2_8 = arg_2_0.levelTF

	arg_2_0.ptIconTF = var_1.Find(var_2_8, "progress/Image")

	local var_2_9 = arg_2_0.levelTF

	arg_2_0.ptValueTF = var_1.Find(var_2_9, "progress/value")

	local var_2_10 = arg_2_0.levelTF

	arg_2_0.ptLvTF = var_1.Find(var_2_10, "lv/Text")

	local var_2_11 = arg_2_0.levelTF

	arg_2_0.awardView = var_1.Find(var_2_11, "awards/view")
	UIItemList = var_1

	local var_2_12 = var_1.New
	local var_2_13 = arg_2_0.awardView
	local var_2_14 = var_3.Find(var_2_13, "content")
	local var_2_15 = arg_2_0.awardView

	arg_2_0.awardUIList = var_2_12(var_2_14, var_4.Find(var_2_15, "content/tpl"))

	local var_2_16 = arg_2_0._tf

	arg_2_0.recordTF = var_1.Find(var_2_16, "frame/record")
	setText = var_1

	local var_2_17 = arg_2_0.recordTF
	local var_2_18 = var_3.Find(var_2_17, "title/content/Text")

	i18n = var_4

	var_1(var_2_18, var_4("adventure_record_title"))

	setText = var_1

	local var_2_19 = arg_2_0.recordTF
	local var_2_20 = var_3.Find(var_2_19, "grade")

	i18n = var_4

	var_1(var_2_20, var_4("adventure_record_grade_title"))

	local var_2_21 = arg_2_0.recordTF

	arg_2_0.recordGradeTF = var_1.Find(var_2_21, "grade/Text")
	UIItemList = var_1

	local var_2_22 = var_1.New
	local var_2_23 = arg_2_0.recordTF
	local var_2_24 = var_3.Find(var_2_23, "form")
	local var_2_25 = arg_2_0.recordTF

	arg_2_0.taskUIList = var_2_22(var_2_24, var_4.Find(var_2_25, "form/tpl"))
	setText = var_1

	local var_2_26 = arg_2_0._tf
	local var_2_27 = var_3.Find(var_2_26, "frame/tip")

	i18n = var_4

	var_1(var_2_27, var_4("adventure_award_end_tip"))

	local var_2_28 = arg_2_0._tf

	arg_2_0.getBtn = var_1.Find(var_2_28, "frame/get_all_btn")
	setText = var_1

	local var_2_29 = arg_2_0.getBtn
	local var_2_30 = var_3.Find(var_2_29, "Text")

	i18n = var_4

	var_1(var_2_30, var_4("adventure_get_all"))

	local var_2_31 = arg_2_0._tf

	arg_2_0.getGreyBtn = var_1.Find(var_2_31, "frame/get_all_btn_grey")
	setText = var_1

	local var_2_32 = arg_2_0.getGreyBtn
	local var_2_33 = var_3.Find(var_2_32, "Text")

	i18n = var_4

	var_1(var_2_33, var_4("adventure_get_all"))

	return
end

function var_0_1.OnInit(arg_3_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)
	local var_3_1 = var_1.getActivityById(var_3_0, var_0_1.BIND_PT_ACT_ID)

	assert = var_1_10002

	var_1_10002(var_3_1, "not exist bind pt act, id" .. var_0_1.BIND_PT_ACT_ID)

	ActivityPtData = var_1_10002
	arg_3_0.ptData = var_1_10002.New(var_3_1)
	getProxy = var_2
	ActivityProxy = var_4

	local var_3_2 = var_2(var_4)

	arg_3_0.taskActivity = var_2.getActivityById(var_3_2, var_0_1.BIND_TASK_ACT_ID)
	assert = var_2

	var_2(arg_3_0.taskActivity, "not exist bind task act, id" .. var_0_1.BIND_TASK_ACT_ID)

	onButton = var_2

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.getBtn

	local function var_3_5()
		local var_4_0 = arg_3_0.ptData
		local var_4_1 = var_0.GetCurrTarget(var_4_0)
		local var_4_2 = arg_3_0
		local var_4_3 = var_1.emit

		OtherworldTerminalMediator = var_2_10004

		var_4_3(var_4_2, var_2_10004.ON_GET_PT_ALL_AWARD, {
			actId = var_0_1.BIND_PT_ACT_ID,
			arg1 = var_4_1
		})

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_3_3, var_3_4, var_3_5, var_1_10007)
	arg_3_0:InitPtUI()
	arg_3_0:UpdatePtView()
	arg_3_0:InitTaskUI()
	arg_3_0:UpdateTaskView()

	return
end

function var_0_1.InitPtUI(arg_5_0)
	LoadImageSpriteAsync = var_1_10001
	Drop = var_1_10003

	local var_5_0 = var_1_10003.New
	local var_5_1 = arg_5_0.ptData
	local var_5_2 = var_5_0(var_5.GetRes(var_5_1))

	var_1_10001(var_3.getIcon(var_5_2), arg_5_0.ptIconTF, false)

	local var_5_3 = arg_5_0.awardUIList

	var_1.make(var_5_3, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = arg_6_1 + 1
			local var_6_1 = arg_5_0.ptData.dropList[var_6_0]
			local var_6_2 = arg_5_0.ptData.targets[var_6_0]

			Drop = var_2_10006

			local var_6_3 = var_2_10006.New({
				type = var_6_1[1],
				id = var_6_1[2],
				count = var_6_1[3]
			})

			updateDrop = var_2_10007

			var_2_10007(arg_6_2:Find("IconTpl"), var_6_3, {
				hideName = true
			})

			onButton = var_2_10007

			local var_6_4 = arg_5_0.binder
			local var_6_5 = arg_6_2
			local var_6_6 = arg_6_2.Find(var_6_5, "IconTpl")

			local function var_6_7()
				local var_7_0 = arg_5_0
				local var_7_1 = var_0.emit

				BaseUI = var_3_10003

				var_7_1(var_7_0, var_3_10003.ON_DROP, var_6_3)

				return
			end

			SFX_PANEL = var_6_5

			var_2_10007(var_6_4, var_6_6, var_6_7, var_6_5)

			local var_6_8 = arg_5_0.ptData
			local var_6_9 = var_7.GetLevel(var_6_8)

			setActive = var_8

			var_8(arg_6_2:Find("IconTpl/got"), var_6_0 <= var_6_9)

			setText = var_8

			var_8(arg_6_2:Find("lv"), "Lv:" .. var_6_0)

			setActive = var_8

			var_8(arg_6_2:Find("lv0"), var_6_0 == 1)

			local var_6_10 = arg_6_2:Find("progress")

			setActive = var_6_8

			var_6_8(var_6_10:Find("left"), var_6_0 ~= 1)

			setActive = var_6_8

			var_6_8(var_6_10:Find("right"), var_6_0 == #arg_5_0.ptData.targets)

			if var_6_0 <= var_6_9 then
				setSlider = var_6_8

				var_6_8(var_6_10, 0, 1, 1)
			else
				local var_6_11 = arg_5_0.ptData.targets[var_6_0]
				local var_6_12 = var_6_0 == 1 and 0 or arg_5_0.ptData.targets[var_6_0 - 1]
				local var_6_13 = arg_5_0.ptData.count

				setSlider = var_12

				var_12(var_6_10, 0, 1, (var_6_13 - var_6_12) / (var_6_11 - var_6_12))
			end
		end

		return
	end)

	return
end

function var_0_1.UpdatePt(arg_8_0, arg_8_1)
	ActivityPtData = var_1_10002
	arg_8_0.ptData = var_1_10002.New(arg_8_1)

	arg_8_0:UpdatePtView()

	return
end

function var_0_1.UpdatePtView(arg_9_0)
	local var_9_0 = arg_9_0.ptData
	local var_9_1 = var_1.CanGetAward(var_9_0)

	setActive = var_1_10002

	var_1_10002(arg_9_0.getBtn, var_9_1)

	setActive = var_1_10002

	var_1_10002(arg_9_0.getGreyBtn, not var_9_1)

	local var_9_2 = arg_9_0.ptData
	local var_9_3 = var_2.GetLevel(var_9_2)
	local var_9_4 = arg_9_0.ptData
	local var_9_5, var_9_6 = var_3.GetResProgress(var_9_4)

	setText = var_9_4

	local var_9_7 = arg_9_0.ptValueTF

	math = var_1_10008

	var_9_4(var_9_7, var_1_10008.max(var_9_6 - var_9_5, 0))

	setText = var_9_4

	var_9_4(arg_9_0.ptLvTF, var_9_3)

	local var_9_8 = arg_9_0.awardUIList

	var_5.align(var_9_8, #arg_9_0.ptData.targets)

	scrollTo = var_5

	var_5(arg_9_0.awardView, var_9_3 / #arg_9_0.ptData.targets, 0)

	return
end

function var_0_1.InitTaskUI(arg_10_0)
	local var_10_0 = arg_10_0.taskActivity

	arg_10_0.taskIds = var_1.getConfig(var_10_0, "config_data")

	local var_10_1 = arg_10_0.taskUIList

	var_1.make(var_10_1, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = arg_10_0.taskIds[arg_11_1 + 1]

			getProxy = var_4
			TaskProxy = var_2_10006

			local var_11_1 = var_4(var_2_10006)
			local var_11_2 = var_4.getTaskById(var_11_1, var_11_0)

			setText = var_2_10005

			var_2_10005(arg_11_2:Find("name"), var_11_2:getConfig("desc"))

			setText = var_2_10005

			var_2_10005(arg_11_2:Find("value"), var_11_2:getProgress())
		end

		return
	end)

	return
end

function var_0_1.UpdateTask(arg_12_0, arg_12_1)
	arg_12_0.taskActivity = arg_12_1

	arg_12_0:UpdateTaskView()

	return
end

function var_0_1.UpdateTaskView(arg_13_0)
	local var_13_0 = arg_13_0.taskUIList

	var_1.align(var_13_0, #arg_13_0.taskIds)

	setText = var_1

	var_1(arg_13_0.recordGradeTF, arg_13_0:GetAdventureGrade())

	return
end

function var_0_1.GetAdventureGrade(arg_14_0)
	local var_14_0 = arg_14_0.taskActivity
	local var_14_1 = var_1.getConfig(var_14_0, "config_client")

	ipairs = var_1_10002

	for iter_14_0, iter_14_1 in var_1_10002(var_14_1) do
		if #iter_14_1[2] > 0 then
			ipairs = var_7

			for iter_14_2, iter_14_3 in var_7(iter_14_1[2]) do
				local var_14_2 = iter_14_3[1]
				local var_14_3 = iter_14_3[2]

				getProxy = var_1_10014
				TaskProxy = var_1_10016
				var_1_10016 = var_1_10014(var_1_10016)

				if var_1_10014.getTaskById(var_1_10016, var_14_2) and var_14_3 <= var_1_10014:getProgress() then
					return iter_14_1[1]
				end
			end
		else
			return iter_14_1[1]
		end
	end

	return ""
end

function var_0_1.OnDestroy(arg_15_0)
	return
end

function var_0_1.IsTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_16_0 = var_1_10000(var_1_10002)

	if not var_0.getActivityById(var_16_0, var_0_1.BIND_PT_ACT_ID) or var_0:isEnd() then
		return false
	end

	ActivityPtData = var_1_10001

	local var_16_1 = var_1_10001.New(var_0)

	return var_1.CanGetAward(var_16_1)
end

return var_0_1
