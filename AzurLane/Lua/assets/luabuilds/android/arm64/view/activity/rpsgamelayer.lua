local var_0_0 = class("RPSGameLayer", import("..base.BaseUI"))
local var_0_1 = 0
local var_0_3 = 75
local var_0_4 = 1
local var_0_5 = 2
local var_0_6 = 3
local var_0_7 = 4
local var_0_8 = 5
local var_0_9 = 5
local var_0_10 = 3
local var_0_11 = 0.1
local var_0_12 = 0.1
local var_0_13 = 2
local var_0_14 = 5
local var_0_15 = 12 * 0.7
local var_0_16 = "event show panel closed"
local var_0_17 = "event take card"
local var_0_18 = "event compared card end"
local var_0_19 = {
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

local function var_0_20(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	({
		Ctor = function(arg_2_0)
			arg_2_0._tf = arg_1_0
			arg_2_0._event = arg_1_1
			arg_2_0._topCardTpl = arg_1_3
			arg_2_0._bottomCardTpl = arg_1_2

			setActive(arg_2_0._tf, false)
			GetComponent(findTF(arg_2_0._tf, "top/bg/desc/img"), typeof(Image)):SetNativeSize()
			GetComponent(findTF(arg_2_0._tf, "bottom/bg/desc/img"), typeof(Image)):SetNativeSize()

			arg_2_0._topContent = findTF(arg_2_0._tf, "top/content")
			arg_2_0._bottomContent = findTF(arg_2_0._tf, "bottom/content")
			arg_2_0.topCards = {}
			arg_2_0.bottomCards = {}

			for iter_2_0 = 1, var_0_8 do
				local var_2_0 = tf(instantiate(arg_2_0._topCardTpl))
				local var_2_1 = tf(instantiate(arg_2_0._bottomCardTpl))

				SetParent(var_2_0, arg_2_0._topContent)
				SetParent(var_2_1, arg_2_0._bottomContent)
				setActive(var_2_0, true)
				setActive(var_2_1, true)
				table.insert(arg_2_0.topCards, var_2_0)
				table.insert(arg_2_0.bottomCards, var_2_1)
			end

			return
		end,
		setCardData = function(arg_3_0, arg_3_1)
			for iter_3_0 = 1, var_0_8 do
				arg_3_0:setCardChildsVisible(findTF(arg_3_0.topCards[iter_3_0], "ad"), false)
				arg_3_0:setCardChildsVisible(findTF(arg_3_0.bottomCards[iter_3_0], "ad"), false)
				setActive(findTF(arg_3_0.topCards[iter_3_0], "ad/" .. arg_3_1.other_cards[iter_3_0]), true)
				setActive(findTF(arg_3_0.bottomCards[iter_3_0], "ad/" .. arg_3_1.my_cards[iter_3_0]), true)
			end

			return
		end,
		setCardChildsVisible = function(arg_4_0, arg_4_1, arg_4_2)
			for iter_4_0 = 1, arg_4_1.childCount do
				setActive(arg_4_1:GetChild(iter_4_0 - 1), arg_4_2)
			end

			return
		end,
		start = function(arg_5_0)
			arg_5_0._countTime = var_0_9

			arg_5_0:setVisible(true)

			return
		end,
		step = function(arg_6_0, arg_6_1)
			if arg_6_0._countTime then
				arg_6_0._countTime = arg_6_0._countTime - arg_6_1

				if arg_6_0._countTime <= 0 then
					arg_6_0._countTime = nil

					arg_6_0:setVisible(false)
					arg_6_0._event:emit(var_0_16)

					return
				end
			end

			return
		end,
		setVisible = function(arg_7_0, arg_7_1)
			setActive(arg_7_0._tf, arg_7_1)

			return
		end
	}).Ctor({
		Ctor = function(arg_2_0)
			arg_2_0._tf = arg_1_0
			arg_2_0._event = arg_1_1
			arg_2_0._topCardTpl = arg_1_3
			arg_2_0._bottomCardTpl = arg_1_2

			setActive(arg_2_0._tf, false)
			GetComponent(findTF(arg_2_0._tf, "top/bg/desc/img"), typeof(Image)):SetNativeSize()
			GetComponent(findTF(arg_2_0._tf, "bottom/bg/desc/img"), typeof(Image)):SetNativeSize()

			arg_2_0._topContent = findTF(arg_2_0._tf, "top/content")
			arg_2_0._bottomContent = findTF(arg_2_0._tf, "bottom/content")
			arg_2_0.topCards = {}
			arg_2_0.bottomCards = {}

			for iter_2_0 = 1, var_0_8 do
				local var_2_0 = tf(instantiate(arg_2_0._topCardTpl))
				local var_2_1 = tf(instantiate(arg_2_0._bottomCardTpl))

				SetParent(var_2_0, arg_2_0._topContent)
				SetParent(var_2_1, arg_2_0._bottomContent)
				setActive(var_2_0, true)
				setActive(var_2_1, true)
				table.insert(arg_2_0.topCards, var_2_0)
				table.insert(arg_2_0.bottomCards, var_2_1)
			end

			return
		end,
		setCardData = function(arg_3_0, arg_3_1)
			for iter_3_0 = 1, var_0_8 do
				arg_3_0:setCardChildsVisible(findTF(arg_3_0.topCards[iter_3_0], "ad"), false)
				arg_3_0:setCardChildsVisible(findTF(arg_3_0.bottomCards[iter_3_0], "ad"), false)
				setActive(findTF(arg_3_0.topCards[iter_3_0], "ad/" .. arg_3_1.other_cards[iter_3_0]), true)
				setActive(findTF(arg_3_0.bottomCards[iter_3_0], "ad/" .. arg_3_1.my_cards[iter_3_0]), true)
			end

			return
		end,
		setCardChildsVisible = function(arg_4_0, arg_4_1, arg_4_2)
			for iter_4_0 = 1, arg_4_1.childCount do
				setActive(arg_4_1:GetChild(iter_4_0 - 1), arg_4_2)
			end

			return
		end,
		start = function(arg_5_0)
			arg_5_0._countTime = var_0_9

			arg_5_0:setVisible(true)

			return
		end,
		step = function(arg_6_0, arg_6_1)
			if arg_6_0._countTime then
				arg_6_0._countTime = arg_6_0._countTime - arg_6_1

				if arg_6_0._countTime <= 0 then
					arg_6_0._countTime = nil

					arg_6_0:setVisible(false)
					arg_6_0._event:emit(var_0_16)

					return
				end
			end

			return
		end,
		setVisible = function(arg_7_0, arg_7_1)
			setActive(arg_7_0._tf, arg_7_1)

			return
		end
	})

	return {
		Ctor = function(arg_2_0)
			arg_2_0._tf = arg_1_0
			arg_2_0._event = arg_1_1
			arg_2_0._topCardTpl = arg_1_3
			arg_2_0._bottomCardTpl = arg_1_2

			setActive(arg_2_0._tf, false)
			GetComponent(findTF(arg_2_0._tf, "top/bg/desc/img"), typeof(Image)):SetNativeSize()
			GetComponent(findTF(arg_2_0._tf, "bottom/bg/desc/img"), typeof(Image)):SetNativeSize()

			arg_2_0._topContent = findTF(arg_2_0._tf, "top/content")
			arg_2_0._bottomContent = findTF(arg_2_0._tf, "bottom/content")
			arg_2_0.topCards = {}
			arg_2_0.bottomCards = {}

			for iter_2_0 = 1, var_0_8 do
				local var_2_0 = tf(instantiate(arg_2_0._topCardTpl))
				local var_2_1 = tf(instantiate(arg_2_0._bottomCardTpl))

				SetParent(var_2_0, arg_2_0._topContent)
				SetParent(var_2_1, arg_2_0._bottomContent)
				setActive(var_2_0, true)
				setActive(var_2_1, true)
				table.insert(arg_2_0.topCards, var_2_0)
				table.insert(arg_2_0.bottomCards, var_2_1)
			end

			return
		end,
		setCardData = function(arg_3_0, arg_3_1)
			for iter_3_0 = 1, var_0_8 do
				arg_3_0:setCardChildsVisible(findTF(arg_3_0.topCards[iter_3_0], "ad"), false)
				arg_3_0:setCardChildsVisible(findTF(arg_3_0.bottomCards[iter_3_0], "ad"), false)
				setActive(findTF(arg_3_0.topCards[iter_3_0], "ad/" .. arg_3_1.other_cards[iter_3_0]), true)
				setActive(findTF(arg_3_0.bottomCards[iter_3_0], "ad/" .. arg_3_1.my_cards[iter_3_0]), true)
			end

			return
		end,
		setCardChildsVisible = function(arg_4_0, arg_4_1, arg_4_2)
			for iter_4_0 = 1, arg_4_1.childCount do
				setActive(arg_4_1:GetChild(iter_4_0 - 1), arg_4_2)
			end

			return
		end,
		start = function(arg_5_0)
			arg_5_0._countTime = var_0_9

			arg_5_0:setVisible(true)

			return
		end,
		step = function(arg_6_0, arg_6_1)
			if arg_6_0._countTime then
				arg_6_0._countTime = arg_6_0._countTime - arg_6_1

				if arg_6_0._countTime <= 0 then
					arg_6_0._countTime = nil

					arg_6_0:setVisible(false)
					arg_6_0._event:emit(var_0_16)

					return
				end
			end

			return
		end,
		setVisible = function(arg_7_0, arg_7_1)
			setActive(arg_7_0._tf, arg_7_1)

			return
		end
	}
end

local function var_0_21(arg_8_0, arg_8_1)
	({
		Ctor = function(arg_9_0)
			arg_9_0._tf = arg_8_0
			arg_9_0._event = arg_8_1
			arg_9_0.btnTake = findTF(arg_9_0._tf, "btnTake")

			setText(findTF(arg_9_0.btnTake, "txt"), i18n("rps_game_take_card"))
			onButton(arg_9_0._event, arg_9_0.btnTake, function()
				arg_9_0:takeMyCard()

				return
			end, SFX_CONFIRM)

			arg_9_0.myCardTfs = {}

			for iter_9_0 = 1, var_0_8 do
				local var_9_0 = findTF(arg_9_0._tf, "bottomCard/cardContent/" .. iter_9_0)

				table.insert(arg_9_0.myCardTfs, var_9_0)
				onButton(arg_9_0._event, var_9_0, function()
					if arg_9_0.lockSelect then
						return
					end

					arg_9_0.cardSelectIndex = iter_9_0

					arg_9_0:updateSelectCard()

					return
				end, SFX_CONFIRM)
			end

			arg_9_0.otherCardTfs = {}

			for iter_9_1 = 1, var_0_8 do
				table.insert(arg_9_0.otherCardTfs, findTF(arg_9_0._tf, "topCard/cardContent/" .. iter_9_1))
			end

			arg_9_0.myHearts = {}
			arg_9_0.otherHearts = {}

			for iter_9_2 = 1, var_0_10 do
				table.insert(arg_9_0.myHearts, findTF(arg_9_0._tf, "bottomStatus/heart/" .. iter_9_2))
				table.insert(arg_9_0.otherHearts, findTF(arg_9_0._tf, "topStatus/heart/" .. iter_9_2))
			end

			arg_9_0.takeTimeText = findTF(arg_9_0._tf, "takeTime/text")
			arg_9_0.compareTf = findTF(arg_9_0._tf, "compare")
			arg_9_0.spineAnimTf = findTF(arg_9_0._tf, "compare/mask/RPSSpine")
			arg_9_0.spineAnim = GetComponent(arg_9_0.spineAnimTf, typeof(SpineAnimUI))

			return
		end,
		updateSelectCard = function(arg_12_0)
			for iter_12_0 = 1, #arg_12_0.myCardTfs do
				if arg_12_0.cardSelectIndex and arg_12_0.cardSelectIndex == iter_12_0 then
					arg_12_0.myCardTfs[iter_12_0].anchoredPosition = Vector2(arg_12_0.myCardTfs[iter_12_0].anchoredPosition.x, 100)

					setActive(findTF(arg_12_0.myCardTfs[iter_12_0], "AD/select"), true)
				else
					arg_12_0.myCardTfs[iter_12_0].anchoredPosition = Vector2(arg_12_0.myCardTfs[iter_12_0].anchoredPosition.x, 0)

					setActive(findTF(arg_12_0.myCardTfs[iter_12_0], "AD/select"), false)
				end
			end

			return
		end,
		updateDetail = function(arg_13_0, arg_13_1)
			local var_13_0 = arg_13_1.other_cards
			local var_13_1 = arg_13_1.my_heart
			local var_13_2 = arg_13_1.other_heart

			arg_13_0.myCardNum = #arg_13_1.my_cards
			arg_13_0.otherCardNum = #var_13_0

			setActive(arg_13_0.btnTake, #arg_13_1.my_cards ~= 0)

			for iter_13_0 = 1, #arg_13_0.myCardTfs do
				if iter_13_0 <= #arg_13_1.my_cards then
					arg_13_0:updateCardIndex(arg_13_0.myCardTfs[iter_13_0], arg_13_1.my_cards[iter_13_0], false)
				end

				setActive(arg_13_0.myCardTfs[iter_13_0], iter_13_0 <= #arg_13_1.my_cards)
			end

			for iter_13_1 = 1, #arg_13_0.otherCardTfs do
				arg_13_0:updateCardCount(arg_13_0.otherCardTfs[iter_13_1], #var_13_0)

				if arg_13_0.otherCardNum <= 0 then
					setActive(arg_13_0.otherCardTfs[iter_13_1], false)
				else
					setActive(arg_13_0.otherCardTfs[iter_13_1], iter_13_1 <= 1)
				end
			end

			for iter_13_2 = 1, #arg_13_0.myHearts do
				setActive(arg_13_0.myHearts[iter_13_2], iter_13_2 <= var_13_1)
			end

			for iter_13_3 = 1, #arg_13_0.otherHearts do
				setActive(arg_13_0.otherHearts[iter_13_3], iter_13_3 <= var_13_2)
			end

			arg_13_0.takeTimeText.anchoredPosition = Vector2(-(var_0_8 - arg_13_0.myCardNum) * var_0_15, 0)

			return
		end,
		updateCardCount = function(arg_14_0, arg_14_1, arg_14_2)
			setText(findTF(arg_14_1, "text"), tostring(arg_14_2))

			return
		end,
		updateCardIndex = function(arg_15_0, arg_15_1, arg_15_2)
			arg_15_0:setCardChildsVisible(findTF(arg_15_1, "AD"), false)
			setActive(findTF(arg_15_1, "AD/" .. arg_15_2), true)

			return
		end,
		setCardChildsVisible = function(arg_16_0, arg_16_1, arg_16_2)
			for iter_16_0 = 1, arg_16_1.childCount do
				setActive(arg_16_1:GetChild(iter_16_0 - 1), arg_16_2)
			end

			return
		end,
		start = function(arg_17_0)
			arg_17_0.cardSelectIndex = nil

			arg_17_0:updateLock(false)
			arg_17_0:setVisible(false)
			setActive(arg_17_0.compareTf, false)

			return
		end,
		step = function(arg_18_0, arg_18_1)
			if arg_18_0.myCardTime and not arg_18_0.myCardCompared and arg_18_0.myCardTime > 0 then
				arg_18_0.myCardTime = arg_18_0.myCardTime - arg_18_1

				if arg_18_0.myCardTime <= 0 then
					arg_18_0.myCardTime = nil
					arg_18_0.cardSelectIndex = math.random(1, arg_18_0.myCardNum)

					arg_18_0:takeMyCard()
				end
			end

			if not arg_18_0.comparedShowTime and arg_18_0.myCardCompared and arg_18_0.otherCardCompared then
				arg_18_0.comparedShowTime = var_0_11
			end

			if arg_18_0.comparedShowTime and arg_18_0.comparedShowTime > 0 then
				arg_18_0.comparedShowTime = arg_18_0.comparedShowTime - arg_18_1

				if arg_18_0.comparedShowTime <= 0 then
					arg_18_0.comparedShowTime = 0

					setActive(arg_18_0.compareTf, true)
					arg_18_0:SetActionWithFinishCallback(arg_18_0.spineAnim, var_0_19[arg_18_0.myCardCompared .. arg_18_0.otherCardCompared], 0, function()
						setActive(arg_18_0.compareTf, false)

						arg_18_0.comparedStepTime = var_0_12

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

					arg_18_0._event:emit(var_0_18)
				end
			end

			if arg_18_0.myCardTime then
				setText(arg_18_0.takeTimeText, tostring(math.ceil(arg_18_0.myCardTime)))
			else
				setText(arg_18_0.takeTimeText, "")
			end

			if arg_18_0.myCardCompared and isActive(arg_18_0.btnTake) then
				setActive(arg_18_0.btnTake, false)
			elseif not arg_18_0.myCardCompared and not isActive(arg_18_0.btnTake) then
				setActive(arg_18_0.btnTake, true)
			end

			return
		end,
		startUp = function(arg_21_0)
			arg_21_0.myCardTime = var_0_14

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
				arg_24_0._event:emit(var_0_17, arg_24_0.cardSelectIndex)

				arg_24_0.cardSelectIndex = nil

				arg_24_0:updateLock(true)
				arg_24_0:updateSelectCard()
			end

			return
		end,
		updateLock = function(arg_25_0, arg_25_1)
			if not arg_25_1 then
				arg_25_0.myCardTime = var_0_14 or nil
				arg_25_0.lockSelect = arg_25_1

				return
			end
		end,
		setVisible = function(arg_26_0, arg_26_1)
			setActive(arg_26_0._tf, arg_26_1)

			return
		end,
		SetActionWithFinishCallback = function(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5, arg_27_6)
			if arg_27_4 or arg_27_6 then
				arg_27_1:SetActionCallBack(function(arg_28_0)
					if arg_28_0 == "finish" and arg_27_4 then
						arg_27_1:SetActionCallBack(nil)
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
			arg_29_0.spineAnim:SetActionCallBack(nil)

			return
		end
	}).Ctor({
		Ctor = function(arg_9_0)
			arg_9_0._tf = arg_8_0
			arg_9_0._event = arg_8_1
			arg_9_0.btnTake = findTF(arg_9_0._tf, "btnTake")

			setText(findTF(arg_9_0.btnTake, "txt"), i18n("rps_game_take_card"))
			onButton(arg_9_0._event, arg_9_0.btnTake, function()
				arg_9_0:takeMyCard()

				return
			end, SFX_CONFIRM)

			arg_9_0.myCardTfs = {}

			for iter_9_0 = 1, var_0_8 do
				local var_9_0 = findTF(arg_9_0._tf, "bottomCard/cardContent/" .. iter_9_0)

				table.insert(arg_9_0.myCardTfs, var_9_0)
				onButton(arg_9_0._event, var_9_0, function()
					if arg_9_0.lockSelect then
						return
					end

					arg_9_0.cardSelectIndex = iter_9_0

					arg_9_0:updateSelectCard()

					return
				end, SFX_CONFIRM)
			end

			arg_9_0.otherCardTfs = {}

			for iter_9_1 = 1, var_0_8 do
				table.insert(arg_9_0.otherCardTfs, findTF(arg_9_0._tf, "topCard/cardContent/" .. iter_9_1))
			end

			arg_9_0.myHearts = {}
			arg_9_0.otherHearts = {}

			for iter_9_2 = 1, var_0_10 do
				table.insert(arg_9_0.myHearts, findTF(arg_9_0._tf, "bottomStatus/heart/" .. iter_9_2))
				table.insert(arg_9_0.otherHearts, findTF(arg_9_0._tf, "topStatus/heart/" .. iter_9_2))
			end

			arg_9_0.takeTimeText = findTF(arg_9_0._tf, "takeTime/text")
			arg_9_0.compareTf = findTF(arg_9_0._tf, "compare")
			arg_9_0.spineAnimTf = findTF(arg_9_0._tf, "compare/mask/RPSSpine")
			arg_9_0.spineAnim = GetComponent(arg_9_0.spineAnimTf, typeof(SpineAnimUI))

			return
		end,
		updateSelectCard = function(arg_12_0)
			for iter_12_0 = 1, #arg_12_0.myCardTfs do
				if arg_12_0.cardSelectIndex and arg_12_0.cardSelectIndex == iter_12_0 then
					arg_12_0.myCardTfs[iter_12_0].anchoredPosition = Vector2(arg_12_0.myCardTfs[iter_12_0].anchoredPosition.x, 100)

					setActive(findTF(arg_12_0.myCardTfs[iter_12_0], "AD/select"), true)
				else
					arg_12_0.myCardTfs[iter_12_0].anchoredPosition = Vector2(arg_12_0.myCardTfs[iter_12_0].anchoredPosition.x, 0)

					setActive(findTF(arg_12_0.myCardTfs[iter_12_0], "AD/select"), false)
				end
			end

			return
		end,
		updateDetail = function(arg_13_0, arg_13_1)
			local var_13_0 = arg_13_1.other_cards
			local var_13_1 = arg_13_1.my_heart
			local var_13_2 = arg_13_1.other_heart

			arg_13_0.myCardNum = #arg_13_1.my_cards
			arg_13_0.otherCardNum = #var_13_0

			setActive(arg_13_0.btnTake, #arg_13_1.my_cards ~= 0)

			for iter_13_0 = 1, #arg_13_0.myCardTfs do
				if iter_13_0 <= #arg_13_1.my_cards then
					arg_13_0:updateCardIndex(arg_13_0.myCardTfs[iter_13_0], arg_13_1.my_cards[iter_13_0], false)
				end

				setActive(arg_13_0.myCardTfs[iter_13_0], iter_13_0 <= #arg_13_1.my_cards)
			end

			for iter_13_1 = 1, #arg_13_0.otherCardTfs do
				arg_13_0:updateCardCount(arg_13_0.otherCardTfs[iter_13_1], #var_13_0)

				if arg_13_0.otherCardNum <= 0 then
					setActive(arg_13_0.otherCardTfs[iter_13_1], false)
				else
					setActive(arg_13_0.otherCardTfs[iter_13_1], iter_13_1 <= 1)
				end
			end

			for iter_13_2 = 1, #arg_13_0.myHearts do
				setActive(arg_13_0.myHearts[iter_13_2], iter_13_2 <= var_13_1)
			end

			for iter_13_3 = 1, #arg_13_0.otherHearts do
				setActive(arg_13_0.otherHearts[iter_13_3], iter_13_3 <= var_13_2)
			end

			arg_13_0.takeTimeText.anchoredPosition = Vector2(-(var_0_8 - arg_13_0.myCardNum) * var_0_15, 0)

			return
		end,
		updateCardCount = function(arg_14_0, arg_14_1, arg_14_2)
			setText(findTF(arg_14_1, "text"), tostring(arg_14_2))

			return
		end,
		updateCardIndex = function(arg_15_0, arg_15_1, arg_15_2)
			arg_15_0:setCardChildsVisible(findTF(arg_15_1, "AD"), false)
			setActive(findTF(arg_15_1, "AD/" .. arg_15_2), true)

			return
		end,
		setCardChildsVisible = function(arg_16_0, arg_16_1, arg_16_2)
			for iter_16_0 = 1, arg_16_1.childCount do
				setActive(arg_16_1:GetChild(iter_16_0 - 1), arg_16_2)
			end

			return
		end,
		start = function(arg_17_0)
			arg_17_0.cardSelectIndex = nil

			arg_17_0:updateLock(false)
			arg_17_0:setVisible(false)
			setActive(arg_17_0.compareTf, false)

			return
		end,
		step = function(arg_18_0, arg_18_1)
			if arg_18_0.myCardTime and not arg_18_0.myCardCompared and arg_18_0.myCardTime > 0 then
				arg_18_0.myCardTime = arg_18_0.myCardTime - arg_18_1

				if arg_18_0.myCardTime <= 0 then
					arg_18_0.myCardTime = nil
					arg_18_0.cardSelectIndex = math.random(1, arg_18_0.myCardNum)

					arg_18_0:takeMyCard()
				end
			end

			if not arg_18_0.comparedShowTime and arg_18_0.myCardCompared and arg_18_0.otherCardCompared then
				arg_18_0.comparedShowTime = var_0_11
			end

			if arg_18_0.comparedShowTime and arg_18_0.comparedShowTime > 0 then
				arg_18_0.comparedShowTime = arg_18_0.comparedShowTime - arg_18_1

				if arg_18_0.comparedShowTime <= 0 then
					arg_18_0.comparedShowTime = 0

					setActive(arg_18_0.compareTf, true)
					arg_18_0:SetActionWithFinishCallback(arg_18_0.spineAnim, var_0_19[arg_18_0.myCardCompared .. arg_18_0.otherCardCompared], 0, function()
						setActive(arg_18_0.compareTf, false)

						arg_18_0.comparedStepTime = var_0_12

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

					arg_18_0._event:emit(var_0_18)
				end
			end

			if arg_18_0.myCardTime then
				setText(arg_18_0.takeTimeText, tostring(math.ceil(arg_18_0.myCardTime)))
			else
				setText(arg_18_0.takeTimeText, "")
			end

			if arg_18_0.myCardCompared and isActive(arg_18_0.btnTake) then
				setActive(arg_18_0.btnTake, false)
			elseif not arg_18_0.myCardCompared and not isActive(arg_18_0.btnTake) then
				setActive(arg_18_0.btnTake, true)
			end

			return
		end,
		startUp = function(arg_21_0)
			arg_21_0.myCardTime = var_0_14

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
				arg_24_0._event:emit(var_0_17, arg_24_0.cardSelectIndex)

				arg_24_0.cardSelectIndex = nil

				arg_24_0:updateLock(true)
				arg_24_0:updateSelectCard()
			end

			return
		end,
		updateLock = function(arg_25_0, arg_25_1)
			if not arg_25_1 then
				arg_25_0.myCardTime = var_0_14 or nil
				arg_25_0.lockSelect = arg_25_1

				return
			end
		end,
		setVisible = function(arg_26_0, arg_26_1)
			setActive(arg_26_0._tf, arg_26_1)

			return
		end,
		SetActionWithFinishCallback = function(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5, arg_27_6)
			if arg_27_4 or arg_27_6 then
				arg_27_1:SetActionCallBack(function(arg_28_0)
					if arg_28_0 == "finish" and arg_27_4 then
						arg_27_1:SetActionCallBack(nil)
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
			arg_29_0.spineAnim:SetActionCallBack(nil)

			return
		end
	})

	return {
		Ctor = function(arg_9_0)
			arg_9_0._tf = arg_8_0
			arg_9_0._event = arg_8_1
			arg_9_0.btnTake = findTF(arg_9_0._tf, "btnTake")

			setText(findTF(arg_9_0.btnTake, "txt"), i18n("rps_game_take_card"))
			onButton(arg_9_0._event, arg_9_0.btnTake, function()
				arg_9_0:takeMyCard()

				return
			end, SFX_CONFIRM)

			arg_9_0.myCardTfs = {}

			for iter_9_0 = 1, var_0_8 do
				local var_9_0 = findTF(arg_9_0._tf, "bottomCard/cardContent/" .. iter_9_0)

				table.insert(arg_9_0.myCardTfs, var_9_0)
				onButton(arg_9_0._event, var_9_0, function()
					if arg_9_0.lockSelect then
						return
					end

					arg_9_0.cardSelectIndex = iter_9_0

					arg_9_0:updateSelectCard()

					return
				end, SFX_CONFIRM)
			end

			arg_9_0.otherCardTfs = {}

			for iter_9_1 = 1, var_0_8 do
				table.insert(arg_9_0.otherCardTfs, findTF(arg_9_0._tf, "topCard/cardContent/" .. iter_9_1))
			end

			arg_9_0.myHearts = {}
			arg_9_0.otherHearts = {}

			for iter_9_2 = 1, var_0_10 do
				table.insert(arg_9_0.myHearts, findTF(arg_9_0._tf, "bottomStatus/heart/" .. iter_9_2))
				table.insert(arg_9_0.otherHearts, findTF(arg_9_0._tf, "topStatus/heart/" .. iter_9_2))
			end

			arg_9_0.takeTimeText = findTF(arg_9_0._tf, "takeTime/text")
			arg_9_0.compareTf = findTF(arg_9_0._tf, "compare")
			arg_9_0.spineAnimTf = findTF(arg_9_0._tf, "compare/mask/RPSSpine")
			arg_9_0.spineAnim = GetComponent(arg_9_0.spineAnimTf, typeof(SpineAnimUI))

			return
		end,
		updateSelectCard = function(arg_12_0)
			for iter_12_0 = 1, #arg_12_0.myCardTfs do
				if arg_12_0.cardSelectIndex and arg_12_0.cardSelectIndex == iter_12_0 then
					arg_12_0.myCardTfs[iter_12_0].anchoredPosition = Vector2(arg_12_0.myCardTfs[iter_12_0].anchoredPosition.x, 100)

					setActive(findTF(arg_12_0.myCardTfs[iter_12_0], "AD/select"), true)
				else
					arg_12_0.myCardTfs[iter_12_0].anchoredPosition = Vector2(arg_12_0.myCardTfs[iter_12_0].anchoredPosition.x, 0)

					setActive(findTF(arg_12_0.myCardTfs[iter_12_0], "AD/select"), false)
				end
			end

			return
		end,
		updateDetail = function(arg_13_0, arg_13_1)
			local var_13_0 = arg_13_1.other_cards
			local var_13_1 = arg_13_1.my_heart
			local var_13_2 = arg_13_1.other_heart

			arg_13_0.myCardNum = #arg_13_1.my_cards
			arg_13_0.otherCardNum = #var_13_0

			setActive(arg_13_0.btnTake, #arg_13_1.my_cards ~= 0)

			for iter_13_0 = 1, #arg_13_0.myCardTfs do
				if iter_13_0 <= #arg_13_1.my_cards then
					arg_13_0:updateCardIndex(arg_13_0.myCardTfs[iter_13_0], arg_13_1.my_cards[iter_13_0], false)
				end

				setActive(arg_13_0.myCardTfs[iter_13_0], iter_13_0 <= #arg_13_1.my_cards)
			end

			for iter_13_1 = 1, #arg_13_0.otherCardTfs do
				arg_13_0:updateCardCount(arg_13_0.otherCardTfs[iter_13_1], #var_13_0)

				if arg_13_0.otherCardNum <= 0 then
					setActive(arg_13_0.otherCardTfs[iter_13_1], false)
				else
					setActive(arg_13_0.otherCardTfs[iter_13_1], iter_13_1 <= 1)
				end
			end

			for iter_13_2 = 1, #arg_13_0.myHearts do
				setActive(arg_13_0.myHearts[iter_13_2], iter_13_2 <= var_13_1)
			end

			for iter_13_3 = 1, #arg_13_0.otherHearts do
				setActive(arg_13_0.otherHearts[iter_13_3], iter_13_3 <= var_13_2)
			end

			arg_13_0.takeTimeText.anchoredPosition = Vector2(-(var_0_8 - arg_13_0.myCardNum) * var_0_15, 0)

			return
		end,
		updateCardCount = function(arg_14_0, arg_14_1, arg_14_2)
			setText(findTF(arg_14_1, "text"), tostring(arg_14_2))

			return
		end,
		updateCardIndex = function(arg_15_0, arg_15_1, arg_15_2)
			arg_15_0:setCardChildsVisible(findTF(arg_15_1, "AD"), false)
			setActive(findTF(arg_15_1, "AD/" .. arg_15_2), true)

			return
		end,
		setCardChildsVisible = function(arg_16_0, arg_16_1, arg_16_2)
			for iter_16_0 = 1, arg_16_1.childCount do
				setActive(arg_16_1:GetChild(iter_16_0 - 1), arg_16_2)
			end

			return
		end,
		start = function(arg_17_0)
			arg_17_0.cardSelectIndex = nil

			arg_17_0:updateLock(false)
			arg_17_0:setVisible(false)
			setActive(arg_17_0.compareTf, false)

			return
		end,
		step = function(arg_18_0, arg_18_1)
			if arg_18_0.myCardTime and not arg_18_0.myCardCompared and arg_18_0.myCardTime > 0 then
				arg_18_0.myCardTime = arg_18_0.myCardTime - arg_18_1

				if arg_18_0.myCardTime <= 0 then
					arg_18_0.myCardTime = nil
					arg_18_0.cardSelectIndex = math.random(1, arg_18_0.myCardNum)

					arg_18_0:takeMyCard()
				end
			end

			if not arg_18_0.comparedShowTime and arg_18_0.myCardCompared and arg_18_0.otherCardCompared then
				arg_18_0.comparedShowTime = var_0_11
			end

			if arg_18_0.comparedShowTime and arg_18_0.comparedShowTime > 0 then
				arg_18_0.comparedShowTime = arg_18_0.comparedShowTime - arg_18_1

				if arg_18_0.comparedShowTime <= 0 then
					arg_18_0.comparedShowTime = 0

					setActive(arg_18_0.compareTf, true)
					arg_18_0:SetActionWithFinishCallback(arg_18_0.spineAnim, var_0_19[arg_18_0.myCardCompared .. arg_18_0.otherCardCompared], 0, function()
						setActive(arg_18_0.compareTf, false)

						arg_18_0.comparedStepTime = var_0_12

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

					arg_18_0._event:emit(var_0_18)
				end
			end

			if arg_18_0.myCardTime then
				setText(arg_18_0.takeTimeText, tostring(math.ceil(arg_18_0.myCardTime)))
			else
				setText(arg_18_0.takeTimeText, "")
			end

			if arg_18_0.myCardCompared and isActive(arg_18_0.btnTake) then
				setActive(arg_18_0.btnTake, false)
			elseif not arg_18_0.myCardCompared and not isActive(arg_18_0.btnTake) then
				setActive(arg_18_0.btnTake, true)
			end

			return
		end,
		startUp = function(arg_21_0)
			arg_21_0.myCardTime = var_0_14

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
				arg_24_0._event:emit(var_0_17, arg_24_0.cardSelectIndex)

				arg_24_0.cardSelectIndex = nil

				arg_24_0:updateLock(true)
				arg_24_0:updateSelectCard()
			end

			return
		end,
		updateLock = function(arg_25_0, arg_25_1)
			if not arg_25_1 then
				arg_25_0.myCardTime = var_0_14 or nil
				arg_25_0.lockSelect = arg_25_1

				return
			end
		end,
		setVisible = function(arg_26_0, arg_26_1)
			setActive(arg_26_0._tf, arg_26_1)

			return
		end,
		SetActionWithFinishCallback = function(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5, arg_27_6)
			if arg_27_4 or arg_27_6 then
				arg_27_1:SetActionCallBack(function(arg_28_0)
					if arg_28_0 == "finish" and arg_27_4 then
						arg_27_1:SetActionCallBack(nil)
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
			arg_29_0.spineAnim:SetActionCallBack(nil)

			return
		end
	}
end

function var_0_0.getUIName(arg_30_0)
	return "RPSGameUI"
end

function var_0_0.didEnter(arg_31_0)
	arg_31_0:initEvent()
	arg_31_0:initData()
	arg_31_0:initUI()
	arg_31_0:initGameUI()
	arg_31_0:readyStart()

	return
end

function var_0_0.initEvent(arg_32_0)
	arg_32_0:bind(var_0_18, function(arg_33_0, arg_33_1, arg_33_2)
		if arg_32_0.myTakeCard == arg_32_0.otherTakeCard + 1 or arg_32_0.myTakeCard + 2 == arg_32_0.otherTakeCard then
			arg_32_0.gameData.my_heart = arg_32_0.gameData.my_heart - 1

			arg_32_0:sendGamingNotice(2)
		elseif arg_32_0.myTakeCard ~= arg_32_0.otherTakeCard then
			arg_32_0.gameData.other_heart = arg_32_0.gameData.other_heart - 1

			arg_32_0:sendGamingNotice(1)
		else
			arg_32_0:sendGamingNotice(3)
		end

		arg_32_0.detailPanel:updateDetail(arg_32_0.gameData)

		if arg_32_0.gameData.my_heart == 0 or arg_32_0.gameData.other_heart == 0 or #arg_32_0.gameData.my_cards == 0 then
			arg_32_0.gameState = var_0_7
			arg_32_0.gameStartFlag = false

			arg_32_0:showSettlement()
		else
			arg_32_0.gameState = var_0_5
			arg_32_0.myTakeCard, arg_32_0.otherTakeCard = nil

			arg_32_0.detailPanel:updateLock(false)
		end

		return
	end)
	arg_32_0:bind(var_0_16, function(arg_34_0, arg_34_1, arg_34_2)
		arg_32_0.gameState = var_0_5

		if arg_32_0.detailPanel then
			arg_32_0.detailPanel:startUp()
		end

		return
	end)
	arg_32_0:bind(var_0_17, function(arg_35_0, arg_35_1, arg_35_2)
		if arg_32_0.gameState == var_0_5 then
			arg_32_0.gameState = var_0_6
			arg_32_0.myTakeCard = table.remove(arg_32_0.gameData.my_cards, arg_35_1)

			arg_32_0.detailPanel:setMyCompareCard(arg_32_0.myTakeCard)
			arg_32_0.detailPanel:updateDetail(arg_32_0.gameData)
		end

		return
	end)

	return
end

function var_0_0.sendGamingNotice(arg_36_0, arg_36_1)
	arg_36_0:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
		operationCode = "GAME_RPS_RESULT",
		index = arg_36_1,
		miniGameId = var_0_3
	})

	return
end

function var_0_0.initData(arg_37_0)
	if Application.targetFrameRate <= 60 then
		local var_37_0 = Application.targetFrameRate or 60

		arg_37_0.stepCount = 1 / var_37_0
		arg_37_0.realTimeStartUp = Time.realtimeSinceStartup
		arg_37_0.timer = Timer.New(function()
			if Time.realtimeSinceStartup - arg_37_0.realTimeStartUp > arg_37_0.stepCount then
				arg_37_0:onTimer()

				arg_37_0.realTimeStartUp = Time.realtimeSinceStartup
			end

			return
		end, 1 / var_37_0, -1)

		return
	end
end

function var_0_0.initUI(arg_39_0)
	arg_39_0.backSceneTf = findTF(arg_39_0._tf, "scene_container/scene_background")
	arg_39_0.sceneTf = findTF(arg_39_0._tf, "scene_container/scene")
	arg_39_0.bgTf = findTF(arg_39_0._tf, "bg")
	arg_39_0.clickMask = findTF(arg_39_0._tf, "clickMask")
	arg_39_0.settlementUI = findTF(arg_39_0._tf, "pop/SettleMentUI")

	onButton(arg_39_0, findTF(arg_39_0.settlementUI, "btnOver"), function()
		arg_39_0:checkGameExit()

		return
	end, SFX_CANCEL)
	SetActive(arg_39_0.settlementUI, false)

	return
end

function var_0_0.initGameUI(arg_41_0)
	arg_41_0.gameUI = findTF(arg_41_0._tf, "ui/gameUI")

	onButton(arg_41_0, findTF(arg_41_0.gameUI, "btnLeave"), function()
		arg_41_0:checkGameExit()

		return
	end)

	arg_41_0.dragDelegate = GetOrAddComponent(arg_41_0.sceneTf, "EventTriggerListener")
	arg_41_0.dragDelegate.enabled = true

	arg_41_0.dragDelegate:AddPointDownFunc(function(arg_43_0, arg_43_1)
		return
	end)

	arg_41_0.showPanel = var_0_20(findTF(arg_41_0.sceneTf, "showPanel"), arg_41_0, findTF(arg_41_0.sceneTf, "tpls/card_1"), findTF(arg_41_0.sceneTf, "tpls/card_2"))
	arg_41_0.detailPanel = var_0_21(findTF(arg_41_0.sceneTf, "detailPanel"), arg_41_0)

	return
end

function var_0_0.Update(arg_44_0)
	if arg_44_0.gameStop or arg_44_0.settlementFlag then
		return
	end

	if IsUnityEditor then
		-- block empty
	end

	return
end

function var_0_0.clearUI(arg_45_0)
	setActive(arg_45_0.sceneTf, false)
	setActive(arg_45_0.settlementUI, false)
	setActive(arg_45_0.gameUI, false)

	return
end

function var_0_0.readyStart(arg_46_0)
	arg_46_0:gameStart()

	return
end

function var_0_0.gameStart(arg_47_0)
	setActive(findTF(arg_47_0._tf, "scene_container"), true)
	setActive(findTF(arg_47_0.bgTf, "on"), false)
	setActive(arg_47_0.gameUI, true)

	arg_47_0.gameStartFlag = true
	arg_47_0.scoreNum = 0
	arg_47_0.gameStepTime = 0
	arg_47_0.gameTime = var_0_1
	arg_47_0.gameData = arg_47_0:createGameData()
	arg_47_0.gameState = var_0_4

	arg_47_0.showPanel:setCardData(arg_47_0.gameData)
	arg_47_0.detailPanel:updateDetail(arg_47_0.gameData)
	arg_47_0:updateGameUI()
	arg_47_0:timerStart()

	if arg_47_0.showPanel then
		arg_47_0.showPanel:start()
	end

	if arg_47_0.detailPanel then
		arg_47_0.detailPanel:start()
	end

	return
end

function var_0_0.createGameData(arg_48_0)
	for iter_48_0 = 4, var_0_8 do
		table.insert({
			1,
			2,
			3
		}, math.random(1, 3))
		table.insert({
			1,
			2,
			3
		}, math.random(1, 3))
	end

	table.sort({
		1,
		2,
		3
	}, function(arg_49_0, arg_49_1)
		return arg_49_0 < arg_49_1
	end)
	table.sort({
		1,
		2,
		3
	}, function(arg_50_0, arg_50_1)
		return arg_50_0 < arg_50_1
	end)

	return {
		other_cards = {
			1,
			2,
			3
		},
		my_cards = {
			1,
			2,
			3
		},
		my_heart = var_0_10,
		other_heart = var_0_10
	}
end

function var_0_0.transformColor(arg_51_0, arg_51_1)
	return Color.New(tonumber(string.sub(arg_51_1, 1, 2), 16) / 255, tonumber(string.sub(arg_51_1, 3, 4), 16) / 255, tonumber(string.sub(arg_51_1, 5, 6), 16) / 255)
end

function var_0_0.onTimer(arg_52_0)
	arg_52_0:gameStep()

	return
end

function var_0_0.gameStep(arg_53_0)
	arg_53_0.deltaTime = Time.realtimeSinceStartup - arg_53_0.realTimeStartUp
	arg_53_0.gameTime = arg_53_0.gameTime - arg_53_0.deltaTime
	arg_53_0.gameStepTime = arg_53_0.gameStepTime + arg_53_0.deltaTime

	if arg_53_0.gameTime < 0 then
		arg_53_0.gameTime = 0
	end

	arg_53_0:updateGameUI()

	if arg_53_0.showPanel then
		arg_53_0.showPanel:step(arg_53_0.deltaTime)
	end

	if arg_53_0.detailPanel then
		arg_53_0.detailPanel:step(arg_53_0.deltaTime)
	end

	arg_53_0:updateOtherTakeCard()

	if arg_53_0.gameTime <= 0 then
		arg_53_0:onGameOver(0)

		return
	end

	return
end

function var_0_0.updateOtherTakeCard(arg_54_0)
	if arg_54_0.gameState == var_0_5 or arg_54_0.gameState == var_0_6 then
		if not arg_54_0.otherTakeCard and not arg_54_0.otherTakeTime then
			arg_54_0.otherTakeTime = math.random(1, var_0_13)
		end

		if arg_54_0.otherTakeTime and arg_54_0.otherTakeTime > 0 then
			arg_54_0.otherTakeTime = arg_54_0.otherTakeTime - arg_54_0.deltaTime

			if arg_54_0.otherTakeTime <= 0 then
				arg_54_0.otherTakeCard = table.remove(arg_54_0.gameData.other_cards, math.random(1, #arg_54_0.gameData.other_cards))

				arg_54_0.detailPanel:updateDetail(arg_54_0.gameData)
				arg_54_0.detailPanel:setOtherCompareCard(arg_54_0.otherTakeCard)

				arg_54_0.otherTakeTime = nil
			end
		end
	end

	return
end

function var_0_0.timerStart(arg_55_0)
	if not arg_55_0.timer.running then
		arg_55_0.realTimeStartUp = Time.realtimeSinceStartup

		arg_55_0.timer:Start()
	end

	return
end

function var_0_0.timerStop(arg_56_0)
	if arg_56_0.timer.running then
		arg_56_0.timer:Stop()
	end

	return
end

function var_0_0.updateGameUI(arg_57_0)
	return
end

function var_0_0.onGameOver(arg_58_0, arg_58_1)
	if arg_58_0.settlementFlag then
		return
	end

	arg_58_0:timerStop()

	arg_58_0.settlementFlag = true

	setActive(arg_58_0.clickMask, true)
	setActive(findTF(arg_58_0._tf, "scene_container"), false)
	setActive(arg_58_0.gameUI, false)
	LeanTween.delayedCall(go(arg_58_0._tf), arg_58_1, System.Action(function()
		arg_58_0.settlementFlag = false
		arg_58_0.gameStartFlag = false

		setActive(arg_58_0.clickMask, false)
		arg_58_0:showSettlement()

		return
	end))

	return
end

function var_0_0.showSettlement(arg_60_0)
	local var_60_0 = var_0_10 - arg_60_0.gameData.other_heart
	local var_60_1 = var_0_10 - arg_60_0.gameData.my_heart

	setText(findTF(arg_60_0.settlementUI, "ad/score/score_1"), var_0_10 - arg_60_0.gameData.other_heart)
	setText(findTF(arg_60_0.settlementUI, "ad/score/score_2"), var_60_1)
	setActive(findTF(arg_60_0.settlementUI, "ad/win"), var_60_1 <= var_60_0)
	setActive(findTF(arg_60_0.settlementUI, "ad/defeat"), var_60_0 < var_60_1)
	arg_60_0.detailPanel:setVisible(false)

	local var_60_2 = getProxy(PlayerProxy):getPlayerId()
	local var_60_3 = PlayerPrefs.GetInt("mg_score_" .. tostring(var_60_2) .. "_" .. var_0_3) or 0

	if var_60_3 <= var_60_0 then
		var_60_3 = var_60_0

		PlayerPrefs.SetInt("mg_score_" .. tostring(var_60_2) .. "_" .. var_0_3, var_60_0)
	end

	arg_60_0:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
		operationCode = "GAME_RESULT",
		win = var_60_1 <= var_60_0,
		score = var_60_0,
		high_score = var_60_3,
		miniGameId = var_0_3
	})
	setActive(arg_60_0.settlementUI, true)

	return
end

function var_0_0.resumeGame(arg_61_0)
	arg_61_0.gameStop = false

	arg_61_0:timerStart()

	return
end

function var_0_0.stopGame(arg_62_0)
	arg_62_0.gameStop = true

	arg_62_0:timerStop()

	return
end

function var_0_0.getMiniGameData(arg_63_0)
	arg_63_0._mgData = arg_63_0._mgData or getProxy(MiniGameProxy):GetMiniGameData(var_0_3)

	return arg_63_0._mgData
end

function var_0_0.onBackPressed(arg_64_0)
	arg_64_0:checkGameExit()

	return
end

function var_0_0.checkGameExit(arg_65_0)
	if not arg_65_0.gameStartFlag then
		arg_65_0:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
			operationCode = "GAME_CLOSE",
			doTrack = true,
			miniGameId = var_0_3
		})
		arg_65_0:emit(var_0_0.ON_BACK_PRESSED)
	else
		if arg_65_0.gameStop then
			return
		end

		arg_65_0:stopGame()

		if arg_65_0.contextData.isDorm3d then
			pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_MSGBOX, {
				contentText = i18n("mini_game_leave"),
				onConfirm = function()
					arg_65_0:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
						operationCode = "GAME_CLOSE",
						doTrack = false,
						miniGameId = var_0_3
					})
					arg_65_0:emit(var_0_0.ON_BACK_PRESSED)

					return
				end,
				onClose = function()
					arg_65_0:resumeGame()

					return
				end
			})
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("mini_game_leave"),
				onYes = function()
					arg_65_0:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
						operationCode = "GAME_CLOSE",
						doTrack = false,
						miniGameId = var_0_3
					})
					arg_65_0:emit(var_0_0.ON_BACK_PRESSED)

					return
				end,
				onNo = function()
					arg_65_0:resumeGame()

					return
				end
			})
		end
	end

	return
end

function var_0_0.willExit(arg_70_0)
	if arg_70_0.detailPanel then
		arg_70_0.detailPanel:dispose()
	end

	if arg_70_0._tf and LeanTween.isTweening(go(arg_70_0._tf)) then
		LeanTween.cancel(go(arg_70_0._tf))
	end

	if arg_70_0.timer and arg_70_0.timer.running then
		arg_70_0.timer:Stop()
	end

	Time.timeScale = 1
	arg_70_0.timer = nil

	return
end

return var_0_0
