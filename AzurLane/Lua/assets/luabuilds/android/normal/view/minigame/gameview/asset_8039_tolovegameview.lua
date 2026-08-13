class = var_0_10000

local var_0_0 = "ToLoveGameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))

import = var_0_0

local var_0_2 = var_0_0("view.miniGame.gameView.ToLoveGame.ToLoveGameVo")

function var_0_1.getUIName(arg_1_0)
	return "ToLoveGameUI"
end

function var_0_1.didEnter(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:initEvent()

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.changeBgm

	ToLoveGameConst = var_1_10003

	var_2_1(var_2_0, var_1_10003.bgm_type_menu)

	return
end

function var_0_1.initData(arg_3_0)
	var_0_2.Init(arg_3_0:GetMGData().id, arg_3_0:GetMGHubData().id)

	local var_3_0 = var_0_2.frameRate

	if 60 < var_3_0 then
		var_3_0 = 60
	end

	Timer = var_2
	arg_3_0.timer = var_2.New(function()
		local var_4_0 = arg_3_0

		var_0.onTimer(var_4_0)

		return
	end, 1 / var_3_0, -1)

	arg_3_0:GetTaskData()

	return
end

function var_0_1.initUI(arg_5_0)
	arg_5_0:initMenuUI()
	arg_5_0:initGamingUI()
	arg_5_0:initPopUI()

	local var_5_0 = arg_5_0._tf

	arg_5_0.clickMask = var_1.Find(var_5_0, "clickMask")

	return
end

function var_0_1.initMenuUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.menuUI = var_1.Find(var_6_0, "ui/menuUI")

	local var_6_1 = arg_6_0.menuUI

	arg_6_0.menuBack = var_1.Find(var_6_1, "btnBack")

	local var_6_2 = arg_6_0.menuUI

	arg_6_0.menuHome = var_1.Find(var_6_2, "btnHome")

	local var_6_3 = arg_6_0.menuUI

	arg_6_0.menuHighestScoreText = var_1.Find(var_6_3, "highestScore/Text")

	local var_6_4 = arg_6_0.menuUI

	arg_6_0.menuRule = var_1.Find(var_6_4, "btnRule")

	local var_6_5 = arg_6_0.menuUI

	arg_6_0.menuStart = var_1.Find(var_6_5, "btnStart")

	local var_6_6 = arg_6_0.menuUI

	arg_6_0.menuRank = var_1.Find(var_6_6, "btnRank")

	local var_6_7 = arg_6_0.menuUI

	arg_6_0.menuBuff = var_1.Find(var_6_7, "btnBuff")

	local var_6_8 = arg_6_0.menuUI

	arg_6_0.menuTask = var_1.Find(var_6_8, "btnTask")

	local var_6_9 = arg_6_0.menuUI

	arg_6_0.menuLastTimesText = var_1.Find(var_6_9, "lastTimes/desc")
	UIItemList = var_1

	local var_6_10 = var_1.New
	local var_6_11 = arg_6_0.menuUI
	local var_6_12 = var_2.Find(var_6_11, "awardsScrollView/Viewport/Content")
	local var_6_13 = arg_6_0.menuUI

	arg_6_0.menuAwardList = var_6_10(var_6_12, var_3.Find(var_6_13, "awardsScrollView/Viewport/Content/award"))

	local var_6_14 = arg_6_0.menuStart

	arg_6_0.menuStartTip = var_1.Find(var_6_14, "tip")

	local var_6_15 = arg_6_0.menuBuff

	arg_6_0.menuBuffTip = var_1.Find(var_6_15, "tip")

	local var_6_16 = arg_6_0.menuTask

	arg_6_0.menuTaskTip = var_1.Find(var_6_16, "tip")
	setText = var_1

	local var_6_17 = arg_6_0.menuUI
	local var_6_18 = var_2.Find(var_6_17, "awards/Text")

	i18n = var_6_17

	var_1(var_6_18, var_6_17("tolovegame_join_reward"))

	local var_6_19 = arg_6_0.menuUI
	local var_6_20 = var_1.Find(var_6_19, "title")
	local var_6_21 = var_1.GetComponent

	typeof = var_3
	Image = var_4

	local var_6_22 = var_6_21(var_6_20, var_3(var_4))

	var_1.SetNativeSize(var_6_22)

	local var_6_23 = arg_6_0.menuUI
	local var_6_24 = var_1.Find(var_6_23, "desc")
	local var_6_25 = var_1.GetComponent

	typeof = var_3
	Image = var_4

	local var_6_26 = var_6_25(var_6_24, var_3(var_4))

	var_1.SetNativeSize(var_6_26)

	setActive = var_1

	var_1(arg_6_0.menuUI, true)

	onButton = var_1

	local var_6_27 = arg_6_0
	local var_6_28 = arg_6_0.menuBack

	local function var_6_29()
		local var_7_0 = arg_6_0

		var_0.closeView(var_7_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_6_27, var_6_28, var_6_29, var_5)

	onButton = var_1

	local var_6_30 = arg_6_0
	local var_6_31 = arg_6_0.menuHome

	local function var_6_32()
		local var_8_0 = arg_6_0
		local var_8_1 = var_0.emit

		BaseUI = var_2_10002

		var_8_1(var_8_0, var_2_10002.ON_HOME)

		return
	end

	SFX_PANEL = var_5

	var_1(var_6_30, var_6_31, var_6_32, var_5)

	local var_6_33

	if arg_6_0:GetMGHubData().highScores[var_0_2.game_id] and arg_6_0:GetMGHubData().highScores[var_0_2.game_id][1] then
		var_6_33 = var_0_2
		var_6_33.highestScore = arg_6_0:GetMGHubData().highScores[var_0_2.game_id][1]
	end

	setText = var_6_33

	var_6_33(arg_6_0.menuHighestScoreText, var_0_2.highestScore)

	onButton = var_6_33

	local var_6_34 = arg_6_0
	local var_6_35 = arg_6_0.menuRule

	local function var_6_36()
		pg = var_2_10000

		local var_9_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_9_2.type = var_2_10003
		pg = var_2_10003

		local var_9_3 = var_2_10003.gametip

		ToLoveGameConst = var_2_10004
		var_9_2.helps = var_9_3[var_2_10004.rule_tip].tip

		var_9_1(var_9_0, var_9_2)

		return
	end

	SFX_PANEL = var_5

	var_6_33(var_6_34, var_6_35, var_6_36, var_5)

	onButton = var_6_33

	local var_6_37 = arg_6_0
	local var_6_38 = arg_6_0.menuStart

	local function var_6_39()
		local var_10_0 = arg_6_0

		var_0.readyStart(var_10_0)

		return
	end

	SFX_PANEL = var_5

	var_6_33(var_6_37, var_6_38, var_6_39, var_5)

	onButton = var_6_33

	local var_6_40 = arg_6_0
	local var_6_41 = arg_6_0.menuRank

	local function var_6_42()
		setActive = var_2_10000

		var_2_10000(arg_6_0.menuUI, false)

		local var_11_0 = arg_6_0

		var_0.ShowRank(var_11_0)

		return
	end

	SFX_PANEL = var_5

	var_6_33(var_6_40, var_6_41, var_6_42, var_5)

	onButton = var_6_33

	local var_6_43 = arg_6_0
	local var_6_44 = arg_6_0.menuBuff

	local function var_6_45()
		setActive = var_2_10000

		var_2_10000(arg_6_0.menuUI, false)

		local var_12_0 = arg_6_0

		var_0.ShowBuff(var_12_0)

		return
	end

	SFX_PANEL = var_5

	var_6_33(var_6_43, var_6_44, var_6_45, var_5)

	onButton = var_6_33

	local var_6_46 = arg_6_0
	local var_6_47 = arg_6_0.menuTask

	local function var_6_48()
		setActive = var_2_10000

		var_2_10000(arg_6_0.menuUI, false)

		local var_13_0 = arg_6_0

		var_0.ShowTask(var_13_0)

		return
	end

	SFX_PANEL = var_5

	var_6_33(var_6_46, var_6_47, var_6_48, var_5)

	setText = var_6_33

	var_6_33(arg_6_0.menuLastTimesText, arg_6_0:GetMGHubData().count)
	arg_6_0:UpdateMenuAwardList()

	setActive = var_1

	var_1(arg_6_0.menuStartTip, arg_6_0:GetMGHubData().count > 0)

	setActive = var_1

	var_1(arg_6_0.menuBuffTip, arg_6_0:ShouldShowBuffTip())

	setActive = var_1

	var_1(arg_6_0.menuTaskTip, arg_6_0.canGetAward)

	return
end

function var_0_1.UpdateMenuAwardList(arg_14_0)
	local var_14_0 = arg_14_0.menuAwardList

	var_1.make(var_14_0, function(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = var_0_2.drop[arg_15_1 + 1]
		local var_15_1 = {
			type = var_15_0[1],
			id = var_15_0[2],
			count = var_15_0[3]
		}

		updateDrop = var_5

		var_5(arg_15_2, var_15_1)

		onButton = var_5

		local var_15_2 = arg_14_0
		local var_15_3 = arg_15_2

		local function var_15_4()
			local var_16_0 = arg_14_0
			local var_16_1 = var_0.emit

			BaseUI = var_3_10002

			var_16_1(var_16_0, var_3_10002.ON_DROP, var_15_1)

			return
		end

		SFX_PANEL = var_2_10009

		var_5(var_15_2, var_15_3, var_15_4, var_2_10009)

		local var_15_5 = arg_14_0
		local var_15_6 = var_5.GetMGHubData(var_15_5).count
		local var_15_7 = arg_14_0
		local var_15_8 = var_6.GetMGHubData(var_15_7).usedtime

		setActive = var_15_7

		var_15_7(arg_15_2:Find("lock"), arg_15_1 + 1 > var_15_6 + var_15_8)

		setActive = var_15_7

		var_15_7(arg_15_2:Find("got"), var_15_8 >= arg_15_1 + 1)

		return
	end)

	local var_14_1 = arg_14_0.menuAwardList

	var_1.align(var_14_1, #var_0_2.drop)

	return
end

function var_0_1.ShouldShowBuffTip(arg_17_0)
	arg_17_0.unlockBuffCount = 0

	local var_17_0 = var_0_2.GetBuffList(arg_17_0:GetMGHubData())

	ipairs = var_2

	for iter_17_0, iter_17_1 in var_2(var_17_0) do
		if iter_17_1[3] == "" then
			arg_17_0.unlockBuffCount = arg_17_0.unlockBuffCount + 1
		end
	end

	PlayerPrefs = var_2

	local var_17_1 = var_2.GetInt("toLoveGameBuffCount", 0)

	if arg_17_0.unlockBuffCount ~= var_17_1 then
		return true
	end

	return false
end

function var_0_1.initGamingUI(arg_18_0)
	local var_18_0 = arg_18_0._tf

	arg_18_0.gamingUI = var_1.Find(var_18_0, "ui/gamingUI")

	local var_18_1 = arg_18_0.gamingUI

	arg_18_0.gamingBack = var_1.Find(var_18_1, "back")

	local var_18_2 = arg_18_0.gamingUI

	arg_18_0.gamingPause = var_1.Find(var_18_2, "pause")

	local var_18_3 = arg_18_0.gamingUI

	arg_18_0.gamingScoreText = var_1.Find(var_18_3, "bgScore/score")

	local var_18_4 = arg_18_0.gamingUI

	arg_18_0.gamingTimeText = var_1.Find(var_18_4, "bgTime/time")

	local var_18_5 = arg_18_0.gamingUI

	arg_18_0.gamingBuff = var_1.Find(var_18_5, "buff")

	local var_18_6 = arg_18_0.gamingUI

	arg_18_0.gamingOperationArea = var_1.Find(var_18_6, "operationArea")

	local var_18_7 = arg_18_0.gamingUI

	arg_18_0.gamingUp = var_1.Find(var_18_7, "operationArea/up")

	local var_18_8 = arg_18_0.gamingUI

	arg_18_0.gamingDown = var_1.Find(var_18_8, "operationArea/down")

	local var_18_9 = arg_18_0.gamingUI

	arg_18_0.gamingLeft = var_1.Find(var_18_9, "operationArea/left")

	local var_18_10 = arg_18_0.gamingUI

	arg_18_0.gamingRight = var_1.Find(var_18_10, "operationArea/right")

	local var_18_11 = arg_18_0.gamingUI

	arg_18_0.gamingMap = var_1.Find(var_18_11, "map")
	setActive = var_1

	var_1(arg_18_0.gamingUI, false)

	setActive = var_1

	var_1(arg_18_0.gamingOperationArea, false)

	onButton = var_1

	local var_18_12 = arg_18_0
	local var_18_13 = arg_18_0.gamingBack

	local function var_18_14()
		if not var_0_2.startSettlement then
			local var_19_0 = arg_18_0

			var_0.pauseGame(var_19_0)

			setActive = var_0

			var_0(arg_18_0.leaveUI, true)

			setActive = var_0

			var_0(arg_18_0.gamingBack, false)

			setActive = var_0

			var_0(arg_18_0.gamingPause, false)

			setActive = var_0

			var_0(arg_18_0.gamingOperationArea, false)

			setActive = var_0

			var_0(arg_18_0.gamingBuff, false)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_18_12, var_18_13, var_18_14, var_1_10005)

	onButton = var_1

	local var_18_15 = arg_18_0
	local var_18_16 = arg_18_0.gamingPause

	local function var_18_17()
		if not var_0_2.startSettlement then
			local var_20_0 = arg_18_0

			var_0.pauseGame(var_20_0)

			setActive = var_0

			var_0(arg_18_0.pauseUI, true)

			setActive = var_0

			var_0(arg_18_0.gamingBack, false)

			setActive = var_0

			var_0(arg_18_0.gamingPause, false)

			setActive = var_0

			var_0(arg_18_0.gamingOperationArea, false)

			setActive = var_0

			var_0(arg_18_0.gamingBuff, false)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_18_15, var_18_16, var_18_17, var_1_10005)

	onButton = var_1

	local var_18_18 = arg_18_0
	local var_18_19 = arg_18_0.gamingUp

	local function var_18_20()
		if var_0_2.canMove then
			var_0_2.canMove = false

			local function var_21_0(arg_22_0)
				local var_22_0 = arg_22_0:Find("player")
				local var_22_1 = var_1.GetComponent

				typeof = var_3
				Animator = var_3_10004

				local var_22_2 = var_22_1(var_22_0, var_3(var_3_10004))
				local var_22_3 = arg_22_0:Find("player")
				local var_22_4 = var_2.GetComponent

				typeof = var_4
				DftAniEvent = var_3_10005

				local var_22_5 = var_22_4(var_22_3, var_4(var_3_10005))
				local var_22_6 = arg_22_0:Find("player")
				local var_22_7 = var_3.GetComponent

				typeof = var_5
				RectTransform = var_3_10006

				local var_22_8 = var_22_7(var_22_6, var_5(var_3_10006))

				Vector2 = var_22_6
				var_22_8.anchoredPosition = var_22_6(0, 0)

				local var_22_9

				if var_0_2.currentPlayerPosition[1] - 1 == 0 then
					var_22_9 = 5
				end

				ToLoveGameConst = var_4

				local var_22_10 = var_4.map[var_22_9][var_0_2.currentPlayerPosition[2]]

				local function var_22_11(arg_23_0)
					local var_23_0 = arg_23_0:Find("player")
					local var_23_1 = var_1.GetComponent

					typeof = var_3
					RectTransform = var_4_10004

					local var_23_2 = var_23_1(var_23_0, var_3(var_4_10004))

					Vector2 = var_23_0
					var_23_2.anchoredPosition = var_23_0(0, -86)

					return
				end

				local var_22_12 = arg_18_0

				var_6.OperateMap(var_22_12, var_22_10, var_22_11)
				var_22_5:SetEndEvent(function()
					local var_24_0 = var_22_5

					var_0.SetEndEvent(var_24_0, nil)

					local function var_24_1(arg_25_0)
						setActive = var_5_10001

						var_5_10001(arg_25_0:Find("player"), false)

						return
					end

					local var_24_2 = arg_18_0

					var_1.OperateMapPlayer(var_24_2, var_24_1)

					var_0_2.currentPlayerPosition[1] = var_22_9

					local function var_24_3(arg_26_0)
						setActive = var_5_10001

						var_5_10001(arg_26_0:Find("player"), true)

						setActive = var_5_10001

						var_5_10001(arg_26_0:Find("player/arrow"), false)

						setActive = var_5_10001

						var_5_10001(arg_26_0:Find("player/happy"), false)

						setActive = var_5_10001

						var_5_10001(arg_26_0:Find("player/sad"), false)

						if var_0_2.shieldCount > 0 then
							setActive = var_1

							var_1(arg_26_0:Find("player/shield"), true)
						else
							setActive = var_1

							var_1(arg_26_0:Find("player/shield"), false)
						end

						local var_26_0 = arg_26_0:Find("player")
						local var_26_1 = var_1.GetComponent

						typeof = var_3
						Animator = var_4

						local var_26_2 = var_26_1(var_26_0, var_3(var_4))

						var_1.Play(var_26_2, "playerDownBack")

						return
					end

					local var_24_4 = arg_18_0

					var_2.OperateMapPlayer(var_24_4, var_24_3)

					return
				end)
				var_22_2:Play("playerUp")

				return
			end

			local var_21_1 = arg_18_0

			var_1.OperateMapPlayer(var_21_1, var_21_0)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_18_18, var_18_19, var_18_20, var_1_10005)

	onButton = var_1

	local var_18_21 = arg_18_0
	local var_18_22 = arg_18_0.gamingDown

	local function var_18_23()
		if var_0_2.canMove then
			var_0_2.canMove = false

			local function var_27_0(arg_28_0)
				local var_28_0 = arg_28_0:Find("player")
				local var_28_1 = var_1.GetComponent

				typeof = var_3
				Animator = var_3_10004

				local var_28_2 = var_28_1(var_28_0, var_3(var_3_10004))
				local var_28_3 = arg_28_0:Find("player")
				local var_28_4 = var_2.GetComponent

				typeof = var_4
				DftAniEvent = var_3_10005

				local var_28_5 = var_28_4(var_28_3, var_4(var_3_10005))
				local var_28_6 = arg_28_0:Find("player")
				local var_28_7 = var_3.GetComponent

				typeof = var_5
				RectTransform = var_3_10006

				local var_28_8 = var_28_7(var_28_6, var_5(var_3_10006))

				Vector2 = var_28_6
				var_28_8.anchoredPosition = var_28_6(0, 0)

				local var_28_9

				if var_0_2.currentPlayerPosition[1] + 1 == 6 then
					var_28_9 = 1
				end

				ToLoveGameConst = var_4

				local var_28_10 = var_4.map[var_28_9][var_0_2.currentPlayerPosition[2]]

				local function var_28_11(arg_29_0)
					local var_29_0 = arg_29_0:Find("player")
					local var_29_1 = var_1.GetComponent

					typeof = var_3
					RectTransform = var_4_10004

					local var_29_2 = var_29_1(var_29_0, var_3(var_4_10004))

					Vector2 = var_29_0
					var_29_2.anchoredPosition = var_29_0(0, 86)

					return
				end

				local var_28_12 = arg_18_0

				var_6.OperateMap(var_28_12, var_28_10, var_28_11)
				var_28_5:SetEndEvent(function()
					local var_30_0 = var_28_5

					var_0.SetEndEvent(var_30_0, nil)

					local function var_30_1(arg_31_0)
						setActive = var_5_10001

						var_5_10001(arg_31_0:Find("player"), false)

						return
					end

					local var_30_2 = arg_18_0

					var_1.OperateMapPlayer(var_30_2, var_30_1)

					var_0_2.currentPlayerPosition[1] = var_28_9

					local function var_30_3(arg_32_0)
						setActive = var_5_10001

						var_5_10001(arg_32_0:Find("player"), true)

						setActive = var_5_10001

						var_5_10001(arg_32_0:Find("player/arrow"), false)

						setActive = var_5_10001

						var_5_10001(arg_32_0:Find("player/happy"), false)

						setActive = var_5_10001

						var_5_10001(arg_32_0:Find("player/sad"), false)

						if var_0_2.shieldCount > 0 then
							setActive = var_1

							var_1(arg_32_0:Find("player/shield"), true)
						else
							setActive = var_1

							var_1(arg_32_0:Find("player/shield"), false)
						end

						local var_32_0 = arg_32_0:Find("player")
						local var_32_1 = var_1.GetComponent

						typeof = var_3
						Animator = var_4

						local var_32_2 = var_32_1(var_32_0, var_3(var_4))

						var_1.Play(var_32_2, "playerUpBack")

						return
					end

					local var_30_4 = arg_18_0

					var_2.OperateMapPlayer(var_30_4, var_30_3)

					return
				end)
				var_28_2:Play("playerDown")

				return
			end

			local var_27_1 = arg_18_0

			var_1.OperateMapPlayer(var_27_1, var_27_0)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_18_21, var_18_22, var_18_23, var_1_10005)

	onButton = var_1

	local var_18_24 = arg_18_0
	local var_18_25 = arg_18_0.gamingLeft

	local function var_18_26()
		if var_0_2.canMove then
			var_0_2.canMove = false

			local function var_33_0(arg_34_0)
				local var_34_0 = arg_34_0:Find("player")
				local var_34_1 = var_1.GetComponent

				typeof = var_3
				Animator = var_3_10004

				local var_34_2 = var_34_1(var_34_0, var_3(var_3_10004))
				local var_34_3 = arg_34_0:Find("player")
				local var_34_4 = var_2.GetComponent

				typeof = var_4
				DftAniEvent = var_3_10005

				local var_34_5 = var_34_4(var_34_3, var_4(var_3_10005))
				local var_34_6 = arg_34_0:Find("player")
				local var_34_7 = var_3.GetComponent

				typeof = var_5
				RectTransform = var_3_10006

				local var_34_8 = var_34_7(var_34_6, var_5(var_3_10006))

				Vector2 = var_34_6
				var_34_8.anchoredPosition = var_34_6(0, 0)

				local var_34_9

				if var_0_2.currentPlayerPosition[2] - 1 == 0 then
					var_34_9 = 5
				end

				ToLoveGameConst = var_4

				local var_34_10 = var_4.map[var_0_2.currentPlayerPosition[1]][var_34_9]

				local function var_34_11(arg_35_0)
					local var_35_0 = arg_35_0:Find("player")
					local var_35_1 = var_1.GetComponent

					typeof = var_3
					RectTransform = var_4_10004

					local var_35_2 = var_35_1(var_35_0, var_3(var_4_10004))

					Vector2 = var_35_0
					var_35_2.anchoredPosition = var_35_0(82.5, 0)

					return
				end

				local var_34_12 = arg_18_0

				var_6.OperateMap(var_34_12, var_34_10, var_34_11)
				var_34_5:SetEndEvent(function()
					local var_36_0 = var_34_5

					var_0.SetEndEvent(var_36_0, nil)

					local function var_36_1(arg_37_0)
						setActive = var_5_10001

						var_5_10001(arg_37_0:Find("player"), false)

						return
					end

					local var_36_2 = arg_18_0

					var_1.OperateMapPlayer(var_36_2, var_36_1)

					var_0_2.currentPlayerPosition[2] = var_34_9

					local function var_36_3(arg_38_0)
						setActive = var_5_10001

						var_5_10001(arg_38_0:Find("player"), true)

						setActive = var_5_10001

						var_5_10001(arg_38_0:Find("player/arrow"), false)

						setActive = var_5_10001

						var_5_10001(arg_38_0:Find("player/happy"), false)

						setActive = var_5_10001

						var_5_10001(arg_38_0:Find("player/sad"), false)

						if var_0_2.shieldCount > 0 then
							setActive = var_1

							var_1(arg_38_0:Find("player/shield"), true)
						else
							setActive = var_1

							var_1(arg_38_0:Find("player/shield"), false)
						end

						local var_38_0 = arg_38_0:Find("player")
						local var_38_1 = var_1.GetComponent

						typeof = var_3
						Animator = var_4

						local var_38_2 = var_38_1(var_38_0, var_3(var_4))

						var_1.Play(var_38_2, "playerRightBack")

						return
					end

					local var_36_4 = arg_18_0

					var_2.OperateMapPlayer(var_36_4, var_36_3)

					return
				end)
				var_34_2:Play("playerLeft")

				return
			end

			local var_33_1 = arg_18_0

			var_1.OperateMapPlayer(var_33_1, var_33_0)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_18_24, var_18_25, var_18_26, var_1_10005)

	onButton = var_1

	local var_18_27 = arg_18_0
	local var_18_28 = arg_18_0.gamingRight

	local function var_18_29()
		if var_0_2.canMove then
			var_0_2.canMove = false

			local function var_39_0(arg_40_0)
				local var_40_0 = arg_40_0:Find("player")
				local var_40_1 = var_1.GetComponent

				typeof = var_3
				Animator = var_3_10004

				local var_40_2 = var_40_1(var_40_0, var_3(var_3_10004))
				local var_40_3 = arg_40_0:Find("player")
				local var_40_4 = var_2.GetComponent

				typeof = var_4
				DftAniEvent = var_3_10005

				local var_40_5 = var_40_4(var_40_3, var_4(var_3_10005))
				local var_40_6 = arg_40_0:Find("player")
				local var_40_7 = var_3.GetComponent

				typeof = var_5
				RectTransform = var_3_10006

				local var_40_8 = var_40_7(var_40_6, var_5(var_3_10006))

				Vector2 = var_40_6
				var_40_8.anchoredPosition = var_40_6(0, 0)

				local var_40_9

				if var_0_2.currentPlayerPosition[2] + 1 == 6 then
					var_40_9 = 1
				end

				ToLoveGameConst = var_4

				local var_40_10 = var_4.map[var_0_2.currentPlayerPosition[1]][var_40_9]

				local function var_40_11(arg_41_0)
					local var_41_0 = arg_41_0:Find("player")
					local var_41_1 = var_1.GetComponent

					typeof = var_3
					RectTransform = var_4_10004

					local var_41_2 = var_41_1(var_41_0, var_3(var_4_10004))

					Vector2 = var_41_0
					var_41_2.anchoredPosition = var_41_0(-82.5, 0)

					return
				end

				local var_40_12 = arg_18_0

				var_6.OperateMap(var_40_12, var_40_10, var_40_11)
				var_40_5:SetEndEvent(function()
					local var_42_0 = var_40_5

					var_0.SetEndEvent(var_42_0, nil)

					local function var_42_1(arg_43_0)
						setActive = var_5_10001

						var_5_10001(arg_43_0:Find("player"), false)

						return
					end

					local var_42_2 = arg_18_0

					var_1.OperateMapPlayer(var_42_2, var_42_1)

					var_0_2.currentPlayerPosition[2] = var_40_9

					local function var_42_3(arg_44_0)
						setActive = var_5_10001

						var_5_10001(arg_44_0:Find("player"), true)

						setActive = var_5_10001

						var_5_10001(arg_44_0:Find("player/arrow"), false)

						setActive = var_5_10001

						var_5_10001(arg_44_0:Find("player/happy"), false)

						setActive = var_5_10001

						var_5_10001(arg_44_0:Find("player/sad"), false)

						if var_0_2.shieldCount > 0 then
							setActive = var_1

							var_1(arg_44_0:Find("player/shield"), true)
						else
							setActive = var_1

							var_1(arg_44_0:Find("player/shield"), false)
						end

						local var_44_0 = arg_44_0:Find("player")
						local var_44_1 = var_1.GetComponent

						typeof = var_3
						Animator = var_4

						local var_44_2 = var_44_1(var_44_0, var_3(var_4))

						var_1.Play(var_44_2, "playerLeftBack")

						return
					end

					local var_42_4 = arg_18_0

					var_2.OperateMapPlayer(var_42_4, var_42_3)

					return
				end)
				var_40_2:Play("playerRight")

				return
			end

			local var_39_1 = arg_18_0

			var_1.OperateMapPlayer(var_39_1, var_39_0)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_18_27, var_18_28, var_18_29, var_1_10005)

	return
end

function var_0_1.initPopUI(arg_45_0)
	local var_45_0 = arg_45_0._tf

	arg_45_0.popUI = var_1.Find(var_45_0, "ui/popUI")

	arg_45_0:initCountUI()
	arg_45_0:initSettlementUI()
	arg_45_0:initLeavelUI()
	arg_45_0:initPauseUI()
	arg_45_0:initRankUI()
	arg_45_0:initBuffUI()
	arg_45_0:initTaskUI()

	return
end

function var_0_1.initCountUI(arg_46_0)
	local var_46_0 = arg_46_0.popUI

	arg_46_0.countUI = var_1.Find(var_46_0, "countUI")

	local var_46_1 = arg_46_0.countUI

	arg_46_0.count = var_1.Find(var_46_1, "count")

	local var_46_2 = arg_46_0.count
	local var_46_3 = var_1.GetComponent

	typeof = var_3
	Animator = var_1_10004
	arg_46_0.countAnimator = var_46_3(var_46_2, var_3(var_1_10004))

	local var_46_4 = arg_46_0.count
	local var_46_5 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_46_0.countDft = var_46_5(var_46_4, var_3(var_1_10004))
	setActive = var_1

	var_1(arg_46_0.countUI, false)

	local var_46_6 = arg_46_0.countDft

	var_1.SetEndEvent(var_46_6, function()
		local var_47_0 = arg_46_0

		var_0.gameStart(var_47_0)

		return
	end)

	return
end

function var_0_1.initSettlementUI(arg_48_0)
	local var_48_0 = arg_48_0.popUI

	arg_48_0.settlementUI = var_1.Find(var_48_0, "settleMentUI")

	local var_48_1 = arg_48_0.settlementUI

	arg_48_0.settlementCurrentText = var_1.Find(var_48_1, "ad/currentText")

	local var_48_2 = arg_48_0.settlementUI

	arg_48_0.settlementHighText = var_1.Find(var_48_2, "ad/highText")

	local var_48_3 = arg_48_0.settlementUI

	arg_48_0.settlementOverBtn = var_1.Find(var_48_3, "ad/btnOver")

	local var_48_4 = arg_48_0.settlementUI

	arg_48_0.settlementNew = var_1.Find(var_48_4, "ad/new")

	local var_48_5 = arg_48_0.settlementUI

	arg_48_0.settlementClose = var_1.Find(var_48_5, "ad/btnClose")

	local var_48_6 = arg_48_0.settlementUI
	local var_48_7 = var_1.Find(var_48_6, "ad/CurImg")
	local var_48_8 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004

	local var_48_9 = var_48_8(var_48_7, var_3(var_1_10004))

	var_1.SetNativeSize(var_48_9)

	local var_48_10 = arg_48_0.settlementUI
	local var_48_11 = var_1.Find(var_48_10, "ad/HighImg")
	local var_48_12 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004

	local var_48_13 = var_48_12(var_48_11, var_3(var_1_10004))

	var_1.SetNativeSize(var_48_13)

	setActive = var_1

	var_1(arg_48_0.settlementUI, false)

	onButton = var_1

	local var_48_14 = arg_48_0
	local var_48_15 = arg_48_0.settlementOverBtn

	local function var_48_16()
		local var_49_0

		if not arg_48_0.sendSuccessFlag then
			var_49_0 = arg_48_0
			var_49_0.sendSuccessFlag = true

			local var_49_1 = arg_48_0

			var_49_0.SendSuccess(var_49_1, 0)
		end

		setActive = var_49_0

		var_49_0(arg_48_0.settlementUI, false)

		setActive = var_49_0

		var_49_0(arg_48_0.menuUI, true)

		setActive = var_49_0

		var_49_0(arg_48_0.gamingUI, false)

		setText = var_49_0

		var_49_0(arg_48_0.menuHighestScoreText, var_0_2.highestScore)

		local var_49_2 = arg_48_0

		var_0.GetTaskData(var_49_2)

		setActive = var_0

		var_0(arg_48_0.menuTaskTip, arg_48_0.canGetAward)

		local var_49_3 = arg_48_0
		local var_49_4 = var_0.changeBgm

		ToLoveGameConst = var_2

		var_49_4(var_49_3, var_2.bgm_type_menu)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_48_14, var_48_15, var_48_16, var_1_10005)

	onButton = var_1

	local var_48_17 = arg_48_0
	local var_48_18 = arg_48_0.settlementClose

	local function var_48_19()
		triggerButton = var_2_10000

		var_2_10000(arg_48_0.settlementOverBtn)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_48_17, var_48_18, var_48_19, var_1_10005)

	return
end

function var_0_1.initLeavelUI(arg_51_0)
	local var_51_0 = arg_51_0.popUI

	arg_51_0.leaveUI = var_1.Find(var_51_0, "leaveUI")

	local var_51_1 = arg_51_0.leaveUI

	arg_51_0.leaveOkBtn = var_1.Find(var_51_1, "ad/btnOk")

	local var_51_2 = arg_51_0.leaveUI

	arg_51_0.leaveCancelBtn = var_1.Find(var_51_2, "ad/btnCancel")

	local var_51_3 = arg_51_0.leaveUI

	arg_51_0.leaveClose = var_1.Find(var_51_3, "ad/btnClose")

	local var_51_4 = arg_51_0.leaveUI
	local var_51_5 = var_1.Find(var_51_4, "ad/desc")
	local var_51_6 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004

	local var_51_7 = var_51_6(var_51_5, var_3(var_1_10004))

	var_1.SetNativeSize(var_51_7)

	local var_51_8 = arg_51_0.leaveUI
	local var_51_9 = var_1.Find(var_51_8, "ad/desc2")
	local var_51_10 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004

	local var_51_11 = var_51_10(var_51_9, var_3(var_1_10004))

	var_1.SetNativeSize(var_51_11)

	setActive = var_1

	var_1(arg_51_0.leaveUI, false)

	onButton = var_1

	local var_51_12 = arg_51_0
	local var_51_13 = arg_51_0.leaveOkBtn

	local function var_51_14()
		setActive = var_2_10000

		var_2_10000(arg_51_0.leaveUI, false)

		local var_52_0 = arg_51_0

		var_0.resumeGame(var_52_0)

		local var_52_1 = arg_51_0

		var_0.onGameOver(var_52_1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_51_12, var_51_13, var_51_14, var_1_10005)

	onButton = var_1

	local var_51_15 = arg_51_0
	local var_51_16 = arg_51_0.leaveCancelBtn

	local function var_51_17()
		setActive = var_2_10000

		var_2_10000(arg_51_0.leaveUI, false)

		setActive = var_2_10000

		var_2_10000(arg_51_0.gamingBack, true)

		setActive = var_2_10000

		var_2_10000(arg_51_0.gamingPause, true)

		if var_0_2.playerMoveFlag then
			setActive = var_0

			var_0(arg_51_0.gamingOperationArea, true)
		end

		setActive = var_0

		var_0(arg_51_0.gamingBuff, true)

		local var_53_0 = arg_51_0

		var_0.resumeGame(var_53_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_51_15, var_51_16, var_51_17, var_1_10005)

	onButton = var_1

	local var_51_18 = arg_51_0
	local var_51_19 = arg_51_0.leaveClose

	local function var_51_20()
		triggerButton = var_2_10000

		var_2_10000(arg_51_0.leaveCancelBtn)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_51_18, var_51_19, var_51_20, var_1_10005)

	return
end

function var_0_1.initPauseUI(arg_55_0)
	local var_55_0 = arg_55_0.popUI

	arg_55_0.pauseUI = var_1.Find(var_55_0, "pauseUI")

	local var_55_1 = arg_55_0.pauseUI

	arg_55_0.pauseOkBtn = var_1.Find(var_55_1, "ad/btnOk")

	local var_55_2 = arg_55_0.pauseUI

	arg_55_0.pauseClose = var_1.Find(var_55_2, "ad/btnClose")

	local var_55_3 = arg_55_0.pauseUI
	local var_55_4 = var_1.Find(var_55_3, "ad/desc")
	local var_55_5 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004

	local var_55_6 = var_55_5(var_55_4, var_3(var_1_10004))

	var_1.SetNativeSize(var_55_6)

	setActive = var_1

	var_1(arg_55_0.pauseUI, false)

	onButton = var_1

	local var_55_7 = arg_55_0
	local var_55_8 = arg_55_0.pauseOkBtn

	local function var_55_9()
		setActive = var_2_10000

		var_2_10000(arg_55_0.pauseUI, false)

		setActive = var_2_10000

		var_2_10000(arg_55_0.gamingBack, true)

		setActive = var_2_10000

		var_2_10000(arg_55_0.gamingPause, true)

		if var_0_2.playerMoveFlag then
			setActive = var_0

			var_0(arg_55_0.gamingOperationArea, true)
		end

		setActive = var_0

		var_0(arg_55_0.gamingBuff, true)

		local var_56_0 = arg_55_0

		var_0.resumeGame(var_56_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_55_7, var_55_8, var_55_9, var_1_10005)

	onButton = var_1

	local var_55_10 = arg_55_0
	local var_55_11 = arg_55_0.pauseClose

	local function var_55_12()
		triggerButton = var_2_10000

		var_2_10000(arg_55_0.pauseOkBtn)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_55_10, var_55_11, var_55_12, var_1_10005)

	return
end

function var_0_1.initRankUI(arg_58_0)
	local var_58_0 = arg_58_0.popUI

	arg_58_0.rankUI = var_1.Find(var_58_0, "rankUI")

	local var_58_1 = arg_58_0.rankUI

	arg_58_0.rankCloseBtn = var_1.Find(var_58_1, "ad/btnClose")
	UIItemList = var_1

	local var_58_2 = var_1.New
	local var_58_3 = arg_58_0.rankUI
	local var_58_4 = var_2.Find(var_58_3, "ad/Scroll View/Viewport/Content")
	local var_58_5 = arg_58_0.rankUI

	arg_58_0.rankPlayerList = var_58_2(var_58_4, var_3.Find(var_58_5, "ad/Scroll View/Viewport/Content/playerTpl"))

	local var_58_6 = arg_58_0.rankUI

	arg_58_0.rankMyself = var_1.Find(var_58_6, "ad/myself")

	local var_58_7 = arg_58_0.rankUI

	arg_58_0.rankDesc = var_1.Find(var_58_7, "ad/desc")
	setText = var_1

	local var_58_8 = arg_58_0.rankUI
	local var_58_9 = var_2.Find(var_58_8, "ad/score")

	i18n = var_58_8

	var_1(var_58_9, var_58_8("tolovegame_score"))

	setText = var_1

	local var_58_10 = arg_58_0.rankUI
	local var_58_11 = var_2.Find(var_58_10, "ad/desc")

	i18n = var_58_10

	var_1(var_58_11, var_58_10("tolovegame_rank_tip"))

	local var_58_12 = arg_58_0.rankUI
	local var_58_13 = var_1.Find(var_58_12, "ad/bg/titleBg/title")
	local var_58_14 = var_1.GetComponent

	typeof = var_3
	Image = var_4

	local var_58_15 = var_58_14(var_58_13, var_3(var_4))

	var_1.SetNativeSize(var_58_15)

	setActive = var_1

	var_1(arg_58_0.rankUI, false)

	onButton = var_1

	local var_58_16 = arg_58_0
	local var_58_17 = arg_58_0.rankCloseBtn

	local function var_58_18()
		setActive = var_2_10000

		var_2_10000(arg_58_0.rankUI, false)

		setActive = var_2_10000

		var_2_10000(arg_58_0.menuUI, true)

		return
	end

	SFX_PANEL = var_5

	var_1(var_58_16, var_58_17, var_58_18, var_5)

	return
end

function var_0_1.initBuffUI(arg_60_0)
	local var_60_0 = arg_60_0.popUI

	arg_60_0.buffUI = var_1.Find(var_60_0, "buffUI")

	local var_60_1 = arg_60_0.buffUI

	arg_60_0.buffCloseBtn = var_1.Find(var_60_1, "ad/btnClose")
	UIItemList = var_1

	local var_60_2 = var_1.New
	local var_60_3 = arg_60_0.buffUI
	local var_60_4 = var_2.Find(var_60_3, "ad/Scroll View/Viewport/Content")
	local var_60_5 = arg_60_0.buffUI

	arg_60_0.buffList = var_60_2(var_60_4, var_3.Find(var_60_5, "ad/Scroll View/Viewport/Content/buff"))

	local var_60_6 = arg_60_0.buffUI
	local var_60_7 = var_1.Find(var_60_6, "ad/bg/titleBg/title")
	local var_60_8 = var_1.GetComponent

	typeof = var_3
	Image = var_60_5

	local var_60_9 = var_60_8(var_60_7, var_3(var_60_5))

	var_1.SetNativeSize(var_60_9)

	setActive = var_1

	var_1(arg_60_0.buffUI, false)

	onButton = var_1

	local var_60_10 = arg_60_0
	local var_60_11 = arg_60_0.buffCloseBtn

	local function var_60_12()
		setActive = var_2_10000

		var_2_10000(arg_60_0.buffUI, false)

		setActive = var_2_10000

		var_2_10000(arg_60_0.menuUI, true)

		return
	end

	SFX_PANEL = var_5

	var_1(var_60_10, var_60_11, var_60_12, var_5)

	return
end

function var_0_1.initTaskUI(arg_62_0)
	local var_62_0 = arg_62_0.popUI

	arg_62_0.taskUI = var_1.Find(var_62_0, "taskUI")

	local var_62_1 = arg_62_0.taskUI

	arg_62_0.taskCloseBtn = var_1.Find(var_62_1, "ad/btnClose")
	UIItemList = var_1

	local var_62_2 = var_1.New
	local var_62_3 = arg_62_0.taskUI
	local var_62_4 = var_2.Find(var_62_3, "ad/Scroll View/Viewport/Content")
	local var_62_5 = arg_62_0.taskUI

	arg_62_0.taskTasklist = var_62_2(var_62_4, var_3.Find(var_62_5, "ad/Scroll View/Viewport/Content/Tasktpl"))

	local var_62_6 = arg_62_0.taskUI
	local var_62_7 = var_1.Find(var_62_6, "ad/bg/titleBg/title")
	local var_62_8 = var_1.GetComponent

	typeof = var_3
	Image = var_62_5

	local var_62_9 = var_62_8(var_62_7, var_3(var_62_5))

	var_1.SetNativeSize(var_62_9)

	setActive = var_1

	var_1(arg_62_0.taskUI, false)

	onButton = var_1

	local var_62_10 = arg_62_0
	local var_62_11 = arg_62_0.taskCloseBtn

	local function var_62_12()
		setActive = var_2_10000

		var_2_10000(arg_62_0.taskUI, false)

		setActive = var_2_10000

		var_2_10000(arg_62_0.menuUI, true)

		local var_63_0 = arg_62_0

		var_0.GetTaskData(var_63_0)

		setActive = var_0

		var_0(arg_62_0.menuTaskTip, arg_62_0.canGetAward)

		return
	end

	SFX_PANEL = var_5

	var_1(var_62_10, var_62_11, var_62_12, var_5)

	return
end

function var_0_1.onTimer(arg_64_0)
	arg_64_0:stepRunTimeData()
	arg_64_0:TimeStep(var_0_2.deltaTime)
	arg_64_0:ShowArrowAndPlayerMove()

	if var_0_2.gameTime <= 0 then
		if var_0_2.buffIndex == 6 then
			math = var_1

			if var_1.random() >= 0.5 then
				local var_64_0 = var_0_2
				local var_64_1 = var_0_2.gameTime

				ToLoveGameConst = var_1_10004
				var_64_0.gameTime = var_64_1 + var_1_10004.addTime
			else
				arg_64_0:onGameOver()
			end
		else
			arg_64_0:onGameOver()
		end
	end

	return
end

function var_0_1.stepRunTimeData(arg_65_0)
	Time = var_1_10001

	local var_65_0 = var_1_10001.deltaTime

	if not var_0_2.startSettlement then
		var_0_2.gameTime = var_0_2.gameTime - var_65_0

		if var_0_2.gameTime < 0 then
			var_0_2.gameTime = 0
		end

		var_0_2.gameStepTime = var_0_2.gameStepTime + var_65_0

		local var_65_3

		if var_0_2.showArrowFlag or var_0_2.playerMoveFlag then
			local var_65_1 = var_0_2.gameStepTime

			ToLoveGameConst = var_65_3

			if var_65_3.motionTime <= var_65_1 then
				local var_65_2 = var_0_2

				var_65_3 = var_0_2.gameStepTime
				ToLoveGameConst = var_1_10004
				var_65_2.gameStepTime = var_65_3 - var_1_10004.motionTime

				var_0_2.ChangeMotion()
			end
		end

		if var_0_2.waitingFlag then
			local var_65_4 = var_0_2.gameStepTime

			ToLoveGameConst = var_65_3

			if var_65_4 >= var_65_3.waitingTime then
				local var_65_5 = var_0_2
				local var_65_6 = var_0_2.gameStepTime

				ToLoveGameConst = var_1_10004
				var_65_5.gameStepTime = var_65_6 - var_1_10004.waitingTime

				var_0_2.ChangeMotion()
			end
		end

		var_0_2.gameArrowTime = var_0_2.gameArrowTime + var_65_0
		var_0_2.gameMoveTime = var_0_2.gameMoveTime + var_65_0
		var_0_2.gameBombTime = var_0_2.gameBombTime + var_65_0

		if var_0_2.bombBlast then
			var_0_2.gameBombBlastTime = var_0_2.gameBombBlastTime + var_65_0
		end
	end

	var_0_2.deltaTime = var_65_0

	return
end

function var_0_1.TimeStep(arg_66_0, arg_66_1)
	math = var_1_10002

	local var_66_0 = var_1_10002.floor(var_0_2.gameTime)

	math = var_3

	local var_66_1 = var_3.floor(var_66_0 / 60)
	local var_66_2 = var_66_0 % 60

	setText = var_1_10005

	local var_66_3 = arg_66_0.gamingTimeText

	string = var_1_10007

	local var_66_4 = var_1_10007.format("%02d", var_66_1)
	local var_66_5 = "  :  "

	string = var_9

	var_1_10005(var_66_3, var_66_4 .. var_66_5 .. var_9.format("%02d", var_66_2))

	return
end

function var_0_1.ShowArrowAndPlayerMove(arg_67_0)
	if var_0_2.showArrowFlag then
		if not var_0_2.hasDone then
			local var_67_0 = var_0_2

			var_67_0.hasDone = true
			setActive = var_67_0

			var_67_0(arg_67_0.gamingOperationArea, false)
		end

		if var_0_2.gameArrowTime >= var_0_2.doTime then
			var_0_2.gameArrowTime = var_0_2.gameArrowTime - var_0_2.doTime

			local function var_67_1(arg_68_0)
				setActive = var_2_10001

				var_2_10001(arg_68_0:Find("player/arrow"), true)

				local var_68_0 = arg_67_0

				var_1.ShowArraw(var_68_0, arg_68_0:Find("player/arrow"), var_0_2.arrowList[var_0_2.nowArrowIndex])

				var_0_2.nowArrowIndex = var_0_2.nowArrowIndex + 1

				return
			end

			arg_67_0:OperateMapPlayer(var_67_1)
		end
	elseif var_0_2.playerMoveFlag then
		if not var_0_2.hasDone then
			local var_67_2 = var_0_2

			var_67_2.hasDone = true
			setActive = var_67_2

			var_67_2(arg_67_0.gamingOperationArea, true)

			local function var_67_3(arg_69_0)
				setActive = var_2_10001

				var_2_10001(arg_69_0:Find("player/arrow"), false)

				return
			end

			arg_67_0:OperateMapPlayer(var_67_3)
		end

		if var_0_2.gameMoveTime >= var_0_2.doTime and var_0_2.moveCount > 0 then
			var_0_2.moveCount = var_0_2.moveCount - 1
			var_0_2.gameMoveTime = var_0_2.gameMoveTime - var_0_2.doTime
			var_0_2.canMove = true
		end
	end

	arg_67_0:BombBlast()

	return
end

function var_0_1.ShowArraw(arg_70_0, arg_70_1, arg_70_2)
	local var_70_0 = arg_70_1
	local var_70_1 = arg_70_1.GetComponent

	typeof = var_1_10005
	Animation = var_1_10006

	local var_70_2 = var_70_1(var_70_0, var_1_10005(var_1_10006))

	var_3.Play(var_70_2, "arrowUp")

	ToLoveGameConst = var_3

	if arg_70_2 == var_3.arrowUp then
		setActive = var_3

		var_3(arg_70_1:Find("up"), true)

		setActive = var_3

		var_3(arg_70_1:Find("down"), false)

		setActive = var_3

		var_3(arg_70_1:Find("left"), false)

		setActive = var_3

		var_3(arg_70_1:Find("right"), false)
	else
		ToLoveGameConst = var_3

		if arg_70_2 == var_3.arrowDown then
			setActive = var_3

			var_3(arg_70_1:Find("up"), false)

			setActive = var_3

			var_3(arg_70_1:Find("down"), true)

			setActive = var_3

			var_3(arg_70_1:Find("left"), false)

			setActive = var_3

			var_3(arg_70_1:Find("right"), false)
		else
			ToLoveGameConst = var_3

			if arg_70_2 == var_3.arrowLeft then
				setActive = var_3

				var_3(arg_70_1:Find("up"), false)

				setActive = var_3

				var_3(arg_70_1:Find("down"), false)

				setActive = var_3

				var_3(arg_70_1:Find("left"), true)

				setActive = var_3

				var_3(arg_70_1:Find("right"), false)
			else
				ToLoveGameConst = var_3

				if arg_70_2 == var_3.arrowRight then
					setActive = var_3

					var_3(arg_70_1:Find("up"), false)

					setActive = var_3

					var_3(arg_70_1:Find("down"), false)

					setActive = var_3

					var_3(arg_70_1:Find("left"), false)

					setActive = var_3

					var_3(arg_70_1:Find("right"), true)
				end
			end
		end
	end

	if var_0_2.arrowVideoCount > 0 then
		local var_70_3 = var_0_2

		var_70_3.arrowVideoCount = var_0_2.arrowVideoCount - 1
		pg = var_70_3

		local var_70_4 = var_70_3.CriMgr.GetInstance()

		var_3.PlaySoundEffect_V3(var_70_4, "ui-di")
	end

	return
end

function var_0_1.BombBlast(arg_71_0)
	local var_71_4

	if var_0_2.nowBombIndex <= #var_0_2.safeList then
		local var_71_0 = var_0_2.gameBombTime

		if var_0_2.doTime <= var_71_0 then
			var_0_2.gameBombTime = var_0_2.gameBombTime - var_0_2.doTime
			var_0_2.safeCellPosition = var_0_2.GetSafeCellPosition(var_0_2.safeList[var_0_2.nowBombIndex])

			local var_71_1 = var_0_2

			Clone = var_71_4
			var_71_1.previousPlayerPosition = var_71_4(var_0_2.currentPlayerPosition)
			var_0_2.nowBombIndex = var_0_2.nowBombIndex + 1
			arg_71_0.isOk = true

			local function var_71_2(arg_72_0)
				setActive = var_2_10001

				var_2_10001(arg_72_0:Find("bomb"), true)

				isActive = var_2_10001

				if var_2_10001(arg_72_0:Find("player")) then
					arg_71_0.isOk = false
				end

				return
			end

			arg_71_0:OperateMapOthers(var_71_2, var_0_2.safeCellPosition)

			pg = var_71_4

			local var_71_3 = var_71_4.CriMgr.GetInstance()

			var_71_4.PlaySoundEffect_V3(var_71_3, "ui-ryza-minigame-bomb")

			if arg_71_0.isOk then
				arg_71_0:AddScore()

				setText = var_71_4

				var_71_4(arg_71_0.gamingScoreText, var_0_2.score)

				if var_0_2.buffIndex == 4 then
					var_71_4 = var_0_2
					var_71_4.shieldGetCombo = var_0_2.shieldGetCombo + 1

					if var_0_2.shieldGetCombo == 5 then
						var_71_4 = var_0_2
						var_71_4.shieldGetCombo = 0

						if var_0_2.shieldCount < 2 then
							var_71_4 = var_0_2
							var_71_4.shieldCount = var_0_2.shieldCount + 1

							function var_71_4(arg_73_0)
								setActive = var_2_10001

								var_2_10001(arg_73_0:Find("player/shield"), true)

								return
							end

							arg_71_0:OperateMapPlayer(var_71_4)
						end
					end
				end

				function var_71_4(arg_74_0)
					setActive = var_2_10001

					var_2_10001(arg_74_0:Find("player/happy"), true)

					return
				end

				arg_71_0:OperateMapPlayer(var_71_4)
			else
				if var_0_2.shieldCount > 0 then
					var_71_4 = var_0_2
					var_71_4.combo = 0
					var_71_4 = var_0_2
					var_71_4.shieldCount = var_0_2.shieldCount - 1

					function var_71_4(arg_75_0)
						if var_0_2.shieldCount > 0 then
							setActive = var_1

							var_1(arg_75_0:Find("player/shield"), true)
						else
							setActive = var_1

							var_1(arg_75_0:Find("player/shield"), false)
						end

						return
					end

					arg_71_0:OperateMapPlayer(var_71_4)
				else
					arg_71_0:onGameOver()
				end

				function var_71_4(arg_76_0)
					setActive = var_2_10001

					var_2_10001(arg_76_0:Find("player/sad"), true)

					return
				end

				arg_71_0:OperateMapPlayer(var_71_4)
			end

			var_71_4 = var_0_2
			var_71_4.bombBlast = true
		end
	end

	if var_0_2.bombBlast then
		local var_71_5 = var_0_2.gameBombBlastTime

		ToLoveGameConst = var_71_4

		if var_71_5 >= var_71_4.bombBlastTime then
			var_0_2.bombBlast = false
			var_0_2.gameBombBlastTime = 0

			local function var_71_6(arg_77_0)
				setActive = var_2_10001

				var_2_10001(arg_77_0:Find("bomb"), false)

				return
			end

			arg_71_0:OperateMapOthers(var_71_6, var_0_2.safeCellPosition)
		end
	end

	return
end

function var_0_1.readyStart(arg_78_0)
	arg_78_0.readyStartFlag = true

	var_0_2.Prepare()

	setActive = var_1

	var_1(arg_78_0.countUI, true)

	setActive = var_1

	var_1(arg_78_0.menuUI, false)

	setActive = var_1

	var_1(arg_78_0.gamingUI, false)

	local var_78_0 = arg_78_0.countAnimator

	var_1.Play(var_78_0, "count")

	pg = var_1

	local var_78_1 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_78_1, var_0_2.SFX_COUNT_DOWN)

	local function var_78_2(arg_79_0)
		setActive = var_2_10001

		var_2_10001(arg_79_0:Find("bomb"), false)

		return
	end

	arg_78_0:OperateMapAll(var_78_2)

	return
end

function var_0_1.gameStart(arg_80_0)
	arg_80_0.readyStartFlag = false
	arg_80_0.gameStartFlag = true
	arg_80_0.sendSuccessFlag = false
	setActive = var_1

	var_1(arg_80_0.countUI, false)

	setActive = var_1

	var_1(arg_80_0.gamingUI, true)
	arg_80_0:ResetMapAndPlayer()
	arg_80_0:timerStart()

	local var_80_0 = arg_80_0
	local var_80_1 = arg_80_0.changeBgm

	ToLoveGameConst = var_3

	var_80_1(var_80_0, var_3.bgm_type_game)

	setText = var_80_1

	var_80_1(arg_80_0.gamingScoreText, var_0_2.score)
	arg_80_0:SetGamingBuff()

	setActive = var_1

	var_1(arg_80_0.gamingBack, true)

	setActive = var_1

	var_1(arg_80_0.gamingPause, true)

	setActive = var_1

	var_1(arg_80_0.gamingBuff, true)

	return
end

function var_0_1.ResetMapAndPlayer(arg_81_0)
	ToLoveGameConst = var_1_10001

	local var_81_0 = var_1_10001.map[var_0_2.currentPlayerPosition[1]][var_0_2.currentPlayerPosition[2]]

	for iter_81_0 = 0, arg_81_0.gamingMap.childCount - 1 do
		local var_81_1 = arg_81_0.gamingMap
		local var_81_2 = var_6.GetChild(var_81_1, iter_81_0)

		setActive = var_81_1

		var_81_1(var_81_2:Find("player/happy"), false)

		setActive = var_81_1

		var_81_1(var_81_2:Find("player/sad"), false)

		local var_81_3 = var_81_2:Find("player")
		local var_81_4 = var_7.GetComponent

		typeof = var_9
		RectTransform = var_10

		local var_81_5 = var_81_4(var_81_3, var_9(var_10))

		Vector2 = var_81_3
		var_81_5.anchoredPosition = var_81_3(0, 0)

		if iter_81_0 == var_81_0 then
			setActive = var_81_5

			var_81_5(var_81_2:Find("player"), true)

			setActive = var_81_5

			var_81_5(var_81_2:Find("player/arrow"), false)

			if var_0_2.shieldCount > 0 then
				setActive = var_81_5

				var_81_5(var_81_2:Find("player/shield"), true)
			else
				setActive = var_81_5

				var_81_5(var_81_2:Find("player/shield"), false)
			end
		else
			setActive = var_81_5

			var_81_5(var_81_2:Find("player"), false)
		end
	end

	return
end

function var_0_1.OperateMapAll(arg_82_0, arg_82_1)
	for iter_82_0 = 0, arg_82_0.gamingMap.childCount - 1 do
		local var_82_0 = arg_82_0.gamingMap
		local var_82_1 = var_6.GetChild(var_82_0, iter_82_0)

		arg_82_1(var_82_1)
	end

	return
end

function var_0_1.OperateMapPlayer(arg_83_0, arg_83_1)
	ToLoveGameConst = var_1_10002

	local var_83_0 = var_1_10002.map[var_0_2.currentPlayerPosition[1]][var_0_2.currentPlayerPosition[2]]

	for iter_83_0 = 0, arg_83_0.gamingMap.childCount - 1 do
		local var_83_1 = arg_83_0.gamingMap
		local var_83_2 = var_7.GetChild(var_83_1, iter_83_0)

		if iter_83_0 == var_83_0 then
			arg_83_1(var_83_2)

			break
		end
	end

	return
end

function var_0_1.OperateMapOthers(arg_84_0, arg_84_1, arg_84_2)
	ToLoveGameConst = var_1_10003

	local var_84_0 = var_1_10003.map[arg_84_2[1]][arg_84_2[2]]

	for iter_84_0 = 0, arg_84_0.gamingMap.childCount - 1 do
		local var_84_1 = arg_84_0.gamingMap
		local var_84_2 = var_8.GetChild(var_84_1, iter_84_0)

		if iter_84_0 ~= var_84_0 then
			arg_84_1(var_84_2)
		end
	end

	return
end

function var_0_1.OperateMap(arg_85_0, arg_85_1, arg_85_2)
	for iter_85_0 = 0, arg_85_0.gamingMap.childCount - 1 do
		local var_85_0 = arg_85_0.gamingMap
		local var_85_1 = var_7.GetChild(var_85_0, iter_85_0)

		if iter_85_0 == arg_85_1 then
			arg_85_2(var_85_1)

			break
		end
	end

	return
end

function var_0_1.SetGamingBuff(arg_86_0)
	for iter_86_0 = 1, 7 do
		setActive = var_1_10005

		local var_86_0 = arg_86_0.gamingBuff

		var_1_10005(var_6.GetChild(var_86_0, iter_86_0 - 1), var_0_2.buffIndex == iter_86_0)
	end

	return
end

function var_0_1.timerStart(arg_87_0)
	if not arg_87_0.timer.running then
		local var_87_0 = arg_87_0.timer

		var_1.Start(var_87_0)
	end

	return
end

function var_0_1.timerStop(arg_88_0)
	if arg_88_0.timer.running then
		local var_88_0 = arg_88_0.timer

		var_1.Stop(var_88_0)
	end

	return
end

function var_0_1.AddScore(arg_89_0)
	var_0_2.combo = var_0_2.combo + 1

	local var_89_0 = 100

	ToLoveGameConst = var_2

	for iter_89_0 = #var_2.comboNum, 1, -1 do
		local var_89_1 = var_0_2.combo

		ToLoveGameConst = var_1_10007

		if var_1_10007.comboNum[iter_89_0] <= var_89_1 then
			ToLoveGameConst = var_89_1
			var_89_0 = var_89_0 + var_89_1.comboAdd[iter_89_0]

			break
		end
	end

	local var_89_2 = var_0_2.GetScoreMultiplyRate()
	local var_89_3 = 1

	if var_0_2.buffIndex == 2 or var_0_2.buffIndex == 7 then
		var_89_3 = 1.2
	elseif var_0_2.buffIndex == 5 then
		math = var_4
		var_89_3 = 1.2 + 0.01 * var_4.floor(var_0_2.combo / 5)
	end

	math = var_4

	local var_89_4 = var_4.ceil(var_89_0 * var_89_2 * var_89_3)

	var_0_2.score = var_0_2.score + var_89_4

	return
end

function var_0_1.onGameOver(arg_90_0)
	if arg_90_0.settlementFlag then
		return
	end

	arg_90_0.settlementFlag = true

	arg_90_0:timerStop()

	local var_90_0 = var_0_2

	var_90_0.startSettlement = true
	setActive = var_90_0

	var_90_0(arg_90_0.clickMask, true)

	LeanTween = var_90_0

	local var_90_1 = var_90_0.delayedCall

	go = var_2

	local var_90_2 = var_2(arg_90_0._tf)
	local var_90_3 = 0.2

	System = var_1_10004

	var_90_1(var_90_2, var_90_3, var_1_10004.Action(function()
		arg_90_0.settlementFlag = false

		local var_91_0 = arg_90_0

		var_91_0.gameStartFlag = false
		setActive = var_91_0

		var_91_0(arg_90_0.clickMask, false)

		local var_91_1 = arg_90_0

		var_0.ShowSettlementUI(var_91_1)

		return
	end))
	arg_90_0:UpdateTaskProgress()

	return
end

function var_0_1.ShowSettlementUI(arg_92_0)
	setActive = var_1_10001

	var_1_10001(arg_92_0.settlementUI, true)

	setActive = var_1_10001

	var_1_10001(arg_92_0.gamingBack, false)

	setActive = var_1_10001

	var_1_10001(arg_92_0.gamingPause, false)

	setActive = var_1_10001

	var_1_10001(arg_92_0.gamingOperationArea, false)

	setActive = var_1_10001

	var_1_10001(arg_92_0.gamingBuff, false)

	setText = var_1_10001

	var_1_10001(arg_92_0.settlementCurrentText, var_0_2.score)

	setActive = var_1_10001

	var_1_10001(arg_92_0.settlementNew, false)

	local var_92_0

	if var_0_2.score > var_0_2.highestScore then
		var_92_0 = var_0_2
		var_92_0.highestScore = var_0_2.score
		setActive = var_92_0

		var_92_0(arg_92_0.settlementNew, true)

		getProxy = var_92_0
		MiniGameProxy = var_2

		local var_92_1 = var_92_0(var_2)

		var_92_0.UpdataHighScore(var_92_1, var_0_2.game_id, {
			var_0_2.highestScore,
			var_0_2.gameTime
		})
	end

	setText = var_92_0

	var_92_0(arg_92_0.settlementHighText, var_0_2.highestScore)

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_93_0, arg_93_1)
	local var_93_0 = arg_93_1.cmd

	MiniGameOPCommand = var_1_10003

	if var_93_0 == var_1_10003.CMD_COMPLETE then
		checkExist = var_93_0

		if var_93_0(var_0_2.story, {
			arg_93_0:GetMGHubData().usedtime
		}, {
			1
		}) then
			pg = var_3

			local var_93_1 = var_3.NewStoryMgr.GetInstance()

			var_3.Play(var_93_1, var_2)
		end

		setText = var_3

		var_3(arg_93_0.menuLastTimesText, arg_93_0:GetMGHubData().count)

		setActive = var_3

		var_3(arg_93_0.menuStartTip, arg_93_0:GetMGHubData().count > 0)
		arg_93_0:UpdateMenuAwardList()
	end

	return
end

function var_0_1.ShowRank(arg_94_0)
	pg = var_1_10001

	local var_94_0 = var_1_10001.m02
	local var_94_1 = var_1.sendNotification

	GAME = var_1_10003

	var_94_1(var_94_0, var_1_10003.MINI_GAME_FRIEND_RANK, {
		id = var_0_2.game_id,
		callback = function(arg_95_0)
			local var_95_0 = {}

			for iter_95_0 = 1, #arg_95_0 do
				local var_95_1 = {}

				pairs = var_2_10007

				for iter_95_1, iter_95_2 in var_2_10007(arg_95_0[iter_95_0]) do
					var_95_1[iter_95_1] = iter_95_2
				end

				table = var_2_10007

				var_2_10007.insert(var_95_0, var_95_1)
			end

			table = var_2

			var_2.sort(var_95_0, function(arg_96_0, arg_96_1)
				if arg_96_0.score ~= arg_96_1.score then
					return arg_96_0.score > arg_96_1.score
				elseif arg_96_0.time_data ~= arg_96_1.time_data then
					return arg_96_0.time_data > arg_96_1.time_data
				else
					return arg_96_0.player_id < arg_96_1.player_id
				end

				return
			end)

			local var_95_2 = arg_94_0

			var_2.SetRankUI(var_95_2, var_95_0)

			return
		end
	})

	return
end

function var_0_1.SetRankUI(arg_97_0, arg_97_1)
	setActive = var_1_10002

	var_1_10002(arg_97_0.rankUI, true)

	local var_97_0
	local var_97_1 = 0
	local var_97_2 = arg_97_0.rankPlayerList

	var_4.make(var_97_2, function(arg_98_0, arg_98_1, arg_98_2)
		local var_98_0 = arg_97_1[arg_98_1 + 1]

		setText = var_4

		var_4(arg_98_2:Find("rank/count"), arg_98_1 + 1)

		local var_98_1

		if arg_98_1 + 1 == 1 then
			var_98_1 = arg_97_0

			var_4.SetRankColor(var_98_1, arg_98_2, "ea69fd", var_98_0.name, var_98_0.score)
		elseif arg_98_1 + 1 == 2 then
			var_98_1 = arg_97_0

			var_4.SetRankColor(var_98_1, arg_98_2, "11bfff", var_98_0.name, var_98_0.score)
		elseif arg_98_1 + 1 == 3 then
			var_98_1 = arg_97_0

			var_4.SetRankColor(var_98_1, arg_98_2, "51edca", var_98_0.name, var_98_0.score)
		else
			var_98_1 = arg_97_0

			var_4.SetRankColor(var_98_1, arg_98_2, "83919c", var_98_0.name, var_98_0.score)
		end

		getProxy = var_4
		PlayerProxy = var_98_1

		local var_98_2 = var_4(var_98_1)

		if var_4.isSelf(var_98_2, var_98_0.player_id) then
			var_97_0 = var_98_0
			var_97_1 = arg_98_1 + 1
		end

		setActive = var_98_2

		var_98_2(arg_98_2:Find("1"), arg_98_1 + 1 == 1)

		setActive = var_98_2

		var_98_2(arg_98_2:Find("2"), arg_98_1 + 1 == 2)

		setActive = var_98_2

		var_98_2(arg_98_2:Find("3"), arg_98_1 + 1 == 3)

		setActive = var_98_2

		var_98_2(arg_98_2:Find("rank/1"), arg_98_1 + 1 == 1)

		setActive = var_98_2

		var_98_2(arg_98_2:Find("rank/2"), arg_98_1 + 1 == 2)

		setActive = var_98_2

		var_98_2(arg_98_2:Find("rank/3"), arg_98_1 + 1 == 3)

		setActive = var_98_2

		var_98_2(arg_98_2:Find("imgMe"), var_4)

		return
	end)

	local var_97_3 = arg_97_0.rankPlayerList

	var_4.align(var_97_3, #arg_97_1)

	setText = var_4

	local var_97_4 = arg_97_0.rankMyself
	local var_97_5 = var_5.Find(var_97_4, "nameText")

	getProxy = var_97_4
	PlayerProxy = var_7

	local var_97_6 = var_97_4(var_7).data

	var_4(var_97_5, var_6.GetName(var_97_6))

	if var_97_0 then
		setText = var_4

		local var_97_7 = arg_97_0.rankMyself

		var_4(var_5.Find(var_97_7, "rank/count"), var_97_1)

		if var_97_1 == 1 then
			arg_97_0:SetRankColor(arg_97_0.rankMyself, "ea69fd", var_97_0.name, var_97_0.score)
		elseif var_97_1 == 2 then
			arg_97_0:SetRankColor(arg_97_0.rankMyself, "11bfff", var_97_0.name, var_97_0.score)
		elseif var_97_1 == 3 then
			arg_97_0:SetRankColor(arg_97_0.rankMyself, "51edca", var_97_0.name, var_97_0.score)
		else
			arg_97_0:SetRankColor(arg_97_0.rankMyself, "83919c", var_97_0.name, var_97_0.score)
		end

		setActive = var_4

		local var_97_8 = arg_97_0.rankMyself

		var_4(var_5.Find(var_97_8, "1"), var_97_1 == 1)

		setActive = var_4

		local var_97_9 = arg_97_0.rankMyself

		var_4(var_5.Find(var_97_9, "2"), var_97_1 == 2)

		setActive = var_4

		local var_97_10 = arg_97_0.rankMyself

		var_4(var_5.Find(var_97_10, "3"), var_97_1 == 3)

		setActive = var_4

		local var_97_11 = arg_97_0.rankMyself

		var_4(var_5.Find(var_97_11, "rank/1"), var_97_1 == 1)

		setActive = var_4

		local var_97_12 = arg_97_0.rankMyself

		var_4(var_5.Find(var_97_12, "rank/2"), var_97_1 == 2)

		setActive = var_4

		local var_97_13 = arg_97_0.rankMyself

		var_4(var_5.Find(var_97_13, "rank/3"), var_97_1 == 3)
	end

	return
end

function var_0_1.SetRankColor(arg_99_0, arg_99_1, arg_99_2, arg_99_3, arg_99_4)
	setText = var_1_10005

	var_1_10005(arg_99_1:Find("nameText"), "<color=#" .. arg_99_2 .. ">" .. arg_99_3 .. "</color>")

	setText = var_1_10005

	var_1_10005(arg_99_1:Find("score"), "<color=#" .. arg_99_2 .. ">" .. arg_99_4 .. "</color>")

	return
end

function var_0_1.ShowBuff(arg_100_0)
	setActive = var_1_10001

	var_1_10001(arg_100_0.buffUI, true)

	local var_100_0 = var_0_2.GetBuffList(arg_100_0:GetMGHubData())
	local var_100_1 = arg_100_0.buffList

	var_2.make(var_100_1, function(arg_101_0, arg_101_1, arg_101_2)
		local var_101_0 = var_100_0[arg_101_1 + 1]

		setText = var_4

		var_4(arg_101_2:Find("name"), var_101_0[1])

		setText = var_4

		var_4(arg_101_2:Find("desc"), var_101_0[2])

		setText = var_4

		var_4(arg_101_2:Find("lock/unlockTime"), var_101_0[3])

		setText = var_4

		local var_101_1 = arg_101_2
		local var_101_2 = arg_101_2.Find(var_101_1, "useToggle/onText")

		i18n = var_101_1

		var_4(var_101_2, var_101_1("tolovegame_buff_switch_1"))

		setText = var_4

		local var_101_3 = arg_101_2
		local var_101_4 = arg_101_2.Find(var_101_3, "useToggle/using/offText")

		i18n = var_101_3

		var_4(var_101_4, var_101_3("tolovegame_buff_switch_2"))

		for iter_101_0 = 1, 7 do
			setActive = var_2_10008

			local var_101_5 = arg_101_2:Find("buffImg")

			var_2_10008(var_9.GetChild(var_101_5, iter_101_0 - 1), arg_101_1 + 1 == iter_101_0)
		end

		onToggle = var_4

		local var_101_6 = arg_100_0
		local var_101_7 = arg_101_2:Find("useToggle")

		local function var_101_8(arg_102_0)
			if arg_102_0 then
				PlayerPrefs = var_3_10001

				var_3_10001.SetInt("ToLoveGameBuff", arg_101_1 + 1)

				PlayerPrefs = var_3_10001

				var_3_10001.Save()

				setActive = var_3_10001

				local var_102_0 = arg_101_2

				var_3_10001(var_2.Find(var_102_0, "buffImg/select"), true)

				setActive = var_3_10001

				local var_102_1 = arg_101_2

				var_3_10001(var_2.Find(var_102_1, "useToggle/using"), true)
			else
				PlayerPrefs = var_3_10001

				var_3_10001.DeleteKey("ToLoveGameBuff")

				setActive = var_1

				local var_102_2 = arg_101_2

				var_1(var_2.Find(var_102_2, "buffImg/select"), false)

				setActive = var_1

				local var_102_3 = arg_101_2

				var_1(var_2.Find(var_102_3, "useToggle/using"), false)
			end

			return
		end

		SFX_PANEL = var_8

		var_4(var_101_6, var_101_7, var_101_8, var_8)

		PlayerPrefs = var_4

		local var_101_9 = var_4.GetInt("ToLoveGameBuff", 0)

		if arg_101_1 + 1 == var_101_9 then
			triggerToggle = var_5

			var_5(arg_101_2:Find("useToggle"), true)
		end

		if var_101_0[3] == "" then
			setActive = var_5

			var_5(arg_101_2:Find("name"), true)

			setActive = var_5

			var_5(arg_101_2:Find("desc"), true)

			setActive = var_5

			var_5(arg_101_2:Find("lock"), false)

			setActive = var_5

			var_5(arg_101_2:Find("useToggle"), true)
		else
			setActive = var_5

			var_5(arg_101_2:Find("name"), false)

			setActive = var_5

			var_5(arg_101_2:Find("desc"), false)

			setActive = var_5

			var_5(arg_101_2:Find("lock"), true)

			setActive = var_5

			var_5(arg_101_2:Find("useToggle"), false)
		end

		return
	end)

	local var_100_2 = arg_100_0.buffList

	var_2.align(var_100_2, #var_100_0)

	PlayerPrefs = var_2

	var_2.SetInt("toLoveGameBuffCount", arg_100_0.unlockBuffCount)

	setActive = var_2

	var_2(arg_100_0.menuBuffTip, arg_100_0:ShouldShowBuffTip())

	return
end

function var_0_1.ShowTask(arg_103_0)
	setActive = var_1_10001

	var_1_10001(arg_103_0.taskUI, true)
	arg_103_0:GetTaskData()

	local var_103_0 = arg_103_0.taskTasklist

	var_1.make(var_103_0, function(arg_104_0, arg_104_1, arg_104_2)
		UIItemList = var_2_10003

		if arg_104_0 == var_2_10003.EventUpdate then
			local var_104_0 = arg_103_0.taskVOs[arg_104_1 + 1]
			local var_104_1 = var_3.getProgress(var_104_0)
			local var_104_2 = var_3
			local var_104_3 = var_3.getConfig(var_104_2, "target_num")

			math = var_104_2

			local var_104_4 = var_104_2.min(var_104_1, var_104_3)

			setText = var_6

			var_6(arg_104_2:Find("frame/progress"), var_104_4 .. "/" .. var_104_3)

			local var_104_5 = arg_104_2:Find("frame/slider")
			local var_104_6 = var_6.GetComponent

			typeof = var_8
			Slider = var_9
			var_104_6(var_104_5, var_8(var_9)).value = var_104_4 / var_104_3
			setText = var_7

			local var_104_7 = arg_104_2
			local var_104_8 = arg_104_2.Find(var_104_7, "frame/go_btn/Text")

			i18n = var_104_7

			var_7(var_104_8, var_104_7("tolovegame_proceed"))

			setText = var_7

			local var_104_9 = arg_104_2
			local var_104_10 = arg_104_2.Find(var_104_9, "frame/get_btn/Text")

			i18n = var_104_9

			var_7(var_104_10, var_104_9("tolovegame_collect"))

			setText = var_7

			local var_104_11 = arg_104_2
			local var_104_12 = arg_104_2.Find(var_104_11, "frame/got_btn/Text")

			i18n = var_104_11

			var_7(var_104_12, var_104_11("tolovegame_collected"))

			local var_104_13 = arg_104_2:Find("frame/awards")
			local var_104_14 = var_7.GetChild(var_104_13, 0)
			local var_104_15 = arg_103_0

			var_9.updateAwards(var_104_15, var_3:getConfig("award_display"), var_7, var_104_14)

			local var_104_16 = arg_104_2:Find("frame/go_btn")
			local var_104_17 = arg_104_2:Find("frame/get_btn")
			local var_104_18 = arg_104_2:Find("frame/got_btn")
			local var_104_19 = arg_104_2:Find("frame/leftBar")
			local var_104_20 = arg_104_2:Find("frame/leftBarGot")

			if var_3:getTaskStatus() == 0 then
				setActive = var_14

				var_14(var_104_16, true)

				setActive = var_14

				var_14(var_104_17, false)

				setActive = var_14

				var_14(var_104_18, false)

				setActive = var_14

				var_14(var_104_19, true)

				setActive = var_14

				var_14(var_104_20, false)

				local var_104_21 = arg_103_0

				var_14.SetTaskColor(var_104_21, arg_104_2, "4de3c2", var_3:getConfig("desc"))
			elseif var_3:getTaskStatus() == 1 then
				setActive = var_14

				var_14(var_104_16, false)

				setActive = var_14

				var_14(var_104_17, true)

				setActive = var_14

				var_14(var_104_18, false)

				setActive = var_14

				var_14(var_104_19, true)

				setActive = var_14

				var_14(var_104_20, false)

				local var_104_22 = arg_103_0

				var_14.SetTaskColor(var_104_22, arg_104_2, "4de3c2", var_3:getConfig("desc"))
			elseif var_3:getTaskStatus() == 2 then
				setActive = var_14

				var_14(var_104_16, false)

				setActive = var_14

				var_14(var_104_17, false)

				setActive = var_14

				var_14(var_104_18, true)

				setActive = var_14

				var_14(var_104_19, false)

				setActive = var_14

				var_14(var_104_20, true)

				local var_104_23 = arg_103_0

				var_14.SetTaskColor(var_104_23, arg_104_2, "616161", var_3:getConfig("desc"))
			end

			onButton = var_14

			local var_104_24 = arg_103_0
			local var_104_25 = var_104_16

			local function var_104_26()
				setActive = var_3_10000

				var_3_10000(arg_103_0.taskUI, false)

				local var_105_0 = arg_103_0

				var_0.ShowBuff(var_105_0)

				local var_105_1 = arg_103_0

				var_0.GetTaskData(var_105_1)

				setActive = var_0

				var_0(arg_103_0.menuTaskTip, arg_103_0.canGetAward)

				return
			end

			SFX_PANEL = var_2_10018

			var_14(var_104_24, var_104_25, var_104_26, var_2_10018)

			onButton = var_14

			local var_104_27 = arg_103_0
			local var_104_28 = var_104_17

			local function var_104_29()
				local var_106_0 = var_0
				local var_106_1 = var_0.getConfig(var_106_0, "award_display")

				getProxy = var_106_0
				PlayerProxy = var_2

				local var_106_2 = var_106_0(var_2)
				local var_106_3 = var_1.getRawData(var_106_2)

				pg = var_106_2

				local var_106_4 = var_106_2.gameset.urpt_chapter_max.description[1]

				LOCK_UR_SHIP = var_3_10004

				if var_3_10004 then
					var_3_10004 = 0
				else
					getProxy = var_3_10004
					BagProxy = var_3_10005
					var_3_10005 = var_3_10004(var_3_10005)
					var_3_10004 = var_3_10004.GetLimitCntById(var_3_10005, var_106_4)
				end

				Task = var_3_10005

				local var_106_5, var_106_6 = var_3_10005.StaticJudgeOverflow(var_106_3.gold, var_106_3.oil, var_3_10004, true, true, var_106_1)
				local var_106_7 = {}

				if var_106_5 then
					table = var_8

					var_8.insert(var_106_7, function(arg_107_0)
						pg = var_4_10001

						local var_107_0 = var_4_10001.MsgboxMgr.GetInstance()
						local var_107_1 = var_1.ShowMsgBox
						local var_107_2 = {}

						MSGBOX_TYPE_ITEM_BOX = var_4_10004
						var_107_2.type = var_4_10004
						i18n = var_4_10004
						var_107_2.content = var_4_10004("award_max_warning")
						var_107_2.items = var_106_6
						var_107_2.onYes = arg_107_0

						var_107_1(var_107_0, var_107_2)

						return
					end)
				end

				seriesAsync = var_8

				var_8(var_106_7, function()
					pg = var_4_10000

					local var_108_0 = var_4_10000.m02
					local var_108_1 = var_0.sendNotification

					GAME = var_4_10002

					var_108_1(var_108_0, var_4_10002.SUBMIT_TASK, var_0.id)

					return
				end)

				return
			end

			SFX_PANEL = var_2_10018

			var_14(var_104_27, var_104_28, var_104_29, var_2_10018)
		end

		return
	end)

	local var_103_1 = arg_103_0.taskTasklist

	var_1.align(var_103_1, #arg_103_0.taskVOs)

	return
end

function var_0_1.GetTaskData(arg_109_0)
	arg_109_0.taskVOs = {}
	getProxy = var_1
	ActivityProxy = var_1_10002

	local var_109_0 = var_1(var_1_10002)
	local var_109_1 = var_1.getActivityById

	ActivityConst = var_1_10003

	local var_109_2 = var_109_1(var_109_0, var_1_10003.TOLOVE_MINIGAME_TASK_ID)

	arg_109_0.taskIds = var_1.getConfig(var_109_2, "config_client").task_ids
	pairs = var_2

	for iter_109_0, iter_109_1 in var_2(arg_109_0.taskIds) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_109_3 = arg_109_0.taskVOs

		getProxy = var_1_10009
		TaskProxy = var_1_10010
		var_1_10010 = var_1_10009(var_1_10010)

		var_1_10007(var_109_3, var_1_10009.getTaskVO(var_1_10010, iter_109_1))
	end

	local var_109_4 = {}

	arg_109_0.canGetAward = false
	pairs = var_3

	for iter_109_2, iter_109_3 in var_3(arg_109_0.taskVOs) do
		if iter_109_3:getTaskStatus() == 1 then
			table = var_8

			var_8.insert(var_109_4, iter_109_3)

			arg_109_0.canGetAward = true
		end
	end

	pairs = var_3

	for iter_109_4, iter_109_5 in var_3(arg_109_0.taskVOs) do
		if iter_109_5:getTaskStatus() == 0 then
			table = var_8

			var_8.insert(var_109_4, iter_109_5)
		end
	end

	pairs = var_3

	for iter_109_6, iter_109_7 in var_3(arg_109_0.taskVOs) do
		if iter_109_7:getTaskStatus() == 2 then
			table = var_8

			var_8.insert(var_109_4, iter_109_7)
		end
	end

	arg_109_0.taskVOs = var_109_4

	return
end

function var_0_1.updateAwards(arg_110_0, arg_110_1, arg_110_2, arg_110_3)
	_ = var_1_10004

	local var_110_0 = var_1_10004.slice(arg_110_1, 1, 3)

	for iter_110_0 = arg_110_2.childCount, #var_110_0 - 1 do
		cloneTplTo = var_1_10010

		var_1_10010(arg_110_3, arg_110_2)
	end

	local var_110_1 = arg_110_2.childCount

	for iter_110_1 = 1, var_110_1 do
		local var_110_2 = arg_110_2:GetChild(iter_110_1 - 1)
		local var_110_3 = iter_110_1 <= #var_110_0

		setActive = var_12

		var_12(var_110_2, var_110_3)

		if var_110_3 then
			local var_110_4 = var_110_0[iter_110_1]
			local var_110_5 = {
				type = var_110_4[1],
				id = var_110_4[2],
				count = var_110_4[3]
			}

			updateDrop = var_14

			var_14(var_110_2, var_110_5)

			onButton = var_14

			local var_110_6 = arg_110_0
			local var_110_7 = var_110_2

			local function var_110_8()
				local var_111_0 = arg_110_0
				local var_111_1 = var_0.emit

				BaseUI = var_2_10002

				var_111_1(var_111_0, var_2_10002.ON_DROP, var_110_5)

				return
			end

			SFX_PANEL = var_1_10018

			var_14(var_110_6, var_110_7, var_110_8, var_1_10018)
		end
	end

	return
end

function var_0_1.SetTaskColor(arg_112_0, arg_112_1, arg_112_2, arg_112_3)
	setText = var_1_10004

	var_1_10004(arg_112_1:Find("frame/desc"), "<color=#" .. arg_112_2 .. ">" .. arg_112_3 .. "</color>")

	return
end

function var_0_1.pauseGame(arg_113_0)
	arg_113_0.gameStop = true

	arg_113_0:timerStop()

	return
end

function var_0_1.resumeGame(arg_114_0)
	arg_114_0.gameStop = false

	arg_114_0:timerStart()

	return
end

function var_0_1.UpdateTaskProgress(arg_115_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10002

	local var_115_0 = var_1_10001(var_1_10002)

	for iter_115_0 = 1, 7 do
		if var_0_2.buffIndex == iter_115_0 then
			if var_115_0:getTaskById(arg_115_0.taskIds[iter_115_0]) then
				pg = var_6

				local var_115_1 = var_6.m02
				local var_115_2 = var_6.sendNotification

				GAME = var_8

				var_115_2(var_115_1, var_8.MINI_GAME_TASK_PROGRESS_UPDATE, {
					progressAdd = 1,
					taskId = arg_115_0.taskIds[iter_115_0]
				})
			end

			if var_115_0:getTaskById(arg_115_0.taskIds[iter_115_0 + 7]) then
				arg_115_0:UpdateTaskScore(arg_115_0.taskIds[iter_115_0 + 7])
			end

			break
		end
	end

	return
end

function var_0_1.UpdateTaskScore(arg_116_0, arg_116_1)
	getProxy = var_1_10002
	TaskProxy = var_1_10003

	local var_116_0 = var_1_10002(var_1_10003)

	if var_2.getTaskById(var_116_0, arg_116_1).progress < var_0_2.score then
		local var_116_1 = 0

		if var_0_2.score > 2000 then
			var_116_1 = 2000 - var_2
		else
			var_116_1 = var_0_2.score - var_2
		end

		pg = var_4

		local var_116_2 = var_4.m02
		local var_116_3 = var_4.sendNotification

		GAME = var_1_10006

		var_116_3(var_116_2, var_1_10006.MINI_GAME_TASK_PROGRESS_UPDATE, {
			taskId = arg_116_1,
			progressAdd = var_116_1
		})
	end

	return
end

function var_0_1.changeBgm(arg_117_0, arg_117_1)
	local var_117_0

	ToLoveGameConst = var_1_10003

	if arg_117_1 == var_1_10003.bgm_type_default then
		if not arg_117_0:getBGM() then
			pg = var_3

			local var_117_1 = var_3.CriMgr.GetInstance()

			if var_3.IsDefaultBGM(var_117_1) then
				pg = var_3
				var_117_0 = var_3.voice_bgm.NewMainScene.default_bgm
			else
				pg = var_3
				var_117_0 = var_3.voice_bgm.NewMainScene.bgm
			end
		end
	else
		ToLoveGameConst = var_3

		if arg_117_1 == var_3.bgm_type_menu then
			ToLoveGameConst = var_3
			var_117_0 = var_3.menu_bgm
		else
			ToLoveGameConst = var_3

			if arg_117_1 == var_3.bgm_type_game then
				ToLoveGameConst = var_3
				var_117_0 = var_3.game_bgm
			end
		end
	end

	if arg_117_0.bgm ~= var_117_0 then
		arg_117_0.bgm = var_117_0
		pg = var_3

		local var_117_2 = var_3.BgmMgr.GetInstance()

		var_3.Push(var_117_2, arg_117_0.__cname, var_117_0)
	end

	return
end

function var_0_1.OnApplicationPaused(arg_118_0)
	if not arg_118_0.gameStartFlag then
		return
	end

	if arg_118_0.readyStartFlag then
		return
	end

	if arg_118_0.settlementFlag then
		return
	end

	arg_118_0:pauseGame()

	return
end

function var_0_1.initEvent(arg_119_0)
	if not arg_119_0.handle then
		IsUnityEditor = var_1

		if var_1 then
			UpdateBeat = var_1
			arg_119_0.handle = var_1:CreateListener(arg_119_0.Update, arg_119_0)
			UpdateBeat = var_1

			var_1:AddListener(arg_119_0.handle)
		end
	end

	return
end

function var_0_1.Update(arg_120_0)
	IsUnityEditor = var_1_10001

	if var_1_10001 then
		Input = var_1_10001

		local var_120_0 = var_1_10001.GetKeyDown

		KeyCode = var_1_10002

		if var_120_0(var_1_10002.W) then
			triggerButton = var_1

			var_1(arg_120_0.gamingUp)
		end

		Input = var_1

		local var_120_1 = var_1.GetKeyUp

		KeyCode = var_2

		if var_120_1(var_2.S) then
			triggerButton = var_1

			var_1(arg_120_0.gamingDown)
		end

		Input = var_1

		local var_120_2 = var_1.GetKeyDown

		KeyCode = var_2

		if var_120_2(var_2.A) then
			triggerButton = var_1

			var_1(arg_120_0.gamingLeft)
		end

		Input = var_1

		local var_120_3 = var_1.GetKeyUp

		KeyCode = var_2

		if var_120_3(var_2.D) then
			triggerButton = var_1

			var_1(arg_120_0.gamingRight)
		end
	end

	return
end

function var_0_1.willExit(arg_121_0)
	if arg_121_0.timer and arg_121_0.timer.running then
		local var_121_0 = arg_121_0.timer

		var_1.Stop(var_121_0)
	end

	arg_121_0.timer = nil

	if arg_121_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_121_0.handle)
	end

	return
end

function var_0_1.onBackPressed(arg_122_0)
	if arg_122_0.readyStartFlag then
		return
	end

	if not arg_122_0.gameStartFlag then
		return
	else
		if arg_122_0.settlementFlag then
			return
		end

		isActive = var_1

		if var_1(arg_122_0.pauseUI) then
			arg_122_0:resumeGame()

			setActive = var_1

			var_1(arg_122_0.pauseUI, false)
		else
			isActive = var_1

			if var_1(arg_122_0.leaveUI) then
				arg_122_0:resumeGame()

				setActive = var_1

				var_1(arg_122_0.leaveUI, false)
			else
				isActive = var_1

				if not var_1(arg_122_0.pauseUI) then
					isActive = var_1

					if not var_1(arg_122_0.pauseUI) then
						if not var_0_2.startSettlement then
							arg_122_0:pauseGame()

							setActive = var_1

							var_1(arg_122_0.pauseUI, true)
						end

						goto label_122_0
					end
				end

				arg_122_0:resumeGame()
			end
		end
	end

	::label_122_0::

	return
end

return var_0_1
