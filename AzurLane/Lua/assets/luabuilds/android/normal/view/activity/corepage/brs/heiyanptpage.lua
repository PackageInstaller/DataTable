class = var_0_10000

local var_0_0 = "HeiYanPtPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.task_bg = var_1.Find(var_1_1, "task_bg")

	local var_1_2 = arg_1_0.task_bg

	arg_1_0.slider = var_1.Find(var_1_2, "slider")

	local var_1_3 = arg_1_0.task_bg

	arg_1_0.step = var_1.Find(var_1_3, "step")

	local var_1_4 = arg_1_0.task_bg

	arg_1_0.progress = var_1.Find(var_1_4, "progress")

	local var_1_5 = arg_1_0.task_bg

	arg_1_0.progres = var_1.Find(var_1_5, "progres")

	local var_1_6 = arg_1_0.task_bg

	arg_1_0.displayBtn = var_1.Find(var_1_6, "display_btn")

	local var_1_7 = arg_1_0.task_bg

	arg_1_0.awardTF = var_1.Find(var_1_7, "award")

	local var_1_8 = arg_1_0.task_bg

	arg_1_0.battleBtn = var_1.Find(var_1_8, "battle_btn")

	local var_1_9 = arg_1_0.task_bg

	arg_1_0.getBtn = var_1.Find(var_1_9, "get_btn")

	local var_1_10 = arg_1_0.task_bg

	arg_1_0.gotBtn = var_1.Find(var_1_10, "got_btn")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	if arg_2_0.ptData then
		local var_2_0 = arg_2_0.ptData

		var_1.Update(var_2_0, arg_2_0.activity)
	else
		ActivityPtData = var_1
		arg_2_0.ptData = var_1.New(arg_2_0.activity)
	end

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.displayBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_4_2 = var_2_10002.SHOW_AWARD_WINDOW

		PtAwardWindow = var_2_10003

		local var_4_3 = {
			blur = true,
			type = arg_3_0.ptData.type,
			dropList = arg_3_0.ptData.dropList,
			targets = arg_3_0.ptData.targets,
			level = arg_3_0.ptData.level,
			count = arg_3_0.ptData.count,
			resId = arg_3_0.ptData.resId
		}
		local var_4_4 = arg_3_0.ptData

		var_4_3.unlockStamps = var_5.GetDayUnlockStamps(var_4_4)

		var_4_1(var_4_0, var_4_2, var_2_10003, var_4_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.battleBtn

	local function var_3_5()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.SPECIAL_BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.getBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.GetAllAward(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)
	arg_3_0:OnUpdateFlush()

	return
end

function var_0_1.GetAllAward(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = arg_7_0.ptData
	local var_7_2 = var_2.GetAward(var_7_1)

	getProxy = var_7_1
	PlayerProxy = var_1_10004

	local var_7_3 = var_7_1(var_1_10004)
	local var_7_4 = var_3.getRawData(var_7_3)

	pg = var_7_3

	local var_7_5 = var_7_3.gameset.urpt_chapter_max.description[1]

	LOCK_UR_SHIP = var_1_10006

	if var_1_10006 then
		var_1_10006 = 0
	else
		getProxy = var_1_10006
		BagProxy = var_1_10007
		var_1_10007 = var_1_10006(var_1_10007)
		var_1_10006 = var_1_10006.GetLimitCntById(var_1_10007, var_7_5)
	end

	Task = var_1_10007

	local var_7_6, var_7_7 = var_1_10007.StaticJudgeOverflow(var_7_4.gold, var_7_4.oil, var_1_10006, true, true, {
		{
			var_7_2.type,
			var_7_2.id,
			var_7_2.count
		}
	})

	if var_7_6 then
		table = var_9

		var_9.insert(var_7_0, function(arg_8_0)
			pg = var_2_10001

			local var_8_0 = var_2_10001.MsgboxMgr.GetInstance()
			local var_8_1 = var_1.ShowMsgBox
			local var_8_2 = {}

			MSGBOX_TYPE_ITEM_BOX = var_2_10004
			var_8_2.type = var_2_10004
			i18n = var_2_10004
			var_8_2.content = var_2_10004("award_max_warning")
			var_8_2.items = var_7_7
			var_8_2.onYes = arg_8_0

			var_8_1(var_8_0, var_8_2)

			return
		end)
	end

	seriesAsync = var_9

	var_9(var_7_0, function()
		local var_9_0 = arg_7_0.ptData
		local var_9_1, var_9_2 = var_0.GetResProgress(var_9_0)
		local var_9_3 = arg_7_0
		local var_9_4 = var_2.emit

		ActivityMediator = var_2_10004

		local var_9_5 = var_2_10004.EVENT_PT_OPERATION
		local var_9_6 = {
			cmd = 1
		}
		local var_9_7 = arg_7_0.ptData

		var_9_6.activity_id = var_6.GetId(var_9_7)
		var_9_6.arg1 = var_9_2

		var_9_4(var_9_3, var_9_5, var_9_6)

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_10_0)
	local var_10_0 = arg_10_0.ptData
	local var_10_1, var_10_2, var_10_3 = var_1.GetLevelProgress(var_10_0)

	if arg_10_0.step then
		setText = var_4

		var_4(arg_10_0.step, var_10_1 .. "/" .. var_10_2)
	end

	local var_10_4 = arg_10_0.activity
	local var_10_5 = var_4.getConfig(var_10_4, "config_client").story

	checkExist = var_10_4

	if var_10_4(var_10_5, {
		var_10_1
	}, {
		1
	}) then
		pg = var_5

		local var_10_6 = var_5.NewStoryMgr.GetInstance()

		var_5.Play(var_10_6, var_10_5[var_10_1][1])
	end

	local var_10_7 = arg_10_0.ptData
	local var_10_8, var_10_9, var_10_10 = var_5.GetResProgress(var_10_7)

	setText = var_8

	var_8(arg_10_0.progress, "/" .. var_10_9)

	setText = var_8

	local var_10_11 = arg_10_0.progres

	if 1 <= var_10_10 then
		setColorStr = var_10

		local var_10_12

		if not var_10(var_10_8, "#6ef0ff") then
			var_10_12 = var_10_8
		end

		var_8(var_10_11, var_10_12)

		setSlider = var_8

		var_8(arg_10_0.slider, 0, 1, var_10_10)

		local var_10_13 = arg_10_0.ptData
		local var_10_14 = var_8.CanGetAward(var_10_13)
		local var_10_15 = arg_10_0.ptData
		local var_10_16 = var_9.CanGetNextAward(var_10_15)
		local var_10_17 = arg_10_0.ptData
		local var_10_18 = var_10.CanGetMorePt(var_10_17)

		setActive = var_10_17

		var_10_17(arg_10_0.battleBtn, var_10_18 and not var_10_14 and var_10_16)

		setActive = var_10_17

		var_10_17(arg_10_0.getBtn, var_10_14)

		setActive = var_10_17

		var_10_17(arg_10_0.gotBtn, not var_10_16)

		local var_10_19 = arg_10_0.ptData
		local var_10_20 = var_11.GetAward(var_10_19)

		updateDrop = var_10_19

		var_10_19(arg_10_0.awardTF, var_10_20)

		onButton = var_10_19

		local var_10_21 = arg_10_0
		local var_10_22 = arg_10_0.awardTF

		local function var_10_23()
			local var_11_0 = arg_10_0
			local var_11_1 = var_0.emit

			BaseUI = var_2_10002

			var_11_1(var_11_0, var_2_10002.ON_DROP, var_10_20)

			return
		end

		SFX_PANEL = var_1_10016

		var_10_19(var_10_21, var_10_22, var_10_23, var_1_10016)

		return
	end
end

function var_0_1.OnDestroy(arg_12_0)
	return
end

function var_0_1.GetWorldPtData(arg_13_0, arg_13_1)
	pg = var_1_10002

	local var_13_0 = var_1_10002.TimeMgr.GetInstance()
	local var_13_1 = var_2.GetServerTime(var_13_0)

	ActivityMainScene = var_13_0

	local var_13_2

	if not var_13_0.Data2Time then
		var_13_2 = 0
	end

	if arg_13_1 <= var_13_1 - var_13_2 then
		ActivityMainScene = var_2
		pg = var_13_2

		local var_13_3 = var_13_2.TimeMgr.GetInstance()

		var_2.Data2Time = var_3.GetServerTime(var_13_3)

		local var_13_4 = arg_13_0
		local var_13_5 = arg_13_0.emit

		ActivityMediator = var_13_3

		local var_13_6 = var_13_3.EVENT_PT_OPERATION
		local var_13_7 = {
			cmd = 2
		}
		local var_13_8 = arg_13_0.ptData

		var_13_7.activity_id = var_6.GetId(var_13_8)

		var_13_5(var_13_4, var_13_6, var_13_7)
	end

	return
end

return var_0_1
