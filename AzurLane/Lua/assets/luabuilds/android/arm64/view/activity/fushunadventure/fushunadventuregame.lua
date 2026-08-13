class = var_0_10000

local var_0_0 = var_0_10000("FushunAdventureGame")
local var_0_1 = false
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3
local var_0_6 = 4

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	pg = var_1_10004

	var_1_10004.DelegateInfo.New(arg_1_0)

	arg_1_0.state = var_0_2
	arg_1_0._go = arg_1_1
	arg_1_0.gameData = arg_1_2

	local var_1_0

	if not arg_1_3:GetRuntimeData("elements") then
		var_1_0 = {}
	end

	local var_1_1

	if not var_1_0[1] then
		var_1_1 = 0
	end

	arg_1_0.highestScore = var_1_1

	arg_1_0:Init()

	return
end

function var_0_0.SetOnShowResult(arg_2_0, arg_2_1)
	arg_2_0.OnShowResult = arg_2_1

	return
end

function var_0_0.SetOnLevelUpdate(arg_3_0, arg_3_1)
	arg_3_0.OnLevelUpdate = arg_3_1

	return
end

function var_0_0.setRoomTip(arg_4_0, arg_4_1)
	arg_4_0.helpTip = arg_4_1

	return
end

function var_0_0.setRoomId(arg_5_0, arg_5_1)
	arg_5_0.roomId = arg_5_1

	return
end

function var_0_0.Init(arg_6_0)
	if arg_6_0.state ~= var_0_2 then
		return
	end

	arg_6_0.state = var_0_4

	arg_6_0:InitMainUI()

	pg = var_1
	arg_6_0.helpTip = var_1.gametip.fushun_adventure_help.tip

	return
end

function var_0_0.loadPrefab(arg_7_0, arg_7_1, arg_7_2)
	ResourceMgr = var_1_10003

	local var_7_0 = var_1_10003.Inst

	var_3.getAssetAsync(var_7_0, arg_7_1, "", function(arg_8_0)
		local var_8_0 = arg_7_2

		instantiate = var_2_10003

		var_8_0(var_2_10003(arg_8_0))

		return
	end, true, true)

	return
end

function var_0_0.InitMainUI(arg_9_0)
	local var_9_0 = arg_9_0._go

	onButton = var_1_10002

	local var_9_1 = arg_9_0

	findTF = var_1_10005

	local var_9_2 = var_1_10005(var_9_0, "btn_help")

	local function var_9_3()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_10_2.type = var_2_10004
		var_10_2.helps = arg_9_0.helpTip

		var_10_1(var_10_0, var_10_2)

		return
	end

	SFX_PANEL = var_7

	var_1_10002(var_9_1, var_9_2, var_9_3, var_7)

	onButton = var_1_10002

	local var_9_4 = arg_9_0

	findTF = var_9_2

	local var_9_5 = var_9_2(var_9_0, "btn_start")

	local function var_9_6()
		pg = var_2_10000

		local var_11_0 = var_2_10000.BgmMgr.GetInstance()

		var_0.StopPlay(var_11_0)

		local var_11_1 = arg_9_0

		var_0.StartGame(var_11_1)

		return
	end

	SFX_PANEL = var_7

	var_1_10002(var_9_4, var_9_5, var_9_6, var_7)

	UIItemList = var_1_10002

	local var_9_7 = var_1_10002.New

	findTF = var_9_4

	local var_9_8 = var_9_4(var_9_0, "levels/scrollrect/content")

	findTF = var_9_5
	arg_9_0.levelList = var_9_7(var_9_8, var_9_5(var_9_0, "levels/scrollrect/content/level"))
	findTF = var_2
	arg_9_0.arrUp = var_2(var_9_0, "levels/arr_up")
	findTF = var_2
	arg_9_0.arrDown = var_2(var_9_0, "levels/arr_bottom")
	onScroll = var_2

	local var_9_9 = arg_9_0

	findTF = var_5

	var_2(var_9_9, var_5(var_9_0, "levels/scrollrect"), function(arg_12_0)
		setActive = var_2_10001

		var_2_10001(arg_9_0.arrUp, arg_12_0.y < 1)

		setActive = var_2_10001

		var_2_10001(arg_9_0.arrDown, arg_12_0.y > 0)

		return
	end)
	arg_9_0:RefreshLevels()

	return
end

function var_0_0.RefreshLevels(arg_13_0)
	local var_13_0
	local var_13_1 = arg_13_0.levelList

	var_2.make(var_13_1, function(arg_14_0, arg_14_1, arg_14_2)
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventUpdate then
			local var_14_0 = arg_14_2:Find("Text")
			local var_14_1 = var_3.GetComponent

			typeof = var_6
			Image = var_2_10008

			local var_14_2 = var_14_1(var_14_0, var_6(var_2_10008))

			GetSpriteFromAtlas = var_2_10004
			var_14_2.sprite = var_2_10004("ui/minigameui/FushunAdventureGame_atlas", "level_" .. arg_14_1 + 1)

			local var_14_3 = arg_13_0.gameData.count > 0 and 1 or 0
			local var_14_4 = arg_14_1 >= arg_13_0.gameData.usedtime + var_14_3

			setActive = var_14_0

			var_14_0(arg_14_2:Find("lock"), var_14_4)

			local var_14_5 = arg_14_1 < arg_13_0.gameData.usedtime

			setActive = var_6

			var_6(arg_14_2:Find("cleared"), var_14_5)

			setActive = var_6

			var_6(arg_14_2:Find("Text"), not var_14_4)

			if not var_14_5 and not var_13_0 then
				var_13_0 = arg_14_1
			end

			local var_14_6 = arg_14_2
			local var_14_7 = arg_14_2.GetComponent

			typeof = var_9
			Image = var_11
			var_14_7(var_14_6, var_9(var_11)).enabled = not var_14_4
		end

		return
	end)

	local var_13_2 = arg_13_0.levelList
	local var_13_3 = var_2.align

	FushunAdventureGameConst = var_5

	var_13_3(var_13_2, var_5.LEVEL_CNT)

	setActive = var_13_3
	findTF = var_13_2

	var_13_3(var_13_2(arg_13_0._go, "tip/got"), arg_13_0.gameData.ultimate ~= 0)

	if var_13_0 then
		local var_13_4 = var_13_0 * (arg_13_0.levelList.item.rect.height + 50)
		local var_13_5 = arg_13_0.levelList.container.anchoredPosition

		setAnchoredPosition = var_4

		var_4(arg_13_0.levelList.container, {
			y = var_13_5.y + var_13_4
		})
	end

	if arg_13_0.OnLevelUpdate then
		arg_13_0.OnLevelUpdate()
	end

	return
end

function var_0_0.InitGameUI(arg_15_0)
	local var_15_0 = arg_15_0.gameUI

	findTF = var_1_10002
	arg_15_0.btnA = var_1_10002(var_15_0, "UI/A")
	findTF = var_2
	arg_15_0.btnB = var_2(var_15_0, "UI/B")

	local var_15_1 = arg_15_0.btnA

	arg_15_0.btnAEffect = var_2.Find(var_15_1, "effect")

	local var_15_2 = arg_15_0.btnB

	arg_15_0.btnBEffect = var_2.Find(var_15_2, "effect")

	local var_15_3 = arg_15_0.btnA

	arg_15_0.btnAExEffect = var_2.Find(var_15_3, "effect_ex")

	local var_15_4 = arg_15_0.btnB

	arg_15_0.btnBExEffect = var_2.Find(var_15_4, "effect_ex")

	local var_15_5 = {}

	findTF = var_1_10003

	local var_15_6 = var_1_10003(var_15_0, "UI/keys/1")
	local var_15_7 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	var_15_5[1] = var_15_7(var_15_6, var_6(var_1_10008))
	findTF = var_3

	local var_15_8 = var_3(var_15_0, "UI/keys/2")
	local var_15_9 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	var_15_5[2] = var_15_9(var_15_8, var_6(var_1_10008))
	findTF = var_3

	local var_15_10 = var_3(var_15_0, "UI/keys/3")
	local var_15_11 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	var_15_5[3] = var_15_11(var_15_10, var_6(var_1_10008))
	arg_15_0.keys = var_15_5

	local var_15_12 = {
		arg_15_0.keys[1].sprite
	}
	local var_15_13 = arg_15_0.btnA
	local var_15_14 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	var_15_12[2] = var_15_14(var_15_13, var_6(var_1_10008)).sprite

	local var_15_15 = arg_15_0.btnB
	local var_15_16 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	var_15_12[3] = var_15_16(var_15_15, var_6(var_1_10008)).sprite
	arg_15_0.btnSprites = var_15_12

	local var_15_17 = {}

	findTF = var_3
	var_15_17[1] = var_3(var_15_0, "UI/heart_score/hearts/1/mark")
	findTF = var_3
	var_15_17[2] = var_3(var_15_0, "UI/heart_score/hearts/2/mark")
	findTF = var_3
	var_15_17[3] = var_3(var_15_0, "UI/heart_score/hearts/3/mark")
	arg_15_0.hearts = var_15_17

	local var_15_18 = {}

	findTF = var_3
	var_15_18[1] = var_3(var_15_0, "UI/countdown_panel/timer/3")
	findTF = var_3
	var_15_18[2] = var_3(var_15_0, "UI/countdown_panel/timer/2")
	findTF = var_3
	var_15_18[3] = var_3(var_15_0, "UI/countdown_panel/timer/1")
	arg_15_0.numbers = var_15_18
	findTF = var_15_18

	local var_15_19 = var_15_18(var_15_0, "UI/heart_score/score/Text")
	local var_15_20 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_15_0.scoreTxt = var_15_20(var_15_19, var_5(var_1_10007))
	findTF = var_2

	local var_15_21 = var_2(var_15_0, "UI/ex/bar")
	local var_15_22 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_15_0.energyBar = var_15_22(var_15_21, var_5(var_1_10007))
	findTF = var_2
	arg_15_0.energyIcon = var_2(var_15_0, "UI/ex/icon")
	findTF = var_2
	arg_15_0.energyLight = var_2(var_15_0, "UI/ex/light")
	findTF = var_2
	arg_15_0.exTipPanel = var_2(var_15_0, "UI/ex_tip_panel")
	findTF = var_2

	local var_15_23 = var_2(var_15_0, "UI/combo/Text")
	local var_15_24 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_15_0.comboTxt = var_15_24(var_15_23, var_5(var_1_10007))
	findTF = var_2
	arg_15_0.countdownPanel = var_2(var_15_0, "UI/countdown_panel")
	findTF = var_2
	arg_15_0.resultPanel = var_2(var_15_0, "UI/result_panel")
	findTF = var_2
	arg_15_0.resultCloseBtn = var_2(arg_15_0.resultPanel, "frame/close")
	findTF = var_2

	local var_15_25 = var_2(arg_15_0.resultPanel, "frame/highest/Text")
	local var_15_26 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_15_0.resultHighestScoreTxt = var_15_26(var_15_25, var_5(var_1_10007))
	findTF = var_2

	local var_15_27 = var_2(arg_15_0.resultPanel, "frame/score/Text")
	local var_15_28 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_15_0.resultScoreTxt = var_15_28(var_15_27, var_5(var_1_10007))
	findTF = var_2
	arg_15_0.msgboxPanel = var_2(var_15_0, "UI/msg_panel")
	findTF = var_2
	arg_15_0.exitMsgboxWindow = var_2(arg_15_0.msgboxPanel, "frame/exit_mode")
	findTF = var_2
	arg_15_0.pauseMsgboxWindow = var_2(arg_15_0.msgboxPanel, "frame/pause_mode")
	findTF = var_2
	arg_15_0.helpWindow = var_2(var_15_0, "UI/help")
	findTF = var_2
	arg_15_0.lightTF = var_2(var_15_0, "game/range")

	local var_15_29 = arg_15_0.lightTF

	arg_15_0.lightMark = var_2.Find(var_15_29, "Image")
	findTF = var_2
	arg_15_0.pauseBtn = var_2(var_15_0, "UI/pause")
	findTF = var_2
	arg_15_0.exitBtn = var_2(var_15_0, "UI/back")
	arg_15_0.energyBar.fillAmount = 0

	return
end

function var_0_0.EnterAnimation(arg_16_0, arg_16_1)
	setActive = var_1_10002

	var_1_10002(arg_16_0.countdownPanel, true)

	local function var_16_0(arg_17_0)
		ipairs = var_2_10001

		for iter_17_0, iter_17_1 in var_2_10001(arg_16_0.numbers) do
			setActive = var_2_10006

			var_2_10006(iter_17_1, iter_17_0 == arg_17_0)
		end

		return
	end

	local var_16_1 = 1

	Timer = var_4
	arg_16_0.countdownTimer = var_4.New(function()
		var_16_1 = var_16_1 + 1

		if var_16_1 > 3 then
			setActive = var_0

			var_0(arg_16_0.countdownPanel, false)
			arg_16_1()
		else
			var_16_0(var_16_1)
		end

		return
	end, 1, 3)

	var_16_0(var_16_1)

	pg = var_4

	local var_16_2 = var_4.CriMgr.GetInstance()
	local var_16_3 = var_4.PlaySoundEffect_V3

	FushunAdventureGameConst = var_7

	var_16_3(var_16_2, var_7.COUNT_DOWN_VOICE)

	local var_16_4 = arg_16_0.countdownTimer

	var_4.Start(var_16_4)

	return
end

function var_0_0.ShowHelpWindow(arg_19_0, arg_19_1)
	setActive = var_1_10002

	var_1_10002(arg_19_0.helpWindow, true)

	onButton = var_1_10002

	local var_19_0 = arg_19_0
	local var_19_1 = arg_19_0.helpWindow

	local function var_19_2()
		setActive = var_2_10000

		var_2_10000(arg_19_0.helpWindow, false)

		PlayerPrefs = var_2_10000

		local var_20_0 = var_2_10000.SetInt
		local var_20_1 = "FushunAdventureGame"

		getProxy = var_3
		PlayerProxy = var_2_10005

		local var_20_2 = var_3(var_2_10005)

		var_20_0(var_20_1 .. var_3.getRawData(var_20_2).id, 1)
		arg_19_1()

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_19_0, var_19_1, var_19_2, var_1_10007)

	return
end

function var_0_0.DisplayKey(arg_21_0)
	local function var_21_0(arg_22_0, arg_22_1)
		local var_22_0

		if not arg_22_1 or arg_22_1 == "" then
			var_22_0 = arg_21_0.btnSprites[1]
		elseif arg_22_1 == "A" then
			var_22_0 = arg_21_0.btnSprites[2]
		elseif arg_22_1 == "B" then
			var_22_0 = arg_21_0.btnSprites[3]
		end

		if arg_22_0.sprite ~= var_22_0 then
			arg_22_0.sprite = var_22_0
		end

		return
	end

	ipairs = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10002(arg_21_0.keys) do
		string = var_1_10007

		if not var_1_10007.sub(arg_21_0.key, iter_21_0, iter_21_0) then
			var_1_10007 = ""
		end

		var_21_0(iter_21_1, var_1_10007)
	end

	return
end

function var_0_0.DisplayeHearts(arg_23_0, arg_23_1)
	ipairs = var_1_10002

	for iter_23_0, iter_23_1 in var_1_10002(arg_23_0.hearts) do
		setActive = var_1_10007

		var_1_10007(iter_23_1, iter_23_0 <= arg_23_1)
	end

	return
end

function var_0_0.DisplayScore(arg_24_0)
	arg_24_0.scoreTxt.text = arg_24_0.score

	return
end

function var_0_0.DisplayeEnergy(arg_25_0, arg_25_1, arg_25_2)
	math = var_1_10003

	local var_25_0 = var_1_10003.min(1, arg_25_1 / arg_25_2)

	arg_25_0.energyBar.fillAmount = var_25_0

	local var_25_1 = arg_25_0.energyIcon.parent.rect.width * var_25_0 - arg_25_0.energyIcon.rect.width

	setAnchoredPosition = var_6

	local var_25_2 = arg_25_0.energyIcon
	local var_25_3 = {}

	math = var_1_10010
	var_25_3.x = var_1_10010.max(0, var_25_1)

	var_6(var_25_2, var_25_3)

	local var_25_4 = 0

	if 1 <= var_25_0 then
		tf = var_7
		var_25_4 = var_7(arg_25_0.energyBar.gameObject).rect.width
	elseif 0 < var_4 then
		var_25_4 = var_4
	end

	setActive = var_7

	var_7(arg_25_0.energyLight, var_25_0 >= 0.01)

	local var_25_5 = arg_25_0.energyLight

	Vector2 = var_25_2
	var_25_5.sizeDelta = var_25_2(var_25_4, arg_25_0.energyLight.sizeDelta.y)

	return
end

function var_0_0.SetGameStateCallback(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0._startCallback = arg_26_1
	arg_26_0._endCallback = arg_26_2

	return
end

function var_0_0.StartGame(arg_27_0)
	if arg_27_0.state ~= var_0_4 then
		return
	end

	if arg_27_0._startCallback then
		arg_27_0._startCallback()
	end

	arg_27_0.enemys = {}
	arg_27_0.hitList = {}
	arg_27_0.missFlags = {}
	arg_27_0.score = 0
	arg_27_0.combo = 0
	arg_27_0.pause = false
	FushunSchedule = var_1
	arg_27_0.schedule = var_1.New()
	FushunSchedule = var_1
	arg_27_0.specailSchedule = var_1.New()

	arg_27_0:LoadScene(function()
		local var_28_0 = arg_27_0

		var_0.EnterGame(var_28_0)

		pg = var_0

		local var_28_1 = var_0.BgmMgr.GetInstance()
		local var_28_2 = var_0.Push
		local var_28_3 = arg_27_0.__cname

		FushunAdventureGameConst = var_2_10004

		var_28_2(var_28_1, var_28_3, var_2_10004.GAME_BGM_NAME)

		return
	end)

	arg_27_0.state = var_0_5

	return
end

function var_0_0.LoadScene(arg_29_0, arg_29_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_30_0)
			if arg_29_0.gameUI then
				setActive = var_1

				var_1(arg_29_0.gameUI, true)
				arg_30_0()
			else
				local var_30_0 = arg_29_0

				var_1.loadPrefab(var_30_0, "ui/FushunAdventureGame", function(arg_31_0)
					arg_29_0.gameUI = arg_31_0

					local var_31_0 = arg_31_0.transform

					var_1.SetParent(var_31_0, arg_29_0._go.transform, false)

					local var_31_1 = arg_29_0

					var_1.InitGameUI(var_31_1)
					arg_30_0()

					return
				end)
			end

			return
		end,
		function(arg_32_0)
			local var_32_0 = arg_29_0

			var_1.DisplayeHearts(var_32_0, 3)

			local var_32_1 = arg_29_0

			var_1.DisplayScore(var_32_1)

			local var_32_2 = arg_29_0

			var_1.DisplayeEnergy(var_32_2, 0, 1)

			PlayerPrefs = var_1

			local var_32_3 = var_1.GetInt
			local var_32_4 = "FushunAdventureGame"

			getProxy = var_4
			PlayerProxy = var_2_10006

			local var_32_5 = var_4(var_2_10006)

			if not (var_32_3(var_32_4 .. var_4.getRawData(var_32_5).id, 0) > 0) then
				local var_32_6 = arg_29_0

				var_2.ShowHelpWindow(var_32_6, arg_32_0)
			else
				arg_32_0()
			end

			return
		end,
		function(arg_33_0)
			parallelAsync = var_2_10001

			var_2_10001({
				function(arg_34_0)
					local var_34_0 = arg_29_0

					var_1.EnterAnimation(var_34_0, arg_34_0)

					return
				end,
				function(arg_35_0)
					local var_35_0 = arg_29_0

					var_1.loadPrefab(var_35_0, "ui/fa_fushun", function(arg_36_0)
						local var_36_0 = arg_29_0

						FushunChar = var_4_10002
						var_36_0.fushun = var_4_10002.New(arg_36_0)

						local var_36_1 = arg_29_0.fushun
						local var_36_2 = var_1.SetPosition

						FushunAdventureGameConst = var_4

						var_36_2(var_36_1, var_4.FUSHUN_INIT_POSITION)

						local var_36_3 = arg_36_0.transform
						local var_36_4 = var_1.SetParent
						local var_36_5 = arg_29_0.gameUI.transform

						var_36_4(var_36_3, var_4.Find(var_36_5, "game"), false)
						arg_35_0()

						return
					end)

					return
				end
			}, arg_33_0)

			return
		end
	}, arg_29_1)

	return
end

function var_0_0.EnterGame(arg_37_0)
	if not arg_37_0.handle then
		UpdateBeat = var_1
		arg_37_0.handle = var_1:CreateListener(arg_37_0.UpdateGame, arg_37_0)
	end

	UpdateBeat = var_1

	var_1:AddListener(arg_37_0.handle)

	local var_37_0 = arg_37_0.lightTF

	Vector2 = var_1_10002
	FushunAdventureGameConst = var_4
	var_37_0.sizeDelta = var_1_10002(var_4.FUSHUN_ATTACK_RANGE, arg_37_0.lightTF.sizeDelta.y)

	local var_37_1 = arg_37_0.lightTF

	Vector2 = var_2
	FushunAdventureGameConst = var_4

	local var_37_2 = var_4.FUSHUN_ATTACK_DISTANCE
	local var_37_3 = arg_37_0.fushun

	var_37_1.localPosition = var_2(var_37_2 + var_5.GetPosition(var_37_3).x, arg_37_0.lightTF.localPosition.y)

	arg_37_0:SpawnEnemys()
	arg_37_0:RegisterEventListener()

	arg_37_0.key = ""

	local var_37_4 = arg_37_0.fushun

	var_1.SetOnAnimEnd(var_37_4, function()
		arg_37_0.key = ""

		local var_38_0 = arg_37_0

		var_0.DisplayKey(var_38_0)

		return
	end)

	return
end

function var_0_0.UpdateGame(arg_39_0)
	if arg_39_0.state == var_0_6 then
		arg_39_0:ExitGame(true)

		return
	end

	if not arg_39_0.pause then
		local var_39_0 = arg_39_0.spawner

		var_1.Update(var_39_0)
		arg_39_0:AddDebugInput()

		local var_39_1 = arg_39_0.fushun

		if var_1.IsDeath(var_39_1) then
			local var_39_2 = arg_39_0.fushun

			var_1.Die(var_39_2)

			arg_39_0.state = var_0_6

			return
		else
			local var_39_3 = arg_39_0.fushun

			if var_1.ShouldInvincible(var_39_3) then
				arg_39_0:EnterInvincibleMode()
			else
				local var_39_4 = arg_39_0.fushun

				if var_1.ShouldVincible(var_39_4) then
					arg_39_0:ExitInvincibleMode()
				end
			end
		end

		local var_39_5 = false

		for iter_39_0 = #arg_39_0.enemys, 1, -1 do
			local var_39_6 = arg_39_0.enemys[iter_39_0]

			if var_6.IsFreeze(var_39_6) then
				-- block empty
			elseif arg_39_0:CheckEnemyDeath(iter_39_0) then
				-- block empty
			else
				var_6:Move()
				arg_39_0:CheckCollision(arg_39_0.fushun, var_6)

				if arg_39_0:CheckAttackRange(var_6) then
					var_39_5 = true
				end
			end
		end

		arg_39_0:RangeLightDisplay(var_39_5)

		local var_39_7 = arg_39_0
		local var_39_8 = arg_39_0.DisplayeEnergy
		local var_39_9 = arg_39_0.fushun
		local var_39_10 = var_5.GetEnergy(var_39_9)
		local var_39_11 = arg_39_0.fushun

		var_39_8(var_39_7, var_39_10, var_6.GetEnergyTarget(var_39_11))

		local var_39_12 = arg_39_0.specailSchedule

		var_2.Update(var_39_12)
	else
		for iter_39_1 = #arg_39_0.enemys, 1, -1 do
			arg_39_0:CheckEnemyDeath(iter_39_1)
		end
	end

	local var_39_13 = arg_39_0.schedule

	var_1.Update(var_39_13)

	return
end

function var_0_0.RangeLightDisplay(arg_40_0, arg_40_1)
	setActive = var_1_10002

	var_1_10002(arg_40_0.lightMark, arg_40_1)

	return
end

function var_0_0.CheckAttackRange(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0.fushun

	return arg_41_1:GetPosition().x <= var_41_0:GetAttackPosition().x
end

function var_0_0.CheckEnemyDeath(arg_42_0, arg_42_1)
	local var_42_0 = false
	local var_42_1 = arg_42_0.enemys[arg_42_1]

	if var_3.IsDeath(var_42_1) then
		if arg_42_0.hitList[var_3.index] and not var_3:IsEscape() then
			arg_42_0:AddScore(var_3:GetScore())
			arg_42_0:AddEnergy(var_3:GetEnergyScore())
		end

		var_3:Vanish()

		table = var_4

		var_4.remove(arg_42_0.enemys, arg_42_1)

		var_42_0 = true
	end

	return var_42_0
end

function var_0_0.EnterInvincibleMode(arg_43_0)
	FushunAdventureGameConst = var_1_10001

	local var_43_0 = var_1_10001.EX_TIP_TIME

	FushunAdventureGameConst = var_1_10002

	local var_43_1 = var_1_10002.EX_TIME
	local var_43_2 = arg_43_0.fushun

	var_3.Invincible(var_43_2)

	setActive = var_3

	var_3(arg_43_0.exTipPanel, true)

	arg_43_0.pause = true
	blinkAni = var_3

	var_3(arg_43_0.energyBar.gameObject, 0.5, -1)

	local var_43_3 = arg_43_0.schedule

	var_3.AddSchedule(var_43_3, var_43_0, 1, function()
		setActive = var_2_10000

		var_2_10000(arg_43_0.exTipPanel, false)

		local var_44_0 = arg_43_0.spawner

		var_0.CarzyMode(var_44_0)

		arg_43_0.pause = false

		local var_44_1 = arg_43_0.fushun

		var_0.StartAction(var_44_1, "EX")

		pg = var_0

		local var_44_2 = var_0.CriMgr.GetInstance()
		local var_44_3 = var_0.PlaySoundEffect_V3

		FushunAdventureGameConst = var_3

		var_44_3(var_44_2, var_3.ENTER_EX_VOICE)

		local var_44_4 = arg_43_0.fushun
		local var_44_5 = var_0.GetEnergyTarget(var_44_4) / var_43_1
		local var_44_6 = arg_43_0.specailSchedule

		var_2.AddSchedule(var_44_6, 1, var_43_1, function()
			local var_45_0 = arg_43_0.fushun

			var_0.ReduceEnergy(var_45_0, var_44_5)

			return
		end)

		return
	end)

	setActive = var_3

	var_3(arg_43_0.btnAExEffect, true)

	setActive = var_3

	var_3(arg_43_0.btnBExEffect, true)

	arg_43_0.key = ""

	arg_43_0:DisplayKey()

	return
end

function var_0_0.ExitInvincibleMode(arg_46_0)
	local var_46_0 = arg_46_0.fushun

	var_1.Vincible(var_46_0)

	local var_46_1 = arg_46_0.energyBar

	Color = var_1_10002
	var_46_1.color = var_1_10002.New(1, 1, 1, 1)
	LeanTween = var_46_1

	var_46_1.cancel(arg_46_0.energyBar.gameObject)

	ipairs = var_1

	for iter_46_0, iter_46_1 in var_1(arg_46_0.enemys) do
		arg_46_0.hitList[iter_46_1.index] = nil

		iter_46_1:Die()
	end

	local var_46_2 = arg_46_0.spawner

	var_1.NormalMode(var_46_2)

	setActive = var_1

	var_1(arg_46_0.btnAExEffect, false)

	setActive = var_1

	var_1(arg_46_0.btnBExEffect, false)

	return
end

function var_0_0.CheckCollision(arg_47_0, arg_47_1, arg_47_2)
	if var_0_0.IsCollision(arg_47_2.effectCollider2D, arg_47_1.collider2D) then
		arg_47_1:Hurt()
		arg_47_2:OnHit()

		local var_47_0 = arg_47_0
		local var_47_1 = arg_47_0.DisplayeHearts
		local var_47_2 = arg_47_0.fushun

		var_47_1(var_47_0, var_6.GetHp(var_47_2))
		arg_47_0:AddCombo(-arg_47_0.combo)
	else
		local var_47_3 = arg_47_0.fushun

		if var_3.InvincibleState(var_47_3) and not arg_47_2:IsDeath() and arg_47_2:GetPosition().x <= arg_47_1:GetAttackPosition().x then
			arg_47_2:Hurt(1)

			arg_47_0.hitList[arg_47_2.index] = true

			arg_47_0:AddHitEffect(arg_47_2)
		elseif var_0_0.IsNearby(arg_47_1:GetPosition(), arg_47_2:GetAttackPosition()) then
			arg_47_2:Attack()
		end
	end

	return
end

function var_0_0.AddHitEffect(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_0.fushun.effectCollider2D.bounds.center
	local var_48_1 = arg_48_0.gameUI.transform
	local var_48_2 = var_3.InverseTransformPoint(var_48_1, var_48_0)
	local var_48_3 = arg_48_1.collider2D.bounds
	local var_48_4 = var_4.GetMin(var_48_3)
	local var_48_5 = arg_48_0.gameUI.transform
	local var_48_6 = var_5.InverseTransformPoint(var_48_5, var_48_4)

	Vector3 = var_48_3

	local var_48_7 = var_48_3(var_48_6.x, var_48_2.y, 0)

	arg_48_0:loadPrefab("ui/fa_attack_effect", function(arg_49_0)
		local var_49_0 = arg_49_0.transform

		var_1.SetParent(var_49_0, arg_48_0.gameUI.transform, false)

		arg_49_0.transform.localPosition = var_48_7

		local var_49_1 = arg_49_0
		local var_49_2 = arg_49_0.GetComponent

		typeof = var_4
		DftAniEvent = var_2_10006

		local var_49_3 = var_49_2(var_49_1, var_4(var_2_10006))

		var_1.SetEndEvent(var_49_3, function()
			local var_50_0 = var_0

			var_0.SetEndEvent(var_50_0, nil)

			if arg_49_0 then
				Destroy = var_0

				var_0(arg_49_0)
			end

			return
		end)

		return
	end)
	arg_48_0:ShakeScreen(arg_48_0.gameUI)

	return
end

function var_0_0.ShakeScreen(arg_51_0, arg_51_1)
	LeanTween = var_1_10002

	if var_1_10002.isTweening(arg_51_1) then
		LeanTween = var_2

		var_2.cancel(arg_51_1)
	end

	LeanTween = var_2

	local var_51_0 = var_2.rotateAroundLocal
	local var_51_1 = arg_51_1

	Vector3 = var_1_10005

	local var_51_2 = var_1_10005(0, 0, 1)

	FushunAdventureGameConst = var_1_10006

	local var_51_3 = var_1_10006.SHAKE_RANGE

	FushunAdventureGameConst = var_7

	local var_51_4 = var_51_0(var_51_1, var_51_2, var_51_3, var_7.SHAKE_TIME)
	local var_51_5 = var_2.setLoopPingPong

	FushunAdventureGameConst = var_51_2

	local var_51_6 = var_51_5(var_51_4, var_51_2.SHAKE_LOOP_CNT)
	local var_51_7 = var_2.setFrom

	FushunAdventureGameConst = var_5

	local var_51_8 = var_51_7(var_51_6, -1 * var_5.SHAKE_RANGE)
	local var_51_9 = var_2.setOnComplete

	System = var_5

	var_51_9(var_51_8, var_5.Action(function()
		local var_52_0 = arg_51_1.transform

		Vector3 = var_2_10001
		var_52_0.localEulerAngles = var_2_10001(0, 0, 0)

		return
	end))

	return
end

function var_0_0.SpawnEnemys(arg_53_0)
	local var_53_0 = {}

	FushunBeastChar = var_1_10002
	var_53_0[1] = var_1_10002
	FushunEliteBeastChar = var_1_10002
	var_53_0[2] = var_1_10002
	FushunEliteBeastChar = var_1_10002
	var_53_0[3] = var_1_10002

	local function var_53_1(arg_54_0)
		FushunAdventureGameConst = var_2_10001

		local var_54_0 = var_2_10001.SPEED_ADDITION
		local var_54_1

		ipairs = var_2_10003

		for iter_54_0, iter_54_1 in var_2_10003(var_54_0) do
			local var_54_2 = iter_54_1[1][1]
			local var_54_3 = iter_54_1[1][2]

			if var_54_2 <= arg_54_0 and arg_54_0 <= var_54_3 then
				var_54_1 = iter_54_1

				break
			end
		end

		var_54_1 = var_54_1 or var_54_0[#var_54_0]

		return var_54_1[2]
	end

	local function var_53_2(arg_55_0)
		local var_55_0 = arg_55_0.config
		local var_55_1 = arg_55_0.speed
		local var_55_2 = arg_55_0.index
		local var_55_3 = var_53_0[var_55_0.id].New(arg_55_0.go, var_55_2, var_55_0)
		local var_55_4 = var_55_1 + var_53_1(arg_53_0.score)

		var_0_0.LOG("  顺序 :", var_55_2, " id :", var_55_0.id, " speed :", var_55_4)
		var_55_3:SetSpeed(var_55_4)

		local var_55_5 = var_55_3
		local var_55_6 = var_55_3.SetPosition

		FushunAdventureGameConst = var_10

		var_55_6(var_55_5, var_10.ENEMY_SPAWN_POSITION)

		table = var_55_6

		var_55_6.insert(arg_53_0.enemys, var_55_3)

		return
	end

	FuShunEnemySpawner = var_1_10004

	local var_53_3 = var_1_10004.New
	local var_53_4 = arg_53_0.gameUI.transform

	arg_53_0.spawner = var_53_3(var_6.Find(var_53_4, "game").transform, var_53_2)

	local var_53_5 = arg_53_0.spawner

	var_4.NormalMode(var_53_5)

	return
end

function var_0_0.AddScore(arg_56_0, arg_56_1)
	arg_56_0:AddCombo(1)

	local var_56_0 = arg_56_0.combo

	FushunAdventureGameConst = var_1_10003

	if var_56_0 >= var_1_10003.COMBO_SCORE_TARGET then
		FushunAdventureGameConst = var_56_0

		local var_56_1

		if not var_56_0.COMBO_EXTRA_SCORE then
			var_56_1 = 0
		end

		arg_56_0.score = arg_56_0.score + arg_56_1 + var_56_1

		arg_56_0:DisplayScore()

		local var_56_2 = arg_56_0.spawner

		var_3.UpdateScore(var_56_2, arg_56_0.score)

		return
	end
end

function var_0_0.AddEnergy(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0.fushun

	var_2.AddEnergy(var_57_0, arg_57_1)

	return
end

function var_0_0.AddCombo(arg_58_0, arg_58_1)
	if arg_58_1 > 0 then
		arg_58_0:loadPrefab("UI/fushun_combo", function(arg_59_0)
			local var_59_0 = arg_59_0.transform
			local var_59_1 = var_1.SetParent
			local var_59_2 = arg_58_0.gameUI.transform

			var_59_1(var_59_0, var_4.Find(var_59_2, "UI"), false)

			local var_59_3

			Timer = var_2_10002

			local var_59_4 = var_2_10002.New(function()
				if arg_59_0 then
					Destroy = var_0

					var_0(arg_59_0)
				end

				if var_59_3 then
					local var_60_0 = var_59_3

					var_0.Stop(var_60_0)

					var_59_3 = nil
				end

				return
			end, 1, 1)

			var_59_3.Start(var_59_4)

			return
		end)
	end

	arg_58_0.combo = arg_58_0.combo + arg_58_1

	local var_58_0 = arg_58_0.comboTxt

	var_58_0.text = arg_58_0.combo
	setActive = var_58_0

	var_58_0(arg_58_0.comboTxt.gameObject.transform.parent, arg_58_0.combo > 0)

	return
end

function var_0_0.Action(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0.fushun

	if var_2.InvincibleState(var_61_0) then
		local var_61_1 = arg_61_0
		local var_61_2 = arg_61_0.AddScore

		FushunAdventureGameConst = var_1_10005

		var_61_2(var_61_1, var_1_10005.EX_CLICK_SCORE)
	else
		arg_61_0:OnFushunAttack(arg_61_1)
	end

	return
end

function var_0_0.OnFushunAttack(arg_62_0, arg_62_1)
	if #arg_62_0.key ~= 3 then
		local var_62_0 = arg_62_0.fushun

		if not var_2.IsMissState(var_62_0) then
			local var_62_1 = arg_62_0.fushun

			if var_2.IsDamageState(var_62_1) then
				return
			end

			arg_62_0.key = arg_62_0.key .. arg_62_1

			local var_62_2 = arg_62_0

			arg_62_0.DisplayKey(var_62_2)

			local var_62_3 = {}
			local var_62_4 = arg_62_0.fushun

			ipairs = var_62_2

			for iter_62_0, iter_62_1 in var_62_2(arg_62_0.enemys) do
				if not iter_62_1:WillDeath() and iter_62_1:GetPosition().x <= var_62_4:GetAttackPosition().x then
					table = var_9

					var_9.insert(var_62_3, iter_62_0)
				end
			end

			local var_62_5 = arg_62_0.fushun

			var_4.TriggerAction(var_62_5, arg_62_0.key, function()
				if #var_62_3 == 0 then
					local var_63_0 = arg_62_0.fushun

					var_0.Miss(var_63_0)
				end

				arg_62_0.key = ""

				local var_63_1 = arg_62_0

				var_0.DisplayKey(var_63_1)

				return
			end)

			if #var_62_3 > 0 then
				ipairs = var_4

				for iter_62_2, iter_62_3 in var_4(var_62_3) do
					local var_62_6 = arg_62_0.enemys[iter_62_3]

					var_9.Hurt(var_62_6, 1)

					arg_62_0.hitList[var_9.index] = true

					arg_62_0:AddHitEffect(var_9)
				end
			end

			return
		end
	end
end

function var_0_0.PauseGame(arg_64_0)
	arg_64_0.pause = true

	return
end

function var_0_0.ResumeGame(arg_65_0)
	arg_65_0.pause = false

	return
end

function var_0_0.ExitGame(arg_66_0, arg_66_1)
	local function var_66_0()
		local var_67_0 = arg_66_0

		var_0.ClearGameScene(var_67_0)

		return
	end

	if arg_66_0.btnA then
		ClearEventTrigger = var_3

		local var_66_1 = arg_66_0.btnA

		var_3(var_5.GetComponent(var_66_1, "EventTriggerListener"))
	end

	if arg_66_0.btnB then
		ClearEventTrigger = var_3

		local var_66_2 = arg_66_0.btnB

		var_3(var_5.GetComponent(var_66_2, "EventTriggerListener"))
	end

	if arg_66_0.handle then
		UpdateBeat = var_3

		var_3:RemoveListener(arg_66_0.handle)

		arg_66_0.handle = nil
	end

	if arg_66_0.schedule then
		local var_66_3 = arg_66_0.schedule

		var_3.Dispose(var_66_3)

		arg_66_0.schedule = nil
	end

	if arg_66_0.specailSchedule then
		local var_66_4 = arg_66_0.specailSchedule

		var_3.Dispose(var_66_4)

		arg_66_0.specailSchedule = nil
	end

	if arg_66_1 then
		if arg_66_0.OnShowResult then
			arg_66_0.OnShowResult(arg_66_0.score)
		end

		arg_66_0:ShowResultWindow(function()
			var_66_0()

			return
		end)
	else
		var_66_0()
	end

	return
end

function var_0_0.ClearGameScene(arg_69_0)
	if arg_69_0.fushun then
		local var_69_0 = arg_69_0.fushun

		var_1.Destory(var_69_0)

		arg_69_0.fushun = nil
	end

	if arg_69_0.spawner then
		local var_69_1 = arg_69_0.spawner

		var_1.Dispose(var_69_1)

		arg_69_0.spawner = nil
	end

	if arg_69_0.enemys then
		ipairs = var_1

		for iter_69_0, iter_69_1 in var_1(arg_69_0.enemys) do
			iter_69_1:Dispose()
		end

		arg_69_0.enemys = nil
	end

	arg_69_0.state = var_0_4

	if arg_69_0.gameUI then
		arg_69_0:HideExitMsgbox()
		arg_69_0:HideResultWindow()
		arg_69_0:HidePauseMsgbox()

		setActive = var_1

		var_1(arg_69_0.gameUI, false)

		pg = var_1

		local var_69_2 = var_1.BgmMgr.GetInstance()
		local var_69_3 = var_1.Push
		local var_69_4 = arg_69_0.__cname

		FushunAdventureGameConst = iter_69_1

		var_69_3(var_69_2, var_69_4, iter_69_1.BGM_NAME)
	end

	if arg_69_0._endCallback then
		arg_69_0._endCallback()
	end

	return
end

function var_0_0.IsStarting(arg_70_0)
	return arg_70_0.state == var_0_5
end

function var_0_0.Dispose(arg_71_0)
	if arg_71_0.countdownTimer then
		local var_71_0 = arg_71_0.countdownTimer

		var_1.Stop(var_71_0)

		arg_71_0.countdownTimer = nil
	end

	arg_71_0._startCallback = nil
	arg_71_0._endCallback = nil

	arg_71_0:ExitGame()

	pg = var_1

	var_1.DelegateInfo.Dispose(arg_71_0)

	if arg_71_0.gameUI then
		Destroy = var_1

		var_1(arg_71_0.gameUI)

		arg_71_0.gameUI = nil
	end

	arg_71_0._go = nil
	arg_71_0.btnSprites = nil
	arg_71_0.state = var_0_2
	arg_71_0.OnShowResult = nil
	arg_71_0.OnLevelUpdate = nil

	return
end

function var_0_0.AddDebugInput(arg_72_0)
	IsUnityEditor = var_1_10001

	if var_1_10001 then
		Input = var_1_10001

		local var_72_0 = var_1_10001.GetKeyDown

		KeyCode = var_1_10003

		local var_72_1

		if var_72_0(var_1_10003.A) then
			var_72_1 = arg_72_0

			arg_72_0.OnShowBtnEffect(var_72_1, "A", true)
		end

		Input = var_1

		local var_72_2 = var_1.GetKeyUp

		KeyCode = var_72_1

		local var_72_3, var_72_4

		if var_72_2(var_72_1.A) then
			var_72_3 = arg_72_0

			arg_72_0.Action(var_72_3, "A")

			var_72_3 = arg_72_0

			arg_72_0.OnShowBtnEffect(var_72_3, "A", false)

			pg = var_72_4
			var_72_3 = var_72_4.CriMgr.GetInstance()
			var_72_4 = var_72_4.PlaySoundEffect_V3
			FushunAdventureGameConst = var_4

			var_72_4(var_72_3, var_4.A_BTN_VOICE)
		end

		Input = var_72_4

		local var_72_5 = var_72_4.GetKeyDown

		KeyCode = var_72_3

		local var_72_6

		if var_72_5(var_72_3.S) then
			var_72_6 = arg_72_0

			arg_72_0.OnShowBtnEffect(var_72_6, "B", true)
		end

		Input = var_1

		local var_72_7 = var_1.GetKeyUp

		KeyCode = var_72_6

		if var_72_7(var_72_6.S) then
			arg_72_0:Action("B")
			arg_72_0:OnShowBtnEffect("B", false)

			pg = var_1

			local var_72_8 = var_1.CriMgr.GetInstance()
			local var_72_9 = var_1.PlaySoundEffect_V3

			FushunAdventureGameConst = var_4

			var_72_9(var_72_8, var_4.B_BTN_VOICE)
		end
	end

	return
end

function var_0_0.RegisterEventListener(arg_73_0)
	local var_73_0 = arg_73_0.btnA
	local var_73_1 = var_1.GetComponent(var_73_0, "EventTriggerListener")

	var_1.AddPointDownFunc(var_73_1, function()
		local var_74_0 = arg_73_0

		var_0.OnShowBtnEffect(var_74_0, "A", true)

		return
	end)
	var_1:AddPointExitFunc(function()
		local var_75_0 = arg_73_0

		var_0.OnShowBtnEffect(var_75_0, "A", false)

		return
	end)
	var_1:AddPointUpFunc(function()
		if arg_73_0.pause then
			return
		end

		local var_76_0 = arg_73_0

		var_0.Action(var_76_0, "A")

		local var_76_1 = arg_73_0

		var_0.OnShowBtnEffect(var_76_1, "A", false)

		pg = var_0

		local var_76_2 = var_0.CriMgr.GetInstance()
		local var_76_3 = var_0.PlaySoundEffect_V3

		FushunAdventureGameConst = var_3

		var_76_3(var_76_2, var_3.A_BTN_VOICE)

		return
	end)

	local var_73_2 = arg_73_0.btnB
	local var_73_3 = var_2.GetComponent(var_73_2, "EventTriggerListener")

	var_2.AddPointDownFunc(var_73_3, function()
		local var_77_0 = arg_73_0

		var_0.OnShowBtnEffect(var_77_0, "B", true)

		return
	end)
	var_2:AddPointExitFunc(function()
		local var_78_0 = arg_73_0

		var_0.OnShowBtnEffect(var_78_0, "B", false)

		return
	end)
	var_2:AddPointUpFunc(function()
		if arg_73_0.pause then
			return
		end

		local var_79_0 = arg_73_0

		var_0.Action(var_79_0, "B")

		local var_79_1 = arg_73_0

		var_0.OnShowBtnEffect(var_79_1, "B", false)

		pg = var_0

		local var_79_2 = var_0.CriMgr.GetInstance()
		local var_79_3 = var_0.PlaySoundEffect_V3

		FushunAdventureGameConst = var_3

		var_79_3(var_79_2, var_3.B_BTN_VOICE)

		return
	end)

	onButton = var_3

	local var_73_4 = arg_73_0
	local var_73_5 = arg_73_0.pauseBtn

	local function var_73_6()
		local var_80_0 = arg_73_0

		var_0.ShowPauseMsgbox(var_80_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_3(var_73_4, var_73_5, var_73_6, var_1_10008)

	onButton = var_3

	local var_73_7 = arg_73_0
	local var_73_8 = arg_73_0.exitBtn

	local function var_73_9()
		local var_81_0 = arg_73_0

		var_0.ShowExitMsgbox(var_81_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_3(var_73_7, var_73_8, var_73_9, var_1_10008)

	return
end

function var_0_0.OnShowBtnEffect(arg_82_0, arg_82_1, arg_82_2)
	setActive = var_1_10003

	var_1_10003(arg_82_0["btn" .. arg_82_1 .. "Effect"], arg_82_2)

	return
end

function var_0_0.ShowResultWindow(arg_83_0, arg_83_1)
	setActive = var_1_10002

	var_1_10002(arg_83_0.resultPanel, true)

	onButton = var_1_10002

	local var_83_0 = arg_83_0
	local var_83_1 = arg_83_0.resultCloseBtn

	local function var_83_2()
		local var_84_0 = arg_83_0

		var_0.HideResultWindow(var_84_0)

		if arg_83_1 then
			arg_83_1()
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_83_0, var_83_1, var_83_2, var_1_10007)

	if arg_83_0.roomId then
		getProxy = var_2
		GameRoomProxy = var_83_0

		local var_83_3 = var_2(var_83_0)

		arg_83_0.highestScore = var_2.getRoomScore(var_83_3, arg_83_0.roomId)
	end

	arg_83_0.resultHighestScoreTxt.text = arg_83_0.highestScore
	arg_83_0.resultScoreTxt.text = arg_83_0.score

	if arg_83_0.score > arg_83_0.highestScore then
		arg_83_0.highestScore = arg_83_0.score
	end

	return
end

function var_0_0.HideResultWindow(arg_85_0)
	setActive = var_1_10001

	var_1_10001(arg_85_0.resultPanel, false)

	return
end

function var_0_0.ShowPauseMsgbox(arg_86_0)
	arg_86_0:PauseGame()

	setActive = var_1

	var_1(arg_86_0.msgboxPanel, true)

	setActive = var_1

	var_1(arg_86_0.pauseMsgboxWindow, true)

	setActive = var_1

	var_1(arg_86_0.exitMsgboxWindow, false)

	onButton = var_1

	local var_86_0 = arg_86_0
	local var_86_1 = arg_86_0.pauseMsgboxWindow
	local var_86_2 = var_4.Find(var_86_1, "continue_btn")

	local function var_86_3()
		local var_87_0 = arg_86_0

		var_0.ResumeGame(var_87_0)

		local var_87_1 = arg_86_0

		var_0.HidePauseMsgbox(var_87_1)

		return
	end

	SFX_PANEL = var_86_1

	var_1(var_86_0, var_86_2, var_86_3, var_86_1)

	return
end

function var_0_0.HidePauseMsgbox(arg_88_0)
	setActive = var_1_10001

	var_1_10001(arg_88_0.msgboxPanel, false)

	setActive = var_1_10001

	var_1_10001(arg_88_0.pauseMsgboxWindow, false)

	return
end

function var_0_0.ShowExitMsgbox(arg_89_0)
	arg_89_0:PauseGame()

	setActive = var_1

	var_1(arg_89_0.msgboxPanel, true)

	setActive = var_1

	var_1(arg_89_0.pauseMsgboxWindow, false)

	setActive = var_1

	var_1(arg_89_0.exitMsgboxWindow, true)

	onButton = var_1

	local var_89_0 = arg_89_0
	local var_89_1 = arg_89_0.exitMsgboxWindow
	local var_89_2 = var_4.Find(var_89_1, "cancel_btn")

	local function var_89_3()
		local var_90_0 = arg_89_0

		var_0.ResumeGame(var_90_0)

		local var_90_1 = arg_89_0

		var_0.HideExitMsgbox(var_90_1)

		return
	end

	SFX_PANEL = var_89_1

	var_1(var_89_0, var_89_2, var_89_3, var_89_1)

	onButton = var_1

	local var_89_4 = arg_89_0
	local var_89_5 = arg_89_0.exitMsgboxWindow
	local var_89_6 = var_4.Find(var_89_5, "confirm_btn")

	local function var_89_7()
		local var_91_0 = arg_89_0

		var_0.HideExitMsgbox(var_91_0)

		if arg_89_0.OnShowResult then
			arg_89_0.OnShowResult(arg_89_0.score)
		end

		local var_91_1 = arg_89_0

		var_0.ExitGame(var_91_1)

		return
	end

	SFX_PANEL = var_89_5

	var_1(var_89_4, var_89_6, var_89_7, var_89_5)

	return
end

function var_0_0.HideExitMsgbox(arg_92_0)
	setActive = var_1_10001

	var_1_10001(arg_92_0.msgboxPanel, false)

	setActive = var_1_10001

	var_1_10001(arg_92_0.exitMsgboxWindow, false)

	return
end

function var_0_0.IsCollision(arg_93_0, arg_93_1)
	local var_93_1

	if arg_93_0.enabled and arg_93_1.enabled and arg_93_0.gameObject.activeSelf then
		local var_93_0 = arg_93_0.bounds

		var_93_1 = var_2.Intersects(var_93_0, arg_93_1.bounds)
	end

	return var_93_1
end

function var_0_0.IsNearby(arg_94_0, arg_94_1)
	return arg_94_1.x - arg_94_0.x <= 0
end

function var_0_0.LOG(...)
	if var_0_1 then
		print = var_0

		var_0(...)
	end

	return
end

return var_0_0
