class = var_0_10000

local var_0_0 = "LimitChallengeScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

LimitChallengeConst = var_0_10001

function var_0_1.getUIName(arg_1_0)
	return "LimitChallengeUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.didEnter(arg_3_0)
	var_0_10001.SetRedPointMonth()
	arg_3_0:updateLeftTime()
	arg_3_0:updateToggleList()
	arg_3_0:trigeHigestUnlockLevel()

	return
end

function var_0_1.onBackPressed(arg_4_0)
	arg_4_0:closeView()

	return
end

function var_0_1.willExit(arg_5_0)
	if arg_5_0.leftTimer then
		local var_5_0 = arg_5_0.leftTimer

		var_1.Stop(var_5_0)

		arg_5_0.leftTimer = nil
	end

	return
end

function var_0_1.initData(arg_6_0)
	getProxy = var_1_10001
	LimitChallengeProxy = var_1_10003
	arg_6_0.proxy = var_1_10001(var_1_10003)
	arg_6_0.levelList = {
		1,
		2,
		3
	}
	arg_6_0.curMonth = var_0_10001.GetCurMonth()
	arg_6_0.descList = {}
	LimitChallengeConst = var_1
	arg_6_0.nextMonthTS = var_1.GetNextMonthTS()
	arg_6_0.curLevel = 0

	return
end

function var_0_1.findUI(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.blurPanel = var_1.Find(var_7_0, "blur_panel")

	local var_7_1 = arg_7_0.blurPanel

	arg_7_0.homeBtn = var_1.Find(var_7_1, "adapt/top/option")

	local var_7_2 = arg_7_0.blurPanel

	arg_7_0.backBtn = var_1.Find(var_7_2, "adapt/top/back_button")

	local var_7_3 = arg_7_0.blurPanel

	arg_7_0.helpBtn = var_1.Find(var_7_3, "adapt/top/HelpBtn")

	local var_7_4 = arg_7_0.blurPanel

	arg_7_0.shareBtn = var_1.Find(var_7_4, "adapt/top/ShareBtn")

	local var_7_5 = arg_7_0._tf

	arg_7_0.levelPanel = var_1.Find(var_7_5, "Adapt/LevelPanel")
	arg_7_0.levelToggleList = {}
	arg_7_0.levelToggleLockList = {}
	ipairs = var_1

	for iter_7_0, iter_7_1 in var_1(arg_7_0.levelList) do
		local var_7_6 = "Level_" .. iter_7_1
		local var_7_7 = arg_7_0.levelPanel
		local var_7_8 = var_7.Find(var_7_7, var_7_6)
		local var_7_9 = var_7.Find(var_7_8, "Toggle")
		local var_7_10 = var_7:Find("Lock")

		arg_7_0.levelToggleList[iter_7_1] = var_7_9
		arg_7_0.levelToggleLockList[iter_7_1] = var_7_10
	end

	local var_7_11 = arg_7_0._tf

	arg_7_0.timePanel = var_1.Find(var_7_11, "Adapt/TimePanel")

	local var_7_12 = arg_7_0.timePanel
	local var_7_13 = var_1.Find(var_7_12, "Left/LeftTime")

	arg_7_0.leftTipText = var_1.Find(var_7_13, "LeftTip")
	arg_7_0.leftDayTipText = var_1:Find("DayTip")
	arg_7_0.leftDayValueText = var_1:Find("DayValue")
	arg_7_0.leftTimeValueText = var_1:Find("TimeValue")

	local var_7_14 = arg_7_0.timePanel

	arg_7_0.passTimeValueText = var_2.Find(var_7_14, "Challenge/Value")
	setText = var_2

	local var_7_15 = arg_7_0.leftTipText

	i18n = var_5

	var_2(var_7_15, var_5("time_remaining_tip"))

	setText = var_2

	local var_7_16 = arg_7_0.leftDayTipText

	i18n = var_5

	var_2(var_7_16, var_5("word_date"))

	local var_7_17 = arg_7_0._tf

	arg_7_0.iconContainer = var_2.Find(var_7_17, "Adapt/DescPanel/ScrollView/Viewport/Container")

	local var_7_18 = arg_7_0._tf

	arg_7_0.iconTpl = var_2.Find(var_7_18, "Adapt/DescPanel/IconTpl")

	local var_7_19 = arg_7_0._tf
	local var_7_20 = var_2.Find(var_7_19, "Adapt/Award")

	arg_7_0.awardIconTF = var_2.Find(var_7_20, "IconTpl")
	arg_7_0.awardGotTF = var_2:Find("Got")

	local var_7_21 = arg_7_0._tf

	arg_7_0.startBtn = var_3.Find(var_7_21, "Adapt/StartBtn")

	local var_7_22 = arg_7_0._tf

	arg_7_0.bgImg = var_3.Find(var_7_22, "BG")

	local var_7_23 = arg_7_0.timePanel

	arg_7_0.nameImg = var_3.Find(var_7_23, "Left")

	local var_7_24 = arg_7_0._tf

	arg_7_0.debugPanel = var_3.Find(var_7_24, "Adapt/Debug")

	local var_7_25 = arg_7_0.debugPanel

	arg_7_0.debugText = var_3.Find(var_7_25, "Text")

	return
end

function var_0_1.addListener(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.homeBtn

	local function var_8_2()
		local var_9_0 = arg_8_0
		local var_9_1 = var_0.emit

		BaseUI = var_2_10003

		var_9_1(var_9_0, var_2_10003.ON_HOME)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10006)

	print = var_1_10001

	local var_8_3 = "-----------"

	tostring = var_8_1

	var_1_10001(var_8_3, var_8_1(arg_8_0.backBtn))

	onButton = var_1_10001

	local var_8_4 = arg_8_0
	local var_8_5 = arg_8_0.backBtn

	local function var_8_6()
		local var_10_0 = arg_8_0

		var_0.closeView(var_10_0)

		return
	end

	SFX_PANEL = var_6

	var_1_10001(var_8_4, var_8_5, var_8_6, var_6)

	onButton = var_1_10001

	local var_8_7 = arg_8_0
	local var_8_8 = arg_8_0.helpBtn

	local function var_8_9()
		pg = var_2_10000

		local var_11_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_11_1 = var_0.ShowMsgBox
		local var_11_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_11_2.type = var_2_10004
		pg = var_2_10004
		var_11_2.helps = var_2_10004.gametip.challenge_help.tip

		var_11_1(var_11_0, var_11_2)

		return
	end

	SFX_PANEL = var_6

	var_1_10001(var_8_7, var_8_8, var_8_9, var_6)

	onButton = var_1_10001

	local var_8_10 = arg_8_0
	local var_8_11 = arg_8_0.shareBtn

	local function var_8_12()
		pg = var_2_10000

		local var_12_0 = var_2_10000.ShareMgr.GetInstance()
		local var_12_1 = var_0.Share

		pg = var_2_10003

		var_12_1(var_12_0, var_2_10003.ShareMgr.TypeChallenge)

		return
	end

	SFX_PANEL = var_6

	var_1_10001(var_8_10, var_8_11, var_8_12, var_6)

	ipairs = var_1_10001

	for iter_8_0, iter_8_1 in var_1_10001(arg_8_0.levelToggleList) do
		onToggle = var_6

		local var_8_13 = arg_8_0
		local var_8_14 = iter_8_1

		local function var_8_15()
			arg_8_0.curLevel = iter_8_0

			local var_13_0 = arg_8_0

			var_0.updatePassTime(var_13_0)

			local var_13_1 = arg_8_0

			var_0.updateAward(var_13_1)

			local var_13_2 = arg_8_0

			var_0.updateDescPanel(var_13_2)

			local var_13_3 = arg_8_0

			var_0.updateBossImg(var_13_3)

			local var_13_4 = arg_8_0

			var_0.updateDebug(var_13_4)

			return
		end

		SFX_CONFIRM = var_1_10011
		SFX_CANCEL = var_1_10012

		var_6(var_8_13, var_8_14, var_8_15, var_1_10011, var_1_10012)
	end

	onButton = var_1

	local var_8_16 = arg_8_0
	local var_8_17 = arg_8_0.startBtn

	local function var_8_18()
		local var_14_0 = var_0_10001.GetStageIDByLevel(arg_8_0.curLevel)
		local var_14_1 = arg_8_0

		var_1.emit(var_14_1, var_0_10001.OPEN_PRE_COMBAT_LAYER, {
			stageID = var_14_0
		})

		return
	end

	SFX_PANEL = var_6

	var_1(var_8_16, var_8_17, var_8_18, var_6)

	UIItemList = var_1
	arg_8_0.iconUIItemList = var_1.New(arg_8_0.iconContainer, arg_8_0.iconTpl)

	local var_8_19 = arg_8_0.iconUIItemList

	var_1.make(var_8_19, function(arg_15_0, arg_15_1, arg_15_2)
		UIItemList = var_2_10003

		if arg_15_0 == var_2_10003.EventUpdate then
			local var_15_0 = arg_15_2:Find("Icon")

			arg_15_1 = arg_15_1 + 1

			if arg_8_0.descList[arg_15_1] ~= false then
				local var_15_1 = var_0_10001.GetChallengeIDByLevel(arg_8_0.curLevel)
				local var_15_2 = arg_8_0
				local var_15_3, var_15_4 = var_5.getBuffIconPath(var_15_2, var_15_1, arg_15_1)

				setImageSprite = var_15_2

				local var_15_5 = var_15_0

				LoadSprite = var_2_10010

				var_15_2(var_15_5, var_2_10010(var_15_3, var_15_4))

				local var_15_6 = arg_8_0.descList[arg_15_1][1]
				local var_15_7 = arg_8_0.descList[arg_15_1][2]
				local var_15_8 = {}

				table = var_10

				var_10.insert(var_15_8, {
					info = var_15_6
				})

				table = var_10

				var_10.insert(var_15_8, {
					info = var_15_7
				})

				onButton = var_10

				local var_15_9 = arg_8_0
				local var_15_10 = var_15_0

				local function var_15_11()
					pg = var_3_10000

					local var_16_0 = var_3_10000.MsgboxMgr.GetInstance()
					local var_16_1 = var_0.ShowMsgBox
					local var_16_2 = {
						hideNo = true
					}

					MSGBOX_TYPE_DROP_ITEM = var_3_10004
					var_16_2.type = var_3_10004
					var_16_2.name = var_15_6
					var_16_2.content = var_15_7
					var_16_2.iconPath = {
						var_15_3,
						var_15_4
					}

					var_16_1(var_16_0, var_16_2)

					return
				end

				SFX_PANEL = var_2_10015

				var_10(var_15_9, var_15_10, var_15_11, var_2_10015)
			end
		end

		return
	end)

	return
end

function var_0_1.updateDebug(arg_17_0)
	local var_17_0 = arg_17_0.curMonth
	local var_17_1 = arg_17_0.curLevel
	local var_17_2 = var_0_10001.GetChallengeIDByLevel(arg_17_0.curLevel)
	local var_17_3 = var_0_10001.GetStageIDByLevel(arg_17_0.curLevel)

	string = var_5

	local var_17_4 = var_5.format
	local var_17_5 = " 月份: %s \n 选择难度: %s \n 选择挑战ID: %s \n 选择关卡ID: %s \n"

	tostring = var_1_10008

	local var_17_6 = var_1_10008(var_17_0)

	tostring = var_1_10009

	local var_17_7 = var_1_10009(var_17_1)

	tostring = var_10

	local var_17_8 = var_10(var_17_2)

	tostring = var_11

	local var_17_9 = var_17_4(var_17_5, var_17_6, var_17_7, var_17_8, var_11(var_17_3))

	ipairs = var_6

	for iter_17_0, iter_17_1 in var_6(arg_17_0.levelList) do
		LimitChallengeConst = var_17_10

		local var_17_10 = var_17_10.GetChallengeIDByLevel(iter_17_1)
		local var_17_11 = arg_17_0.proxy
		local var_17_12 = var_12.isAwardedByChallengeID(var_17_11, var_17_10)
		local var_17_13 = " 难度" .. iter_17_1 .. "奖励:" .. (var_17_12 and "已领取" or "未领取") .. "\n"

		var_17_9 = var_17_9 .. var_17_13
	end

	ipairs = var_6

	for iter_17_2, iter_17_3 in var_6(arg_17_0.levelList) do
		LimitChallengeConst = var_17_10
		var_17_10 = var_17_10.GetChallengeIDByLevel(iter_17_3)

		local var_17_14 = arg_17_0.proxy
		local var_17_15 = var_12.getPassTimeByChallengeID(var_17_14, var_17_10)
		local var_17_16 = " 难度" .. iter_17_3 .. "时间:" .. (var_17_15 and var_17_15 or "没有记录") .. "\n"

		var_17_9 = var_17_9 .. var_17_16
	end

	setText = var_6

	var_6(arg_17_0.debugText, var_17_9)

	return
end

function var_0_1.updateToggleList(arg_18_0)
	local var_18_0 = arg_18_0:getHigestUnlockLevel()

	ipairs = var_1_10002

	for iter_18_0, iter_18_1 in var_1_10002(arg_18_0.levelToggleLockList) do
		local var_18_1 = var_18_0 < iter_18_0

		setActive = var_1_10008

		var_1_10008(iter_18_1, var_18_1)

		var_1_10008 = arg_18_0.levelToggleList[iter_18_0]
		setActive = var_1_10009

		var_1_10009(var_1_10008, not var_18_1)
	end

	return
end

function var_0_1.updateLeftTime(arg_19_0)
	if arg_19_0.leftTimer then
		local var_19_0 = arg_19_0.leftTimer

		var_1.Stop(var_19_0)

		arg_19_0.leftTimer = nil
	end

	pg = var_1

	local var_19_1 = var_1.TimeMgr.GetInstance()
	local var_19_2 = var_1.GetServerTime(var_19_1)

	if arg_19_0.nextMonthTS - var_19_2 > 0 then
		if arg_19_0.leftTimer then
			local var_19_3 = arg_19_0.leftTimer

			var_4.Stop(var_19_3)

			arg_19_0.leftTimer = nil
		end

		local function var_19_4()
			local var_20_1

			if var_0 <= 0 and arg_19_0.leftTimer then
				local var_20_0 = arg_19_0.leftTimer

				var_20_1.Stop(var_20_0)

				var_20_1 = arg_19_0
				var_20_1.leftTimer = nil
			end

			pg = var_20_1

			local var_20_2 = var_20_1.TimeMgr.GetInstance()
			local var_20_3, var_20_4, var_20_5, var_20_6 = var_0.parseTimeFrom(var_20_2, var_0)

			setText = var_2_10004

			var_2_10004(arg_19_0.leftDayValueText, var_20_3)

			setText = var_2_10004

			local var_20_7 = arg_19_0.leftTimeValueText

			string = var_7

			var_2_10004(var_20_7, var_7.format("%02d:%02d:%02d", var_20_4, var_20_5, var_20_6))

			var_0 = var_0 - 1

			return
		end

		Timer = var_1_10005
		arg_19_0.leftTimer = var_1_10005.New(var_19_4, 1, -1)

		local var_19_5 = arg_19_0.leftTimer

		var_5.Start(var_19_5)
		var_19_4()
	end

	return
end

function var_0_1.updateBossImg(arg_21_0)
	local var_21_0 = var_0_10001.GetChallengeIDByLevel(arg_21_0.curLevel)

	pg = var_1_10002

	local var_21_1 = var_1_10002.expedition_constellation_challenge_template[var_21_0].painting
	local var_21_2 = var_2.information_icon
	local var_21_3 = "limitchallenge/boss/" .. var_21_1

	setImageSprite = var_6

	local var_21_4 = arg_21_0.bgImg

	LoadSprite = var_1_10009

	var_6(var_21_4, var_1_10009(var_21_3, var_21_1))

	local var_21_5 = "limitchallenge/name/" .. var_21_2

	setImageSprite = var_7

	local var_21_6 = arg_21_0.nameImg

	LoadSprite = var_1_10010

	var_7(var_21_6, var_1_10010(var_21_5, var_21_2), true)

	local var_21_7 = var_2.button_style .. "_btn_start"
	local var_21_8 = "limitchallenge/btn/" .. var_21_7

	setImageSprite = var_9

	local var_21_9 = arg_21_0.startBtn

	LoadSprite = var_12

	var_9(var_21_9, var_12(var_21_8, var_21_7), true)

	local var_21_10 = "%d_level_%d_selected"

	ipairs = var_10

	for iter_21_0, iter_21_1 in var_10(arg_21_0.levelList) do
		string = var_21_11

		local var_21_11 = var_21_11.format(var_21_10, var_2.button_style, iter_21_1)
		local var_21_12 = "limitchallenge/btn/" .. var_21_11
		local var_21_13 = arg_21_0.levelToggleList[iter_21_1]
		local var_21_14

		var_21_14, setImageSprite = var_17.Find(var_21_13, "Selected"), var_18
		LoadSprite = var_1_10021

		var_18(var_21_14, var_1_10021(var_21_12, var_21_11), true)
	end

	return
end

function var_0_1.updateDescPanel(arg_22_0)
	arg_22_0.descList = {}

	local var_22_0 = var_0_10001.GetChallengeIDByLevel(arg_22_0.curLevel)

	pg = var_1_10002
	arg_22_0.descList = var_1_10002.expedition_constellation_challenge_template[var_22_0].description

	if 3 - #arg_22_0.descList > 0 then
		for iter_22_0 = 1, var_4 do
			table = var_1_10009

			var_1_10009.insert(arg_22_0.descList, false)
		end
	end

	local var_22_1 = arg_22_0.iconUIItemList

	var_5.align(var_22_1, #arg_22_0.descList)

	return
end

function var_0_1.updatePassTime(arg_23_0)
	LimitChallengeConst = var_1_10001

	local var_23_0 = var_1_10001.GetChallengeIDByLevel(arg_23_0.curLevel)
	local var_23_1 = arg_23_0.proxy
	local var_23_2

	if not var_2.getPassTimeByChallengeID(var_23_1, var_23_0) then
		var_23_2 = 0
	end

	math = var_3

	local var_23_3 = var_3.floor(var_23_2 / 60)

	math = var_23_1

	local var_23_4 = var_23_1.floor(var_23_2 % 60)

	string = var_5

	local var_23_5 = var_5.format("%02d:%02d", var_23_3, var_23_4)

	setText = var_6

	var_6(arg_23_0.passTimeValueText, var_23_5)

	return
end

function var_0_1.updateAward(arg_24_0)
	LimitChallengeConst = var_1_10001

	local var_24_0 = var_1_10001.GetChallengeIDByLevel(arg_24_0.curLevel)

	pg = var_1_10002

	local var_24_1 = var_1_10002.expedition_constellation_challenge_template[var_24_0].award_display[1]
	local var_24_2 = arg_24_0.proxy
	local var_24_3 = var_3.isAwardedByChallengeID(var_24_2, var_24_0)

	setActive = var_1_10004

	var_1_10004(arg_24_0.awardGotTF, var_24_3)

	if var_24_1 and #var_24_1 > 0 then
		var_1_10004 = {
			type = var_24_1[1],
			id = var_24_1[2]
		}

		local var_24_4

		if not var_24_1[3] then
			var_24_4 = 1
		end

		var_1_10004.count = var_24_4
		updateDrop = var_24_4

		var_24_4(arg_24_0.awardIconTF, var_1_10004)

		onButton = var_24_4

		local var_24_5 = arg_24_0
		local var_24_6 = arg_24_0.awardIconTF

		local function var_24_7()
			local var_25_0 = arg_24_0
			local var_25_1 = var_0.emit

			BaseUI = var_2_10003

			var_25_1(var_25_0, var_2_10003.ON_DROP, var_1_10004)

			return
		end

		SFX_PANEL = var_1_10010

		var_24_4(var_24_5, var_24_6, var_24_7, var_1_10010)

		setActive = var_24_4

		var_24_4(arg_24_0.awardIconTF, true)
	else
		setActive = var_1_10004

		var_1_10004(arg_24_0.awardIconTF, false)
	end

	return
end

function var_0_1.trigeHigestUnlockLevel(arg_26_0)
	local var_26_0 = arg_26_0:getHigestUnlockLevel()

	triggerToggle = var_1_10002

	var_1_10002(arg_26_0.levelToggleList[var_26_0], true)

	return
end

function var_0_1.onReqInfo(arg_27_0)
	arg_27_0:initData()
	arg_27_0:updateLeftTime()
	arg_27_0:updateToggleList()
	arg_27_0:trigeHigestUnlockLevel()

	return
end

function var_0_1.getHigestUnlockLevel(arg_28_0)
	for iter_28_0 = #arg_28_0.levelList, 1, -1 do
		local var_28_0 = arg_28_0.levelList[iter_28_0]
		local var_28_1 = arg_28_0.proxy

		if var_7.isLevelUnlock(var_28_1, var_28_0) then
			return var_28_0
		end
	end

	return
end

function var_0_1.getBuffIconPath(arg_29_0, arg_29_1, arg_29_2)
	pg = var_1_10003

	local var_29_0 = var_1_10003.expedition_constellation_challenge_template[arg_29_1]

	string = var_1_10004

	local var_29_1 = var_1_10004.format("%s_%d", var_29_0.painting, arg_29_2)

	return "limitchallenge/icon/" .. var_29_1, var_29_1
end

return var_0_1
