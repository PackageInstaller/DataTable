class = var_0_10000

local var_0_0 = var_0_10000("PileGameView")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.controller = arg_1_1

	return
end

function var_0_0.SetUI(arg_2_0, arg_2_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_2_0)

	arg_2_0._go = arg_2_1
	tf = var_2
	arg_2_0._tf = var_2(arg_2_1)

	local var_2_0 = arg_2_0._tf

	arg_2_0.bg = var_2.Find(var_2_0, "AD")

	local var_2_1 = arg_2_0._tf

	arg_2_0.curtainTF = var_2.Find(var_2_1, "AD/curtain")

	local var_2_2 = arg_2_0.curtainTF
	local var_2_3 = var_2.Find(var_2_2, "Text")
	local var_2_4 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_2_0.countDown = var_2_4(var_2_3, var_5(var_1_10007))

	local var_2_5 = arg_2_0._tf

	arg_2_0.itemTpl = var_2.Find(var_2_5, "AD/item")

	local var_2_6 = arg_2_0._tf

	arg_2_0.groundTpl = var_2.Find(var_2_6, "AD/ground")

	local var_2_7 = arg_2_0._tf

	arg_2_0.gameContainer = var_2.Find(var_2_7, "AD/game")

	local var_2_8 = arg_2_0._tf

	arg_2_0.itemsContainer = var_2.Find(var_2_8, "AD/game/items")

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_2.Find(var_2_9, "AD/score_panel/Text")
	local var_2_11 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_2_0.scoreTxt = var_2_11(var_2_10, var_5(var_1_10007))

	local var_2_12 = {}
	local var_2_13 = arg_2_0._tf

	var_2_12[1] = var_3.Find(var_2_13, "AD/score_panel/heart1")

	local var_2_14 = arg_2_0._tf

	var_2_12[2] = var_3.Find(var_2_14, "AD/score_panel/heart2")

	local var_2_15 = arg_2_0._tf

	var_2_12[3] = var_3.Find(var_2_15, "AD/score_panel/heart3")
	arg_2_0.heats = var_2_12

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_2.Find(var_2_16, "AD/npc/manjuu")
	local var_2_18 = var_2.GetComponent

	typeof = var_5
	Animator = var_1_10007
	arg_2_0.manjuuAnim = var_2_18(var_2_17, var_5(var_1_10007))

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_2.Find(var_2_19, "AD/npc/aniki")
	local var_2_21 = var_2.GetComponent

	typeof = var_5
	Animator = var_1_10007
	arg_2_0.anikiAnim = var_2_21(var_2_20, var_5(var_1_10007))

	local var_2_22 = arg_2_0._tf

	arg_2_0.manjuuPilot = var_2.Find(var_2_22, "AD/npc/manjuu_pilot")

	local var_2_23 = arg_2_0._tf

	arg_2_0.backBtn = var_2.Find(var_2_23, "AD/back")

	local var_2_24 = arg_2_0._tf

	arg_2_0.exitPanel = var_2.Find(var_2_24, "AD/exit_panel")

	local var_2_25 = arg_2_0.exitPanel

	arg_2_0.exitPanelConfirmBtn = var_2.Find(var_2_25, "frame/confirm")

	local var_2_26 = arg_2_0.exitPanel

	arg_2_0.exitPanelCancelBtn = var_2.Find(var_2_26, "frame/cancel")

	local var_2_27 = arg_2_0._tf

	arg_2_0.resultPanel = var_2.Find(var_2_27, "AD/result")

	local var_2_28 = arg_2_0.resultPanel

	arg_2_0.endGameBtn = var_2.Find(var_2_28, "frame/endGame")

	local var_2_29 = arg_2_0.resultPanel
	local var_2_30 = var_2.Find(var_2_29, "frame/score/Text")
	local var_2_31 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_2_0.finalScoreTxt = var_2_31(var_2_30, var_5(var_1_10007))

	local var_2_32 = arg_2_0.resultPanel
	local var_2_33 = var_2.Find(var_2_32, "frame/highestscore/Text")
	local var_2_34 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_2_0.highestScoreText = var_2_34(var_2_33, var_5(var_1_10007))

	local var_2_35 = arg_2_0._tf

	arg_2_0.itemIndexTF = var_2.Find(var_2_35, "AD/score_panel/index/target")

	local var_2_36 = arg_2_0._tf

	arg_2_0.overviewPanel = var_2.Find(var_2_36, "overview")

	local var_2_37 = arg_2_0._tf

	arg_2_0.startBtn = var_2.Find(var_2_37, "overview/start")

	local var_2_38 = arg_2_0._tf

	arg_2_0.helpBtn = var_2.Find(var_2_38, "overview/help")

	local var_2_39 = arg_2_0._tf

	arg_2_0.deathLine = var_2.Find(var_2_39, "death_line")

	local var_2_40 = arg_2_0._tf

	arg_2_0.safeLine = var_2.Find(var_2_40, "safe_line")

	local var_2_41 = arg_2_0._tf

	arg_2_0.itemCollider = var_2.Find(var_2_41, "item_collider")
	arg_2_0.items = {}
	PileGameBgMgr = var_2

	local var_2_42 = var_2.New
	local var_2_43 = arg_2_0._tf

	arg_2_0.bgMgr = var_2_42(var_4.Find(var_2_43, "AD/bgs"))

	return
end

function var_0_0.OnEnterGame(arg_3_0, arg_3_1)
	arg_3_0.viewData = arg_3_1

	local var_3_0

	if not arg_3_0.viewData.tip or not arg_3_0.viewData.tip then
		var_3_0 = nil
	end

	arg_3_0.gameHelpTip = var_3_0
	setActive = var_3_0

	var_3_0(arg_3_0.overviewPanel, true)

	setActive = var_3_0

	var_3_0(arg_3_0.bg, false)

	onButton = var_3_0

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.startBtn

	local function var_3_3()
		local var_4_0 = arg_3_0.controller

		var_0.StartGame(var_4_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_3_0(var_3_1, var_3_2, var_3_3, var_1_10007)

	onButton = var_3_0

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.helpBtn

	local function var_3_6()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_5_2.type = var_2_10004

		local var_5_3

		if not arg_3_0.gameHelpTip then
			pg = var_5_3
			var_5_3 = var_5_3.gametip.pile_game_notice.tip
		end

		var_5_2.helps = var_5_3

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_1_10007

	var_3_0(var_3_4, var_3_5, var_3_6, var_1_10007)

	onButton = var_3_0

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.backBtn

	local function var_3_9()
		local var_6_0 = arg_3_0

		var_0.ShowExitMsg(var_6_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_3_0(var_3_7, var_3_8, var_3_9, var_1_10007)

	return
end

function var_0_0.ShowExitMsg(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_7_0, arg_7_0.exitPanel)

	setActive = var_1

	var_1(arg_7_0.exitPanel, true)

	local function var_7_1()
		setActive = var_2_10000

		var_2_10000(arg_7_0.exitPanel, false)

		pg = var_2_10000

		local var_8_0 = var_2_10000.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_8_0, arg_7_0.exitPanel, arg_7_0.bg)

		return
	end

	onButton = var_1_10002

	local var_7_2 = arg_7_0
	local var_7_3 = arg_7_0.exitPanelCancelBtn
	local var_7_4 = var_7_1

	SFX_PANEL = var_1_10007

	var_1_10002(var_7_2, var_7_3, var_7_4, var_1_10007)

	onButton = var_1_10002

	local var_7_5 = arg_7_0
	local var_7_6 = arg_7_0.exitPanelConfirmBtn

	local function var_7_7()
		var_7_1()

		local var_9_0 = arg_7_0.controller

		var_0.OnEndGame(var_9_0, false)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_7_5, var_7_6, var_7_7, var_1_10007)

	return
end

function var_0_0.DoCurtain(arg_10_0, arg_10_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_11_0)
			local var_11_0 = arg_10_0.bgMgr

			var_1.Init(var_11_0, arg_11_0)

			return
		end,
		function(arg_12_0)
			setActive = var_2_10001

			var_2_10001(arg_10_0.overviewPanel, false)

			setActive = var_2_10001

			var_2_10001(arg_10_0.bg, true)

			setActive = var_2_10001

			var_2_10001(arg_10_0.curtainTF, true)

			setAnchoredPosition = var_2_10001

			var_2_10001(arg_10_0.anikiAnim.gameObject, {
				x = -177,
				y = 158
			})

			local var_12_0 = 4
			local var_12_1 = arg_10_0

			Timer = var_3
			var_12_1.timer = var_3.New(function()
				var_12_0 = var_12_0 - 1

				if var_12_0 == 3 then
					pg = var_0

					local var_13_0 = var_0.CriMgr.GetInstance()
					local var_13_1 = var_0.PlaySoundEffect_V3

					SFX_STEP_PILE_COUNTDOWN = var_3_10003

					var_13_1(var_13_0, var_3_10003)
				end

				arg_10_0.countDown.text = var_12_0

				if var_12_0 == 0 then
					setActive = var_0

					var_0(arg_10_0.curtainTF, false)
					arg_12_0()
				end

				return
			end, 1, 4)

			local var_12_2 = arg_10_0.timer

			var_2.Start(var_12_2)
			arg_10_0.timer.func()

			return
		end
	}, arg_10_1)

	return
end

function var_0_0.UpdateScore(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.scoreTxt.text = arg_14_1

	local var_14_0 = false

	if 0 < arg_14_1 then
		PileGameConst = var_4

		if arg_14_1 % var_4.LEVEL_TO_HAPPY_ANIM == 0 then
			local var_14_1 = arg_14_0.manjuuAnim

			var_4.SetTrigger(var_14_1, "happy")

			local var_14_2 = arg_14_0.anikiAnim

			var_4.SetTrigger(var_14_2, "nice")

			var_14_0 = true
		end
	end

	if arg_14_0.items[arg_14_2] and var_14_0 then
		var_1_10007 = var_4
		var_1_10007 = var_4.Find(var_1_10007, "anim")

		local var_14_3 = var_5.GetComponent

		typeof = var_8
		Animator = var_1_10010
		var_1_10007 = var_14_3(var_1_10007, var_8(var_1_10010))

		var_5.SetTrigger(var_1_10007, "win")
	elseif var_4 then
		var_1_10007 = var_4
		var_1_10007 = var_4.Find(var_1_10007, "anim")

		local var_14_4 = var_5.GetComponent

		typeof = var_8
		Animator = var_1_10010
		var_1_10007 = var_14_4(var_1_10007, var_8(var_1_10010))

		var_5.SetTrigger(var_1_10007, "idle")
	end

	if arg_14_2 then
		local var_14_5 = arg_14_2.position.x
		local var_14_6 = arg_14_0.itemIndexTF

		Vector3 = var_1_10007
		PileGameConst = var_1_10009
		var_14_6.localPosition = var_1_10007(var_14_5 / var_1_10009.RATIO, 0, 0)
		pg = var_14_6

		local var_14_7 = var_14_6.CriMgr.GetInstance()
		local var_14_8 = var_6.PlaySoundEffect_V3

		SFX_STEP_PILE_SUCCESS = var_9

		var_14_8(var_14_7, var_9)
	end

	return
end

function var_0_0.UpdateFailedCnt(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	ipairs = var_1_10005

	for iter_15_0, iter_15_1 in var_1_10005(arg_15_0.heats) do
		setActive = var_1_10010

		var_1_10010(iter_15_1, arg_15_2 < iter_15_0)
	end

	if arg_15_3 then
		local var_15_0 = arg_15_0.anikiAnim

		var_5.SetTrigger(var_15_0, "miss")

		local var_15_1 = arg_15_0.items[arg_15_4]
		local var_15_2 = var_5.Find(var_15_1, "anim")
		local var_15_3 = var_6.GetComponent

		typeof = var_9
		Animator = var_1_10011

		local var_15_4 = var_15_3(var_15_2, var_9(var_1_10011))

		var_6.SetTrigger(var_15_4, "miss")
	end

	return
end

function var_0_0.AddPile(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local function var_16_0(arg_17_0)
		tf = var_2_10001

		local var_17_0 = var_2_10001(arg_17_0)

		SetParent = var_2_10002

		var_2_10002(var_17_0, arg_16_0.itemsContainer)

		var_17_0.sizeDelta = arg_16_1.sizeDelta
		var_17_0.pivot = arg_16_1.pivot
		go = var_2
		var_2(var_17_0).name = arg_16_1.name .. "_" .. arg_16_1.gname

		local var_17_1 = arg_16_0.items

		var_17_1[arg_16_1] = var_17_0
		Vector3 = var_17_1
		var_17_0.eulerAngles = var_17_1(0, 0, 0)

		local var_17_2 = arg_16_0

		var_2.OnItemPositionChange(var_17_2, arg_16_1)

		setActive = var_2

		var_2(var_17_0, not arg_16_2)

		local var_17_4

		if not arg_16_2 then
			local var_17_3 = var_17_0:Find("anim")

			var_17_4 = var_17_4.GetComponent
			typeof = var_5
			Animator = var_2_10007

			local var_17_5 = var_17_4(var_17_3, var_5(var_2_10007))

			var_17_4.SetTrigger(var_17_5, "exit")
		end

		PileGameConst = var_17_4

		if var_17_4.DEBUG then
			local var_17_6 = arg_16_0

			var_2.AddPileCollider(var_17_6, arg_16_1)
		end

		arg_16_3()

		return
	end

	PoolMgr = var_1_10005

	local var_16_1 = var_1_10005.GetInstance()

	var_5.GetPrefab(var_16_1, "Stacks/" .. arg_16_1.gname, arg_16_1.gname, true, var_16_0)

	return
end

function var_0_0.OnStartDrop(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_3 then
		local var_18_0 = arg_18_0.manjuuAnim
		local var_18_1 = var_4.SetBool
		local var_18_2 = "despair"

		PileGameController = var_1_10008

		var_18_1(var_18_0, var_18_2, var_1_10008.DROP_AREA_WARN == arg_18_2)
	else
		local var_18_3 = arg_18_0.manjuuAnim

		var_4.SetTrigger(var_18_3, "shock")
	end

	local var_18_4 = arg_18_0.items[arg_18_1]
	local var_18_5 = var_4.Find(var_18_4, "anim")
	local var_18_6 = var_5.GetComponent

	typeof = var_8
	Animator = var_1_10010

	local var_18_7 = var_18_6(var_18_5, var_8(var_1_10010))

	var_5.SetTrigger(var_18_7, "drop")

	return
end

function var_0_0.OnItemPositionChange(arg_19_0, arg_19_1)
	if arg_19_0.items[arg_19_1] then
		var_2.localPosition = arg_19_1.position
	end

	return
end

function var_0_0.OnItemPositionChangeWithAnim(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_0.items[arg_20_1] then
		LeanTween = var_1_10004

		local var_20_0 = var_1_10004.moveLocalY

		go = var_1_10006

		local var_20_1 = var_1_10006(var_3)
		local var_20_2 = arg_20_1.position.y

		PileGameConst = var_8

		local var_20_3 = var_20_0(var_20_1, var_20_2, var_8.SINK_TIME)
		local var_20_4 = var_4.setOnComplete

		System = var_20_2

		var_20_4(var_20_3, var_20_2.Action(arg_20_2))
	end

	return
end

function var_0_0.OnItemIndexPositionChange(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1.position.x
	local var_21_1 = arg_21_1.position.y
	local var_21_2

	if not arg_21_0.prevPosition then
		var_21_2 = arg_21_0.manjuuPilot.localPosition.x
	end

	arg_21_0.prevPosition = var_21_2

	local var_21_3 = 0
	local var_21_4 = 1

	if var_21_0 - arg_21_0.prevPosition <= 0 then
		var_21_3 = var_21_0 + 12
		var_21_4 = -1
	else
		var_21_3 = var_21_0 - 12
	end

	local var_21_5 = var_21_1 + arg_21_1.sizeDelta.y + arg_21_0.manjuuPilot.rect.height / 2
	local var_21_6 = arg_21_0.manjuuPilot

	Vector3 = var_1_10008
	var_21_6.localPosition = var_1_10008(var_21_3, var_21_5, 0)

	local var_21_7 = arg_21_0.manjuuPilot

	Vector3 = var_8
	var_21_7.localScale = var_8(var_21_4, 1, 1)
	arg_21_0.prevPosition = var_21_0

	return
end

function var_0_0.OnExceedingTheHighestScore(arg_22_0)
	local var_22_0 = arg_22_0.manjuuAnim

	var_1.SetTrigger(var_22_0, "satisfied")

	return
end

function var_0_0.DoSink(arg_23_0, arg_23_1, arg_23_2)
	getAnchoredPosition = var_1_10003

	local var_23_0 = var_1_10003(arg_23_0.anikiAnim.gameObject)

	LeanTween = var_1_10004

	local var_23_1 = var_1_10004.value
	local var_23_2 = arg_23_0.anikiAnim.gameObject
	local var_23_3 = var_23_0.y
	local var_23_4 = var_23_0.y - arg_23_1

	PileGameConst = var_1_10009

	local var_23_5 = var_23_1(var_23_2, var_23_3, var_23_4, var_1_10009.SINK_TIME)
	local var_23_6 = var_4.setOnUpdate

	System = var_23_3

	local var_23_7 = var_23_6(var_23_5, var_23_3.Action_float(function(arg_24_0)
		setAnchoredPosition = var_2_10001

		var_2_10001(arg_23_0.anikiAnim.gameObject, {
			y = arg_24_0
		})

		return
	end))
	local var_23_8 = var_4.setOnComplete

	System = var_7

	var_23_8(var_23_7, var_7.Action(arg_23_2))

	local var_23_9 = arg_23_0.bgMgr

	var_4.DoMove(var_23_9, arg_23_1)

	return
end

function var_0_0.OnRemovePile(arg_25_0, arg_25_1)
	if arg_25_0.items[arg_25_1] then
		PileGameConst = var_1_10003

		if var_1_10003.DEBUG then
			Destroy = var_3

			var_3(var_2:Find("collider").gameObject)
		end

		local var_25_0 = var_2:Find("anim")
		local var_25_1 = var_3.GetComponent

		typeof = var_6
		Animator = var_1_10008

		local var_25_2 = var_25_1(var_25_0, var_6(var_1_10008))

		var_3.SetTrigger(var_25_2, "exit")

		Vector3 = var_3
		var_2.eulerAngles = var_3(0, 0, 0)
		PoolMgr = var_3

		local var_25_3 = var_3.GetInstance()

		var_3.ReturnPrefab(var_25_3, "Stacks/" .. arg_25_1.gname, arg_25_1.gname, var_2.gameObject)

		arg_25_0.items[arg_25_1] = nil
	end

	return
end

function var_0_0.PlaySpeAction(arg_26_0, arg_26_1)
	if arg_26_0.items[arg_26_1] then
		if arg_26_1.speActionCount == 0 then
			return
		end

		math = var_1_10004

		local var_26_0 = var_1_10004.random(1, var_3) - 1 == 0 and "spe" or "spe" .. var_4
		local var_26_1 = var_2:Find("anim")
		local var_26_2 = var_6.GetComponent

		typeof = var_9
		Animator = var_1_10011

		local var_26_3 = var_26_2(var_26_1, var_9(var_1_10011))

		var_6.SetTrigger(var_26_3, var_26_0)
	end

	return
end

function var_0_0.OnGameStart(arg_27_0)
	onButton = var_1_10001

	local var_27_0 = arg_27_0
	local var_27_1 = arg_27_0.bg

	local function var_27_2()
		local var_28_0 = arg_27_0.controller

		var_0.Drop(var_28_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_27_0, var_27_1, var_27_2, var_1_10006)

	return
end

function var_0_0.OnGameExited(arg_29_0)
	setActive = var_1_10001

	var_1_10001(arg_29_0.overviewPanel, true)

	setActive = var_1_10001

	var_1_10001(arg_29_0.bg, false)

	local var_29_0 = arg_29_0.itemsContainer

	Vector3 = var_1_10002
	var_29_0.eulerAngles = var_1_10002(0, 0, 0)

	local var_29_1 = arg_29_0.itemsContainer

	Vector2 = var_2
	var_29_1.pivot = var_2(0.5, 0.5)

	local var_29_2 = arg_29_0.bgMgr

	var_1.Clear(var_29_2)

	PileGameConst = var_1

	if var_1.DEBUG then
		Destroy = var_1

		local var_29_3 = arg_29_0.gameContainer

		var_1(var_3.Find(var_29_3, "ground").gameObject)

		Destroy = var_1

		local var_29_4 = arg_29_0.gameContainer

		var_1(var_3.Find(var_29_4, "deathLineR").gameObject)

		Destroy = var_1

		local var_29_5 = arg_29_0.gameContainer

		var_1(var_3.Find(var_29_5, "deathLineL").gameObject)

		Destroy = var_1

		local var_29_6 = arg_29_0.gameContainer

		var_1(var_3.Find(var_29_6, "safeLineL").gameObject)

		Destroy = var_1

		local var_29_7 = arg_29_0.gameContainer

		var_1(var_3.Find(var_29_7, "safeLineR").gameObject)
	end

	return
end

function var_0_0.OnGameEnd(arg_30_0, arg_30_1, arg_30_2)
	(function()
		pg = var_2_10000

		local var_31_0 = var_2_10000.UIMgr.GetInstance()

		var_0.BlurPanel(var_31_0, arg_30_0.resultPanel)

		setActive = var_0

		var_0(arg_30_0.resultPanel, true)

		onButton = var_0

		var_0(arg_30_0, arg_30_0.endGameBtn, function()
			setActive = var_3_10000

			var_3_10000(arg_30_0.resultPanel, false)

			pg = var_3_10000

			local var_32_0 = var_3_10000.UIMgr.GetInstance()

			var_0.UnOverlayPanel(var_32_0, arg_30_0.resultPanel, arg_30_0.bg)

			local var_32_1 = arg_30_0.controller

			var_0.ExitGame(var_32_1)

			return
		end)

		arg_30_0.finalScoreTxt.text = arg_30_1
		arg_30_0.highestScoreText.text = arg_30_2

		return
	end)()

	return
end

function var_0_0.OnShake(arg_33_0, arg_33_1)
	getAnchoredPosition = var_1_10002

	local var_33_0 = var_1_10002(arg_33_0.anikiAnim)

	setAnchoredPosition = var_1_10003

	var_1_10003(arg_33_0.anikiAnim, {
		x = var_33_0.x + arg_33_1
	})

	return
end

function var_0_0.OnCollapse(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local function var_34_0(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
		LeanTween = var_2_10004

		local var_35_0 = var_2_10004.value

		go = var_2_10006

		local var_35_1 = var_35_0(var_2_10006(arg_34_0.itemsContainer), arg_35_0, arg_35_1, arg_35_2)
		local var_35_2 = var_4.setOnUpdate

		System = var_7

		local var_35_3 = var_35_2(var_35_1, var_7.Action_float(function(arg_36_0)
			local var_36_0 = arg_34_0.itemsContainer

			Vector3 = var_3_10002
			var_36_0.eulerAngles = var_3_10002(0, 0, arg_36_0)

			return
		end))
		local var_35_4 = var_4.setOnComplete

		System = var_7

		var_35_4(var_35_3, var_7.Action(arg_35_3))

		return
	end

	seriesAsync = var_1_10005

	var_1_10005({
		function(arg_37_0)
			local var_37_0 = arg_34_0.manjuuAnim

			var_1.SetTrigger(var_37_0, "shock")

			local var_37_1 = 0.5 + arg_34_1 / arg_34_0.itemsContainer.rect.width
			local var_37_2 = arg_34_0.itemsContainer

			Vector2 = var_4
			var_37_2.pivot = var_4(var_37_1, 0)

			local var_37_3 = arg_34_2 == 1 and -35 or 35

			var_34_0(0, var_37_3, 0.5, function()
				arg_37_0(var_37_3)

				return
			end)

			return
		end,
		function(arg_39_0, arg_39_1)
			local var_39_0 = {}

			_ = var_2_10003

			local var_39_1 = var_2_10003.values(arg_34_0.items)

			table = var_2_10004

			var_2_10004.sort(var_39_1, function(arg_40_0, arg_40_1)
				return arg_40_0.localPosition.y < arg_40_1.localPosition.y
			end)

			ipairs = var_4

			for iter_39_0, iter_39_1 in var_4(var_39_1) do
				table = var_2_10009

				var_2_10009.insert(var_39_0, function(arg_41_0)
					local var_41_0 = arg_34_2 == 1 and -90 or 90

					parallelAsync = var_3_10002

					var_3_10002({
						function(arg_42_0)
							var_34_0(arg_39_1, var_41_0, 1, arg_42_0)

							return
						end,
						function(arg_43_0)
							local var_43_0 = arg_34_2 == 1 and -356 or 356

							LeanTween = var_4_10002

							local var_43_1 = var_4_10002.value

							go = var_4_10004

							local var_43_2 = var_43_1(var_4_10004(iter_39_1), 0, var_43_0, 1)
							local var_43_3 = var_2.setOnUpdate

							System = var_5

							local var_43_4 = var_43_3(var_43_2, var_5.Action_float(function(arg_44_0)
								local var_44_0 = iter_39_1

								Vector3 = var_5_10002
								var_44_0.eulerAngles = var_5_10002(0, 0, arg_44_0)

								return
							end))
							local var_43_5 = var_2.setOnComplete

							System = var_5

							var_43_5(var_43_4, var_5.Action(arg_43_0))

							return
						end,
						function(arg_45_0)
							LeanTween = var_4_10001

							local var_45_0 = var_4_10001.moveLocalY

							go = var_4_10003

							local var_45_1 = var_45_0(var_4_10003(iter_39_1), iter_39_1.localPosition.y + 50 * iter_39_0, 1)
							local var_45_2 = var_1.setOnComplete

							System = var_4

							var_45_2(var_45_1, var_4.Action(arg_45_0))

							return
						end
					}, arg_41_0)

					return
				end)
			end

			parallelAsync = var_4

			var_4(var_39_0, arg_39_0)

			return
		end
	}, arg_34_3)

	return
end

function var_0_0.InitSup(arg_46_0, arg_46_1)
	PileGameConst = var_1_10002

	if var_1_10002.DEBUG then
		local var_46_0 = arg_46_1.ground

		cloneTplTo = var_1_10003

		local var_46_1 = var_1_10003(arg_46_0.groundTpl, arg_46_0.gameContainer, "ground")

		var_46_1.sizeDelta = var_46_0.sizeDelta
		var_46_1.pivot = var_46_0.pivot
		var_46_1.localPosition = var_46_0.position
		cloneTplTo = var_4

		local var_46_2 = var_4(arg_46_0.deathLine, arg_46_0.gameContainer, "deathLineR")

		Vector3 = var_5
		var_46_2.localPosition = var_5(arg_46_1.deathLine.y, 0, 0)
		cloneTplTo = var_5

		local var_46_3 = var_5(arg_46_0.deathLine, arg_46_0.gameContainer, "deathLineL")

		Vector3 = var_6
		var_46_3.localPosition = var_6(arg_46_1.deathLine.x, 0, 0)
		cloneTplTo = var_6

		local var_46_4 = var_6(arg_46_0.safeLine, arg_46_0.gameContainer, "safeLineL")

		Vector3 = var_7
		var_46_4.localPosition = var_7(arg_46_1.safeLine.x, 0, 0)
		cloneTplTo = var_7

		local var_46_5 = var_7(arg_46_0.safeLine, arg_46_0.gameContainer, "safeLineR")

		Vector3 = var_8
		var_46_5.localPosition = var_8(arg_46_1.safeLine.y, 0, 0)
	end

	return
end

function var_0_0.AddPileCollider(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_0.items[arg_47_1]

	cloneTplTo = var_1_10003

	local var_47_1 = var_1_10003(arg_47_0.itemCollider, var_47_0, "collider")
	local var_47_2 = arg_47_1.collider
	local var_47_3 = (0.5 - arg_47_1.pivot.x) * arg_47_1.sizeDelta.x + var_47_2.offset.x
	local var_47_4 = (0.5 - arg_47_1.pivot.y) * arg_47_1.sizeDelta.y + var_47_2.offset.y

	Vector3 = var_7
	var_47_1.localPosition = var_7(var_47_3, var_47_4, 0)
	var_47_1.sizeDelta = var_47_2.sizeDelta

	return
end

function var_0_0.onBackPressed(arg_48_0)
	isActive = var_1_10001

	if var_1_10001(arg_48_0.resultPanel) then
		setActive = var_1

		var_1(arg_48_0.resultPanel, false)

		pg = var_1

		local var_48_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_48_0, arg_48_0.resultPanel, arg_48_0.bg)

		local var_48_1 = arg_48_0.controller

		var_1.ExitGame(var_48_1)

		return true
	else
		isActive = var_1

		if var_1(arg_48_0.exitPanel) then
			setActive = var_1

			var_1(arg_48_0.exitPanel, false)

			pg = var_1

			local var_48_2 = var_1.UIMgr.GetInstance()

			var_1.UnOverlayPanel(var_48_2, arg_48_0.exitPanel, arg_48_0.bg)

			return true
		else
			isActive = var_1

			if var_1(arg_48_0.bg) then
				local var_48_3 = arg_48_0.controller

				var_1.ExitGame(var_48_3)

				if arg_48_0.timer then
					local var_48_4 = arg_48_0.timer

					var_1.Stop(var_48_4)

					arg_48_0.timer = nil
				end

				return true
			end
		end
	end

	return false
end

function var_0_0.Dispose(arg_49_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_49_0)

	if arg_49_0.timer then
		local var_49_0 = arg_49_0.timer

		var_1.Stop(var_49_0)

		arg_49_0.timer = nil
	end

	local var_49_1 = arg_49_0.bgMgr

	var_1.Clear(var_49_1)

	return
end

return var_0_0
