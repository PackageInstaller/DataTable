class = var_0_10000

local var_0_0 = "RPSGameLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))
local var_0_2 = 0
local var_0_3 = "ui/rpsgameui_atlas"
local var_0_4 = 75
local var_0_5 = 1
local var_0_6 = 2
local var_0_7 = 3
local var_0_8 = 4
local var_0_9 = 5
local var_0_10 = 5
local var_0_11 = 3
local var_0_12 = 0.1
local var_0_13 = 0.1
local var_0_14 = 2
local var_0_15 = 5
local var_0_16 = 0.7
local var_0_17 = 12 * var_0_16
local var_0_18 = "event show panel closed"
local var_0_19 = "event take card"
local var_0_20 = "event compared card end"
local var_0_21 = {
	["23"] = "action9",
	["13"] = "action3",
	["33"] = "action4",
	["12"] = "action2",
	["11"] = "action1",
	["32"] = "action6",
	["22"] = "action7",
	["21"] = "action8",
	["31"] = "action5"
}

local function var_0_22(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = {
		Ctor = function(arg_2_0)
			arg_2_0._tf = arg_1_0
			arg_2_0._event = arg_1_1
			arg_2_0._topCardTpl = arg_1_3
			arg_2_0._bottomCardTpl = arg_1_2
			setActive = var_1

			var_1(arg_2_0._tf, false)

			GetComponent = var_1
			findTF = var_3

			local var_2_0 = var_3(arg_2_0._tf, "top/bg/desc/img")

			typeof = var_4
			Image = var_6

			local var_2_1 = var_1(var_2_0, var_4(var_6))

			var_1.SetNativeSize(var_2_1)

			GetComponent = var_1
			findTF = var_2_1

			local var_2_2 = var_2_1(arg_2_0._tf, "bottom/bg/desc/img")

			typeof = var_4
			Image = var_2_5

			local var_2_3 = var_1(var_2_2, var_4(var_2_5))

			var_1.SetNativeSize(var_2_3)

			findTF = var_1
			arg_2_0._topContent = var_1(arg_2_0._tf, "top/content")
			findTF = var_1
			arg_2_0._bottomContent = var_1(arg_2_0._tf, "bottom/content")
			arg_2_0.topCards = {}
			arg_2_0.bottomCards = {}

			for iter_2_0 = 1, var_0_9 do
				tf = var_2_4
				instantiate = var_2_10007

				local var_2_4 = var_2_4(var_2_10007(arg_2_0._topCardTpl))

				tf = var_2_5
				instantiate = var_2_10008

				local var_2_5 = var_2_5(var_2_10008(arg_2_0._bottomCardTpl))

				SetParent = var_2_10007

				var_2_10007(var_2_4, arg_2_0._topContent)

				SetParent = var_2_10007

				var_2_10007(var_2_5, arg_2_0._bottomContent)

				setActive = var_2_10007

				var_2_10007(var_2_4, true)

				setActive = var_2_10007

				var_2_10007(var_2_5, true)

				table = var_2_10007

				var_2_10007.insert(arg_2_0.topCards, var_2_4)

				table = var_2_10007

				var_2_10007.insert(arg_2_0.bottomCards, var_2_5)
			end

			return
		end,
		setCardData = function(arg_3_0, arg_3_1)
			local var_3_0 = arg_3_1.other_cards
			local var_3_1 = arg_3_1.my_cards

			for iter_3_0 = 1, var_0_9 do
				local var_3_2 = arg_3_0
				local var_3_3 = arg_3_0.setCardChildsVisible

				findTF = var_2_10011

				var_3_3(var_3_2, var_2_10011(arg_3_0.topCards[iter_3_0], "ad"), false)

				local var_3_4 = arg_3_0
				local var_3_5 = arg_3_0.setCardChildsVisible

				findTF = var_2_10011

				var_3_5(var_3_4, var_2_10011(arg_3_0.bottomCards[iter_3_0], "ad"), false)

				setActive = var_3_5
				findTF = var_3_4

				var_3_5(var_3_4(arg_3_0.topCards[iter_3_0], "ad/" .. var_3_0[iter_3_0]), true)

				setActive = var_3_5
				findTF = var_10

				var_3_5(var_10(arg_3_0.bottomCards[iter_3_0], "ad/" .. var_3_1[iter_3_0]), true)
			end

			return
		end,
		setCardChildsVisible = function(arg_4_0, arg_4_1, arg_4_2)
			for iter_4_0 = 1, arg_4_1.childCount do
				setActive = var_2_10007

				var_2_10007(arg_4_1:GetChild(iter_4_0 - 1), arg_4_2)
			end

			return
		end,
		start = function(arg_5_0)
			arg_5_0._countTime = var_0_10

			arg_5_0:setVisible(true)

			return
		end,
		step = function(arg_6_0, arg_6_1)
			if arg_6_0._countTime then
				arg_6_0._countTime = arg_6_0._countTime - arg_6_1

				if arg_6_0._countTime <= 0 then
					arg_6_0._countTime = nil

					arg_6_0:setVisible(false)

					local var_6_0 = arg_6_0._event

					var_2.emit(var_6_0, var_0_18)

					return
				end
			end

			return
		end,
		setVisible = function(arg_7_0, arg_7_1)
			setActive = var_2_10002

			var_2_10002(arg_7_0._tf, arg_7_1)

			return
		end
	}

	var_4.Ctor(var_1_0)

	return var_4
end

local function var_0_23(arg_8_0, arg_8_1)
	local var_8_0 = {
		Ctor = function(arg_9_0)
			arg_9_0._tf = arg_8_0
			arg_9_0._event = arg_8_1
			findTF = var_1
			arg_9_0.btnTake = var_1(arg_9_0._tf, "btnTake")
			setText = var_1
			findTF = var_3

			local var_9_0 = var_3(arg_9_0.btnTake, "txt")

			i18n = var_4

			var_1(var_9_0, var_4("rps_game_take_card"))

			onButton = var_1

			local var_9_1 = arg_9_0._event
			local var_9_2 = arg_9_0.btnTake

			local function var_9_3()
				local var_10_0 = arg_9_0

				var_0.takeMyCard(var_10_0)

				return
			end

			SFX_CONFIRM = var_6

			var_1(var_9_1, var_9_2, var_9_3, var_6)

			arg_9_0.myCardTfs = {}

			for iter_9_0 = 1, var_0_9 do
				findTF = var_9_3
				var_9_3 = var_9_3(arg_9_0._tf, "bottomCard/cardContent/" .. iter_9_0)
				table = var_6

				var_6.insert(arg_9_0.myCardTfs, var_9_3)

				onButton = var_6
				var_2_10008 = arg_9_0._event

				local var_9_4 = var_9_3

				local function var_9_5()
					if arg_9_0.lockSelect then
						return
					end

					arg_9_0.cardSelectIndex = iter_9_0

					local var_11_0 = arg_9_0

					var_0.updateSelectCard(var_11_0)

					return
				end

				SFX_CONFIRM = var_2_10011

				var_6(var_2_10008, var_9_4, var_9_5, var_2_10011)
			end

			arg_9_0.otherCardTfs = {}

			for iter_9_1 = 1, var_0_9 do
				table = var_9_3
				var_9_3 = var_9_3.insert

				local var_9_6 = arg_9_0.otherCardTfs

				findTF = var_2_10008

				var_9_3(var_9_6, var_2_10008(arg_9_0._tf, "topCard/cardContent/" .. iter_9_1))
			end

			arg_9_0.myHearts = {}
			arg_9_0.otherHearts = {}

			for iter_9_2 = 1, var_0_11 do
				table = var_9_3
				var_9_3 = var_9_3.insert

				local var_9_7 = arg_9_0.myHearts

				findTF = var_2_10008

				var_9_3(var_9_7, var_2_10008(arg_9_0._tf, "bottomStatus/heart/" .. iter_9_2))

				table = var_9_3
				var_9_3 = var_9_3.insert

				local var_9_8 = arg_9_0.otherHearts

				findTF = var_2_10008

				var_9_3(var_9_8, var_2_10008(arg_9_0._tf, "topStatus/heart/" .. iter_9_2))
			end

			findTF = var_1
			arg_9_0.takeTimeText = var_1(arg_9_0._tf, "takeTime/text")
			findTF = var_1
			arg_9_0.compareTf = var_1(arg_9_0._tf, "compare")
			findTF = var_1
			arg_9_0.spineAnimTf = var_1(arg_9_0._tf, "compare/mask/RPSSpine")
			GetComponent = var_1

			local var_9_9 = arg_9_0.spineAnimTf

			typeof = var_4
			SpineAnimUI = var_6
			arg_9_0.spineAnim = var_1(var_9_9, var_4(var_6))

			return
		end,
		updateSelectCard = function(arg_12_0)
			for iter_12_0 = 1, #arg_12_0.myCardTfs do
				local var_12_0 = arg_12_0.myCardTfs[iter_12_0].anchoredPosition

				if arg_12_0.cardSelectIndex and arg_12_0.cardSelectIndex == iter_12_0 then
					local var_12_1 = arg_12_0.myCardTfs[iter_12_0]

					Vector2 = var_2_10007
					var_12_1.anchoredPosition = var_2_10007(var_12_0.x, 100)
					setActive = var_12_1
					findTF = var_2_10008

					var_12_1(var_2_10008(arg_12_0.myCardTfs[iter_12_0], "AD/select"), true)
				else
					local var_12_2 = arg_12_0.myCardTfs[iter_12_0]

					Vector2 = var_2_10007
					var_12_2.anchoredPosition = var_2_10007(var_12_0.x, 0)
					setActive = var_12_2
					findTF = var_2_10008

					var_12_2(var_2_10008(arg_12_0.myCardTfs[iter_12_0], "AD/select"), false)
				end
			end

			return
		end,
		updateDetail = function(arg_13_0, arg_13_1)
			local var_13_0 = arg_13_1.my_cards
			local var_13_1 = arg_13_1.other_cards
			local var_13_2 = arg_13_1.my_heart
			local var_13_3 = arg_13_1.other_heart

			arg_13_0.myCardNum = #var_13_0
			arg_13_0.otherCardNum = #var_13_1
			setActive = var_6

			var_6(arg_13_0.btnTake, #var_13_0 ~= 0)

			for iter_13_0 = 1, #arg_13_0.myCardTfs do
				if iter_13_0 <= #var_13_0 then
					arg_13_0:updateCardIndex(arg_13_0.myCardTfs[iter_13_0], var_13_0[iter_13_0], false)
				end

				setActive = var_2_10010

				var_2_10010(arg_13_0.myCardTfs[iter_13_0], iter_13_0 <= #var_13_0)
			end

			for iter_13_1 = 1, #arg_13_0.otherCardTfs do
				arg_13_0:updateCardCount(arg_13_0.otherCardTfs[iter_13_1], #var_13_1)

				if arg_13_0.otherCardNum <= 0 then
					setActive = var_2_10010

					var_2_10010(arg_13_0.otherCardTfs[iter_13_1], false)
				else
					setActive = var_2_10010

					var_2_10010(arg_13_0.otherCardTfs[iter_13_1], iter_13_1 <= 1)
				end
			end

			for iter_13_2 = 1, #arg_13_0.myHearts do
				setActive = var_2_10010

				var_2_10010(arg_13_0.myHearts[iter_13_2], iter_13_2 <= var_13_2)
			end

			for iter_13_3 = 1, #arg_13_0.otherHearts do
				setActive = var_2_10010

				var_2_10010(arg_13_0.otherHearts[iter_13_3], iter_13_3 <= var_13_3)
			end

			local var_13_4 = arg_13_0.takeTimeText

			Vector2 = var_7
			var_13_4.anchoredPosition = var_7(-(var_0_9 - arg_13_0.myCardNum) * var_0_17, 0)

			return
		end,
		updateCardCount = function(arg_14_0, arg_14_1, arg_14_2)
			setText = var_2_10003
			findTF = var_2_10005

			local var_14_0 = var_2_10005(arg_14_1, "text")

			tostring = var_2_10006

			var_2_10003(var_14_0, var_2_10006(arg_14_2))

			return
		end,
		updateCardIndex = function(arg_15_0, arg_15_1, arg_15_2)
			local var_15_0 = arg_15_0
			local var_15_1 = arg_15_0.setCardChildsVisible

			findTF = var_2_10006

			var_15_1(var_15_0, var_2_10006(arg_15_1, "AD"), false)

			setActive = var_15_1
			findTF = var_15_0

			var_15_1(var_15_0(arg_15_1, "AD/" .. arg_15_2), true)

			return
		end,
		setCardChildsVisible = function(arg_16_0, arg_16_1, arg_16_2)
			for iter_16_0 = 1, arg_16_1.childCount do
				setActive = var_2_10007

				var_2_10007(arg_16_1:GetChild(iter_16_0 - 1), arg_16_2)
			end

			return
		end,
		start = function(arg_17_0)
			arg_17_0.cardSelectIndex = nil

			arg_17_0:updateLock(false)
			arg_17_0:setVisible(false)

			setActive = var_1

			var_1(arg_17_0.compareTf, false)

			return
		end,
		step = function(arg_18_0, arg_18_1)
			if arg_18_0.myCardTime and not arg_18_0.myCardCompared and arg_18_0.myCardTime > 0 then
				arg_18_0.myCardTime = arg_18_0.myCardTime - arg_18_1

				if arg_18_0.myCardTime <= 0 then
					arg_18_0.myCardTime = nil
					math = var_2
					arg_18_0.cardSelectIndex = var_2.random(1, arg_18_0.myCardNum)

					arg_18_0:takeMyCard()
				end
			end

			if not arg_18_0.comparedShowTime and arg_18_0.myCardCompared and arg_18_0.otherCardCompared then
				arg_18_0.comparedShowTime = var_0_12
			end

			if arg_18_0.comparedShowTime and arg_18_0.comparedShowTime > 0 then
				arg_18_0.comparedShowTime = arg_18_0.comparedShowTime - arg_18_1

				if arg_18_0.comparedShowTime <= 0 then
					arg_18_0.comparedShowTime = 0
					setActive = var_2

					var_2(arg_18_0.compareTf, true)
					arg_18_0:SetActionWithFinishCallback(arg_18_0.spineAnim, var_0_21[arg_18_0.myCardCompared .. arg_18_0.otherCardCompared], 0, function()
						setActive = var_3_10000

						var_3_10000(arg_18_0.compareTf, false)

						arg_18_0.comparedStepTime = var_0_13

						return
					end, true, function()
						return
					end)
				end
			end

			if arg_18_0.comparedStepTime and arg_18_0.comparedStepTime > 0 then
				arg_18_0.comparedStepTime = arg_18_0.comparedStepTime - arg_18_1

				if arg_18_0.comparedStepTime and arg_18_0.comparedStepTime <= 0 then
					arg_18_0.comparedStepTime = nil
					arg_18_0.comparedShowTime = nil
					arg_18_0.myCardCompared = nil
					arg_18_0.otherCardCompared = nil

					local var_18_0 = arg_18_0._event

					var_2.emit(var_18_0, var_0_20)
				end
			end

			if arg_18_0.myCardTime then
				setText = var_2

				local var_18_1 = arg_18_0.takeTimeText

				tostring = var_2_10005
				math = var_2_10007

				var_2(var_18_1, var_2_10005(var_2_10007.ceil(arg_18_0.myCardTime)))
			else
				setText = var_2

				var_2(arg_18_0.takeTimeText, "")
			end

			if arg_18_0.myCardCompared then
				isActive = var_2

				if var_2(arg_18_0.btnTake) then
					setActive = var_2

					var_2(arg_18_0.btnTake, false)

					goto label_18_0
				end
			end

			if not arg_18_0.myCardCompared then
				isActive = var_2

				if not var_2(arg_18_0.btnTake) then
					setActive = var_2

					var_2(arg_18_0.btnTake, true)
				end
			end

			::label_18_0::

			return
		end,
		startUp = function(arg_21_0)
			arg_21_0.myCardTime = var_0_15

			arg_21_0:setVisible(true)

			return
		end,
		setMyCompareCard = function(arg_22_0, arg_22_1)
			arg_22_0.myCardCompared = arg_22_1

			return
		end,
		setOtherCompareCard = function(arg_23_0, arg_23_1)
			arg_23_0.otherCardCompared = arg_23_1

			return
		end,
		takeMyCard = function(arg_24_0)
			if arg_24_0.lockSelect then
				return
			end

			if arg_24_0.myCardNum == 1 and not arg_24_0.cardSelectIndex then
				arg_24_0.cardSelectIndex = 1
			end

			if arg_24_0.cardSelectIndex then
				local var_24_0 = arg_24_0._event

				var_1.emit(var_24_0, var_0_19, arg_24_0.cardSelectIndex)

				arg_24_0.cardSelectIndex = nil

				arg_24_0:updateLock(true)
				arg_24_0:updateSelectCard()
			end

			return
		end,
		updateLock = function(arg_25_0, arg_25_1)
			local var_25_0

			if arg_25_1 or not var_0_15 then
				var_25_0 = nil
			end

			arg_25_0.myCardTime = var_25_0
			arg_25_0.lockSelect = arg_25_1

			return
		end,
		setVisible = function(arg_26_0, arg_26_1)
			setActive = var_2_10002

			var_2_10002(arg_26_0._tf, arg_26_1)

			return
		end,
		SetActionWithFinishCallback = function(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5, arg_27_6)
			if arg_27_4 or arg_27_6 then
				arg_27_1:SetActionCallBack(function(arg_28_0)
					if arg_28_0 == "finish" and arg_27_4 then
						local var_28_0 = arg_27_1

						var_1.SetActionCallBack(var_28_0, nil)
						arg_27_4()
					elseif arg_28_0 == "action" and arg_27_6 then
						arg_27_6()
					end

					return
				end)
			else
				arg_27_1:SetActionCallBack(nil)
			end

			arg_27_1:SetAction(arg_27_2, arg_27_3)

			return
		end,
		dispose = function(arg_29_0)
			local var_29_0 = arg_29_0.spineAnim

			var_1.SetActionCallBack(var_29_0, nil)

			return
		end
	}

	var_2.Ctor(var_8_0)

	return var_2
end

function var_0_1.getUIName(arg_30_0)
	return "RPSGameUI"
end

function var_0_1.didEnter(arg_31_0)
	arg_31_0:initEvent()
	arg_31_0:initData()
	arg_31_0:initUI()
	arg_31_0:initGameUI()
	arg_31_0:readyStart()

	return
end

function var_0_1.initEvent(arg_32_0)
	arg_32_0:bind(var_0_20, function(arg_33_0, arg_33_1, arg_33_2)
		if arg_32_0.myTakeCard == arg_32_0.otherTakeCard + 1 or arg_32_0.myTakeCard + 2 == arg_32_0.otherTakeCard then
			arg_32_0.gameData.my_heart = arg_32_0.gameData.my_heart - 1

			local var_33_0 = arg_32_0

			var_3.sendGamingNotice(var_33_0, 2)
		elseif arg_32_0.myTakeCard ~= arg_32_0.otherTakeCard then
			arg_32_0.gameData.other_heart = arg_32_0.gameData.other_heart - 1

			local var_33_1 = arg_32_0

			var_3.sendGamingNotice(var_33_1, 1)
		else
			local var_33_2 = arg_32_0

			var_3.sendGamingNotice(var_33_2, 3)
		end

		local var_33_3 = arg_32_0.detailPanel

		var_3.updateDetail(var_33_3, arg_32_0.gameData)

		if arg_32_0.gameData.my_heart == 0 or arg_32_0.gameData.other_heart == 0 or #arg_32_0.gameData.my_cards == 0 then
			arg_32_0.gameState = var_0_8
			arg_32_0.gameStartFlag = false

			local var_33_4 = arg_32_0

			var_3.showSettlement(var_33_4)
		else
			arg_32_0.gameState = var_0_6
			arg_32_0.myTakeCard, arg_32_0.otherTakeCard = nil

			local var_33_5 = arg_32_0.detailPanel

			var_3.updateLock(var_33_5, false)
		end

		return
	end)
	arg_32_0:bind(var_0_18, function(arg_34_0, arg_34_1, arg_34_2)
		arg_32_0.gameState = var_0_6

		if arg_32_0.detailPanel then
			local var_34_0 = arg_32_0.detailPanel

			var_3.startUp(var_34_0)
		end

		return
	end)
	arg_32_0:bind(var_0_19, function(arg_35_0, arg_35_1, arg_35_2)
		if arg_32_0.gameState == var_0_6 then
			arg_32_0.gameState = var_0_7

			local var_35_0 = arg_32_0

			table = var_4
			var_35_0.myTakeCard = var_4.remove(arg_32_0.gameData.my_cards, arg_35_1)

			local var_35_1 = arg_32_0.detailPanel

			var_3.setMyCompareCard(var_35_1, arg_32_0.myTakeCard)

			local var_35_2 = arg_32_0.detailPanel

			var_3.updateDetail(var_35_2, arg_32_0.gameData)
		end

		return
	end)

	return
end

function var_0_1.sendGamingNotice(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0
	local var_36_1 = arg_36_0.emit

	Dorm3dMiniGameMediator = var_1_10005

	var_36_1(var_36_0, var_1_10005.GAME_OPERATION, {
		operationCode = "GAME_RPS_RESULT",
		index = arg_36_1,
		miniGameId = var_0_4
	})

	return
end

function var_0_1.initData(arg_37_0)
	Application = var_1_10001

	if var_1_10001.targetFrameRate <= 60 then
		Application = var_1

		local var_37_0

		if not var_1.targetFrameRate then
			var_37_0 = 60
		end

		arg_37_0.stepCount = 1 / var_37_0
		Time = var_2
		arg_37_0.realTimeStartUp = var_2.realtimeSinceStartup
		Timer = var_2
		arg_37_0.timer = var_2.New(function()
			Time = var_2_10000

			local var_38_0 = var_2_10000.realtimeSinceStartup - arg_37_0.realTimeStartUp

			if arg_37_0.stepCount < var_38_0 then
				local var_38_1 = arg_37_0

				var_0.onTimer(var_38_1)

				local var_38_2 = arg_37_0

				Time = var_1
				var_38_2.realTimeStartUp = var_1.realtimeSinceStartup
			end

			return
		end, 1 / var_37_0, -1)

		return
	end
end

function var_0_1.initUI(arg_39_0)
	findTF = var_1_10001
	arg_39_0.backSceneTf = var_1_10001(arg_39_0._tf, "scene_container/scene_background")
	findTF = var_1
	arg_39_0.sceneTf = var_1(arg_39_0._tf, "scene_container/scene")
	findTF = var_1
	arg_39_0.bgTf = var_1(arg_39_0._tf, "bg")
	findTF = var_1
	arg_39_0.clickMask = var_1(arg_39_0._tf, "clickMask")
	findTF = var_1
	arg_39_0.settlementUI = var_1(arg_39_0._tf, "pop/SettleMentUI")
	onButton = var_1

	local var_39_0 = arg_39_0

	findTF = var_4

	local var_39_1 = var_4(arg_39_0.settlementUI, "btnOver")

	local function var_39_2()
		local var_40_0 = arg_39_0

		var_0.checkGameExit(var_40_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_39_0, var_39_1, var_39_2, var_6)

	SetActive = var_1

	var_1(arg_39_0.settlementUI, false)

	return
end

function var_0_1.initGameUI(arg_41_0)
	findTF = var_1_10001
	arg_41_0.gameUI = var_1_10001(arg_41_0._tf, "ui/gameUI")
	onButton = var_1

	local var_41_0 = arg_41_0

	findTF = var_4

	var_1(var_41_0, var_4(arg_41_0.gameUI, "btnLeave"), function()
		local var_42_0 = arg_41_0

		var_0.checkGameExit(var_42_0)

		return
	end)

	GetOrAddComponent = var_1
	arg_41_0.dragDelegate = var_1(arg_41_0.sceneTf, "EventTriggerListener")
	arg_41_0.dragDelegate.enabled = true

	local var_41_1 = arg_41_0.dragDelegate

	var_1.AddPointDownFunc(var_41_1, function(arg_43_0, arg_43_1)
		return
	end)

	local var_41_2 = var_0_22

	findTF = var_41_1

	local var_41_3 = var_41_1(arg_41_0.sceneTf, "showPanel")
	local var_41_4 = arg_41_0

	findTF = var_5

	local var_41_5 = var_5(arg_41_0.sceneTf, "tpls/card_1")

	findTF = var_6
	arg_41_0.showPanel = var_41_2(var_41_3, var_41_4, var_41_5, var_6(arg_41_0.sceneTf, "tpls/card_2"))

	local var_41_6 = var_0_23

	findTF = var_41_3
	arg_41_0.detailPanel = var_41_6(var_41_3(arg_41_0.sceneTf, "detailPanel"), arg_41_0)

	return
end

function var_0_1.Update(arg_44_0)
	if arg_44_0.gameStop or arg_44_0.settlementFlag then
		return
	end

	IsUnityEditor = var_1

	if var_1 then
		-- block empty
	end

	return
end

function var_0_1.clearUI(arg_45_0)
	setActive = var_1_10001

	var_1_10001(arg_45_0.sceneTf, false)

	setActive = var_1_10001

	var_1_10001(arg_45_0.settlementUI, false)

	setActive = var_1_10001

	var_1_10001(arg_45_0.gameUI, false)

	return
end

function var_0_1.readyStart(arg_46_0)
	arg_46_0:gameStart()

	return
end

function var_0_1.gameStart(arg_47_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_47_0._tf, "scene_container"), true)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_47_0.bgTf, "on"), false)

	setActive = var_1_10001

	var_1_10001(arg_47_0.gameUI, true)

	arg_47_0.gameStartFlag = true
	arg_47_0.scoreNum = 0
	arg_47_0.gameStepTime = 0
	arg_47_0.gameTime = var_0_2
	arg_47_0.gameData = arg_47_0:createGameData()
	arg_47_0.gameState = var_0_5

	local var_47_0 = arg_47_0.showPanel

	var_1.setCardData(var_47_0, arg_47_0.gameData)

	local var_47_1 = arg_47_0.detailPanel

	var_1.updateDetail(var_47_1, arg_47_0.gameData)
	arg_47_0:updateGameUI()
	arg_47_0:timerStart()

	if arg_47_0.showPanel then
		local var_47_2 = arg_47_0.showPanel

		var_1.start(var_47_2)
	end

	if arg_47_0.detailPanel then
		local var_47_3 = arg_47_0.detailPanel

		var_1.start(var_47_3)
	end

	return
end

function var_0_1.createGameData(arg_48_0)
	local var_48_0 = {
		1,
		2,
		3
	}
	local var_48_1 = {
		1,
		2,
		3
	}

	for iter_48_0 = 4, var_0_9 do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_48_2 = var_48_0

		math = var_1_10010

		var_1_10007(var_48_2, var_1_10010.random(1, 3))

		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_48_3 = var_48_1

		math = var_1_10010

		var_1_10007(var_48_3, var_1_10010.random(1, 3))
	end

	table = var_3

	var_3.sort(var_48_0, function(arg_49_0, arg_49_1)
		return arg_49_0 < arg_49_1
	end)

	table = var_3

	var_3.sort(var_48_1, function(arg_50_0, arg_50_1)
		return arg_50_0 < arg_50_1
	end)

	return {
		other_cards = var_48_0,
		my_cards = var_48_1,
		my_heart = var_0_11,
		other_heart = var_0_11
	}
end

function var_0_1.transformColor(arg_51_0, arg_51_1)
	tonumber = var_1_10002
	string = var_1_10004

	local var_51_0 = var_1_10002(var_1_10004.sub(arg_51_1, 1, 2), 16)

	tonumber = var_1_10003
	string = var_5

	local var_51_1 = var_1_10003(var_5.sub(arg_51_1, 3, 4), 16)

	tonumber = var_4
	string = var_6

	local var_51_2 = var_4(var_6.sub(arg_51_1, 5, 6), 16)

	Color = var_5

	return var_5.New(var_51_0 / 255, var_51_1 / 255, var_51_2 / 255)
end

function var_0_1.onTimer(arg_52_0)
	arg_52_0:gameStep()

	return
end

function var_0_1.gameStep(arg_53_0)
	Time = var_1_10001
	arg_53_0.deltaTime = var_1_10001.realtimeSinceStartup - arg_53_0.realTimeStartUp
	arg_53_0.gameTime = arg_53_0.gameTime - arg_53_0.deltaTime
	arg_53_0.gameStepTime = arg_53_0.gameStepTime + arg_53_0.deltaTime

	if arg_53_0.gameTime < 0 then
		arg_53_0.gameTime = 0
	end

	arg_53_0:updateGameUI()

	if arg_53_0.showPanel then
		local var_53_0 = arg_53_0.showPanel

		var_1.step(var_53_0, arg_53_0.deltaTime)
	end

	if arg_53_0.detailPanel then
		local var_53_1 = arg_53_0.detailPanel

		var_1.step(var_53_1, arg_53_0.deltaTime)
	end

	arg_53_0:updateOtherTakeCard()

	if arg_53_0.gameTime <= 0 then
		arg_53_0:onGameOver(0)

		return
	end

	return
end

function var_0_1.updateOtherTakeCard(arg_54_0)
	if arg_54_0.gameState == var_0_6 or arg_54_0.gameState == var_0_7 then
		if not arg_54_0.otherTakeCard and not arg_54_0.otherTakeTime then
			math = var_1
			arg_54_0.otherTakeTime = var_1.random(1, var_0_14)
		end

		if arg_54_0.otherTakeTime and arg_54_0.otherTakeTime > 0 then
			arg_54_0.otherTakeTime = arg_54_0.otherTakeTime - arg_54_0.deltaTime

			if arg_54_0.otherTakeTime <= 0 then
				table = var_1

				local var_54_0 = var_1.remove
				local var_54_1 = arg_54_0.gameData.other_cards

				math = var_1_10004
				arg_54_0.otherTakeCard = var_54_0(var_54_1, var_1_10004.random(1, #arg_54_0.gameData.other_cards))

				local var_54_2 = arg_54_0.detailPanel

				var_1.updateDetail(var_54_2, arg_54_0.gameData)

				local var_54_3 = arg_54_0.detailPanel

				var_1.setOtherCompareCard(var_54_3, arg_54_0.otherTakeCard)

				arg_54_0.otherTakeTime = nil
			end
		end
	end

	return
end

function var_0_1.timerStart(arg_55_0)
	if not arg_55_0.timer.running then
		Time = var_1
		arg_55_0.realTimeStartUp = var_1.realtimeSinceStartup

		local var_55_0 = arg_55_0.timer

		var_1.Start(var_55_0)
	end

	return
end

function var_0_1.timerStop(arg_56_0)
	if arg_56_0.timer.running then
		local var_56_0 = arg_56_0.timer

		var_1.Stop(var_56_0)
	end

	return
end

function var_0_1.updateGameUI(arg_57_0)
	return
end

function var_0_1.onGameOver(arg_58_0, arg_58_1)
	if arg_58_0.settlementFlag then
		return
	end

	arg_58_0:timerStop()

	arg_58_0.settlementFlag = true
	setActive = var_2

	var_2(arg_58_0.clickMask, true)

	setActive = var_2
	findTF = var_4

	var_2(var_4(arg_58_0._tf, "scene_container"), false)

	setActive = var_2

	var_2(arg_58_0.gameUI, false)

	LeanTween = var_2

	local var_58_0 = var_2.delayedCall

	go = var_4

	local var_58_1 = var_4(arg_58_0._tf)
	local var_58_2 = arg_58_1

	System = var_6

	var_58_0(var_58_1, var_58_2, var_6.Action(function()
		arg_58_0.settlementFlag = false

		local var_59_0 = arg_58_0

		var_59_0.gameStartFlag = false
		setActive = var_59_0

		var_59_0(arg_58_0.clickMask, false)

		local var_59_1 = arg_58_0

		var_0.showSettlement(var_59_1)

		return
	end))

	return
end

function var_0_1.showSettlement(arg_60_0)
	local var_60_0 = var_0_11 - arg_60_0.gameData.other_heart
	local var_60_1 = var_0_11 - arg_60_0.gameData.my_heart

	setText = var_3
	findTF = var_1_10005

	var_3(var_1_10005(arg_60_0.settlementUI, "ad/score/score_1"), var_60_0)

	setText = var_3
	findTF = var_5

	var_3(var_5(arg_60_0.settlementUI, "ad/score/score_2"), var_60_1)

	setActive = var_3
	findTF = var_5

	var_3(var_5(arg_60_0.settlementUI, "ad/win"), var_60_1 <= var_60_0)

	setActive = var_3
	findTF = var_5

	var_3(var_5(arg_60_0.settlementUI, "ad/defeat"), var_60_0 < var_60_1)

	local var_60_2 = arg_60_0.detailPanel

	var_3.setVisible(var_60_2, false)

	getProxy = var_3
	PlayerProxy = var_60_2

	local var_60_3 = var_3(var_60_2)
	local var_60_4 = var_3.getPlayerId(var_60_3)

	PlayerPrefs = var_1_10004

	local var_60_5 = var_1_10004.GetInt
	local var_60_6 = "mg_score_"

	tostring = var_7

	local var_60_7

	if not var_60_5(var_60_6 .. var_7(var_60_4) .. "_" .. var_0_4) then
		var_60_7 = 0
	end

	if var_60_7 <= var_60_0 then
		var_60_7 = var_60_0
		PlayerPrefs = var_60_3

		local var_60_8 = var_60_3.SetInt
		local var_60_9 = "mg_score_"

		tostring = var_8

		var_60_8(var_60_9 .. var_8(var_60_4) .. "_" .. var_0_4, var_60_7)
	end

	local var_60_10 = arg_60_0
	local var_60_11 = arg_60_0.emit

	Dorm3dMiniGameMediator = var_8

	var_60_11(var_60_10, var_8.GAME_OPERATION, {
		operationCode = "GAME_RESULT",
		win = var_60_1 <= var_60_0,
		score = var_60_0,
		high_score = var_60_7,
		miniGameId = var_0_4
	})

	setActive = var_60_11

	var_60_11(arg_60_0.settlementUI, true)

	return
end

function var_0_1.resumeGame(arg_61_0)
	arg_61_0.gameStop = false

	arg_61_0:timerStart()

	return
end

function var_0_1.stopGame(arg_62_0)
	arg_62_0.gameStop = true

	arg_62_0:timerStop()

	return
end

function var_0_1.getMiniGameData(arg_63_0)
	if not arg_63_0._mgData then
		getProxy = var_1
		MiniGameProxy = var_1_10003

		local var_63_0 = var_1(var_1_10003)

		arg_63_0._mgData = var_1.GetMiniGameData(var_63_0, var_0_4)
	end

	return arg_63_0._mgData
end

function var_0_1.onBackPressed(arg_64_0)
	arg_64_0:checkGameExit()

	return
end

function var_0_1.checkGameExit(arg_65_0)
	if not arg_65_0.gameStartFlag then
		local var_65_0 = arg_65_0
		local var_65_1 = arg_65_0.emit

		Dorm3dMiniGameMediator = var_1_10004

		var_65_1(var_65_0, var_1_10004.GAME_OPERATION, {
			operationCode = "GAME_CLOSE",
			doTrack = true,
			miniGameId = var_0_4
		})
		arg_65_0:emit(var_0_1.ON_BACK_PRESSED)
	else
		if arg_65_0.gameStop then
			return
		end

		arg_65_0:stopGame()

		local var_65_3

		if arg_65_0.contextData.isDorm3d then
			pg = var_65_3

			local var_65_2 = var_65_3.NewStyleMsgboxMgr.GetInstance()

			var_65_3 = var_65_3.Show
			pg = var_1_10004

			local var_65_4 = var_1_10004.NewStyleMsgboxMgr.TYPE_MSGBOX

			var_1_10005 = {}
			i18n = var_1_10006
			var_1_10005.contentText = var_1_10006("mini_game_leave")

			function var_1_10005.onConfirm()
				local var_66_0 = arg_65_0
				local var_66_1 = var_0.emit

				Dorm3dMiniGameMediator = var_2_10003

				var_66_1(var_66_0, var_2_10003.GAME_OPERATION, {
					operationCode = "GAME_CLOSE",
					doTrack = false,
					miniGameId = var_0_4
				})

				local var_66_2 = arg_65_0

				var_0.emit(var_66_2, var_0_1.ON_BACK_PRESSED)

				return
			end

			function var_1_10005.onClose()
				local var_67_0 = arg_65_0

				var_0.resumeGame(var_67_0)

				return
			end

			var_65_3(var_65_2, var_65_4, var_1_10005)
		else
			pg = var_65_3

			local var_65_5 = var_65_3.MsgboxMgr.GetInstance()
			local var_65_6 = var_1.ShowMsgBox
			local var_65_7 = {}

			i18n = var_1_10005
			var_65_7.content = var_1_10005("mini_game_leave")

			function var_65_7.onYes()
				local var_68_0 = arg_65_0
				local var_68_1 = var_0.emit

				Dorm3dMiniGameMediator = var_2_10003

				var_68_1(var_68_0, var_2_10003.GAME_OPERATION, {
					operationCode = "GAME_CLOSE",
					doTrack = false,
					miniGameId = var_0_4
				})

				local var_68_2 = arg_65_0

				var_0.emit(var_68_2, var_0_1.ON_BACK_PRESSED)

				return
			end

			function var_65_7.onNo()
				local var_69_0 = arg_65_0

				var_0.resumeGame(var_69_0)

				return
			end

			var_65_6(var_65_5, var_65_7)
		end
	end

	return
end

function var_0_1.willExit(arg_70_0)
	if arg_70_0.detailPanel then
		var_1_10003 = arg_70_0.detailPanel

		var_1.dispose(var_1_10003)
	end

	if arg_70_0._tf then
		LeanTween = var_1

		local var_70_0 = var_1.isTweening

		go = var_1_10003

		if var_70_0(var_1_10003(arg_70_0._tf)) then
			LeanTween = var_1

			local var_70_1 = var_1.cancel

			go = var_3

			var_70_1(var_3(arg_70_0._tf))
		end
	end

	if arg_70_0.timer and arg_70_0.timer.running then
		local var_70_2 = arg_70_0.timer

		var_1.Stop(var_70_2)
	end

	Time = var_1
	var_1.timeScale = 1
	arg_70_0.timer = nil

	return
end

return var_0_1
