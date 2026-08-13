class = var_0_10000

local var_0_0 = "NieRAutomataKillPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.title = var_1.Find(var_1_1, "title")

	local var_1_2 = arg_1_0.title

	arg_1_0.desc1 = var_1.Find(var_1_2, "desc1")

	local var_1_3 = arg_1_0.title

	arg_1_0.desc2 = var_1.Find(var_1_3, "desc2")

	local var_1_4 = arg_1_0.bg

	arg_1_0.rtTask = var_1.Find(var_1_4, "task")

	local var_1_5 = arg_1_0.rtTask

	arg_1_0.step = var_1.Find(var_1_5, "step")

	local var_1_6 = arg_1_0.step

	arg_1_0.nowday = var_1.Find(var_1_6, "nowday")

	local var_1_7 = arg_1_0.step

	arg_1_0.aimday = var_1.Find(var_1_7, "aimday")

	local var_1_8 = arg_1_0.rtTask

	arg_1_0.progress = var_1.Find(var_1_8, "progress")

	local var_1_9 = arg_1_0.progress

	arg_1_0.slider = var_1.Find(var_1_9, "slider")

	local var_1_10 = arg_1_0.progress

	arg_1_0.awardTF = var_1.Find(var_1_10, "award")

	local var_1_11 = arg_1_0.progress

	arg_1_0.progressStep = var_1.Find(var_1_11, "step")

	local var_1_12 = arg_1_0.progress

	arg_1_0.progressRule = var_1.Find(var_1_12, "rule")

	local var_1_13 = arg_1_0.rtTask

	arg_1_0.BtnGroup = var_1.Find(var_1_13, "BtnGroup")

	local var_1_14 = arg_1_0.BtnGroup

	arg_1_0.displayBtn = var_1.Find(var_1_14, "Check_btn")

	local var_1_15 = arg_1_0.BtnGroup

	arg_1_0.battleBtn = var_1.Find(var_1_15, "battle_btn")

	local var_1_16 = arg_1_0.BtnGroup

	arg_1_0.getBtn = var_1.Find(var_1_16, "get_btn")

	local var_1_17 = arg_1_0.BtnGroup

	arg_1_0.gotBtn = var_1.Find(var_1_17, "got_btn")

	local var_1_18 = arg_1_0.displayBtn

	arg_1_0.displayText = var_1.Find(var_1_18, "Text")
	arg_1_0.finishAll = false

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

function var_0_1.LocalInit(arg_3_0)
	setText = var_1_10001

	local var_3_0 = arg_3_0.displayText

	i18n = var_1_10004

	var_1_10001(var_3_0, var_1_10004("nier_core_award_check"))

	setText = var_1_10001

	local var_3_1 = arg_3_0.progressRule

	i18n = var_4

	var_1_10001(var_3_1, var_4("nier_core_task_desc"))

	return
end

function var_0_1.LocalFresh(arg_4_0)
	local var_4_0 = arg_4_0.ptData
	local var_4_1, var_4_2, var_4_3 = var_1.GetLevelProgress(var_4_0)
	local var_4_4 = "nier_2b_text_block_day"
	local var_4_5 = arg_4_0.ptData
	local var_4_6 = var_5.CanGetNextAward(var_4_5)
	local var_4_7

	arg_4_0.finishAll = var_4_1 >= 7 and not var_4_6

	if arg_4_0.finishAll then
		i18n = var_7
		var_4_7 = var_7(var_4_4 .. "_fin")
		setActive = var_7

		var_7(arg_4_0.desc1, false)
	else
		i18n = var_7
		var_4_7 = var_7(var_4_4 .. var_4_1)
		setText = var_7

		var_7(arg_4_0.desc1, var_4_7[1].info)
	end

	setText = var_7

	var_7(arg_4_0.desc2, var_4_7[2].info)

	setActive = var_7

	var_7(arg_4_0.desc2, false)
	arg_4_0:Playwriter()

	return
end

function var_0_1.InitBtn(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.displayBtn

	local function var_5_2()
		local var_6_0 = arg_5_0
		local var_6_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_6_2 = var_2_10003.SHOW_AWARD_WINDOW

		PtAwardWindow = var_2_10004

		local var_6_3 = {
			blur = true,
			type = arg_5_0.ptData.type,
			dropList = arg_5_0.ptData.dropList,
			targets = arg_5_0.ptData.targets,
			level = arg_5_0.ptData.level,
			count = arg_5_0.ptData.count,
			resId = arg_5_0.ptData.resId
		}
		local var_6_4 = arg_5_0.ptData

		var_6_3.unlockStamps = var_6.GetDayUnlockStamps(var_6_4)

		var_6_1(var_6_0, var_6_2, var_2_10004, var_6_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10006)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.battleBtn

	local function var_5_5()
		local var_7_0 = arg_5_0
		local var_7_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_7_1(var_7_0, var_2_10003.GO_Activity_level)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10006)

	onButton = var_1_10001

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.getBtn

	local function var_5_8()
		local var_8_0 = {}
		local var_8_1 = arg_5_0.ptData
		local var_8_2 = var_1.GetAward(var_8_1)

		getProxy = var_2_10002
		PlayerProxy = var_2_10004

		local var_8_3 = var_2_10002(var_2_10004)
		local var_8_4 = var_2.getRawData(var_8_3)

		pg = var_2_10004

		local var_8_5 = var_2_10004.gameset.urpt_chapter_max.description[1]

		LOCK_UR_SHIP = var_8_3

		if var_8_3 then
			var_8_3 = 0
		else
			getProxy = var_8_3
			BagProxy = var_2_10007

			local var_8_6 = var_8_3(var_2_10007)

			var_8_3 = var_8_3.GetLimitCntById(var_8_6, var_8_5)
		end

		Task = var_2_10006

		local var_8_7, var_8_8 = var_2_10006.StaticJudgeOverflow(var_8_4.gold, var_8_4.oil, var_8_3, true, true, {
			{
				var_8_2.type,
				var_8_2.id,
				var_8_2.count
			}
		})

		if var_8_7 then
			table = var_8

			var_8.insert(var_8_0, function(arg_9_0)
				pg = var_3_10001

				local var_9_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_9_1 = var_1.ShowMsgBox
				local var_9_2 = {}

				MSGBOX_TYPE_ITEM_BOX = var_3_10005
				var_9_2.type = var_3_10005
				i18n = var_3_10005
				var_9_2.content = var_3_10005("award_max_warning")
				var_9_2.items = var_8_8
				var_9_2.onYes = arg_9_0

				var_9_1(var_9_0, var_9_2)

				return
			end)
		end

		seriesAsync = var_8

		var_8(var_8_0, function()
			local var_10_0 = arg_5_0.ptData
			local var_10_1, var_10_2 = var_0.GetResProgress(var_10_0)
			local var_10_3 = arg_5_0
			local var_10_4 = var_2.emit

			ActivityMediator = var_3_10005

			local var_10_5 = var_3_10005.EVENT_PT_OPERATION
			local var_10_6 = {
				cmd = 1
			}
			local var_10_7 = arg_5_0.ptData

			var_10_6.activity_id = var_7.GetId(var_10_7)
			var_10_6.arg1 = var_10_2

			var_10_4(var_10_3, var_10_5, var_10_6)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_6, var_5_7, var_5_8, var_1_10006)

	return
end

function var_0_1.GetTypewriterSpeed(arg_11_0)
	local var_11_0 = arg_11_0.activity

	return var_1.getConfig(var_11_0, "config_client").typewriterSpeed and var_2 or 0.1
end

function var_0_1.InvalidateWriter(arg_12_0)
	local var_12_0

	if not arg_12_0.writerToken then
		var_12_0 = 0
	end

	arg_12_0.writerToken = var_12_0 + 1

	if arg_12_0.desc1 then
		GetOrAddComponent = var_1

		local var_12_1 = arg_12_0.desc1

		typeof = var_1_10004
		Typewriter = var_1_10006
		var_1(var_12_1, var_1_10004(var_1_10006)).endFunc = nil
	end

	if arg_12_0.desc2 then
		GetOrAddComponent = var_1

		local var_12_2 = arg_12_0.desc2

		typeof = var_1_10004
		Typewriter = var_1_10006
		var_1(var_12_2, var_1_10004(var_1_10006)).endFunc = nil
	end

	return
end

function var_0_1.Playwriter(arg_13_0)
	arg_13_0:InvalidateWriter()

	local var_13_0 = arg_13_0.writerToken

	local function var_13_1()
		local var_14_0

		if arg_13_0.writerToken == var_13_0 then
			if arg_13_0._go then
				isActive = var_14_0
				var_14_0 = var_14_0(arg_13_0._go)
			end
		else
			var_14_0 = false
		end

		if false then
			var_14_0 = true
		end

		return var_14_0
	end

	local var_13_2 = {}
	local var_13_4

	if not arg_13_0.finishAll then
		table = var_13_4

		var_13_4.insert(var_13_2, function(arg_15_0)
			if not var_13_1() then
				return
			end

			local var_15_0

			var_15_0, GetOrAddComponent = arg_13_0.desc1, var_2_10002
			typeof = var_2_10005
			Typewriter = var_2_10007

			local var_15_1 = var_2_10002(var_15_0, var_2_10005(var_2_10007))

			function var_15_1.endFunc()
				if not var_13_1() then
					return
				end

				arg_15_0()

				return
			end

			local var_15_2 = var_15_1
			local var_15_3 = var_15_1.setSpeed
			local var_15_4 = arg_13_0

			var_15_3(var_15_2, var_6.GetTypewriterSpeed(var_15_4))
			var_15_1:Play()

			return
		end)
	else
		local var_13_3 = arg_13_0.ptData
		local var_13_5, var_13_6

		var_13_4, var_13_5, var_13_6 = var_13_4.GetLevelProgress(var_13_3)
		table = var_1_10007

		var_1_10007.insert(var_13_2, function(arg_17_0)
			local var_17_0 = arg_13_0.activity
			local var_17_1 = var_1.getConfig(var_17_0, "config_client").story

			checkExist = var_2_10002

			if var_2_10002(var_17_1, {
				var_13_4
			}, {
				1
			}) then
				pg = var_17_0

				local var_17_2 = var_17_0.NewStoryMgr.GetInstance()

				if not var_3.IsPlayed(var_17_2, var_2) then
					pg = var_3

					local var_17_3 = var_3.NewStoryMgr.GetInstance()

					var_3.Play(var_17_3, var_2, function()
						if not var_13_1() then
							return
						end

						arg_17_0()

						return
					end)

					goto label_17_0
				end
			end

			arg_17_0()

			::label_17_0::

			return
		end)
	end

	table = var_13_4

	var_13_4.insert(var_13_2, function(arg_19_0)
		if not var_13_1() then
			return
		end

		local var_19_0 = arg_13_0.desc2

		setActive = var_2_10002

		var_2_10002(arg_13_0.desc2, true)

		GetOrAddComponent = var_2_10002

		local var_19_1 = var_19_0

		typeof = var_5
		Typewriter = var_2_10007

		local var_19_2 = var_2_10002(var_19_1, var_5(var_2_10007))

		function var_19_2.endFunc()
			if not var_13_1() then
				return
			end

			arg_19_0()

			return
		end

		local var_19_3 = var_19_2
		local var_19_4 = var_19_2.setSpeed
		local var_19_5 = arg_13_0

		var_19_4(var_19_3, var_6.GetTypewriterSpeed(var_19_5))
		var_19_2:Play()

		return
	end)

	seriesAsync = var_4

	var_4(var_13_2)

	return
end

function var_0_1.OnFirstFlush(arg_21_0)
	arg_21_0:LocalInit()
	arg_21_0:LocalFresh()
	arg_21_0:InitBtn()
	arg_21_0:Hx4Channel()

	return
end

function var_0_1.OnUpdateFlush(arg_22_0)
	local var_22_0 = arg_22_0.ptData
	local var_22_1 = var_1.getTargetLevel(var_22_0)
	local var_22_2 = arg_22_0.ptData
	local var_22_3, var_22_4, var_22_5 = var_2.GetLevelProgress(var_22_2)

	setText = var_1_10005

	local var_22_6 = arg_22_0.nowday

	string = var_1_10008

	var_1_10005(var_22_6, var_1_10008.format("%s", var_22_3))

	setText = var_1_10005

	local var_22_7 = arg_22_0.aimday

	string = var_8

	var_1_10005(var_22_7, var_8.format("/%s", var_22_4))
	arg_22_0:LocalFresh()

	local var_22_8 = arg_22_0.ptData
	local var_22_9, var_22_10, var_22_11 = var_5.GetResProgress(var_22_8)

	setText = var_8

	local var_22_12 = arg_22_0.progressStep

	string = var_11

	local var_22_13 = var_11.format
	local var_22_14 = "%s<color=#ffffff33>/%s</color>"

	if 1 <= var_22_11 then
		setColorStr = var_14

		local var_22_15 = var_22_9

		COLOR_GREEN = var_1_10017

		local var_22_16

		if not var_14(var_22_15, var_1_10017) then
			var_22_16 = var_22_9
		end

		var_8(var_22_12, var_22_13(var_22_14, var_22_16, var_22_10))

		setSlider = var_8

		var_8(arg_22_0.slider, 0, 1, var_22_11)

		local var_22_17 = arg_22_0.ptData
		local var_22_18 = var_8.CanGetAward(var_22_17)
		local var_22_19 = arg_22_0.ptData
		local var_22_20 = var_9.CanGetNextAward(var_22_19)
		local var_22_21 = arg_22_0.ptData
		local var_22_22 = var_10.CanGetMorePt(var_22_21)

		setActive = var_22_19

		var_22_19(arg_22_0.battleBtn, var_22_22 and not var_22_18 and var_22_20)

		setActive = var_22_19

		var_22_19(arg_22_0.getBtn, var_22_18)

		setActive = var_22_19

		var_22_19(arg_22_0.gotBtn, not var_22_20)

		local var_22_23 = arg_22_0.ptData
		local var_22_24 = var_11.GetAward(var_22_23)

		updateDrop = var_22_21

		var_22_21(arg_22_0.awardTF, var_22_24)

		onButton = var_22_21

		local var_22_25 = arg_22_0
		local var_22_26 = arg_22_0.awardTF

		local function var_22_27()
			local var_23_0 = arg_22_0
			local var_23_1 = var_0.emit

			BaseUI = var_2_10003

			var_23_1(var_23_0, var_2_10003.ON_DROP, var_22_24)

			return
		end

		SFX_PANEL = var_1_10017

		var_22_21(var_22_25, var_22_26, var_22_27, var_1_10017)

		return
	end
end

function var_0_1.OnDestroy(arg_24_0)
	return
end

function var_0_1.GetWorldPtData(arg_25_0, arg_25_1)
	pg = var_1_10002

	local var_25_0 = var_1_10002.TimeMgr.GetInstance()
	local var_25_1 = var_2.GetServerTime(var_25_0)

	ActivityMainScene = var_1_10003

	local var_25_2

	if not var_1_10003.Data2Time then
		var_25_2 = 0
	end

	if arg_25_1 <= var_25_1 - var_25_2 then
		ActivityMainScene = var_2
		pg = var_25_2

		local var_25_3 = var_25_2.TimeMgr.GetInstance()

		var_2.Data2Time = var_3.GetServerTime(var_25_3)

		local var_25_4 = arg_25_0
		local var_25_5 = arg_25_0.emit

		ActivityMediator = var_25_3

		local var_25_6 = var_25_3.EVENT_PT_OPERATION
		local var_25_7 = {
			cmd = 2
		}
		local var_25_8 = arg_25_0.ptData

		var_25_7.activity_id = var_7.GetId(var_25_8)

		var_25_5(var_25_4, var_25_6, var_25_7)
	end

	return
end

local function var_0_2(arg_26_0)
	pg = var_1_10001

	local var_26_0 = var_1_10001.SdkMgr.GetInstance()
	local var_26_1 = var_1.GetChannelUIDIncludeHarmony(var_26_0)
	local var_26_2 = arg_26_0._tf

	return (var_2.Find(var_26_2, "rw/hx_ch" .. var_26_1))
end

function var_0_1.Hx4Channel(arg_27_0)
	local var_27_0 = var_0_2(arg_27_0)

	IsNil = var_1_10002

	if not var_1_10002(var_27_0) then
		setActive = var_2

		local var_27_1 = var_27_0

		HXSet = var_1_10005

		var_2(var_27_1, var_1_10005.isHx())
	end

	return
end

function var_0_1.OnHideFlush(arg_28_0)
	arg_28_0:InvalidateWriter()

	return
end

function var_0_1.OnDestroy(arg_29_0)
	arg_29_0:InvalidateWriter()

	return
end

return var_0_1
