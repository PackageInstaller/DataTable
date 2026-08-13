class = var_0_10000

local var_0_0 = "Match3GameView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))
local var_0_2 = 6
local var_0_3 = 7
local var_0_4 = -405
local var_0_5 = -275
local var_0_6 = 135
local var_0_7 = 110
local var_0_8 = false
local var_0_9 = 0.1
local var_0_10 = 0
local var_0_11 = 0.3
local var_0_12 = 0.5
local var_0_13 = 100
local var_0_14 = 0.2
local var_0_15 = 0.4
local var_0_16 = 180
local var_0_17 = 60
local var_0_18 = 3
local var_0_19 = 2
local var_0_20 = 0.3
local var_0_21 = 0.3
local var_0_22 = 2.5
local var_0_23 = "event:/ui/ddldaoshu2"
local var_0_24 = "event:/ui/boat_drag"
local var_0_25 = "event:/ui/break_out_full"
local var_0_26 = "event:/ui/sx-good"
local var_0_27 = "event:/ui/sx-perfect"
local var_0_28 = "event:/ui/sx-jishu"
local var_0_29 = "event:/ui/furnitrue_save"

function var_0_1.getUIName(arg_1_0)
	return "Match3GameUI"
end

function var_0_1.getBGM(arg_2_0)
	return "backyard"
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.matchEffect = var_1.Find(var_3_0, "effects/sanxiaoxiaoshi")

	local var_3_1 = arg_3_0._tf

	arg_3_0.goodEffect = var_1.Find(var_3_1, "effects/sanxiaoGood")

	local var_3_2 = arg_3_0._tf

	arg_3_0.greatEffect = var_1.Find(var_3_2, "effects/sanxiaoGreat")

	local var_3_3 = arg_3_0._tf

	arg_3_0.perfectEffect = var_1.Find(var_3_3, "effects/sanxiaoPerfect")

	local var_3_4 = arg_3_0._tf

	arg_3_0.hintEffect = var_1.Find(var_3_4, "effects/hint")

	local var_3_5 = arg_3_0._tf

	arg_3_0.selectedEffect = var_1.Find(var_3_5, "effects/selected")

	local var_3_6 = arg_3_0._tf
	local var_3_7 = var_1.Find(var_3_6, "effects/whiten")

	arg_3_0.whitenMat = var_1.GetComponent(var_3_7, "Image").material

	local var_3_8 = arg_3_0._tf

	arg_3_0.backBtn = var_1.Find(var_3_8, "button/back")

	local var_3_9 = arg_3_0._tf

	arg_3_0.mainPage = var_1.Find(var_3_9, "main")

	local var_3_10 = arg_3_0._tf

	arg_3_0.startBtn = var_1.Find(var_3_10, "main/start")

	local var_3_11 = arg_3_0._tf

	arg_3_0.helpBtn = var_1.Find(var_3_11, "main/rule")

	local var_3_12 = arg_3_0._tf

	arg_3_0.countdownPage = var_1.Find(var_3_12, "countdown")

	local var_3_13 = arg_3_0._tf

	arg_3_0.countdownAnim = var_1.Find(var_3_13, "countdown")

	local var_3_14 = arg_3_0._tf

	arg_3_0.gamePage = var_1.Find(var_3_14, "game")

	local var_3_15 = arg_3_0._tf

	arg_3_0.gameMask = var_1.Find(var_3_15, "game/mask")

	local var_3_16 = arg_3_0._tf

	arg_3_0.warning = var_1.Find(var_3_16, "game/warning")

	local var_3_17 = arg_3_0._tf

	arg_3_0.countdownTf = var_1.Find(var_3_17, "game/countdown")

	local var_3_18 = arg_3_0._tf

	arg_3_0.countdownText = var_1.Find(var_3_18, "game/countdown/Text")

	local var_3_19 = arg_3_0._tf

	arg_3_0.inf = var_1.Find(var_3_19, "game/countdown/inf")

	local var_3_20 = arg_3_0._tf

	arg_3_0.scoreText = var_1.Find(var_3_20, "game/score/Text")

	local var_3_21 = arg_3_0._tf

	arg_3_0.floatText = var_1.Find(var_3_21, "game/floatText")
	arg_3_0.floatChar = {}

	local var_3_22 = arg_3_0._tf

	arg_3_0.pausePage = var_1.Find(var_3_22, "game/pause")

	local var_3_23 = arg_3_0._tf

	arg_3_0.pauseYes = var_1.Find(var_3_23, "game/pause/yes")

	local var_3_24 = arg_3_0._tf

	arg_3_0.pauseNo = var_1.Find(var_3_24, "game/pause/no")

	for iter_3_0 = 0, 9 do
		local var_3_25 = arg_3_0.floatChar
		local var_3_26 = arg_3_0._tf

		var_3_25[iter_3_0] = var_6.Find(var_3_26, "game/floatText/" .. iter_3_0)
	end

	local var_3_27 = arg_3_0._tf

	arg_3_0.tilesRoot = var_1.Find(var_3_27, "game/tiles")

	local var_3_28 = arg_3_0.tilesRoot

	arg_3_0.gameListener = var_1.GetComponent(var_3_28, "EventTriggerListener")

	local var_3_29 = arg_3_0.tilesRoot

	arg_3_0.longPressListener = var_1.GetComponent(var_3_29, "UILongPressTrigger")

	local var_3_30 = arg_3_0._tf

	arg_3_0.endPage = var_1.Find(var_3_30, "end")

	local var_3_31 = arg_3_0._tf

	arg_3_0.endBtn = var_1.Find(var_3_31, "end/end_btn")

	local var_3_32 = arg_3_0._tf

	arg_3_0.endScore = var_1.Find(var_3_32, "end/score/Text")

	local var_3_33 = arg_3_0._tf

	arg_3_0.newSign = var_1.Find(var_3_33, "end/score/Text/new")

	local var_3_34 = arg_3_0._tf

	arg_3_0.bestScore = var_1.Find(var_3_34, "end/highest/Text")

	local var_3_35 = {}
	local var_3_36 = arg_3_0._tf

	var_3_35[1] = var_2.Find(var_3_36, "tiles/Akashi")

	local var_3_37 = arg_3_0._tf

	var_3_35[2] = var_2.Find(var_3_37, "tiles/Ayanami")

	local var_3_38 = arg_3_0._tf

	var_3_35[3] = var_2.Find(var_3_38, "tiles/Javelin")

	local var_3_39 = arg_3_0._tf

	var_3_35[4] = var_2.Find(var_3_39, "tiles/Laffey")

	local var_3_40 = arg_3_0._tf

	var_3_35[5] = var_2.Find(var_3_40, "tiles/Z23")
	arg_3_0.tiles = var_3_35

	return
end

function var_0_1.onBackPressed(arg_4_0)
	isActive = var_1_10001

	if var_1_10001(arg_4_0.mainPage) then
		arg_4_0:emit(var_0_1.ON_BACK)
	else
		isActive = var_1

		if var_1(arg_4_0.pausePage) then
			triggerButton = var_1

			var_1(arg_4_0.pauseNo)
		else
			isActive = var_1

			if var_1(arg_4_0.gamePage) then
				arg_4_0:pause()
			else
				isActive = var_1

				if var_1(arg_4_0.endPage) then
					local var_4_0 = arg_4_0.endBtn

					if var_1.GetComponent(var_4_0, "Button").enabled then
						triggerButton = var_1

						var_1(arg_4_0.endBtn)
					end
				end
			end
		end
	end

	return
end

function var_0_1.didEnter(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.backBtn

	local function var_5_2()
		local var_6_0 = arg_5_0

		var_0.onBackPressed(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10006)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.startBtn, function()
		if var_0_8 then
			setActive = var_0

			var_0(arg_5_0.mainPage, false)

			setActive = var_0

			var_0(arg_5_0.gamePage, true)

			local var_7_0 = arg_5_0

			var_0.startGame(var_7_0)
		else
			local var_7_1 = arg_5_0.mainPage

			var_0.GetComponent(var_7_1, "CanvasGroup").blocksRaycasts = false

			local var_7_2 = arg_5_0
			local var_7_3 = var_0.managedTween

			LeanTween = var_3

			local var_7_4 = var_3.value

			local function var_7_5()
				local var_8_0 = arg_5_0.mainPage

				var_0.GetComponent(var_8_0, "CanvasGroup").alpha = 1

				local var_8_1 = arg_5_0.mainPage
				local var_8_2 = var_0.GetComponent(var_8_1, "CanvasGroup")

				var_8_2.blocksRaycasts = true
				setActive = var_8_2

				var_8_2(arg_5_0.mainPage, false)

				setActive = var_8_2

				var_8_2(arg_5_0.countdownPage, true)

				pg = var_8_2

				local var_8_3 = var_8_2.CriMgr.GetInstance()

				var_0.PlaySoundEffect_V3(var_8_3, var_0_23)

				return
			end

			go = var_2_10005

			local var_7_6 = var_7_3(var_7_2, var_7_4, var_7_5, var_2_10005(arg_5_0.mainPage), 1, 0, var_0_21)
			local var_7_7 = var_0.setOnUpdate

			System = var_7_4

			var_7_7(var_7_6, var_7_4.Action_float(function(arg_9_0)
				local var_9_0 = arg_5_0.mainPage

				var_1.GetComponent(var_9_0, "CanvasGroup").alpha = arg_9_0

				return
			end))
		end

		return
	end)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.helpBtn

	local function var_5_5()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_10_2.type = var_2_10004
		i18n = var_2_10004
		var_10_2.helps = var_2_10004("3match_tip")

		var_10_1(var_10_0, var_10_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10006)

	local var_5_6 = arg_5_0.countdownAnim
	local var_5_7 = var_1.GetComponent

	typeof = var_5_4
	DftAniEvent = var_1_10006

	local var_5_8 = var_5_7(var_5_6, var_5_4(var_1_10006))

	var_1.SetEndEvent(var_5_8, function(arg_11_0)
		setActive = var_2_10001

		var_2_10001(arg_5_0.countdownPage, false)

		setActive = var_2_10001

		var_2_10001(arg_5_0.gamePage, true)

		local var_11_0 = arg_5_0

		var_1.startGame(var_11_0)

		return
	end)

	onButton = var_2

	var_2(arg_5_0, arg_5_0.endBtn, function()
		local var_12_0 = arg_5_0.mainPage

		var_0.GetComponent(var_12_0, "CanvasGroup").blocksRaycasts = false

		local var_12_1 = arg_5_0
		local var_12_2 = var_0.managedTween

		LeanTween = var_3

		local var_12_3 = var_3.value

		local function var_12_4()
			local var_13_0 = arg_5_0.mainPage

			var_0.GetComponent(var_13_0, "CanvasGroup").alpha = 1

			local var_13_1 = arg_5_0.mainPage

			var_0.GetComponent(var_13_1, "CanvasGroup").blocksRaycasts = true

			return
		end

		go = var_2_10005

		local var_12_5 = var_12_2(var_12_1, var_12_3, var_12_4, var_2_10005(arg_5_0.endPage), 0, 1, var_0_21)
		local var_12_6 = var_0.setOnUpdate

		System = var_12_3

		var_12_6(var_12_5, var_12_3.Action_float(function(arg_14_0)
			local var_14_0 = arg_5_0.mainPage

			var_1.GetComponent(var_14_0, "CanvasGroup").alpha = arg_14_0

			return
		end))

		setActive = var_12_6

		var_12_6(arg_5_0.mainPage, true)

		setActive = var_12_6

		var_12_6(arg_5_0.countdownPage, false)

		setActive = var_12_6

		var_12_6(arg_5_0.gamePage, false)

		setActive = var_12_6

		var_12_6(arg_5_0.endPage, false)

		return
	end)

	onButton = var_2

	var_2(arg_5_0, arg_5_0.pauseYes, function()
		local var_15_0 = arg_5_0

		var_0.stopGame(var_15_0)

		return
	end)

	onButton = var_2

	var_2(arg_5_0, arg_5_0.pauseNo, function()
		setActive = var_2_10000

		var_2_10000(arg_5_0.pausePage, false)

		local var_16_0 = arg_5_0

		var_0.resumeGame(var_16_0)

		return
	end)

	local var_5_9 = false
	local var_5_10 = arg_5_0.gameListener

	var_3.AddPointClickFunc(var_5_10, function(arg_17_0, arg_17_1)
		if var_5_9 then
			var_5_9 = false

			return
		end

		if arg_5_0.updating then
			return
		end

		if not arg_5_0.inGame then
			return
		end

		LuaHelper = var_2

		local var_17_0 = var_2.ScreenToLocal
		local var_17_1 = arg_5_0.tilesRoot
		local var_17_2 = arg_17_1.position

		GameObject = var_2_10006

		local var_17_3 = var_2_10006.Find("UICamera")
		local var_17_4 = var_6.GetComponent

		typeof = var_2_10009
		Camera = var_2_10011

		local var_17_5 = var_17_0(var_17_1, var_17_2, var_17_4(var_17_3, var_2_10009(var_2_10011)))
		local var_17_6 = arg_5_0
		local var_17_7, var_17_8 = var_3.pos2index(var_17_6, var_17_5)

		if arg_5_0.selected then
			if arg_5_0.selected == arg_5_0.tileTfs[var_17_7][var_17_8] then
				local var_17_9 = arg_5_0

				var_5.unselect(var_17_9)
			else
				math = var_5

				local var_17_10 = var_5.abs(var_17_7 - arg_5_0.selectedIndex.i)

				math = var_6

				if var_17_10 + var_6.abs(var_17_8 - arg_5_0.selectedIndex.j) == 1 then
					local var_17_11 = arg_5_0

					var_5.tryMoveTo(var_17_11, {
						i = var_17_7,
						j = var_17_8
					})
				else
					local var_17_12 = arg_5_0

					var_5.select(var_17_12, var_17_7, var_17_8)
				end
			end
		else
			local var_17_13 = arg_5_0

			var_5.select(var_17_13, var_17_7, var_17_8)
		end

		return
	end)

	local var_5_11 = arg_5_0.longPressListener.onLongPressed

	var_3.AddListener(var_5_11, function()
		if arg_5_0.updating then
			return
		end

		if not arg_5_0.inGame then
			return
		end

		LuaHelper = var_0

		local var_18_0 = var_0.ScreenToLocal
		local var_18_1 = arg_5_0.tilesRoot

		Input = var_2_10003

		local var_18_2 = var_2_10003.mousePosition

		GameObject = var_2_10004

		local var_18_3 = var_2_10004.Find("UICamera")
		local var_18_4 = var_4.GetComponent

		typeof = var_2_10007
		Camera = var_2_10009

		local var_18_5 = var_18_0(var_18_1, var_18_2, var_18_4(var_18_3, var_2_10007(var_2_10009)))
		local var_18_6 = arg_5_0
		local var_18_7, var_18_8 = var_1.pos2index(var_18_6, var_18_5)
		local var_18_9 = arg_5_0

		var_3.unselect(var_18_9)

		local var_18_10 = arg_5_0

		var_3.animate(var_18_10, var_18_7, var_18_8, true)

		return
	end)

	local var_5_12 = arg_5_0.gameListener

	var_3.AddBeginDragFunc(var_5_12, function(arg_19_0, arg_19_1)
		if arg_5_0.updating then
			return
		end

		if not arg_5_0.inGame then
			return
		end

		var_5_9 = true

		local var_19_0 = arg_19_1.delta

		LuaHelper = var_2_10003

		local var_19_1 = var_2_10003.ScreenToLocal
		local var_19_2 = arg_5_0.tilesRoot
		local var_19_3 = arg_19_1.position

		GameObject = var_2_10007

		local var_19_4 = var_2_10007.Find("UICamera")
		local var_19_5 = var_7.GetComponent

		typeof = var_2_10010
		Camera = var_2_10012

		local var_19_6 = var_19_1(var_19_2, var_19_3, var_19_5(var_19_4, var_2_10010(var_2_10012)))
		local var_19_7 = arg_5_0
		local var_19_8, var_19_9 = var_4.pos2index(var_19_7, var_19_6)
		local var_19_10 = arg_5_0

		var_6.animate(var_19_10, var_19_8, var_19_9, false)

		local var_19_11 = arg_5_0

		var_6.unselect(var_19_11)

		arg_5_0.selected = arg_5_0.tileTfs[var_19_8][var_19_9]

		local var_19_12 = arg_5_0

		var_19_12.selectedIndex = {
			i = var_19_8,
			j = var_19_9
		}
		math = var_19_12

		local var_19_13 = var_19_12.abs(var_19_0.x)

		math = var_7

		if var_19_13 > var_7.abs(var_19_0.y) then
			var_19_8 = 0
			var_19_9 = var_19_0.x > 0 and 1 or -1
		else
			var_19_8 = var_19_0.y > 0 and 1 or -1
			var_19_9 = 0
		end

		local var_19_14 = arg_5_0

		var_6.tryMoveTo(var_19_14, {
			i = arg_5_0.selectedIndex.i + var_19_8,
			j = arg_5_0.selectedIndex.j + var_19_9
		})

		return
	end)

	setActive = var_3

	var_3(arg_5_0.mainPage, true)
	arg_5_0:updateData()

	return
end

function var_0_1.updateData(arg_20_0)
	arg_20_0.infinite = arg_20_0:GetMGHubData().count == 0

	local var_20_0 = arg_20_0:GetMGData()
	local var_20_1

	if not var_2.GetRuntimeData(var_20_0, "elements") or not var_2[1] then
		var_20_1 = 0
	end

	arg_20_0.best = var_20_1

	return
end

function var_0_1.index2pos(arg_21_0, arg_21_1, arg_21_2)
	Vector3 = var_1_10003

	return var_1_10003.New(var_0_4 + (arg_21_2 - 1) * var_0_6, var_0_5 + (arg_21_1 - 1) * var_0_7)
end

function var_0_1.pos2index(arg_22_0, arg_22_1)
	local var_22_0 = var_0_4 - var_0_6 / 2
	local var_22_1 = var_0_5 - var_0_7 / 2

	math = var_4

	local var_22_2 = var_4.ceil((arg_22_1.y - var_22_1) / var_0_7)

	math = var_1_10005

	local var_22_3 = var_1_10005.ceil((arg_22_1.x - var_22_0) / var_0_6)
end

function var_0_1.dropTime(arg_23_0)
	math = var_1_10001

	return var_1_10001.max(arg_23_0 * var_0_9, var_0_10)
end

function var_0_1.cancelHint(arg_24_0)
	if arg_24_0.hint then
		Destroy = var_1

		var_1(arg_24_0.hint)

		local var_24_0 = arg_24_0.hint1
		local var_24_1 = var_1.GetComponent(var_24_0, "Animator")

		var_1.SetBool(var_24_1, "selected", false)

		local var_24_2 = arg_24_0.hint2
		local var_24_3 = var_1.GetComponent(var_24_2, "Animator")

		var_1.SetBool(var_24_3, "selected", false)

		arg_24_0.hint = nil
		arg_24_0.hint1 = nil
		arg_24_0.hint2 = nil
	end

	return
end

local var_0_30 = {
	{
		0,
		1
	},
	{
		0,
		-1
	},
	{
		-1,
		0
	},
	{
		1,
		0
	}
}

function var_0_1.unselect(arg_25_0)
	if arg_25_0.selectedEffectTf then
		Destroy = var_1

		var_1(arg_25_0.selectedEffectTf)

		arg_25_0.selectedEffectTf = nil
	end

	if arg_25_0.selected then
		arg_25_0:animate(arg_25_0.selectedIndex.i, arg_25_0.selectedIndex.j, false)

		arg_25_0.selected = nil
		arg_25_0.selectedIndex = nil

		arg_25_0:reorderTiles()
	end

	return
end

function var_0_1.select(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0

	arg_26_0.unselect(var_26_0)

	arg_26_0.selected = arg_26_0.tileTfs[arg_26_1][arg_26_2]
	arg_26_0.selectedIndex = {
		i = arg_26_1,
		j = arg_26_2
	}
	rtf = var_3
	cloneTplTo = var_26_0
	arg_26_0.selectedEffectTf = var_3(var_26_0(arg_26_0.selectedEffect, arg_26_0.tilesRoot))
	arg_26_0.selectedEffectTf.anchoredPosition = arg_26_0.selected.anchoredPosition

	local var_26_1 = arg_26_0.selected

	var_3.SetAsLastSibling(var_26_1)
	arg_26_0:animate(arg_26_1, arg_26_2, true)

	return
end

function var_0_1.animate(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if not arg_27_0.tileTfs[arg_27_1][arg_27_2] then
		warning = var_4

		var_4("bad position", arg_27_1, arg_27_2)
	end

	local var_27_0 = arg_27_0.tileTfs[arg_27_1][arg_27_2]
	local var_27_1 = var_4.GetComponent(var_27_0, "Animator")

	var_4.SetBool(var_27_1, "selected", arg_27_3)

	pairs = var_4

	for iter_27_0, iter_27_1 in var_4(var_0_30) do
		if arg_27_0.tileTfs[arg_27_1 + iter_27_1[1]][arg_27_2 + iter_27_1[2]] then
			local var_27_2 = var_9:GetComponent("Animator")

			var_10.SetBool(var_27_2, "selected", arg_27_3)
		end
	end

	if arg_27_0.hint then
		local var_27_3 = arg_27_0.hint1
		local var_27_4 = var_4.GetComponent(var_27_3, "Animator")

		var_4.SetBool(var_27_4, "selected", true)

		local var_27_5 = arg_27_0.hint2
		local var_27_6 = var_4.GetComponent(var_27_5, "Animator")

		var_4.SetBool(var_27_6, "selected", true)
	end

	return
end

function var_0_1.tryMoveTo(arg_28_0, arg_28_1)
	if arg_28_0.selectedIndex == nil then
		return
	end

	if arg_28_0.hintTimer then
		local var_28_0 = arg_28_0.hintTimer

		var_2.Pause(var_28_0)
	end

	if not arg_28_0.tileIndicies[arg_28_1.i][arg_28_1.j] then
		return
	end

	pg = var_2

	local var_28_1 = var_2.CriMgr.GetInstance()

	var_2.PlaySoundEffect_V3(var_28_1, var_0_24)

	if arg_28_0:moveValid(arg_28_0.selectedIndex, arg_28_1) then
		local var_28_2 = arg_28_0.selectedIndex

		arg_28_0:unselect()

		arg_28_0.updating = true

		arg_28_0:swap(var_28_2, arg_28_1)

		local var_28_3 = arg_28_0
		local var_28_4 = arg_28_0.managedTween

		LeanTween = var_6

		var_28_4(var_28_3, var_6.delayedCall, function()
			if not arg_28_0.inGame then
				return
			end

			arg_28_0.combo = 0

			local var_29_0 = arg_28_0

			var_0.update(var_29_0)

			return
		end, var_0_14, nil)
	else
		local var_28_5 = arg_28_0.tileTfs[arg_28_0.selectedIndex.i][arg_28_0.selectedIndex.j]
		local var_28_6 = arg_28_0.tileTfs[arg_28_1.i][arg_28_1.j]
		local var_28_7 = arg_28_0:index2pos(arg_28_0.selectedIndex.i, arg_28_0.selectedIndex.j)
		local var_28_8 = arg_28_0:index2pos(arg_28_1.i, arg_28_1.j)
		local var_28_9 = arg_28_0
		local var_28_10 = arg_28_0.managedTween

		LeanTween = var_9

		local var_28_11 = var_28_10(var_28_9, var_9.move, nil, var_28_5, var_28_8, var_0_14)

		var_6.setLoopPingPong(var_28_11, 1)

		local var_28_12 = arg_28_0
		local var_28_13 = arg_28_0.managedTween

		LeanTween = var_9

		local var_28_14 = var_28_13(var_28_12, var_9.move, nil, var_28_6, var_28_7, var_0_14)

		var_6.setLoopPingPong(var_28_14, 1)

		arg_28_0.updating = true

		local var_28_15 = arg_28_0
		local var_28_16 = arg_28_0.managedTween

		LeanTween = var_9

		var_28_16(var_28_15, var_9.delayedCall, function()
			arg_28_0.updating = false

			local var_30_0 = arg_28_0.hintTimer

			var_0.Resume(var_30_0)

			return
		end, var_0_14 * 2 + 0.1, nil)
		arg_28_0:unselect()
	end

	return
end

local var_0_31 = {
	{
		{
			0,
			-2
		},
		{
			0,
			-1
		}
	},
	{
		{
			0,
			-1
		},
		{
			0,
			1
		}
	},
	{
		{
			0,
			1
		},
		{
			0,
			2
		}
	}
}

function var_0_1.isConnected(arg_31_0, arg_31_1)
	pairs = var_1_10002

	for iter_31_0, iter_31_1 in var_1_10002(var_0_31) do
		local var_31_0
		local var_31_1
		local var_31_2
		local var_31_3 = arg_31_0.tileIndicies[arg_31_1.i][arg_31_1.j]
		local var_31_4 = arg_31_0.tileIndicies[arg_31_1.i + iter_31_1[1][1]][arg_31_1.j + iter_31_1[1][2]]
		local var_31_5 = arg_31_0.tileIndicies[arg_31_1.i + iter_31_1[2][1]][arg_31_1.j + iter_31_1[2][2]]

		if var_31_3 == var_31_4 and var_31_3 == var_31_5 then
			return true
		end

		local var_31_6 = arg_31_0.tileIndicies[arg_31_1.i + iter_31_1[1][2]][arg_31_1.j + iter_31_1[1][1]]
		local var_31_7 = arg_31_0.tileIndicies[arg_31_1.i + iter_31_1[2][2]][arg_31_1.j + iter_31_1[2][1]]

		if var_31_3 == var_31_6 and var_31_3 == var_31_7 then
			return true
		end
	end

	return false
end

function var_0_1.moveValid(arg_32_0, arg_32_1, arg_32_2)
	arg_32_0.tileIndicies[arg_32_1.i][arg_32_1.j], arg_32_0.tileIndicies[arg_32_2.i][arg_32_2.j] = arg_32_0.tileIndicies[arg_32_2.i][arg_32_2.j], arg_32_0.tileIndicies[arg_32_1.i][arg_32_1.j]

	local var_32_0

	if not arg_32_0:isConnected(arg_32_1) then
		var_32_0 = arg_32_0:isConnected(arg_32_2)
	end

	arg_32_0.tileIndicies[arg_32_1.i][arg_32_1.j], arg_32_0.tileIndicies[arg_32_2.i][arg_32_2.j] = arg_32_0.tileIndicies[arg_32_2.i][arg_32_2.j], arg_32_0.tileIndicies[arg_32_1.i][arg_32_1.j]

	return var_32_0
end

function var_0_1.moveTile(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = arg_33_0:index2pos(arg_33_2.i, arg_33_2.j)
	local var_33_1 = arg_33_0
	local var_33_2 = arg_33_0.managedTween

	LeanTween = var_8

	local var_33_3 = var_33_2(var_33_1, var_8.move, nil, arg_33_1, var_33_0, arg_33_3 or 0)
	local var_33_4 = var_5.setEase

	LeanTweenType = var_8

	var_33_4(var_33_3, var_8.easeInQuad)

	return
end

function var_0_1.swap(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_0.tileTfs[arg_34_1.i][arg_34_1.j]
	local var_34_1 = arg_34_0.tileTfs[arg_34_2.i][arg_34_2.j]

	arg_34_0:moveTile(var_34_0, arg_34_2, var_0_14)
	arg_34_0:moveTile(var_34_1, arg_34_1, var_0_14)

	arg_34_0.tileTfs[arg_34_1.i][arg_34_1.j], arg_34_0.tileTfs[arg_34_2.i][arg_34_2.j] = arg_34_0.tileTfs[arg_34_2.i][arg_34_2.j], arg_34_0.tileTfs[arg_34_1.i][arg_34_1.j]
	arg_34_0.tileIndicies[arg_34_1.i][arg_34_1.j], arg_34_0.tileIndicies[arg_34_2.i][arg_34_2.j] = arg_34_0.tileIndicies[arg_34_2.i][arg_34_2.j], arg_34_0.tileIndicies[arg_34_1.i][arg_34_1.j]

	return
end

function var_0_1.formatTime(arg_35_0, arg_35_1)
	math = var_1_10002
	arg_35_1 = arg_35_1 - var_1_10002.floor(arg_35_1 / 60) * 60
	math = var_3

	local var_35_0 = var_3.floor(arg_35_1)

	return var_2 .. ":" .. var_35_0
end

local function var_0_32(arg_36_0)
	if arg_36_0[1] == 1 then
		return -90
	elseif arg_36_0[1] == -1 then
		return 90
	elseif arg_36_0[2] == 1 then
		return 180
	elseif arg_36_0[2] == -1 then
		return 0
	end

	return
end

local var_0_33 = dir2Angle

function var_0_1.startGame(arg_37_0)
	arg_37_0:updateData()

	Timer = var_1

	local var_37_0 = var_1.New

	local function var_37_1()
		local var_38_0 = arg_37_0
		local var_38_1 = var_0.managedTween

		LeanTween = var_2_10003

		local var_38_2 = var_2_10003.value

		local function var_38_3()
			local var_39_0 = arg_37_0.gamePage

			var_0.GetComponent(var_39_0, "CanvasGroup").alpha = 1

			local var_39_1 = arg_37_0

			var_0.stopGame(var_39_1)

			return
		end

		go = var_2_10005

		local var_38_4 = var_38_1(var_38_0, var_38_2, var_38_3, var_2_10005(arg_37_0.gamePage), 1, 0, var_0_11)
		local var_38_5 = var_0.setOnUpdate

		System = var_38_2

		var_38_5(var_38_4, var_38_2.Action_float(function(arg_40_0)
			local var_40_0 = arg_37_0.gamePage

			var_1.GetComponent(var_40_0, "CanvasGroup").alpha = arg_40_0

			return
		end))

		UpdateBeat = var_38_5

		var_38_5:RemoveListener(arg_37_0.handle)

		return
	end

	local var_37_2

	if not arg_37_0.infinite or not var_0_16 then
		var_37_2 = var_0_17
	end

	local var_37_3 = var_37_0(var_37_1, var_37_2)

	UpdateBeat = var_1_10002
	arg_37_0.handle = var_1_10002:CreateListener(function()
		setText = var_2_10000

		local var_41_0 = arg_37_0.countdownText

		math = var_2_10003

		var_2_10000(var_41_0, var_2_10003.floor(var_37_3.time))

		if var_37_3.time <= var_0_18 then
			isActive = var_0

			if not var_0(arg_37_0.warning) then
				setActive = var_0

				var_0(arg_37_0.warning, true)
			end
		end

		return
	end, arg_37_0)

	var_37_3:Start()

	UpdateBeat = var_2

	var_2:AddListener(arg_37_0.handle)

	arg_37_0.timer = var_37_3
	setActive = var_2

	var_2(arg_37_0.inf, false)

	setActive = var_2

	var_2(arg_37_0.countdownText, true)

	arg_37_0.tileIndicies = {}

	for iter_37_0 = -1, var_0_2 + 2 do
		arg_37_0.tileIndicies[iter_37_0] = {}
	end

	arg_37_0.tileTfs = {}

	for iter_37_1 = -1, var_0_2 + 2 do
		arg_37_0.tileTfs[iter_37_1] = {}
	end

	arg_37_0:fillTileIndicies()
	arg_37_0:fillTiles(true)

	arg_37_0.selected = nil
	arg_37_0.updating = false
	arg_37_0.score = 0
	arg_37_0.combo = 0
	arg_37_0.inGame = true
	setText = var_2

	var_2(arg_37_0.scoreText, arg_37_0.score)

	function arg_37_0.hintFunc()
		if arg_37_0.hint then
			return
		end

		local var_42_0 = arg_37_0
		local var_42_1, var_42_2, var_42_3 = var_0.findMove(var_42_0)
		local var_42_4 = arg_37_0
		local var_42_5 = var_3.index2pos(var_42_4, var_42_1, var_42_2)
		local var_42_6 = arg_37_0
		local var_42_7 = (var_42_5 + var_4.index2pos(var_42_6, var_42_1 + var_42_3[1], var_42_2 + var_42_3[2])) / 2

		rtf = var_4
		cloneTplTo = var_42_6

		local var_42_8 = var_4(var_42_6(arg_37_0.hintEffect, arg_37_0.tilesRoot))

		var_42_8.anchoredPosition = var_42_7
		Vector3 = var_42_4

		local var_42_9 = var_42_4.New
		local var_42_10 = 0
		local var_42_11 = 0

		dir2Angle = var_9
		var_42_8.localEulerAngles = var_42_9(var_42_10, var_42_11, var_9(var_42_3))
		arg_37_0.hint = var_42_8
		arg_37_0.hint1 = arg_37_0.tileTfs[var_42_1][var_42_2]
		arg_37_0.hint2 = arg_37_0.tileTfs[var_42_1 + var_42_3[1]][var_42_2 + var_42_3[2]]

		local var_42_12 = arg_37_0.hint1
		local var_42_13 = var_5.GetComponent(var_42_12, "Animator")

		var_5.SetBool(var_42_13, "selected", true)

		local var_42_14 = arg_37_0.hint2
		local var_42_15 = var_5.GetComponent(var_42_14, "Animator")

		var_5.SetBool(var_42_15, "selected", true)

		return
	end

	Timer = var_2
	arg_37_0.hintTimer = var_2.New(arg_37_0.hintFunc, var_0_22)

	local var_37_4 = arg_37_0.hintTimer

	var_2.Start(var_37_4)

	return
end

function var_0_1.pauseGame(arg_43_0)
	if arg_43_0.timer then
		local var_43_0 = arg_43_0.timer

		var_1.Pause(var_43_0)
	end

	if arg_43_0.hintTimer then
		local var_43_1 = arg_43_0.hintTimer

		var_1.Pause(var_43_1)
	end

	if arg_43_0.warning then
		local var_43_2 = arg_43_0.warning

		var_1.GetComponent(var_43_2, "Animator").enabled = false
	end

	arg_43_0:pauseManagedTween()

	return
end

function var_0_1.pause(arg_44_0)
	setActive = var_1_10001

	var_1_10001(arg_44_0.pausePage, true)
	arg_44_0:pauseGame()

	return
end

function var_0_1.resumeGame(arg_45_0)
	if arg_45_0.timer then
		local var_45_0 = arg_45_0.timer

		var_1.Resume(var_45_0)
	end

	if arg_45_0.hintTimer then
		local var_45_1 = arg_45_0.hintTimer

		var_1.Resume(var_45_1)
	end

	if arg_45_0.warning then
		local var_45_2 = arg_45_0.warning

		var_1.GetComponent(var_45_2, "Animator").enabled = true
	end

	arg_45_0:resumeManagedTween()

	return
end

function var_0_1.fillTileIndicies(arg_46_0)
	local var_46_0 = {}

	for iter_46_0 = -1, var_0_2 + 2 do
		var_46_0[iter_46_0] = {}

		for iter_46_1 = 1, var_0_3 do
			var_46_0[iter_46_0][iter_46_1] = arg_46_0.tileIndicies[iter_46_0][iter_46_1]
		end
	end

	repeat
		arg_46_0.tileIndicies = {}

		for iter_46_2 = -1, var_0_2 + 2 do
			arg_46_0.tileIndicies[iter_46_2] = {}

			for iter_46_3 = 1, var_0_3 do
				arg_46_0.tileIndicies[iter_46_2][iter_46_3] = var_46_0[iter_46_2][iter_46_3]
			end
		end

		for iter_46_4 = 1, var_0_2 do
			for iter_46_5 = 1, var_0_3 do
				if not arg_46_0.tileIndicies[iter_46_4][iter_46_5] then
					local var_46_1
					local var_46_2

					if arg_46_0.tileIndicies[iter_46_4 - 1][iter_46_5] and arg_46_0.tileIndicies[iter_46_4 - 1][iter_46_5] == arg_46_0.tileIndicies[iter_46_4 - 2][iter_46_5] then
						var_46_1 = arg_46_0.tileIndicies[iter_46_4 - 1][iter_46_5]
					end

					if arg_46_0.tileIndicies[iter_46_4][iter_46_5 - 1] and arg_46_0.tileIndicies[iter_46_4][iter_46_5 - 1] == arg_46_0.tileIndicies[iter_46_4][iter_46_5 - 2] then
						var_46_2 = arg_46_0.tileIndicies[iter_46_4][iter_46_5 - 2]
					end

					math = var_12

					local var_46_3 = var_12.random(1, #arg_46_0.tiles)

					while var_46_3 == var_46_1 or var_46_3 == var_46_2 do
						math = var_13
						var_46_3 = var_13.random(1, #arg_46_0.tiles)
					end

					arg_46_0.tileIndicies[iter_46_4][iter_46_5] = var_46_3
				end
			end
		end
	until arg_46_0:findMove()

	return
end

function var_0_1.reorderTiles(arg_47_0)
	for iter_47_0 = 1, var_0_2 do
		for iter_47_1 = 1, var_0_3 do
			if arg_47_0.tileTfs[iter_47_0][iter_47_1] then
				local var_47_0 = arg_47_0.tileTfs[iter_47_0][iter_47_1]

				var_9.SetAsFirstSibling(var_47_0)
			end
		end
	end

	return
end

function var_0_1.fillTiles(arg_48_0, arg_48_1)
	local var_48_0 = 0

	for iter_48_0 = 1, var_0_3 do
		local var_48_1 = 0

		for iter_48_1 = var_0_2, 1, -1 do
			if not arg_48_0.tileTfs[iter_48_1][iter_48_0] then
				var_48_1 = var_48_1 + 1
			end
		end

		math = var_8
		var_48_0 = var_8.max(var_48_1, var_48_0)

		for iter_48_2 = 1, var_0_2 do
			if not arg_48_0.tileTfs[iter_48_2][iter_48_0] then
				rtf = var_12
				cloneTplTo = var_1_10014

				local var_48_2 = var_12(var_1_10014(arg_48_0.tiles[arg_48_0.tileIndicies[iter_48_2][iter_48_0]], arg_48_0.tilesRoot))

				if arg_48_1 then
					var_48_2.anchoredPosition = arg_48_0:index2pos(iter_48_2, iter_48_0)
				else
					var_48_2.anchoredPosition = arg_48_0:index2pos(iter_48_2 + var_48_1, iter_48_0)

					arg_48_0:moveTile(var_48_2, {
						i = iter_48_2,
						j = iter_48_0
					}, arg_48_0.dropTime(var_48_1))
				end

				arg_48_0.tileTfs[iter_48_2][iter_48_0] = var_48_2
			end
		end
	end

	arg_48_0:reorderTiles()

	return var_48_0
end

local var_0_34 = {
	{
		{
			-1,
			-2
		},
		{
			-1,
			-1
		}
	},
	{
		{
			-1,
			-1
		},
		{
			-1,
			1
		}
	},
	{
		{
			-1,
			1
		},
		{
			-1,
			2
		}
	}
}

function var_0_1.findMove(arg_49_0)
	for iter_49_0 = 1, var_0_2 do
		for iter_49_1 = 1, var_0_3 do
			local var_49_0 = arg_49_0.tileIndicies[iter_49_0][iter_49_1]
			local var_49_1
			local var_49_2

			pairs = var_1_10012

			for iter_49_2, iter_49_3 in var_1_10012(var_0_34) do
				local var_49_3 = arg_49_0.tileIndicies[iter_49_0 + iter_49_3[1][1]][iter_49_1 + iter_49_3[1][2]]
				local var_49_4 = arg_49_0.tileIndicies[iter_49_0 + iter_49_3[2][1]][iter_49_1 + iter_49_3[2][2]]

				if var_49_0 == var_49_3 and var_49_0 == var_49_4 then
					return iter_49_0, iter_49_1, {
						-1,
						0
					}
				end

				local var_49_5 = arg_49_0.tileIndicies[iter_49_0 - iter_49_3[1][1]][iter_49_1 - iter_49_3[1][2]]
				local var_49_6 = arg_49_0.tileIndicies[iter_49_0 - iter_49_3[2][1]][iter_49_1 - iter_49_3[2][2]]

				if var_49_0 == var_49_5 and var_49_0 == var_49_6 then
					return iter_49_0, iter_49_1, {
						1,
						0
					}
				end

				local var_49_7 = arg_49_0.tileIndicies[iter_49_0 - iter_49_3[1][2]][iter_49_1 + iter_49_3[1][1]]
				local var_49_8 = arg_49_0.tileIndicies[iter_49_0 - iter_49_3[2][2]][iter_49_1 + iter_49_3[2][1]]

				if var_49_0 == var_49_7 and var_49_0 == var_49_8 then
					return iter_49_0, iter_49_1, {
						0,
						-1
					}
				end

				local var_49_9 = arg_49_0.tileIndicies[iter_49_0 + iter_49_3[1][2]][iter_49_1 - iter_49_3[1][1]]
				local var_49_10 = arg_49_0.tileIndicies[iter_49_0 + iter_49_3[2][2]][iter_49_1 - iter_49_3[2][1]]

				if var_49_0 == var_49_9 and var_49_0 == var_49_10 then
					return iter_49_0, iter_49_1, {
						0,
						1
					}
				end
			end
		end
	end

	return
end

function var_0_1.stopGame(arg_50_0)
	arg_50_0.inGame = false
	setActive = var_1

	var_1(arg_50_0.warning, false)

	local var_50_0 = arg_50_0.hintTimer

	var_1.Reset(var_50_0, arg_50_0.hintFunc, 5)

	local var_50_1 = arg_50_0.hintTimer

	var_1.Stop(var_50_1)
	arg_50_0:cleanManagedTween(true)
	arg_50_0:cancelHint()

	if arg_50_0.timer then
		local var_50_2 = arg_50_0.timer

		var_1.Pause(var_50_2)
	end

	if arg_50_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_50_0.handle)
	end

	for iter_50_0 = 1, var_0_2 do
		for iter_50_1 = 1, var_0_3 do
			if arg_50_0.tileTfs[iter_50_0][iter_50_1] then
				Destroy = var_9

				var_9(arg_50_0.tileTfs[iter_50_0][iter_50_1])
			end
		end
	end

	if arg_50_0.selectedEffectTf then
		Destroy = var_1

		var_1(arg_50_0.selectedEffectTf)

		arg_50_0.selectedEffectTf = nil
	end

	setText = var_1

	local var_50_3 = arg_50_0.bestScore

	math = iter_50_0

	var_1(var_50_3, iter_50_0.max(arg_50_0.best, arg_50_0.score))

	setActive = var_1

	var_1(arg_50_0.gamePage, false)

	setActive = var_1

	var_1(arg_50_0.pausePage, false)

	setActive = var_1

	var_1(arg_50_0.endBtn, false)

	setActive = var_1

	var_1(arg_50_0.endPage, true)

	if arg_50_0.score > 0 then
		pg = var_1

		local var_50_4 = var_1.CriMgr.GetInstance()

		var_1.PlaySoundEffect_V3(var_50_4, var_0_28)
	end

	setActive = var_1

	var_1(arg_50_0.newSign, false)

	setText = var_1

	var_1(arg_50_0.endScore, 0)

	local var_50_5 = arg_50_0
	local var_50_6 = arg_50_0.managedTween

	LeanTween = var_4

	local var_50_7 = var_4.value

	local function var_50_8()
		setActive = var_2_10000

		var_2_10000(arg_50_0.newSign, arg_50_0.best < arg_50_0.score)

		setActive = var_2_10000

		var_2_10000(arg_50_0.endBtn, true)

		setImageAlpha = var_2_10000

		var_2_10000(arg_50_0.endBtn, 0)

		local var_51_0 = arg_50_0.endBtn
		local var_51_1 = var_0.GetComponent(var_51_0, "Button")

		var_51_1.enabled = false
		pg = var_51_1

		local var_51_2 = var_51_1.CriMgr.GetInstance()

		var_0.PlaySoundEffect_V3(var_51_2, var_0_29)

		local var_51_3 = arg_50_0
		local var_51_4 = var_0.managedTween

		LeanTween = var_3

		local var_51_5 = var_3.value

		local function var_51_6()
			local var_52_0 = arg_50_0.endBtn

			var_0.GetComponent(var_52_0, "Button").enabled = true

			if arg_50_0.infinite or arg_50_0.timer and arg_50_0.timer.time <= 0 then
				if not arg_50_0.infinite then
					local var_52_1 = arg_50_0

					var_0.SendSuccess(var_52_1, 0)
				end

				if arg_50_0.score > arg_50_0.best then
					local var_52_2 = arg_50_0

					var_0.StoreDataToServer(var_52_2, {
						arg_50_0.score
					})
				end
			end

			arg_50_0.timer = nil

			return
		end

		go = var_2_10005

		local var_51_7 = var_51_4(var_51_3, var_51_5, var_51_6, var_2_10005(arg_50_0.endBtn), 0, 1, var_0_20)
		local var_51_8 = var_0.setOnUpdate

		System = var_51_5

		var_51_8(var_51_7, var_51_5.Action_float(function(arg_53_0)
			setImageAlpha = var_3_10001

			var_3_10001(arg_50_0.endBtn, arg_53_0)

			return
		end))

		return
	end

	go = var_6

	local var_50_9 = var_6(arg_50_0.endScore)
	local var_50_10 = 0
	local var_50_11 = arg_50_0.score
	local var_50_12

	if not (arg_50_0.score > 0) or not var_0_19 then
		var_50_12 = 0
	end

	local var_50_13 = var_50_6(var_50_5, var_50_7, var_50_8, var_50_9, var_50_10, var_50_11, var_50_12)
	local var_50_14 = var_1.setOnUpdate

	System = var_50_7

	var_50_14(var_50_13, var_50_7.Action_float(function(arg_54_0)
		setText = var_2_10001

		local var_54_0 = arg_50_0.endScore

		math = var_2_10004

		var_2_10001(var_54_0, var_2_10004.floor(arg_54_0))

		return
	end))

	return
end

function var_0_1.formatScore(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = {}

	while 0 < arg_55_2 do
		table = var_55_1

		local var_55_1 = var_55_1.insert
		local var_55_2 = var_55_0

		math = var_1_10007

		var_55_1(var_55_2, var_1_10007.fmod(arg_55_2, 10))

		math = var_55_1
		arg_55_2 = var_55_1.floor(arg_55_2 / 10)
	end

	for iter_55_0 = #var_55_0, 1, -1 do
		cloneTplTo = var_1_10008

		var_1_10008(arg_55_0.floatChar[var_55_0[iter_55_0]], arg_55_1)
	end

	return
end

function var_0_1.update(arg_56_0)
	local var_56_0 = arg_56_0.hintTimer

	var_1.Stop(var_56_0)

	local var_56_1 = true

	arg_56_0.updating = true

	local var_56_2 = arg_56_0
	local var_56_3 = arg_56_0.tryMatch(var_56_2)

	next = var_56_0

	if var_56_0(var_56_3) ~= nil then
		arg_56_0:cancelHint()

		var_56_1 = false
		arg_56_0.combo = arg_56_0.combo + 1
		pg = var_3

		local var_56_4 = var_3.CriMgr.GetInstance()

		var_3.PlaySoundEffect_V3(var_56_4, var_0_25)

		local var_56_5

		pairs = var_56_2

		for iter_56_0, iter_56_1 in var_56_2(var_56_3) do
			if #iter_56_1 == 3 then
				var_56_5 = 30 * arg_56_0.combo
			elseif #iter_56_1 == 4 then
				var_56_5 = 60 * arg_56_0.combo
			else
				var_56_5 = 20 * #iter_56_1 * arg_56_0.combo
			end

			arg_56_0.score = arg_56_0.score + var_56_5
			setText = var_9

			var_9(arg_56_0.scoreText, arg_56_0.score)

			Vector2 = var_9

			local var_56_6 = var_9.zero

			_ = var_1_10010

			var_1_10010.each(iter_56_1, function(arg_57_0)
				arg_56_0.tileIndicies[arg_57_0[1]][arg_57_0[2]] = nil

				if arg_56_0.tileTfs[arg_57_0[1]][arg_57_0[2]] then
					local var_57_0 = arg_56_0.tileTfs[arg_57_0[1]][arg_57_0[2]]

					var_56_6 = var_56_6 + var_57_0.anchoredPosition
					var_57_0:GetComponent("Image").material = arg_56_0.whitenMat

					local var_57_1 = var_57_0.localPosition

					var_57_1.z = -50
					cloneTplTo = var_3

					local var_57_2 = var_3(arg_56_0.matchEffect, arg_56_0.tilesRoot)

					var_57_2.localPosition = var_57_1

					local var_57_3 = arg_56_0
					local var_57_4 = var_4.managedTween

					LeanTween = var_2_10007

					local var_57_5 = var_2_10007.value

					local function var_57_6()
						Destroy = var_3_10000

						var_3_10000(var_57_0)

						Destroy = var_3_10000

						var_3_10000(var_57_2)

						return
					end

					go = var_2_10009

					local var_57_7 = var_57_4(var_57_3, var_57_5, var_57_6, var_2_10009(var_57_0), 1, 0, var_0_11)
					local var_57_8 = var_4.setOnUpdate

					System = var_57_5

					var_57_8(var_57_7, var_57_5.Action_float(function(arg_59_0)
						setImageAlpha = var_3_10001

						var_3_10001(var_57_0, arg_59_0)

						setLocalScale = var_3_10001

						local var_59_0 = var_57_0

						Vector3 = var_4

						var_3_10001(var_59_0, var_4.one * arg_59_0 * 2.7)

						return
					end))
				end

				arg_56_0.tileTfs[arg_57_0[1]][arg_57_0[2]] = nil

				return
			end)

			var_56_6 = var_56_6 / #iter_56_1
			rtf = var_1_10010
			cloneTplTo = var_12
			var_1_10010 = var_1_10010(var_12(arg_56_0.floatText, arg_56_0.tilesRoot))
			var_1_10010.anchoredPosition = var_56_6

			arg_56_0:formatScore(var_1_10010, var_56_5)

			local var_56_7 = arg_56_0
			local var_56_8 = arg_56_0.managedTween

			LeanTween = var_14

			var_56_8(var_56_7, var_14.moveY, function()
				Destroy = var_2_10000

				var_2_10000(var_1_10010)

				return
			end, var_1_10010, var_56_6.y + var_0_13, var_0_12)
		end

		local var_56_9 = arg_56_0
		local var_56_10 = arg_56_0.managedTween

		LeanTween = iter_56_0

		var_56_10(var_56_9, iter_56_0.delayedCall, function()
			if not arg_56_0.inGame then
				return
			end

			local var_61_0 = 0

			for iter_61_0 = 1, var_0_2 do
				for iter_61_1 = 1, var_0_3 do
					if arg_56_0.tileIndicies[iter_61_0][iter_61_1] then
						local var_61_1 = iter_61_0

						for iter_61_2 = iter_61_0, 1, -1 do
							if arg_56_0.tileIndicies[iter_61_2 - 1][iter_61_1] or iter_61_2 == 1 then
								var_61_1 = iter_61_2

								break
							end
						end

						if var_61_1 ~= iter_61_0 then
							local var_61_2 = iter_61_0 - var_61_1

							math = var_11
							var_61_0 = var_11.max(var_61_2, var_61_0)

							local var_61_3 = arg_56_0

							var_11.moveTile(var_61_3, arg_56_0.tileTfs[iter_61_0][iter_61_1], {
								i = var_61_1,
								j = iter_61_1
							}, arg_56_0.dropTime(var_61_2))

							arg_56_0.tileTfs[var_61_1][iter_61_1] = arg_56_0.tileTfs[iter_61_0][iter_61_1]
							arg_56_0.tileIndicies[var_61_1][iter_61_1] = arg_56_0.tileIndicies[iter_61_0][iter_61_1]
							arg_56_0.tileTfs[iter_61_0][iter_61_1] = nil
							arg_56_0.tileIndicies[iter_61_0][iter_61_1] = nil
						end
					end
				end
			end

			local var_61_4 = arg_56_0

			var_1.fillTileIndicies(var_61_4)

			local var_61_5 = arg_56_0
			local var_61_6 = var_1.tryMatch(var_61_5)
			local var_61_7 = arg_56_0.combo

			if 1 < var_61_7 then
				next = var_61_7

				if var_61_7(var_61_6) == nil then
					var_61_7 = nil
					Vector3 = var_3

					local var_61_8 = var_3.New(0, 0, -50)

					if arg_56_0.combo == 2 then
						cloneTplTo = var_4
						var_61_7 = var_4(arg_56_0.goodEffect, arg_56_0.tilesRoot)
						pg = var_4

						local var_61_9 = var_4.CriMgr.GetInstance()

						var_4.PlaySoundEffect_V3(var_61_9, var_0_26)
					elseif arg_56_0.combo == 3 then
						cloneTplTo = var_4
						var_61_7 = var_4(arg_56_0.greatEffect, arg_56_0.tilesRoot)
						pg = var_4

						local var_61_10 = var_4.CriMgr.GetInstance()

						var_4.PlaySoundEffect_V3(var_61_10, var_0_26)
					else
						cloneTplTo = var_4
						var_61_7 = var_4(arg_56_0.perfectEffect, arg_56_0.tilesRoot)
						pg = var_4

						local var_61_11 = var_4.CriMgr.GetInstance()

						var_4.PlaySoundEffect_V3(var_61_11, var_0_27)
					end

					var_61_7.localPosition = var_61_8

					local var_61_12 = arg_56_0
					local var_61_13 = var_4.managedTween

					LeanTween = var_2_10007

					var_61_13(var_61_12, var_2_10007.delayedCall, function()
						Destroy = var_3_10000

						var_3_10000(var_61_7)

						return
					end, var_0_15, nil)
				end
			end

			math = var_61_7

			local var_61_14 = var_61_7.max
			local var_61_15 = arg_56_0
			local var_61_16 = var_61_14(var_4.fillTiles(var_61_15), var_61_0)
			local var_61_17 = arg_56_0
			local var_61_18 = var_2.managedTween

			LeanTween = var_5

			local var_61_19 = var_5.delayedCall

			local function var_61_20()
				if not arg_56_0.inGame then
					return
				end

				local var_63_0 = arg_56_0

				var_0.update(var_63_0)

				return
			end

			math = var_2_10007

			var_61_18(var_61_17, var_61_19, var_61_20, var_2_10007.max(var_0_15, arg_56_0.dropTime(var_61_16)), nil)

			return
		end, var_0_11, nil)
	end

	if arg_56_0.inGame then
		local var_56_11 = arg_56_0.hintTimer

		var_3.Reset(var_56_11, arg_56_0.hintFunc, var_0_22)

		local var_56_12 = arg_56_0.hintTimer

		var_3.Start(var_56_12)
	end

	arg_56_0.updating = not var_56_1

	return
end

function var_0_1.tryMatch(arg_64_0)
	local var_64_0 = {}

	for iter_64_0 = 1, var_0_2 do
		var_64_0[iter_64_0] = {}
	end

	return arg_64_0:bfs(var_64_0)
end

function var_0_1.bfs(arg_65_0, arg_65_1)
	local var_65_0 = {}

	for iter_65_0 = 1, var_0_2 do
		for iter_65_1 = 1, var_0_3 do
			if not arg_65_1[iter_65_0][iter_65_1] then
				if not arg_65_0:isConnected({
					i = iter_65_0,
					j = iter_65_1
				}) then
					arg_65_1[iter_65_0][iter_65_1] = true
				else
					local var_65_1 = {
						{
							iter_65_0,
							iter_65_1
						}
					}
					local var_65_2 = {
						{
							iter_65_0,
							iter_65_1
						}
					}
					local var_65_3 = arg_65_0.tileIndicies[iter_65_0][iter_65_1]

					::label_65_0::

					next = var_65_4

					if var_65_4(var_65_1) ~= nil then
						repeat
							unpack = var_65_4
							table = var_65_6

							local var_65_4, var_65_5 = var_65_4(var_65_6.remove(var_65_1))
							local var_65_6 = arg_65_1[var_65_4]

							var_65_6[var_65_5] = true
							pairs = var_65_6

							for iter_65_2, iter_65_3 in var_65_6(var_0_30) do
								local var_65_7 = var_65_4 + iter_65_3[1]
								local var_65_8 = var_65_5 + iter_65_3[2]

								if arg_65_0.tileIndicies[var_65_7][var_65_8] and not arg_65_1[var_65_7][var_65_8] and arg_65_0.tileIndicies[var_65_7][var_65_8] == var_65_3 and arg_65_0:isConnected({
									i = var_65_7,
									j = var_65_8
								}) then
									table = var_23

									var_23.insert(var_65_1, {
										var_65_7,
										var_65_8
									})

									table = var_23

									var_23.insert(var_65_2, {
										var_65_7,
										var_65_8
									})
								end
							end

							goto label_65_0
						until true
					end

					if #var_65_2 >= 3 then
						table = var_14

						var_14.insert(var_65_0, var_65_2)
					end
				end
			end
		end
	end

	return var_65_0
end

return var_0_1
