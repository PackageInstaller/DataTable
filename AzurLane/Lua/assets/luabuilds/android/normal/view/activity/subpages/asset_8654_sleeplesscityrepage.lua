class = var_0_10000

local var_0_0 = "SleeplessCityRePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))

var_0_1.COLOR = "#BD3F40"

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.getBtn

	local function var_1_2()
		local var_2_0 = {}
		local var_2_1 = arg_1_0.ptData
		local var_2_2 = var_1.GetAward(var_2_1)

		getProxy = var_2_1
		PlayerProxy = var_2_10003

		local var_2_3 = var_2_1(var_2_10003)
		local var_2_4 = var_2.getRawData(var_2_3)

		pg = var_2_3

		local var_2_5 = var_2_3.gameset.urpt_chapter_max.description[1]

		LOCK_UR_SHIP = var_2_10005

		if var_2_10005 then
			var_2_10005 = 0
		else
			getProxy = var_2_10005
			BagProxy = var_2_10006
			var_2_10006 = var_2_10005(var_2_10006)
			var_2_10005 = var_2_10005.GetLimitCntById(var_2_10006, var_2_5)
		end

		Task = var_2_10006

		local var_2_6, var_2_7 = var_2_10006.StaticJudgeOverflow(var_2_4.gold, var_2_4.oil, var_2_10005, true, true, {
			{
				var_2_2.type,
				var_2_2.id,
				var_2_2.count
			}
		})

		if var_2_6 then
			table = var_8

			var_8.insert(var_2_0, function(arg_3_0)
				pg = var_3_10001

				local var_3_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_3_1 = var_1.ShowMsgBox
				local var_3_2 = {}

				MSGBOX_TYPE_ITEM_BOX = var_3_10004
				var_3_2.type = var_3_10004
				i18n = var_3_10004
				var_3_2.content = var_3_10004("award_max_warning")
				var_3_2.items = var_2_7
				var_3_2.onYes = arg_3_0

				var_3_1(var_3_0, var_3_2)

				return
			end)
		end

		seriesAsync = var_8

		var_8(var_2_0, function()
			local var_4_0 = arg_1_0.ptData
			local var_4_1, var_4_2 = var_0.GetResProgress(var_4_0)
			local var_4_3 = arg_1_0
			local var_4_4 = var_2.emit

			ActivityMediator = var_3_10004

			local var_4_5 = var_3_10004.EVENT_PT_OPERATION
			local var_4_6 = {
				cmd = 1
			}
			local var_4_7 = arg_1_0.ptData

			var_4_6.activity_id = var_6.GetId(var_4_7)
			var_4_6.arg1 = var_4_2

			function var_4_6.callback()
				local var_5_0 = arg_1_0

				var_0.OnUpdateFlush(var_5_0)

				return
			end

			var_4_4(var_4_3, var_4_5, var_4_6)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_0, var_1_1, var_1_2, var_1_10005)
	arg_1_0:OnUpdateFlush()

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	local var_6_0 = arg_6_0.activity
	local var_6_1 = var_1.getConfig(var_6_0, "config_client").story

	if arg_6_0.level then
		checkExist = var_2

		if var_2(var_6_1, {
			arg_6_0.level
		}, {
			1
		}) then
			pg = var_2

			local var_6_2 = var_2.NewStoryMgr.GetInstance()

			var_2.Play(var_6_2, var_6_1[arg_6_0.level][1])
		end
	end

	local var_6_3 = arg_6_0.ptData

	arg_6_0.level = var_2.getTargetLevel(var_6_3)

	if arg_6_0.step then
		local var_6_4 = arg_6_0.ptData
		local var_6_5, var_6_6, var_6_7 = var_2.GetLevelProgress(var_6_4)

		setText = var_1_10005

		var_1_10005(arg_6_0.step, var_6_5 .. "/" .. var_6_6)
	end

	local var_6_8 = arg_6_0.ptData
	local var_6_9, var_6_10, var_6_11 = var_2.GetResProgress(var_6_8)

	setText = var_1_10005

	local var_6_12 = arg_6_0.progress

	if 1 <= var_6_11 then
		setColorStr = var_6_14

		local var_6_13 = var_6_9

		COLOR_GREEN = var_1_10009

		local var_6_14

		if not var_6_14(var_6_13, var_1_10009) then
			setColorStr = var_6_14
			var_6_14 = var_6_14(var_6_9, var_0_1.COLOR)
		end

		var_1_10005(var_6_12, var_6_14 .. "/" .. var_6_10)

		setSlider = var_1_10005

		var_1_10005(arg_6_0.slider, 0, 1, var_6_11)

		local var_6_15 = arg_6_0.ptData
		local var_6_16 = var_5.CanGetAward(var_6_15)
		local var_6_17 = arg_6_0.ptData
		local var_6_18 = var_6.CanGetNextAward(var_6_17)
		local var_6_19 = arg_6_0.ptData
		local var_6_20 = var_7.CanGetMorePt(var_6_19)

		setActive = var_6_19

		var_6_19(arg_6_0.battleBtn, var_6_20 and not var_6_16 and var_6_18)

		setActive = var_6_19

		var_6_19(arg_6_0.getBtn, var_6_16)

		setActive = var_6_19

		var_6_19(arg_6_0.gotBtn, not var_6_18)

		local var_6_21 = arg_6_0.ptData
		local var_6_22 = var_8.GetAward(var_6_21)

		updateDrop = var_6_21

		var_6_21(arg_6_0.awardTF, var_6_22)

		onButton = var_6_21

		local var_6_23 = arg_6_0
		local var_6_24 = arg_6_0.awardTF

		local function var_6_25()
			local var_7_0 = arg_6_0
			local var_7_1 = var_0.emit

			BaseUI = var_2_10002

			var_7_1(var_7_0, var_2_10002.ON_DROP, var_6_22)

			return
		end

		SFX_PANEL = var_1_10013

		var_6_21(var_6_23, var_6_24, var_6_25, var_1_10013)

		setText = var_6_21

		local var_6_26 = arg_6_0.bg
		local var_6_27 = var_10.Find(var_6_26, "description")

		i18n = var_6_26

		var_6_21(var_6_27, var_6_26("activity_victory"))

		if not var_6_18 and var_6_11 >= 1 and not var_6_16 then
			arg_6_0.level = arg_6_0.level + 1
		end

		return
	end
end

return var_0_1
