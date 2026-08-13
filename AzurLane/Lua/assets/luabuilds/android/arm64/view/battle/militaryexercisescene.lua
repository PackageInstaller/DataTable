class = var_0_10000

local var_0_0 = "MilitaryExerciseScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.TYPE_SHOP = 1

function var_0_1.getUIName(arg_1_0)
	return "MilitaryExerciseUI"
end

function var_0_1.ResUISettings(arg_2_0)
	return true
end

function var_0_1.setShips(arg_3_0, arg_3_1)
	arg_3_0.ships = arg_3_1

	return
end

function var_0_1.setFleet(arg_4_0, arg_4_1)
	arg_4_0.fleet = arg_4_1

	return
end

function var_0_1.setRivals(arg_5_0, arg_5_1)
	table = var_1_10002

	var_1_10002.sort(arg_5_1, function(arg_6_0, arg_6_1)
		return arg_6_0.rank < arg_6_1.rank
	end)

	arg_5_0.rivalVOs = arg_5_1

	return
end

function var_0_1.setExerciseCount(arg_7_0, arg_7_1)
	arg_7_0.exerciseCount = arg_7_1

	return
end

function var_0_1.setSeasonTime(arg_8_0, arg_8_1)
	arg_8_0.seasonTime = arg_8_1

	return
end

function var_0_1.setRecoverTime(arg_9_0, arg_9_1)
	arg_9_0.recoverTime = arg_9_1

	return
end

function var_0_1.setActivity(arg_10_0, arg_10_1)
	arg_10_0.activity = arg_10_1

	arg_10_0:setSeasonTime(arg_10_1.stopTime)

	return
end

function var_0_1.updateSeaInfoVO(arg_11_0, arg_11_1)
	arg_11_0.seasonInfo = arg_11_1

	arg_11_0:setFleet(arg_11_1.fleet)
	arg_11_0:setRivals(arg_11_1.rivals)
	arg_11_0:setExerciseCount(arg_11_1.fightCount)
	arg_11_0:setRecoverTime(arg_11_1.resetTime)

	return
end

function var_0_1.setSeasonInfo(arg_12_0, arg_12_1)
	arg_12_0:updateSeaInfoVO(arg_12_1)
	arg_12_0:setFleet(arg_12_1.fleet)
	arg_12_0:setRivals(arg_12_1.rivals)
	arg_12_0:setExerciseCount(arg_12_1.fightCount)
	arg_12_0:setRecoverTime(arg_12_1.resetTime)
	arg_12_0:updateSeasonTime()
	arg_12_0:initPlayerFleet()
	arg_12_0:initPlayerInfo()
	arg_12_0:updateRivals()

	return
end

function var_0_1.init(arg_13_0)
	local var_13_0 = arg_13_0._tf

	arg_13_0.backBtn = var_1.Find(var_13_0, "blur_panel/adapt/top/backBtn")
	pg = var_1
	arg_13_0._normalUIMain = var_1.UIMgr.GetInstance().UIMain
	pg = var_1
	arg_13_0._overlayUIMain = var_1.UIMgr.GetInstance().OverlayMain
	findTF = var_1
	arg_13_0.top = var_1(arg_13_0._tf, "blur_panel/adapt/top")

	local var_13_1 = arg_13_0._tf

	arg_13_0.awardPanel = var_1.Find(var_13_1, "award_info_panel")
	setActive = var_1

	var_1(arg_13_0.awardPanel, false)

	local var_13_2 = arg_13_0._tf

	arg_13_0.rivalList = var_1.Find(var_13_2, "center/rival_list")

	local var_13_3 = arg_13_0._tf

	arg_13_0.bottomPanel = var_1.Find(var_13_3, "bottom")
	arg_13_0.shipTpl = arg_13_0:getTpl("fleet_info/shiptpl", arg_13_0.bottomPanel)
	arg_13_0.emptyTpl = arg_13_0:getTpl("fleet_info/emptytpl", arg_13_0.bottomPanel)

	local var_13_4 = arg_13_0.bottomPanel

	arg_13_0.mainContainer = var_1.Find(var_13_4, "fleet_info/main")

	local var_13_5 = arg_13_0.bottomPanel

	arg_13_0.vanguardContainer = var_1.Find(var_13_5, "fleet_info/vanguard")
	pg = var_1
	arg_13_0.rankCfg = var_1.arena_data_rank

	arg_13_0:uiStartAnimating()

	return
end

function var_0_1.updatePlayer(arg_14_0, arg_14_1)
	arg_14_0.player = arg_14_1
	setText = var_1_10002
	findTF = var_1_10004

	local var_14_0 = arg_14_0._tf

	var_1_10002(var_1_10004(var_6.Find(var_14_0, "bottom/player_info"), "statistics_panel/exploit_bg/score"), arg_14_1.exploit)

	return
end

function var_0_1.uiStartAnimating(arg_15_0)
	local var_15_0 = 0
	local var_15_1 = arg_15_0.bottomPanel.localPosition.y

	setAnchoredPosition = var_1_10003

	var_1_10003(arg_15_0.bottomPanel, {
		y = var_15_1 - 308
	})

	shiftPanel = var_1_10003

	var_1_10003(arg_15_0.bottomPanel, nil, var_15_1, 0.3, var_15_0, true, true)

	return
end

function var_0_1.uiExitAnimating(arg_16_0)
	local var_16_0 = 0
	local var_16_1 = arg_16_0.bottomPanel.localPosition.y

	shiftPanel = var_1_10003

	var_1_10003(arg_16_0.bottomPanel, nil, var_16_1 - 308, 0.3, var_16_0, true, true)

	return
end

function var_0_1.didEnter(arg_17_0)
	onButton = var_1_10001

	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.backBtn

	local function var_17_2()
		if arg_17_0.isOpenRivalInfoPanel then
			local var_18_0 = arg_17_0

			var_0.closeRivalInfoPanel(var_18_0)
		else
			local var_18_1 = arg_17_0

			var_0.emit(var_18_1, var_0_1.ON_BACK)
		end

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_17_0, var_17_1, var_17_2, var_1_10006)

	setActive = var_1_10001

	local var_17_3 = arg_17_0._tf
	local var_17_4 = var_3.Find(var_17_3, "stamp")

	getProxy = var_17_1
	TaskProxy = var_6

	local var_17_5 = var_17_1(var_6)

	var_1_10001(var_17_4, var_4.mingshiTouchFlagEnabled(var_17_5))

	LOCK_CLICK_MINGSHI = var_1_10001

	if var_1_10001 then
		setActive = var_1_10001

		local var_17_6 = arg_17_0._tf

		var_1_10001(var_3.Find(var_17_6, "stamp"), false)
	end

	onButton = var_1_10001

	local var_17_7 = arg_17_0
	local var_17_8 = arg_17_0._tf
	local var_17_9 = var_4.Find(var_17_8, "stamp")

	local function var_17_10()
		getProxy = var_2_10000
		TaskProxy = var_2_10002

		local var_19_0 = var_2_10000(var_2_10002)

		var_0.dealMingshiTouchFlag(var_19_0, 10)

		return
	end

	SFX_CONFIRM = var_17_8

	var_1_10001(var_17_7, var_17_9, var_17_10, var_17_8)

	onButton = var_1_10001

	local var_17_11 = arg_17_0
	local var_17_12 = arg_17_0._tf
	local var_17_13 = var_4.Find(var_17_12, "bottom/buttons/rank_btn")

	local function var_17_14()
		local var_20_0 = arg_17_0
		local var_20_1 = var_0.emit

		MilitaryExerciseMediator = var_2_10003

		var_20_1(var_20_0, var_2_10003.OPEN_RANK)

		return
	end

	SFX_PANEL = var_17_12

	var_1_10001(var_17_11, var_17_13, var_17_14, var_17_12)

	onButton = var_1_10001

	local var_17_15 = arg_17_0
	local var_17_16 = arg_17_0._tf
	local var_17_17 = var_4.Find(var_17_16, "bottom/buttons/shop_btn")

	local function var_17_18()
		local var_21_0 = arg_17_0
		local var_21_1 = var_0.emit

		MilitaryExerciseMediator = var_2_10003

		var_21_1(var_21_0, var_2_10003.OPEN_SHOP)

		return
	end

	SFX_PANEL = var_17_16

	var_1_10001(var_17_15, var_17_17, var_17_18, var_17_16)

	onButton = var_1_10001

	local var_17_19 = arg_17_0
	local var_17_20 = arg_17_0._tf
	local var_17_21 = var_4.Find(var_17_20, "bottom/buttons/award_btn")

	local function var_17_22()
		local var_22_0 = arg_17_0

		var_22_0.isOpenAwards = true
		pg = var_22_0

		local var_22_1 = var_22_0.UIMgr.GetInstance()

		var_0.BlurPanel(var_22_1, arg_17_0.awardPanel)

		local var_22_3

		if not arg_17_0.isInitAward then
			local var_22_2 = arg_17_0

			var_22_3.initAwards(var_22_2)

			var_22_3 = arg_17_0
			var_22_3.isInitAward = true
		else
			setActive = var_22_3

			var_22_3(arg_17_0.awardPanel, true)
		end

		return
	end

	SFX_PANEL = var_17_20

	var_1_10001(var_17_19, var_17_21, var_17_22, var_17_20)

	onButton = var_1_10001

	local var_17_23 = arg_17_0

	findTF = var_17_21

	local var_17_24 = var_17_21(arg_17_0._tf, "center/replace_rival_btn")

	local function var_17_25()
		local var_23_0 = arg_17_0
		local var_23_1 = var_0.emit

		MilitaryExerciseMediator = var_2_10003

		var_23_1(var_23_0, var_2_10003.REPLACE_RIVALS)

		return
	end

	SFX_PANEL = var_6

	var_1_10001(var_17_23, var_17_24, var_17_25, var_6)

	if arg_17_0.contextData.mode == var_0_1.TYPE_SHOP then
		triggerToggle = var_1

		var_1(arg_17_0.shopBtn, true)
	end

	return
end

function var_0_1.updateSeasonTime(arg_24_0)
	local var_24_0 = arg_24_0._tf

	arg_24_0.seasonInfoPanel = var_1.Find(var_24_0, "center/season_info")

	arg_24_0:updateSeasonLeftTime(arg_24_0.seasonTime)
	arg_24_0:updateRecoverTime(arg_24_0.recoverTime)
	arg_24_0:updateExerciseCount()

	return
end

function var_0_1.updateExerciseCount(arg_25_0)
	setText = var_1_10001
	findTF = var_1_10003

	local var_25_0 = var_1_10003(arg_25_0.seasonInfoPanel, "count")

	math = var_1_10004

	local var_25_1 = var_1_10004.max
	local var_25_2

	if not arg_25_0.exerciseCount then
		var_25_2 = 0
	end

	local var_25_3 = var_25_1(var_25_2, 0)
	local var_25_4 = "/"

	SeasonInfo = var_25_2

	var_1_10001(var_25_0, var_25_3 .. var_25_4 .. var_25_2.MAX_FIGHTCOUNT)

	return
end

function var_0_1.updateSeasonLeftTime(arg_26_0, arg_26_1)
	if arg_26_0.leftTimeTimer then
		local var_26_0 = arg_26_0.leftTimeTimer

		var_2.Stop(var_26_0)

		arg_26_0.leftTimeTimer = nil
	end

	findTF = var_2

	local var_26_1 = var_2(arg_26_0.seasonInfoPanel, "left_time_container/day")

	findTF = var_1_10003

	local var_26_2 = var_1_10003(arg_26_0.seasonInfoPanel, "left_time_container/time")

	Timer = var_4
	arg_26_0.leftTimeTimer = var_4.New(function()
		local var_27_0 = arg_26_1

		pg = var_2_10001

		local var_27_1 = var_2_10001.TimeMgr.GetInstance()
		local var_27_2 = var_27_0 - var_1.GetServerTime(var_27_1)
		local var_27_4

		if 0 < var_27_2 then
			pg = var_27_4

			local var_27_3 = var_27_4.TimeMgr.GetInstance()
			local var_27_5, var_27_6, var_27_7

			var_27_4, var_27_5, var_27_6, var_27_7 = var_27_4.parseTimeFrom(var_27_3, var_27_2)
			setText = var_2_10005

			var_2_10005(var_26_1, var_27_4)

			setText = var_2_10005

			local var_27_8 = var_26_2

			string = var_8

			var_2_10005(var_27_8, var_8.format("%02d:%02d:%02d", var_27_5, var_27_6, var_27_7))
		else
			setText = var_27_4

			var_27_4(var_26_1, 0)

			setText = var_27_4

			local var_27_9 = var_26_2

			string = var_4

			var_27_4(var_27_9, var_4.format("%02d:%02d:%02d", 0, 0, 0))

			local var_27_10 = arg_26_0.leftTimeTimer

			var_1.Stop(var_27_10)

			arg_26_0.leftTimeTimer = nil
		end

		return
	end, 1, -1)

	local var_26_3 = arg_26_0.leftTimeTimer

	var_4.Start(var_26_3)
	arg_26_0.leftTimeTimer.func()

	return
end

function var_0_1.updateRecoverTime(arg_28_0, arg_28_1)
	if arg_28_0.recoverTimer then
		local var_28_0 = arg_28_0.recoverTimer

		var_2.Stop(var_28_0)

		arg_28_0.recoverTimer = nil
	end

	findTF = var_2

	local var_28_1 = var_2(arg_28_0.seasonInfoPanel, "recover_container/time")

	if arg_28_1 == 0 then
		setText = var_1_10003

		var_1_10003(var_28_1, "")

		return
	end

	Timer = var_1_10003
	arg_28_0.recoverTimer = var_1_10003.New(function()
		local var_29_0 = arg_28_1

		pg = var_2_10001

		local var_29_1 = var_2_10001.TimeMgr.GetInstance()
		local var_29_2 = var_29_0 - var_1.GetServerTime(var_29_1)

		if 0 < var_29_2 then
			setText = var_1

			local var_29_3 = var_28_1

			i18n = var_2_10004

			local var_29_4 = "exercise_count_recover_tip"

			pg = var_2_10007

			local var_29_5 = var_2_10007.TimeMgr.GetInstance()

			var_1(var_29_3, var_2_10004(var_29_4, var_7.DescCDTime(var_29_5, var_29_2)))
		else
			local var_29_6 = arg_28_0.recoverTimer

			var_1.Stop(var_29_6)

			arg_28_0.recoverTimer = nil
		end

		return
	end, 1, -1)

	local var_28_2 = arg_28_0.recoverTimer

	var_3.Start(var_28_2)
	arg_28_0.recoverTimer.func()

	return
end

function var_0_1.initPlayerFleet(arg_30_0)
	local function var_30_0(arg_31_0, arg_31_1, arg_31_2)
		cloneTplTo = var_2_10003

		local var_31_0 = var_2_10003(arg_30_0.shipTpl, arg_31_1)
		local var_31_1 = arg_31_0.configId
		local var_31_2 = arg_31_0.skinId

		updateShip = var_6

		var_6(var_31_0, arg_31_0, {
			initStar = true
		})

		setText = var_6
		findTF = var_8

		var_6(var_8(var_31_0, "icon_bg/lv/Text"), arg_31_0.level)

		onButton = var_6

		local var_31_3 = arg_30_0
		local var_31_4 = var_31_0

		local function var_31_5()
			local var_32_0 = arg_30_0
			local var_32_1 = var_0.emit

			MilitaryExerciseMediator = var_3_10003

			var_32_1(var_32_0, var_3_10003.OPEN_DOCKYARD, arg_31_2, arg_31_0.id)

			return
		end

		SFX_PANEL = var_11

		var_6(var_31_3, var_31_4, var_31_5, var_11)

		return
	end

	removeAllChildren = var_1_10002

	var_1_10002(arg_30_0.mainContainer)

	removeAllChildren = var_1_10002

	var_1_10002(arg_30_0.vanguardContainer)

	for iter_30_0 = 1, 3 do
		if arg_30_0.fleet.mainShips[iter_30_0] then
			if arg_30_0.ships[var_6] then
				var_1_10008 = var_30_0

				local var_30_1 = var_1_10007

				var_1_10011 = arg_30_0.mainContainer
				TeamType = var_1_10012

				var_1_10008(var_30_1, var_1_10011, var_1_10012.Main)
			end
		else
			cloneTplTo = var_1_10007
			var_1_10007 = var_1_10007(arg_30_0.emptyTpl, arg_30_0.mainContainer)
			onButton = var_1_10008

			local var_30_2 = arg_30_0

			findTF = var_1_10011
			var_1_10011 = var_1_10011(var_1_10007, "icon_bg")

			function var_1_10012()
				local var_33_0 = arg_30_0
				local var_33_1 = var_0.emit

				MilitaryExerciseMediator = var_2_10003

				local var_33_2 = var_2_10003.OPEN_DOCKYARD

				TeamType = var_2_10004

				var_33_1(var_33_0, var_33_2, var_2_10004.Main, 0)

				return
			end

			SFX_PANEL = var_13

			var_1_10008(var_30_2, var_1_10011, var_1_10012, var_13)
		end
	end

	for iter_30_1 = 1, 3 do
		if arg_30_0.fleet.vanguardShips[iter_30_1] then
			if arg_30_0.ships[var_6] then
				var_1_10008 = var_30_0

				local var_30_3 = var_1_10007

				var_1_10011 = arg_30_0.vanguardContainer
				TeamType = var_1_10012

				var_1_10008(var_30_3, var_1_10011, var_1_10012.Vanguard)
			end
		else
			cloneTplTo = var_1_10007
			var_1_10007 = var_1_10007(arg_30_0.emptyTpl, arg_30_0.vanguardContainer)
			onButton = var_1_10008

			local var_30_4 = arg_30_0

			findTF = var_1_10011
			var_1_10011 = var_1_10011(var_1_10007, "icon_bg")

			function var_1_10012()
				local var_34_0 = arg_30_0
				local var_34_1 = var_0.emit

				MilitaryExerciseMediator = var_2_10003

				local var_34_2 = var_2_10003.OPEN_DOCKYARD

				TeamType = var_2_10004

				var_34_1(var_34_0, var_34_2, var_2_10004.Vanguard, 0)

				return
			end

			SFX_PANEL = var_13

			var_1_10008(var_30_4, var_1_10011, var_1_10012, var_13)
		end
	end

	return
end

function var_0_1.initPlayerInfo(arg_35_0)
	local var_35_0 = arg_35_0.seasonInfo.score
	local var_35_1 = arg_35_0._tf
	local var_35_2 = var_2.Find(var_35_1, "bottom/player_info")

	setText = var_1_10003
	findTF = var_5

	var_1_10003(var_5(var_35_2, "statistics_panel/score_bg/score"), var_35_0)

	setText = var_1_10003
	findTF = var_5

	var_1_10003(var_5(var_35_2, "statistics_panel/rank_bg/score"), arg_35_0.seasonInfo.rank)

	findTF = var_1_10003

	local var_35_3 = var_1_10003(var_35_2, "upgrade_tip/level")

	findTF = var_35_1

	local var_35_4 = var_35_1(var_35_2, "upgrade_rank_tip/level")

	findTF = var_5

	local var_35_5 = var_5(var_35_2, "upgrade_score_tip/level")

	SeasonInfo = var_6

	local var_35_6 = var_6.getMilitaryRank(var_35_0, arg_35_0.seasonInfo.rank)

	assert = var_7

	var_7(var_35_6, ">>>" .. var_35_0 .. "--" .. arg_35_0.seasonInfo.rank)

	SeasonInfo = var_7

	local var_35_7 = var_7.getEmblem(var_35_0, arg_35_0.seasonInfo.rank)

	LoadImageSpriteAsync = var_8

	local var_35_8 = "emblem/" .. var_35_7

	findTF = var_11

	var_8(var_35_8, var_11(var_35_2, "medal_bg/medal"), true)

	LoadImageSpriteAsync = var_8

	local var_35_9 = "emblem/n_" .. var_35_7

	findTF = var_11

	var_8(var_35_9, var_11(var_35_2, "medal_bg/Text"), true)

	findTF = var_8

	local var_35_10 = var_8(var_35_2, "exp_slider")
	local var_35_11 = var_8.GetComponent(var_35_10, "Slider")

	SeasonInfo = var_9

	local var_35_12, var_35_13, var_35_14 = var_9.getNextMilitaryRank(var_35_0, arg_35_0.seasonInfo.rank)

	math = var_12

	local var_35_15 = var_12.min(var_35_13, var_35_0)

	setText = var_12

	var_12(var_35_3, var_35_12)

	setText = var_12

	var_12(var_35_5, var_35_13)

	setText = var_12

	var_12(var_35_4, var_35_14 > 0 and var_35_14 or "-")

	var_35_11.value = var_35_15 / var_35_13

	return
end

function var_0_1.updateRivals(arg_36_0)
	arg_36_0.rivalTFs = {}

	for iter_36_0 = 1, 4 do
		table = var_1_10005
		var_1_10005 = var_1_10005.insert

		local var_36_0 = arg_36_0.rivalTFs
		local var_36_1 = arg_36_0.rivalList

		var_1_10005(var_36_0, var_8.GetChild(var_36_1, iter_36_0 - 1))
	end

	for iter_36_1 = 1, 4 do
		local var_36_2 = arg_36_0.rivalTFs[iter_36_1]

		setActive = var_1_10006

		var_1_10006(var_36_2, iter_36_1 <= #arg_36_0.rivalVOs)

		if iter_36_1 <= #arg_36_0.rivalVOs then
			arg_36_0:updateRival(iter_36_1)
		end
	end

	return
end

function var_0_1.updateRival(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0.rivalTFs[arg_37_1]
	local var_37_1 = arg_37_0.rivalVOs[arg_37_1]

	SeasonInfo = var_1_10004

	local var_37_2 = var_1_10004.getMilitaryRank(var_37_1.score, var_37_1.rank)

	assert = var_1_10005

	var_1_10005(var_37_2, ">>>" .. var_37_1.score .. "--" .. var_37_1.rank)

	findTF = var_1_10005

	local var_37_3 = var_1_10005(var_37_0, "shiptpl")

	SeasonInfo = var_6

	local var_37_4 = var_6.getEmblem(var_37_1.score, var_37_1.rank)

	LoadImageSpriteAsync = var_7

	local var_37_5 = "emblem/" .. var_37_4

	findTF = var_10

	var_7(var_37_5, var_10(var_37_0, "medal"), true)

	LoadImageSpriteAsync = var_7

	local var_37_6 = "emblem/n_" .. var_37_4

	findTF = var_10

	var_7(var_37_6, var_10(var_37_0, "Text"), true)

	updateDrop = var_7

	local var_37_7 = var_37_3
	local var_37_8 = {}

	DROP_TYPE_SHIP = var_11
	var_37_8.type = var_11
	var_37_8.id = var_37_1.icon
	var_37_8.skinId = var_37_1.skinId
	var_37_8.propose = var_37_1.proposeTime
	var_37_8.remoulded = var_37_1.remoulded

	var_7(var_37_7, var_37_8, {
		initStar = true
	})

	setActive = var_7
	findTF = var_37_7

	var_7(var_37_7(var_37_3, "icon_bg/lv"), false)

	setText = var_7
	findTF = var_9

	var_7(var_9(var_37_0, "rank_bg/rank_container/name"), var_37_1.rank)

	setText = var_7
	findTF = var_9

	var_7(var_9(var_37_0, "name_container/name"), var_37_1.name)

	setText = var_7
	findTF = var_9

	var_7(var_9(var_37_0, "name_container/lv"), "Lv." .. var_37_1.level)

	setText = var_7
	findTF = var_9

	local var_37_9 = var_9(var_37_0, "comprehensive_panel/comprehensive/main_fleet/value")
	local var_37_10 = var_37_1
	local var_37_11 = var_37_1.GetGearScoreSum

	TeamType = var_13

	var_7(var_37_9, var_37_11(var_37_10, var_13.Main))

	setText = var_7
	findTF = var_37_9

	local var_37_12 = var_37_9(var_37_0, "comprehensive_panel/comprehensive/vanguard_fleet/value")
	local var_37_13 = var_37_1
	local var_37_14 = var_37_1.GetGearScoreSum

	TeamType = var_13

	var_7(var_37_12, var_37_14(var_37_13, var_13.Vanguard))

	onButton = var_7

	local var_37_15 = arg_37_0
	local var_37_16 = var_37_0

	local function var_37_17()
		local var_38_0 = arg_37_0
		local var_38_1 = var_0.emit

		MilitaryExerciseMediator = var_2_10003

		var_38_1(var_38_0, var_2_10003.OPEN_RIVAL_INFO, var_37_1)

		return
	end

	SFX_PANEL = var_37_13

	var_7(var_37_15, var_37_16, var_37_17, var_37_13)

	return
end

function var_0_1.initAwards(arg_39_0)
	assert = var_1_10001

	var_1_10001(not arg_39_0.isInitAward, "已经初始化奖励列表")

	setActive = var_1_10001

	var_1_10001(arg_39_0.awardPanel, true)

	onButton = var_1_10001

	local var_39_0 = arg_39_0
	local var_39_1 = arg_39_0.awardPanel
	local var_39_2 = var_4.Find(var_39_1, "top/btnBack")

	local function var_39_3()
		local var_40_0 = arg_39_0

		var_0.closeAwards(var_40_0)

		return
	end

	SFX_CANCEL = var_39_1

	var_1_10001(var_39_0, var_39_2, var_39_3, var_39_1)

	local var_39_4 = arg_39_0.awardPanel
	local var_39_5

	var_39_5, setText = var_1.Find(var_39_4, "bg/frame/content/time_panel/Text"), var_1_10002
	i18n = var_39_3

	local var_39_6 = "exercise_time_tip"
	local var_39_7 = "   "

	os = var_1_10009

	local var_39_8 = var_1_10009.date("%Y.%m.%d", arg_39_0.activity.data1)
	local var_39_9 = " — "

	os = var_11

	var_1_10002(var_39_5, var_39_3(var_39_6, var_39_7 .. var_39_8 .. var_39_9 .. var_11.date("%Y.%m.%d", arg_39_0.activity.stopTime)))

	local var_39_10 = arg_39_0.awardPanel
	local var_39_11

	var_39_11, setText = var_2.Find(var_39_10, "bg/frame/content/desc_panel/Text"), var_39_4
	i18n = var_39_1

	var_39_4(var_39_11, var_39_1("exercise_rule_tip"))

	local var_39_12 = arg_39_0.awardPanel
	local var_39_13 = var_3.Find(var_39_12, "bg/frame/content/award_panel/award_list")
	local var_39_14 = arg_39_0:getTpl("awardtpl", var_39_13)
	local var_39_15 = arg_39_0:getTpl("awards/equipmenttpl", var_39_14)
	local var_39_16 = var_39_13
	local var_39_17 = var_39_13.Find(var_39_16, "linetpl")
	local var_39_18 = arg_39_0.awardPanel
	local var_39_19

	var_39_19, setText = var_7.Find(var_39_18, "bg/frame/content/award_panel/Text"), var_39_16
	i18n = var_11

	var_39_16(var_39_19, var_11("exercise_award_tip"))

	local function var_39_20(arg_41_0, arg_41_1)
		local var_41_0 = arg_41_0
		local var_41_1 = arg_41_0.Find(var_41_0, "awards")
		local var_41_2 = arg_39_0.rankCfg[arg_41_1]

		setText = var_41_0
		findTF = var_2_10006

		var_41_0(var_2_10006(arg_41_0, "Text"), var_41_2.name .. ":")

		ipairs = var_41_0

		for iter_41_0, iter_41_1 in var_41_0(var_41_2.award_list) do
			cloneTplTo = var_41_3

			local var_41_3 = var_41_3(var_39_15, var_41_1)

			updateDrop = var_2_10010

			var_2_10010(var_41_3, {
				type = iter_41_1[1],
				id = iter_41_1[2],
				count = iter_41_1[3]
			})

			onButton = var_2_10010

			local var_41_4 = arg_39_0
			local var_41_5 = var_41_3
			local var_41_6 = var_41_3.Find(var_41_5, "icon_bg")

			local function var_41_7()
				local var_42_0 = arg_39_0
				local var_42_1 = var_0.emit

				BaseUI = var_3_10003

				local var_42_2 = var_3_10003.ON_ITEM

				if iter_41_1[1] == 1 then
					id2ItemId = var_4

					local var_42_3

					if not var_4(iter_41_1[2]) then
						var_42_3 = iter_41_1[2]
					end

					var_42_1(var_42_0, var_42_2, var_42_3)

					return
				end
			end

			SFX_PANEL = var_41_5

			var_2_10010(var_41_4, var_41_6, var_41_7, var_41_5)
		end

		setText = var_4
		findTF = var_6

		var_4(var_6(arg_41_0, "upgrade_score_tip/level"), var_41_2.point)

		setText = var_4
		findTF = var_6

		local var_41_8 = var_6(arg_41_0, "upgrade_rank_tip/level")
		local var_41_9

		if not (var_41_2.order > 0) or not var_41_2.order then
			var_41_9 = "-"
		end

		var_4(var_41_8, var_41_9)

		return
	end

	for iter_39_0 = #arg_39_0.rankCfg.all, 1, -1 do
		local var_39_21 = arg_39_0.rankCfg.all[iter_39_0]

		if #arg_39_0.rankCfg[var_39_21].award_list > 0 then
			local var_39_22 = var_39_20

			cloneTplTo = var_1_10016

			var_39_22(var_1_10016(var_39_14, var_39_13), var_39_21)

			cloneTplTo = var_39_22

			var_39_22(var_39_17, var_39_13)
		end
	end

	return
end

function var_0_1.closeAwards(arg_43_0)
	if arg_43_0.isOpenAwards then
		setActive = var_1

		var_1(arg_43_0.awardPanel, false)

		arg_43_0.isOpenAwards = false
		pg = var_1

		local var_43_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_43_0, arg_43_0.awardPanel, arg_43_0._tf)
	end

	return
end

function var_0_1.onBackPressed(arg_44_0)
	if arg_44_0.isOpenAwards then
		arg_44_0:closeAwards()
	else
		pg = var_1

		local var_44_0 = var_1.CriMgr.GetInstance()
		local var_44_1 = var_1.PlaySoundEffect_V3

		SFX_CANCEL = var_1_10004

		var_44_1(var_44_0, var_1_10004)
		arg_44_0:emit(var_0_1.ON_BACK)
	end

	return
end

function var_0_1.willExit(arg_45_0)
	if arg_45_0.tweens then
		cancelTweens = var_1

		var_1(arg_45_0.tweens)
	end

	if arg_45_0.leftTimeTimer then
		local var_45_0 = arg_45_0.leftTimeTimer

		var_1.Stop(var_45_0)

		arg_45_0.leftTimeTimer = nil
	end

	if arg_45_0.recoverTimer then
		local var_45_1 = arg_45_0.recoverTimer

		var_1.Stop(var_45_1)

		arg_45_0.recoverTimer = nil
	end

	arg_45_0:closeAwards()

	return
end

return var_0_1
