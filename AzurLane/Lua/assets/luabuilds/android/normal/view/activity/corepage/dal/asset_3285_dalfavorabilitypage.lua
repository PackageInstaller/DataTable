class = var_0_10000

local var_0_0 = "DALFavorabilityPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.progres = var_1.Find(var_1_1, "progres")

	local var_1_2 = arg_1_0.bg

	arg_1_0.awardTF = var_1.Find(var_1_2, "award")

	local var_1_3 = arg_1_0.bg

	arg_1_0.battleBtn = var_1.Find(var_1_3, "battle_btn")

	local var_1_4 = arg_1_0.bg

	arg_1_0.getBtn = var_1.Find(var_1_4, "get_btn")

	local var_1_5 = arg_1_0.bg

	arg_1_0.gotBtn = var_1.Find(var_1_5, "got_btn")

	local var_1_6 = arg_1_0.bg

	arg_1_0.displayBtn = var_1.Find(var_1_6, "display_btn")

	local var_1_7 = arg_1_0.bg

	arg_1_0.vx_get = var_1.Find(var_1_7, "vx_get")

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
	SetActive = var_1_10001

	var_1_10001(arg_3_0.vx_get, false)

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

	SetActive = var_9

	var_9(arg_7_0.vx_get, true)

	return
end

function var_0_1.OnUpdateFlush(arg_10_0)
	local var_10_0 = arg_10_0.ptData
	local var_10_1 = var_1.GetAward(var_10_0)

	updateDrop = var_10_0

	local var_10_2 = arg_10_0.awardTF

	var_10_0(var_3.Find(var_10_2, "IconTpl"), var_10_1)

	local var_10_3 = arg_10_0.ptData
	local var_10_4, var_10_5, var_10_6 = var_2.GetResProgress(var_10_3)

	setText = var_5

	local var_10_7 = arg_10_0.progres

	setColorStr = var_1_10007

	local var_10_8 = var_1_10007(var_10_4, "#ffffff")

	setColorStr = var_8

	var_5(var_10_7, var_10_8 .. var_8("/" .. var_10_5, "#DD9D9D"))

	local var_10_9 = arg_10_0.ptData
	local var_10_10 = var_5.CanGetAward(var_10_9)
	local var_10_11 = arg_10_0.ptData
	local var_10_12 = var_6.CanGetNextAward(var_10_11)
	local var_10_13 = arg_10_0.ptData
	local var_10_14 = var_7.CanGetMorePt(var_10_13)

	setActive = var_10_13

	var_10_13(arg_10_0.battleBtn, var_10_14 and not var_10_10 and var_10_12)

	setActive = var_10_13

	var_10_13(arg_10_0.getBtn, var_10_10)

	setActive = var_10_13

	var_10_13(arg_10_0.gotBtn, not var_10_12)

	for iter_10_0 = 1, 10 do
		local var_10_15 = arg_10_0.ptData

		if iter_10_0 <= var_12.GetLevel(var_10_15) then
			SetActive = var_12

			local var_10_16 = arg_10_0.bg

			var_12(var_13.Find(var_10_16, "schedule/" .. iter_10_0 .. "/on"), true)

			SetActive = var_12

			local var_10_17 = arg_10_0.bg

			var_12(var_13.Find(var_10_17, "schedule/" .. iter_10_0 .. "/not"), false)
		else
			SetActive = var_12

			local var_10_18 = arg_10_0.bg

			var_12(var_13.Find(var_10_18, "schedule/" .. iter_10_0 .. "/on"), false)

			SetActive = var_12

			local var_10_19 = arg_10_0.bg

			var_12(var_13.Find(var_10_19, "schedule/" .. iter_10_0 .. "/not"), true)
		end
	end

	return
end

function var_0_1.GetWorldPtData(arg_11_0, arg_11_1)
	pg = var_1_10002

	local var_11_0 = var_1_10002.TimeMgr.GetInstance()
	local var_11_1 = var_2.GetServerTime(var_11_0)

	ActivityMainScene = var_11_0

	local var_11_2

	if not var_11_0.Data2Time then
		var_11_2 = 0
	end

	if arg_11_1 <= var_11_1 - var_11_2 then
		ActivityMainScene = var_2
		pg = var_11_2

		local var_11_3 = var_11_2.TimeMgr.GetInstance()

		var_2.Data2Time = var_3.GetServerTime(var_11_3)

		local var_11_4 = arg_11_0
		local var_11_5 = arg_11_0.emit

		ActivityMediator = var_11_3

		local var_11_6 = var_11_3.EVENT_PT_OPERATION
		local var_11_7 = {
			cmd = 2
		}
		local var_11_8 = arg_11_0.ptData

		var_11_7.activity_id = var_6.GetId(var_11_8)

		var_11_5(var_11_4, var_11_6, var_11_7)
	end

	return
end

return var_0_1
