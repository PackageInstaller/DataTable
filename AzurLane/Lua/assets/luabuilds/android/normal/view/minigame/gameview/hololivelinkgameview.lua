class = var_0_10000

local var_0_0 = "HoloLiveLinkGameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))

var_0_1.MAX_ROW = 6
var_0_1.MAX_COLUMN = 11
var_0_1.COUNT_DOWN = 3
var_0_1.RESET_CD = 5
var_0_1.GAME_STATE_BEGIN = 0
var_0_1.GAME_STATE_GAMING = 1
var_0_1.GAME_STATE_END = 2
var_0_1.CARD_STATE_NORMAL = 0
var_0_1.CARD_STATE_LINKED = 1
var_0_1.CARD_STATE_BLANK = 2
var_0_1.NAME_TO_INDEX = {
	mio = 4,
	shion = 5,
	aqua = 2,
	fubuki = 0,
	Purifier = 8,
	Kawakaze = 7,
	matsuri = 1,
	sora = 6,
	ayame = 3
}

function var_0_1.getUIName(arg_1_0)
	return "HoloLiveLinkGameUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0.miniGameData = arg_3_0:GetMGData()

	local var_3_0 = arg_3_0.miniGameData

	arg_3_0.linkGameID = var_1.GetRuntimeData(var_3_0, "curLinkGameID")

	local var_3_1 = arg_3_0.miniGameData

	arg_3_0.bestScoreTable = var_1.GetRuntimeData(var_3_1, "elements")

	if #arg_3_0.bestScoreTable == 0 then
		arg_3_0.bestScoreTable = {
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}

		local var_3_2 = arg_3_0.miniGameData

		var_1.SetRuntimeData(var_3_2, "elements", arg_3_0.bestScoreTable)
	end

	setText = var_1

	var_1(arg_3_0.bestTxt, arg_3_0:FormatRecordTime(arg_3_0.bestScoreTable[arg_3_0.linkGameID]))
	arg_3_0:SetState(var_0_1.GAME_STATE_BEGIN)

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_4_0)
	return
end

function var_0_1.onBackPressed(arg_5_0)
	triggerButton = var_1_10001

	var_1_10001(arg_5_0.backBtn)

	return
end

function var_0_1.willExit(arg_6_0)
	LeanTween = var_1_10001

	local var_6_0 = var_1_10001.cancel

	go = var_1_10002

	var_6_0(var_1_10002(arg_6_0.countDown))

	for iter_6_0 = 0, arg_6_0.layout.childCount - 1 do
		LeanTween = var_1_10005
		var_1_10005 = var_1_10005.cancel
		go = var_1_10006

		local var_6_1 = arg_6_0.layout

		var_1_10005(var_1_10006(var_7.GetChild(var_6_1, iter_6_0)))
	end

	if arg_6_0.countTimer then
		local var_6_2 = arg_6_0.countTimer

		var_1.Stop(var_6_2)

		arg_6_0.countTimer = nil
	end

	return
end

function var_0_1.initData(arg_7_0)
	return
end

function var_0_1.findUI(arg_8_0)
	local var_8_0 = arg_8_0._tf

	arg_8_0.backBtn = var_1.Find(var_8_0, "ForNotchPanel/BackBtn")

	local var_8_1 = arg_8_0._tf

	arg_8_0.helpBtn = var_1.Find(var_8_1, "ForNotchPanel/HelpBtn")

	local var_8_2 = arg_8_0._tf

	arg_8_0.resetBtn = var_1.Find(var_8_2, "ResetBtn")

	local var_8_3 = arg_8_0._tf

	arg_8_0.timeTxt = var_1.Find(var_8_3, "ForNotchPanel/CurTime/Text")

	local var_8_4 = arg_8_0._tf

	arg_8_0.bestTxt = var_1.Find(var_8_4, "ForNotchPanel/BestTime/Text")

	local var_8_5 = arg_8_0._tf

	arg_8_0.layout = var_1.Find(var_8_5, "card_con/layout")

	local var_8_6 = arg_8_0.layout

	arg_8_0.item = var_1.Find(var_8_6, "card")

	local var_8_7 = arg_8_0._tf

	arg_8_0.bottom = var_1.Find(var_8_7, "card_con/bottom")

	local var_8_8 = arg_8_0.bottom

	arg_8_0.line = var_1.Find(var_8_8, "card")

	local var_8_9 = arg_8_0._tf

	arg_8_0.countDown = var_1.Find(var_8_9, "count_down")

	local var_8_10 = arg_8_0._tf

	arg_8_0.resource = var_1.Find(var_8_10, "resource")

	local var_8_11 = arg_8_0._tf

	arg_8_0.resultPanel = var_1.Find(var_8_11, "ResultPanel")

	local var_8_12 = arg_8_0.resultPanel

	arg_8_0.resultPanelBG = var_1.Find(var_8_12, "BG")

	local var_8_13 = arg_8_0.resultPanel
	local var_8_14 = var_1.Find(var_8_13, "Result")

	arg_8_0.resultNewImg = var_1.Find(var_8_14, "NewImg")
	arg_8_0.resultTimeText = var_1:Find("TimeText")
	arg_8_0.resultRestartBtn = var_1:Find("RestartBtn")

	return
end

function var_0_1.addListener(arg_9_0)
	onButton = var_1_10001

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.backBtn

	local function var_9_2()
		local var_10_0 = arg_9_0

		var_0.emit(var_10_0, var_0_1.ON_BACK)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_9_0, var_9_1, var_9_2, var_1_10005)

	onButton = var_1_10001

	local var_9_3 = arg_9_0
	local var_9_4 = arg_9_0.helpBtn

	local function var_9_5()
		pg = var_2_10000

		local var_11_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_11_1 = var_0.ShowMsgBox
		local var_11_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_11_2.type = var_2_10003
		pg = var_2_10003
		var_11_2.helps = var_2_10003.gametip.hololive_lianliankan.tip

		var_11_1(var_11_0, var_11_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_9_3, var_9_4, var_9_5, var_1_10005)

	onButton = var_1_10001

	local var_9_6 = arg_9_0
	local var_9_7 = arg_9_0.resultPanelBG

	local function var_9_8()
		local var_12_0 = arg_9_0

		var_0.showResultPanel(var_12_0, false)

		local var_12_1 = arg_9_0

		var_0.emit(var_12_1, var_0_1.ON_BACK)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_9_6, var_9_7, var_9_8, var_1_10005)

	onButton = var_1_10001

	local var_9_9 = arg_9_0
	local var_9_10 = arg_9_0.resultRestartBtn

	local function var_9_11()
		local var_13_0 = arg_9_0

		var_0.showResultPanel(var_13_0, false)

		local var_13_1 = arg_9_0

		var_0.SetState(var_13_1, var_0_1.GAME_STATE_BEGIN)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_9_9, var_9_10, var_9_11, var_1_10005)

	return
end

function var_0_1.showResultPanel(arg_14_0, arg_14_1)
	if not arg_14_1 then
		SetActive = var_1_10002

		var_1_10002(arg_14_0.resultPanel, false)

		return
	end

	setText = var_1_10002

	var_1_10002(arg_14_0.resultTimeText, arg_14_0:FormatRecordTime(arg_14_0.lastRecord))

	SetActive = var_1_10002

	var_1_10002(arg_14_0.resultPanel, true)

	return
end

function var_0_1.playStory(arg_15_0)
	local var_15_0 = arg_15_0.miniGameData

	if var_1.GetConfigCsvLine(var_15_0, arg_15_0.linkGameID).story == "" then
		var_1_10004 = arg_15_0

		arg_15_0.showResultPanel(var_1_10004, true)
	else
		local var_15_1 = var_2[1]

		pg = var_1_10004

		local var_15_2 = var_1_10004.NewStoryMgr.GetInstance()

		if not var_4.IsPlayed(var_15_2, var_15_1) then
			var_4:Play(var_15_1, function()
				local var_16_0 = arg_15_0

				var_0.showResultPanel(var_16_0, true)

				return
			end)
		end
	end

	return
end

function var_0_1.SetState(arg_17_0, arg_17_1)
	if arg_17_0.state ~= arg_17_1 then
		arg_17_0.state = arg_17_1

		if arg_17_1 == var_0_1.GAME_STATE_BEGIN then
			arg_17_0:GameBegin()
		elseif arg_17_1 == var_0_1.GAME_STATE_GAMING then
			arg_17_0:GameLoop()
		elseif arg_17_1 == var_0_1.GAME_STATE_END then
			arg_17_0:GameEnd()
		end
	end

	return
end

function var_0_1.GameBegin(arg_18_0)
	arg_18_0.cards = {}

	local var_18_0 = arg_18_0:setIconList()
	local var_18_1 = 0

	::label_18_0::

	local var_18_2 = #var_18_0

	if 0 < var_18_2 then
		repeat
			math = var_18_2
			var_18_2 = var_18_2.clamp
			math = var_18_3

			local var_18_3 = var_18_3.floor

			math = var_1_10005
			var_18_2 = var_18_2(var_18_3(var_1_10005.random() * #var_18_0 + 1), 1, #var_18_0)
			math = var_18_3
			var_18_3 = var_18_3.floor(var_18_1 / (var_0_1.MAX_COLUMN - 2)) + 1
			var_1_10005 = var_18_1 % (var_0_1.MAX_COLUMN - 2) + 1

			local var_18_4 = arg_18_0.cards
			local var_18_5

			if not arg_18_0.cards[var_18_3] then
				var_18_5 = {}
			end

			var_18_4[var_18_3] = var_18_5

			local var_18_6 = arg_18_0.cards[var_18_3]

			var_18_6[var_1_10005] = {
				row = var_18_3,
				column = var_1_10005,
				id = var_18_0[var_18_2],
				state = var_0_1.CARD_STATE_NORMAL
			}
			table = var_18_6

			var_18_6.remove(var_18_0, var_18_2)

			var_18_1 = var_18_1 + 1

			goto label_18_0
		until true
	end

	for iter_18_0 = 0, var_0_1.MAX_ROW - 1 do
		for iter_18_1 = 0, var_0_1.MAX_COLUMN - 1 do
			local var_18_7 = arg_18_0.cards
			local var_18_8

			if not arg_18_0.cards[iter_18_0] then
				var_18_8 = {}
			end

			var_18_7[iter_18_0] = var_18_8

			local var_18_9 = arg_18_0.cards[iter_18_0]
			local var_18_10

			if not arg_18_0.cards[iter_18_0][iter_18_1] then
				var_18_10 = {
					row = iter_18_0,
					column = iter_18_1,
					state = var_0_1.CARD_STATE_BLANK
				}
			end

			var_18_9[iter_18_1] = var_18_10
		end
	end

	UIItemList = var_3
	arg_18_0.list = var_3.New(arg_18_0.layout, arg_18_0.item)

	local var_18_11 = arg_18_0.list

	var_3.make(var_18_11, function(arg_19_0, arg_19_1, arg_19_2)
		UIItemList = var_2_10003

		if arg_19_0 == var_2_10003.EventUpdate then
			math = var_3

			local var_19_0 = var_3.floor(arg_19_1 / var_0_1.MAX_COLUMN)
			local var_19_1 = arg_19_1 % var_0_1.MAX_COLUMN
			local var_19_2 = arg_18_0.cards[var_19_0][var_19_1]

			arg_19_2.name = var_19_0 .. "_" .. var_19_1
			Vector3 = var_6
			arg_19_2.localScale = var_6.one
			setActive = var_6

			var_6(arg_19_2:Find("display"), var_19_2.state == var_0_1.CARD_STATE_NORMAL)

			if var_19_2.state == var_0_1.CARD_STATE_NORMAL then
				getImageSprite = var_6

				local var_19_3 = arg_18_0.resource
				local var_19_4 = var_6(var_7.GetChild(var_19_3, var_19_2.id))

				setImageSprite = var_7

				var_7(arg_19_2:Find("display/icon"), var_19_4)

				setActive = var_7

				var_7(arg_19_2:Find("display/selected"), false)

				GetComponent = var_7

				local var_19_5 = arg_19_2

				typeof = var_9
				Animator = var_10

				local var_19_6 = var_7(var_19_5, var_9(var_10))

				var_19_6.enabled = true

				var_19_6:SetBool("AniSwitch", false)
			end
		end

		return
	end)

	local var_18_12 = arg_18_0.list

	var_3.align(var_18_12, var_0_1.MAX_ROW * var_0_1.MAX_COLUMN)

	UIItemList = var_3
	arg_18_0.llist = var_3.New(arg_18_0.bottom, arg_18_0.line)

	local var_18_13 = arg_18_0.llist

	var_3.make(var_18_13, function(arg_20_0, arg_20_1, arg_20_2)
		UIItemList = var_2_10003

		if arg_20_0 == var_2_10003.EventUpdate then
			local var_20_0 = arg_20_2:Find("lines")

			for iter_20_0 = 0, var_20_0.childCount - 1 do
				setActive = var_2_10008

				var_2_10008(var_20_0:GetChild(iter_20_0), false)
			end
		end

		return
	end)

	local var_18_14 = arg_18_0.llist

	var_3.align(var_18_14, var_0_1.MAX_ROW * var_0_1.MAX_COLUMN)

	setText = var_3

	var_3(arg_18_0.timeTxt, arg_18_0:FormatRecordTime(0))

	setActive = var_3

	var_3(arg_18_0.countDown, true)

	for iter_18_2 = 0, arg_18_0.countDown.childCount - 1 do
		setActive = var_7

		local var_18_15 = arg_18_0.countDown

		var_7(var_8.GetChild(var_18_15, iter_18_2), false)
	end

	local var_18_16 = 0
	local var_18_17 = arg_18_0.countDown
	local var_18_18 = var_4.GetChild(var_18_17, var_18_16)

	setActive = var_18_17

	var_18_17(var_18_18, true)

	setImageAlpha = var_18_17

	var_18_17(var_18_18, 0)

	LeanTween = var_18_17

	local var_18_19 = var_18_17.value

	go = var_6

	local var_18_20 = var_18_19(var_6(arg_18_0.countDown), 0, 1, 1)
	local var_18_21 = var_5.setOnUpdate

	System = var_7

	local var_18_22 = var_18_21(var_18_20, var_7.Action_float(function(arg_21_0)
		math = var_2_10001
		arg_21_0 = var_2_10001.min(arg_21_0 / 0.3, 1)
		setImageAlpha = var_1

		var_1(var_18_18, arg_21_0)

		setLocalScale = var_1

		var_1(var_18_18, {
			x = (1 - arg_21_0) * 2 + 1,
			y = (1 - arg_21_0) * 2 + 1
		})

		return
	end))
	local var_18_23 = var_5.setOnComplete

	System = var_7

	local var_18_24 = var_18_23(var_18_22, var_7.Action(function()
		setActive = var_2_10000

		var_2_10000(var_18_18, false)

		var_18_16 = var_18_16 + 1

		if var_18_16 < arg_18_0.countDown.childCount then
			local var_22_0 = arg_18_0.countDown

			var_18_18 = var_0.GetChild(var_22_0, var_18_16)
			setActive = var_0

			var_0(var_18_18, true)

			setImageAlpha = var_0

			var_0(var_18_18, 0)
		else
			setActive = var_0

			var_0(arg_18_0.countDown, false)

			local var_22_1 = arg_18_0

			var_0.SetState(var_22_1, var_0_1.GAME_STATE_GAMING)
		end

		return
	end))
	local var_18_25 = var_5.setRepeat(var_18_24, 4)
	local var_18_26 = var_5.setLoopType

	LeanTweenType = var_7

	local var_18_27 = var_18_26(var_18_25, var_7.punch)
	local var_18_28 = var_5.setOnCompleteOnRepeat(var_18_27, true)
	local var_18_29 = var_5.setEase

	LeanTweenType = var_7

	var_18_29(var_18_28, var_7.easeOutSine)

	return
end

function var_0_1.GameLoop(arg_23_0)
	local function var_23_0(arg_24_0)
		local var_24_0 = 0
		local var_24_1 = 0

		for iter_24_0 = 1, #arg_24_0 - 1 do
			local var_24_2 = arg_24_0[iter_24_0]
			local var_24_3 = arg_24_0[iter_24_0 + 1].row - var_24_2.row
			local var_24_4 = var_8.column - var_24_2.column
			local var_24_5 = arg_23_0.bottom
			local var_24_6 = var_11.GetChild(var_24_5, var_24_2.row * var_0_1.MAX_COLUMN + var_24_2.column)
			local var_24_7 = var_11.Find(var_24_6, "lines")

			for iter_24_1 = 0, var_24_7.childCount - 1 do
				setActive = var_2_10016

				var_2_10016(var_24_7:GetChild(iter_24_1), false)
			end

			if var_24_3 ~= 0 then
				setActive = var_12

				var_12(var_24_7:Find("y" .. var_24_3), true)
			elseif var_24_4 ~= 0 then
				setActive = var_12

				var_12(var_24_7:Find("x" .. var_24_4), true)
			end
		end

		return
	end

	local function var_23_1(arg_25_0)
		for iter_25_0 = 1, #arg_25_0 - 1 do
			local var_25_0 = arg_25_0[iter_25_0].row * var_0_1.MAX_COLUMN + var_5.column
			local var_25_1 = arg_23_0.bottom
			local var_25_2 = var_7.GetChild(var_25_1, var_25_0)
			local var_25_3 = var_7.Find(var_25_2, "lines")

			for iter_25_1 = 0, var_25_3.childCount - 1 do
				setActive = var_2_10012

				var_2_10012(var_25_3:GetChild(iter_25_1), false)
			end
		end

		return
	end

	local var_23_2
	local var_23_3
	local var_23_4
	local var_23_5 = arg_23_0.list

	var_6.each(var_23_5, function(arg_26_0, arg_26_1)
		onButton = var_2_10002

		local var_26_0 = arg_23_0
		local var_26_1 = arg_26_1:Find("display/icon")

		local function var_26_2()
			math = var_3_10000

			local var_27_0 = var_3_10000.floor(arg_26_0 / var_0_1.MAX_COLUMN)
			local var_27_1 = arg_26_0 % var_0_1.MAX_COLUMN

			if arg_23_0.cards[var_27_0][var_27_1].state ~= var_0_1.CARD_STATE_NORMAL then
				return
			elseif not var_23_2 then
				var_23_2 = var_2
				var_23_3 = arg_26_1
				setActive = var_3

				local var_27_2 = arg_26_1

				var_3(var_4.Find(var_27_2, "display/selected"), true)
			elseif var_23_4 then
				return
			elseif var_23_2 == var_2 then
				setActive = var_3

				local var_27_3 = arg_26_1

				var_3(var_4.Find(var_27_3, "display/selected"), false)

				var_23_3 = nil
				var_23_2 = nil
			elseif var_23_2.id ~= var_2.id then
				setActive = var_3

				local var_27_4 = var_23_3

				var_3(var_4.Find(var_27_4, "display/selected"), false)

				var_23_3 = nil
				var_23_2 = nil
			else
				local var_27_5 = arg_23_0

				if not var_3.LinkLink(var_27_5, var_23_2, var_2) then
					setActive = var_27_5

					local var_27_6 = var_23_3

					var_27_5(var_5.Find(var_27_6, "display/selected"), false)

					var_23_3 = nil
					var_23_2 = nil
				else
					var_2.state = var_0_1.CARD_STATE_LINKED

					local var_27_7 = var_23_2

					var_27_7.state = var_0_1.CARD_STATE_LINKED
					setActive = var_27_7

					local var_27_8 = arg_26_1

					var_27_7(var_5.Find(var_27_8, "display/selected"), true)
					var_23_0(var_3)

					var_23_4 = true

					local var_27_9 = arg_26_1
					local var_27_10 = var_23_3

					GetComponent = var_6

					local var_27_11 = var_27_9

					typeof = var_3_10008
					Animator = var_3_10009

					local var_27_12 = var_6(var_27_11, var_3_10008(var_3_10009))

					GetComponent = var_27_11

					local var_27_13 = var_27_10

					typeof = var_3_10009
					Animator = var_3_10010

					local var_27_14 = var_27_11(var_27_13, var_3_10009(var_3_10010))

					GetComponent = var_27_13

					local var_27_15 = var_27_13(var_27_9, "DftAniEvent")

					GetComponent = var_9

					local var_27_16 = var_9(var_27_10, "DftAniEvent")

					var_27_12:SetBool("AniSwitch", true)
					var_27_14:SetBool("AniSwitch", true)
					var_27_16:SetEndEvent(function(arg_28_0)
						var_23_1(var_0)

						var_23_4 = false
						var_23_3 = nil
						var_23_2 = nil

						local var_28_0 = true

						for iter_28_0 = 0, var_0_1.MAX_ROW - 1 do
							for iter_28_1 = 0, var_0_1.MAX_COLUMN - 1 do
								if arg_23_0.cards[iter_28_0][iter_28_1].state == var_0_1.CARD_STATE_NORMAL then
									var_28_0 = false

									break
								end
							end
						end

						if var_28_0 then
							local var_28_1 = arg_23_0

							var_2.SetState(var_28_1, var_0_1.GAME_STATE_END)
						end

						return
					end)
				end
			end

			return
		end

		SFX_PANEL = var_6

		var_2_10002(var_26_0, var_26_1, var_26_2, var_6)

		return
	end)

	IsUnityEditor = var_6

	if var_6 then
		AUTO_LINKLINK = var_6

		if var_6 then
			setActive = var_6

			var_6(arg_23_0.helpBtn, true)

			onButton = var_6

			var_6(arg_23_0, arg_23_0.helpBtn, function()
				var_23_2 = nil
				var_23_3 = nil

				for iter_29_0 = 0, var_0_1.MAX_ROW - 1 do
					for iter_29_1 = 0, var_0_1.MAX_COLUMN - 1 do
						local var_29_0 = arg_23_0.cards[iter_29_0][iter_29_1].row * var_0_1.MAX_COLUMN + var_8.column
						local var_29_1 = arg_23_0.layout
						local var_29_2 = var_10.GetChild(var_29_1, var_29_0)

						if var_8.state == var_0_1.CARD_STATE_NORMAL then
							for iter_29_2 = 0, var_0_1.MAX_ROW - 1 do
								for iter_29_3 = 0, var_0_1.MAX_COLUMN - 1 do
									if iter_29_0 ~= iter_29_2 or iter_29_1 ~= iter_29_3 then
										local var_29_3 = arg_23_0.cards[iter_29_2][iter_29_3].row * var_0_1.MAX_COLUMN + var_19.column
										local var_29_4 = arg_23_0.layout
										local var_29_5 = var_21.GetChild(var_29_4, var_29_3)

										if var_8.id == var_19.id then
											triggerButton = var_22

											var_22(var_29_2:Find("display/icon"))

											triggerButton = var_22

											var_22(var_29_5:Find("display/icon"))

											if var_23_4 then
												Timer = var_22

												local var_29_6 = var_22.New(function()
													triggerButton = var_3_10000

													var_3_10000(arg_23_0.helpBtn)

													return
												end, 0.4, 1)

												var_22.Start(var_29_6)

												return
											end
										end
									end
								end
							end
						end
					end
				end

				return
			end)
		end
	end

	local var_23_6 = 0

	onButton = var_23_5

	local var_23_7 = arg_23_0
	local var_23_8 = arg_23_0.resetBtn

	local function var_23_9()
		if arg_23_0.state ~= var_0_1.GAME_STATE_GAMING then
			return
		else
			Time = var_0

			if var_0.realtimeSinceStartup - var_23_6 < var_0_1.RESET_CD then
				pg = var_0

				local var_31_0 = var_0.TipsMgr.GetInstance()
				local var_31_1 = var_0.ShowTips

				i18n = var_2_10002

				var_31_1(var_31_0, var_2_10002("common_wait"))
			else
				if var_23_2 then
					setActive = var_0

					local var_31_2 = var_23_3

					var_0(var_1.Find(var_31_2, "display/selected"), false)

					var_23_3 = nil
					var_23_2 = nil
				end

				local var_31_3 = {}
				local var_31_4 = {}

				for iter_31_0 = 0, var_0_1.MAX_ROW - 1 do
					for iter_31_1 = 0, var_0_1.MAX_COLUMN - 1 do
						if arg_23_0.cards[iter_31_0][iter_31_1].state == var_0_1.CARD_STATE_NORMAL then
							table = var_11

							var_11.insert(var_31_3, {
								row = iter_31_0,
								column = iter_31_1
							})

							table = var_11

							var_11.insert(var_31_4, var_10.id)
						end
					end
				end

				local var_31_5 = 1

				::label_31_0::

				local var_31_6 = #var_31_4

				if 0 < var_31_6 then
					repeat
						math = var_31_6
						var_31_6 = var_31_6.clamp
						math = var_31_7

						local var_31_7 = var_31_7.floor

						math = iter_31_0
						var_31_6 = var_31_6(var_31_7(iter_31_0.random() * #var_31_4 + 1), 1, #var_31_4)
						var_31_7 = arg_23_0.cards[var_31_3[var_31_5].row][var_31_3[var_31_5].column]
						var_31_7.id = var_31_4[var_31_6]
						table = var_31_7

						var_31_7.remove(var_31_4, var_31_6)

						var_31_5 = var_31_5 + 1

						goto label_31_0
					until true
				end

				local var_31_8 = arg_23_0.list

				var_3.each(var_31_8, function(arg_32_0, arg_32_1)
					math = var_3_10002

					local var_32_0 = var_3_10002.floor(arg_32_0 / var_0_1.MAX_COLUMN)
					local var_32_1 = arg_32_0 % var_0_1.MAX_COLUMN

					if arg_23_0.cards[var_32_0][var_32_1].state == var_0_1.CARD_STATE_NORMAL then
						getImageSprite = var_5

						local var_32_2 = arg_23_0.resource
						local var_32_3 = var_5(var_6.GetChild(var_32_2, var_4.id))

						setImageSprite = var_6

						var_6(arg_32_1:Find("display/icon"), var_32_3)
					end

					return
				end)

				Time = var_3
				var_23_6 = var_3.realtimeSinceStartup
			end
		end

		return
	end

	SFX_PANEL = var_1_10011

	var_23_5(var_23_7, var_23_8, var_23_9, var_1_10011)

	Time = var_23_5
	arg_23_0.startTime = var_23_5.realtimeSinceStartup
	Timer = var_7
	arg_23_0.countTimer = var_7.New(function()
		local var_33_0 = arg_23_0

		math = var_2_10001

		local var_33_1 = var_2_10001.floor

		Time = var_2_10002
		var_33_0.lastRecord = var_33_1((var_2_10002.realtimeSinceStartup - arg_23_0.startTime) * 1000)
		math = var_33_0

		local var_33_2 = var_33_0.floor(arg_23_0.lastRecord)

		setText = var_1

		local var_33_3 = arg_23_0.timeTxt
		local var_33_4 = arg_23_0

		var_1(var_33_3, var_3.FormatRecordTime(var_33_4, var_33_2))

		return
	end, 0.033, -1)

	local var_23_10 = arg_23_0.countTimer

	var_7.Start(var_23_10)
	arg_23_0.countTimer.func()

	return
end

function var_0_1.GameEnd(arg_34_0)
	local var_34_0 = arg_34_0.countTimer

	var_1.Stop(var_34_0)

	arg_34_0.countTimer = nil

	if arg_34_0.bestScoreTable[arg_34_0.linkGameID] == 0 then
		local var_34_1 = arg_34_0.linkGameID

		pg = var_2

		local var_34_2 = var_34_1 == #var_2.activity_event_linkgame.all and 0 or 1

		pg = var_2

		local var_34_3 = var_2.m02
		local var_34_4 = var_2.sendNotification

		GAME = var_1_10004

		local var_34_5 = var_1_10004.SEND_MINI_GAME_OP
		local var_34_6 = {}
		local var_34_7 = arg_34_0.miniGameData

		var_34_6.hubid = var_6.getConfig(var_34_7, "hub_id")
		MiniGameOPCommand = var_6
		var_34_6.cmd = var_6.CMD_COMPLETE
		var_34_6.args1 = {
			var_34_2,
			arg_34_0.linkGameID
		}

		var_34_4(var_34_3, var_34_5, var_34_6)

		local var_34_8 = arg_34_0.bestScoreTable

		var_34_8[arg_34_0.linkGameID] = arg_34_0.lastRecord
		setText = var_34_8

		var_34_8(arg_34_0.bestTxt, arg_34_0:FormatRecordTime(arg_34_0.bestScoreTable[arg_34_0.linkGameID]))

		SetActive = var_34_8

		var_34_8(arg_34_0.resultNewImg, true)
		arg_34_0:StoreDataToServer(arg_34_0.bestScoreTable)
	else
		local var_34_9

		if arg_34_0.lastRecord < arg_34_0.bestScoreTable[arg_34_0.linkGameID] then
			var_34_9 = arg_34_0.bestScoreTable
			var_34_9[arg_34_0.linkGameID] = arg_34_0.lastRecord
			setText = var_34_9

			var_34_9(arg_34_0.bestTxt, arg_34_0:FormatRecordTime(arg_34_0.bestScoreTable[arg_34_0.linkGameID]))

			SetActive = var_34_9

			var_34_9(arg_34_0.resultNewImg, true)
			arg_34_0:StoreDataToServer(arg_34_0.bestScoreTable)
			arg_34_0:showResultPanel(true)
		else
			SetActive = var_34_9

			var_34_9(arg_34_0.resultNewImg, false)
			arg_34_0:showResultPanel(true)
		end
	end

	return
end

function var_0_1.LinkLink(arg_35_0, arg_35_1, arg_35_2)
	assert = var_1_10003

	var_1_10003(arg_35_1.row ~= arg_35_2.row or arg_35_1.column ~= arg_35_2.column)

	assert = var_1_10003

	var_1_10003(arg_35_1.id == arg_35_2.id)

	local var_35_0 = {
		row = arg_35_1.row,
		column = arg_35_1.column
	}
	local var_35_1 = {
		row = arg_35_2.row,
		column = arg_35_2.column
	}
	local var_35_2 = {}
	local var_35_3 = {}

	table = var_1_10007

	var_1_10007.insert(var_35_2, var_35_0)

	table = var_7

	var_7.insert(var_35_3, var_35_0)

	for iter_35_0 = 1, 3 do
		if arg_35_0:IterateByOneSnap(var_35_1, arg_35_1.id, var_35_2, var_35_3) then
			local var_35_4 = {
				var_35_7
			}

			while var_35_7 and var_35_7.from do
				if var_35_7.row ~= var_35_7.from.row then
					local var_35_5 = var_35_7.row > var_35_7.from.row and -1 or 1

					for iter_35_1 = var_35_7.row + var_35_5, var_35_7.from.row, var_35_5 do
						table = var_1_10018

						var_1_10018.insert(var_35_4, {
							row = iter_35_1,
							column = var_35_7.column
						})
					end
				else
					local var_35_6

					if var_35_7.from.column ~= var_35_7.column then
						var_35_6 = var_35_7.column > var_35_7.from.column and -1 or 1

						for iter_35_2 = var_35_7.column + var_35_6, var_35_7.from.column, var_35_6 do
							table = var_1_10018

							var_1_10018.insert(var_35_4, {
								row = var_35_7.row,
								column = iter_35_2
							})
						end
					else
						assert = var_35_6

						var_35_6(false)
					end
				end

				local var_35_7 = var_35_7.from
			end

			return var_35_4
		end
	end

	return
end

function var_0_1.IterateByOneSnap(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	for iter_36_0 = 1, #arg_36_3 do
		local var_36_0 = arg_36_0
		local var_36_1 = arg_36_0.FindDirectLinkPoint(var_36_0, arg_36_2, arg_36_3[iter_36_0], arg_36_4, arg_36_1)

		ipairs = var_36_0

		for iter_36_1, iter_36_2 in var_36_0(var_36_1) do
			if iter_36_2.row == arg_36_1.row and iter_36_2.column == arg_36_1.column then
				return iter_36_2
			end

			table = var_15

			var_15.insert(arg_36_3, iter_36_2)
		end
	end

	_ = var_5

	var_5.each(arg_36_3, function(arg_37_0)
		arg_36_4[arg_37_0.row .. "_" .. arg_37_0.column] = true

		return
	end)

	return
end

function var_0_1.FindDirectLinkPoint(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4)
	local var_38_0 = {}

	for iter_38_0 = arg_38_2.row - 1, 0, -1 do
		local var_38_1 = iter_38_0 .. "_" .. arg_38_2.column

		if arg_38_0.cards[iter_38_0][arg_38_2.column].state == var_0_1.CARD_STATE_NORMAL and var_11.id == arg_38_1 then
			if iter_38_0 == arg_38_4.row and arg_38_2.column == arg_38_4.column then
				table = var_12

				var_12.insert(var_38_0, {
					row = iter_38_0,
					column = arg_38_2.column,
					from = arg_38_2
				})
			end

			break
		end

		if false then
			break
		end

		if var_11.state == var_0_1.CARD_STATE_NORMAL and var_11.id ~= arg_38_1 or arg_38_3[var_38_1] then
			break
		end

		table = var_12

		var_12.insert(var_38_0, {
			row = iter_38_0,
			column = arg_38_2.column,
			from = arg_38_2
		})
	end

	for iter_38_1 = arg_38_2.row + 1, var_0_1.MAX_ROW - 1 do
		local var_38_2 = iter_38_1 .. "_" .. arg_38_2.column

		if arg_38_0.cards[iter_38_1][arg_38_2.column].state == var_0_1.CARD_STATE_NORMAL and var_11.id == arg_38_1 then
			if iter_38_1 == arg_38_4.row and arg_38_2.column == arg_38_4.column then
				table = var_12

				var_12.insert(var_38_0, {
					row = iter_38_1,
					column = arg_38_2.column,
					from = arg_38_2
				})
			end

			break
		end

		if false then
			break
		end

		if var_11.state == var_0_1.CARD_STATE_NORMAL and var_11.id ~= arg_38_1 or arg_38_3[var_38_2] then
			break
		end

		table = var_12

		var_12.insert(var_38_0, {
			row = iter_38_1,
			column = arg_38_2.column,
			from = arg_38_2
		})
	end

	for iter_38_2 = arg_38_2.column - 1, 0, -1 do
		local var_38_3 = arg_38_2.row .. "_" .. iter_38_2

		if arg_38_0.cards[arg_38_2.row][iter_38_2].state == var_0_1.CARD_STATE_NORMAL and var_11.id == arg_38_1 then
			if arg_38_2.row == arg_38_4.row and iter_38_2 == arg_38_4.column then
				table = var_12

				var_12.insert(var_38_0, {
					row = arg_38_2.row,
					column = iter_38_2,
					from = arg_38_2
				})
			end

			break
		end

		if false then
			break
		end

		if var_11.state == var_0_1.CARD_STATE_NORMAL and var_11.id ~= arg_38_1 or arg_38_3[var_38_3] then
			break
		end

		table = var_12

		var_12.insert(var_38_0, {
			row = arg_38_2.row,
			column = iter_38_2,
			from = arg_38_2
		})
	end

	for iter_38_3 = arg_38_2.column + 1, var_0_1.MAX_COLUMN - 1 do
		local var_38_4 = arg_38_2.row .. "_" .. iter_38_3

		if arg_38_0.cards[arg_38_2.row][iter_38_3].state == var_0_1.CARD_STATE_NORMAL and var_11.id == arg_38_1 then
			if arg_38_2.row == arg_38_4.row and iter_38_3 == arg_38_4.column then
				table = var_12

				var_12.insert(var_38_0, {
					row = arg_38_2.row,
					column = iter_38_3,
					from = arg_38_2
				})
			end

			break
		end

		if false then
			break
		end

		if var_11.state == var_0_1.CARD_STATE_NORMAL and var_11.id ~= arg_38_1 or arg_38_3[var_38_4] then
			break
		end

		table = var_12

		var_12.insert(var_38_0, {
			row = arg_38_2.row,
			column = iter_38_3,
			from = arg_38_2
		})
	end

	return var_38_0
end

function var_0_1.setIconList(arg_39_0)
	local var_39_0 = {}
	local var_39_1 = arg_39_0:GetMGData()
	local var_39_2 = var_2.GetRuntimeData(var_39_1, "curLinkGameID")

	print = var_39_1

	local var_39_3 = "当前地图ID"

	tostring = var_1_10006

	var_39_1(var_39_3, var_1_10006(var_39_2))

	local var_39_4 = var_2:GetConfigCsvLine(var_39_2).block

	ipairs = var_6

	for iter_39_0, iter_39_1 in var_6(var_39_4) do
		local var_39_5 = iter_39_1[1]

		if iter_39_1[2] % 2 ~= 0 then
			assert = var_13

			var_13(false, "资源名" .. var_39_5 .. "数量不为偶数" .. var_12)
		end

		local var_39_6 = var_0_1.NAME_TO_INDEX[var_39_5]

		assert = var_1_10014

		var_1_10014(var_39_6, "没有定义该资源名" .. var_39_5)

		for iter_39_2 = 1, var_12 do
			table = var_1_10018

			var_1_10018.insert(var_39_0, var_39_6)
		end
	end

	if #var_39_0 ~= 36 then
		assert = var_6

		var_6(false, "总数不为36")
	end

	return var_39_0
end

function var_0_1.FormatRecordTime(arg_40_0, arg_40_1)
	math = var_1_10002

	local var_40_0 = var_1_10002.floor(arg_40_1 / 60000)

	var_40_0 = 10 <= var_40_0 and var_40_0 or "0" .. var_40_0
	math = var_3

	local var_40_1 = var_3.floor(arg_40_1 % 60000 / 1000)

	var_40_1 = 10 <= var_40_1 and var_40_1 or "0" .. var_40_1
	math = var_4

	local var_40_2 = var_4.floor(arg_40_1 % 1000 / 10) >= 10 and var_40_2 or "0" .. var_40_2

	return var_40_0 .. "'" .. var_40_1 .. "'" .. var_40_2
end

return var_0_1
