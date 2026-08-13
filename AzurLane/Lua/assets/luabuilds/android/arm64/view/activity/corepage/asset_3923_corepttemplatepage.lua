class = var_0_10000

local var_0_0 = "CorePtTemplatePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.slider = var_1.Find(var_1_1, "slider")

	local var_1_2 = arg_1_0.bg

	arg_1_0.step = var_1.Find(var_1_2, "step")

	local var_1_3 = arg_1_0.bg

	arg_1_0.progress = var_1.Find(var_1_3, "progress")

	local var_1_4 = arg_1_0.bg

	arg_1_0.displayBtn = var_1.Find(var_1_4, "display_btn")

	local var_1_5 = arg_1_0.bg

	arg_1_0.awardTF = var_1.Find(var_1_5, "award")

	local var_1_6 = arg_1_0.bg

	arg_1_0.battleBtn = var_1.Find(var_1_6, "battle_btn")

	local var_1_7 = arg_1_0.bg

	arg_1_0.getBtn = var_1.Find(var_1_7, "get_btn")

	local var_1_8 = arg_1_0.bg

	arg_1_0.gotBtn = var_1.Find(var_1_8, "got_btn")

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

		ActivityMediator = var_2_10003

		local var_4_2 = var_2_10003.SHOW_AWARD_WINDOW

		PtAwardWindow = var_2_10004

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

		var_4_3.unlockStamps = var_6.GetDayUnlockStamps(var_4_4)

		var_4_1(var_4_0, var_4_2, var_2_10004, var_4_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.battleBtn

	local function var_3_5()
		local var_5_0
		local var_5_1
		local var_5_2 = arg_3_0.activity

		if var_2.getConfig(var_5_2, "config_client") ~= "" then
			local var_5_3 = arg_3_0.activity

			if var_2_10003.getConfig(var_5_3, "config_client").linkActID then
				getProxy = var_2_10003
				ActivityProxy = var_5_3

				local var_5_4 = var_2_10003(var_5_3)

				var_5_1 = var_2_10003.getActivityById(var_5_4, var_5_0)
			end
		end

		if not var_5_0 then
			local var_5_5 = arg_3_0

			var_2_10003 = var_2_10003.emit
			ActivityMediator = var_2_10006

			var_2_10003(var_5_5, var_2_10006.BATTLE_OPERA)
		elseif var_5_1 and not var_5_1:isEnd() then
			local var_5_6 = arg_3_0

			var_2_10003 = var_2_10003.emit
			ActivityMediator = var_2_10006

			var_2_10003(var_5_6, var_2_10006.BATTLE_OPERA)
		else
			pg = var_2_10003

			local var_5_7 = var_2_10003.TipsMgr.GetInstance()
			local var_5_8 = var_3.ShowTips

			i18n = var_2_10006

			var_5_8(var_5_7, var_2_10006("common_activity_end"))
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.getBtn

	local function var_3_8()
		local var_6_0 = {}
		local var_6_1 = arg_3_0.ptData
		local var_6_2 = var_1.GetAward(var_6_1)

		getProxy = var_2_10002
		PlayerProxy = var_2_10004

		local var_6_3 = var_2_10002(var_2_10004)
		local var_6_4 = var_2.getRawData(var_6_3)

		pg = var_2_10004

		local var_6_5 = var_2_10004.gameset.urpt_chapter_max.description[1]

		LOCK_UR_SHIP = var_6_3

		if var_6_3 then
			var_6_3 = 0
		else
			getProxy = var_6_3
			BagProxy = var_2_10007

			local var_6_6 = var_6_3(var_2_10007)

			var_6_3 = var_6_3.GetLimitCntById(var_6_6, var_6_5)
		end

		Task = var_2_10006

		local var_6_7, var_6_8 = var_2_10006.StaticJudgeOverflow(var_6_4.gold, var_6_4.oil, var_6_3, true, true, {
			{
				var_6_2.type,
				var_6_2.id,
				var_6_2.count
			}
		})

		if var_6_7 then
			table = var_8

			var_8.insert(var_6_0, function(arg_7_0)
				pg = var_3_10001

				local var_7_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_7_1 = var_1.ShowMsgBox
				local var_7_2 = {}

				MSGBOX_TYPE_ITEM_BOX = var_3_10005
				var_7_2.type = var_3_10005
				i18n = var_3_10005
				var_7_2.content = var_3_10005("award_max_warning")
				var_7_2.items = var_6_8
				var_7_2.onYes = arg_7_0

				var_7_1(var_7_0, var_7_2)

				return
			end)
		end

		seriesAsync = var_8

		var_8(var_6_0, function()
			local var_8_0 = arg_3_0.ptData
			local var_8_1, var_8_2 = var_0.GetResProgress(var_8_0)
			local var_8_3 = arg_3_0
			local var_8_4 = var_2.emit

			ActivityMediator = var_3_10005

			local var_8_5 = var_3_10005.EVENT_PT_OPERATION
			local var_8_6 = {
				cmd = 1
			}
			local var_8_7 = arg_3_0.ptData

			var_8_6.activity_id = var_7.GetId(var_8_7)
			var_8_6.arg1 = var_8_2

			var_8_4(var_8_3, var_8_5, var_8_6)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	return
end

function var_0_1.OnUpdateFlush(arg_9_0)
	local var_9_0 = arg_9_0.ptData
	local var_9_1 = var_1.getTargetLevel(var_9_0)
	local var_9_2 = arg_9_0.activity
	local var_9_3 = var_2.getConfig(var_9_2, "config_client").story

	checkExist = var_9_0

	if var_9_0(var_9_3, {
		var_9_1
	}, {
		1
	}) then
		pg = var_3

		local var_9_4 = var_3.NewStoryMgr.GetInstance()

		var_3.Play(var_9_4, var_9_3[var_9_1][1])
	end

	if arg_9_0.step then
		local var_9_5 = arg_9_0.ptData
		local var_9_6, var_9_7, var_9_8 = var_3.GetLevelProgress(var_9_5)

		setText = var_6

		var_6(arg_9_0.step, var_9_6 .. "/" .. var_9_7)
	end

	local var_9_9 = arg_9_0.ptData
	local var_9_10, var_9_11, var_9_12 = var_3.GetResProgress(var_9_9)

	setText = var_6

	local var_9_13 = arg_9_0.progress

	if 1 <= var_9_12 then
		setColorStr = var_9

		local var_9_14 = var_9_10

		COLOR_GREEN = var_1_10012

		local var_9_15

		if not var_9(var_9_14, var_1_10012) then
			var_9_15 = var_9_10
		end

		var_6(var_9_13, var_9_15 .. "/" .. var_9_11)

		setSlider = var_6

		var_6(arg_9_0.slider, 0, 1, var_9_12)

		local var_9_16 = arg_9_0.ptData
		local var_9_17 = var_6.CanGetAward(var_9_16)
		local var_9_18 = arg_9_0.ptData
		local var_9_19 = var_7.CanGetNextAward(var_9_18)
		local var_9_20 = arg_9_0.ptData
		local var_9_21 = var_8.CanGetMorePt(var_9_20)

		setActive = var_9_18

		var_9_18(arg_9_0.battleBtn, var_9_21 and not var_9_17 and var_9_19)

		setActive = var_9_18

		var_9_18(arg_9_0.getBtn, var_9_17)

		setActive = var_9_18

		var_9_18(arg_9_0.gotBtn, not var_9_19)

		local var_9_22 = arg_9_0.ptData
		local var_9_23 = var_9.GetAward(var_9_22)

		updateDrop = var_9_20

		var_9_20(arg_9_0.awardTF, var_9_23)

		onButton = var_9_20

		local var_9_24 = arg_9_0
		local var_9_25 = arg_9_0.awardTF

		local function var_9_26()
			local var_10_0 = arg_9_0
			local var_10_1 = var_0.emit

			BaseUI = var_2_10003

			var_10_1(var_10_0, var_2_10003.ON_DROP, var_9_23)

			return
		end

		SFX_PANEL = var_1_10015

		var_9_20(var_9_24, var_9_25, var_9_26, var_1_10015)

		return
	end
end

function var_0_1.OnDestroy(arg_11_0)
	return
end

function var_0_1.GetWorldPtData(arg_12_0, arg_12_1)
	pg = var_1_10002

	local var_12_0 = var_1_10002.TimeMgr.GetInstance()
	local var_12_1 = var_2.GetServerTime(var_12_0)

	ActivityMainScene = var_1_10003

	local var_12_2

	if not var_1_10003.Data2Time then
		var_12_2 = 0
	end

	if arg_12_1 <= var_12_1 - var_12_2 then
		ActivityMainScene = var_2
		pg = var_12_2

		local var_12_3 = var_12_2.TimeMgr.GetInstance()

		var_2.Data2Time = var_3.GetServerTime(var_12_3)

		local var_12_4 = arg_12_0
		local var_12_5 = arg_12_0.emit

		ActivityMediator = var_12_3

		local var_12_6 = var_12_3.EVENT_PT_OPERATION
		local var_12_7 = {
			cmd = 2
		}
		local var_12_8 = arg_12_0.ptData

		var_12_7.activity_id = var_7.GetId(var_12_8)

		var_12_5(var_12_4, var_12_6, var_12_7)
	end

	return
end

return var_0_1
