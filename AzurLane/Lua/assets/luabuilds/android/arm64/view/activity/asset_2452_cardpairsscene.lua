class = var_0_10000

local var_0_0 = "CardPairsScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.CARD_NUM = 18
var_0_1.GAME_STATE_BEGIN = 0
var_0_1.GAME_STATE_GAMING = 1
var_0_1.GAME_STATE_END = 2
var_0_1.config_init = false

function var_0_1.getUIName(arg_1_0)
	return "CardPairsUI"
end

function var_0_1.setPlayerData(arg_2_0, arg_2_1)
	arg_2_0.playerData = arg_2_1

	return
end

function var_0_1.setActivityData(arg_3_0, arg_3_1)
	arg_3_0.activityData = arg_3_1

	if not arg_3_0.config_init then
		local var_3_0 = arg_3_0.activityData

		if var_2.getConfig(var_3_0, "config_client")[2] then
			arg_3_0.firstShowingTime = var_2.firstShowingTime
			arg_3_0.showingTime = var_2.showingTime
			arg_3_0.aniTime = var_2.aniTime

			local var_3_1 = arg_3_0.activityData

			arg_3_0.cardEffectTimesMax = var_1_10003.getConfig(var_3_1, "config_data")[4]
		else
			arg_3_0.firstShowingTime = 2
			arg_3_0.showingTime = 0.3
			arg_3_0.aniTime = 0.2
			arg_3_0.cardEffectTimesMax = 7
		end

		CardPairsCard = var_1_10003
		var_1_10003.ANI_TIME = arg_3_0.aniTime
		arg_3_0.config_init = true
	end

	arg_3_0:updateTimes()

	if arg_3_0.activityData.data4 <= 0 then
		setText = var_2

		var_2(arg_3_0.bestTxt, "--'--'--")
	else
		setText = var_2

		var_2(arg_3_0.bestTxt, arg_3_0:getTimeFormat(arg_3_0.activityData.data4))
	end

	return
end

function var_0_1.checkActivityEnd(arg_4_0)
	return
end

function var_0_1.init(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.backBtn = var_1.Find(var_5_0, "top/back")

	local var_5_1 = arg_5_0._tf

	arg_5_0.cardTpl = var_1.Find(var_5_1, "res/card")

	local var_5_2 = arg_5_0._tf

	arg_5_0.cardCon = var_1.Find(var_5_2, "card_con/layout")

	local var_5_3 = arg_5_0._tf

	arg_5_0.pics = var_1.Find(var_5_3, "res/pics")

	local var_5_4 = arg_5_0._tf

	arg_5_0.helpBtn = var_1.Find(var_5_4, "top/help_btn")

	local var_5_5 = arg_5_0._tf

	arg_5_0.timesTxt = var_1.Find(var_5_5, "num_txt")

	local var_5_6 = arg_5_0._tf

	arg_5_0.timeTxt = var_1.Find(var_5_6, "time_txt")

	local var_5_7 = arg_5_0._tf

	arg_5_0.bestTxt = var_1.Find(var_5_7, "best_txt")

	local var_5_8 = arg_5_0._tf

	arg_5_0.maskBtn = var_1.Find(var_5_8, "mask_btn")

	local var_5_9 = arg_5_0._tf

	arg_5_0.endTips = var_1.Find(var_5_9, "end_tips")

	local var_5_10 = arg_5_0
	local var_5_11 = arg_5_0.hideChild
	local var_5_12 = arg_5_0._tf

	var_5_11(var_5_10, var_4.Find(var_5_12, "res"))

	return
end

function var_0_1.didEnter(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.backBtn

	local function var_6_2()
		local var_7_0 = arg_6_0

		var_0.emit(var_7_0, var_0_1.ON_BACK)

		return
	end

	SOUND_BACK = var_1_10006

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10006)

	onButton = var_1_10001

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.helpBtn

	local function var_6_5()
		pg = var_2_10000

		local var_8_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_8_1 = var_0.ShowMsgBox
		local var_8_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_8_2.type = var_2_10004
		i18n = var_2_10004
		var_8_2.helps = var_2_10004("card_pairs_help_tip")

		var_8_1(var_8_0, var_8_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_3, var_6_4, var_6_5, var_1_10006)

	onButton = var_1_10001

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0.maskBtn

	local function var_6_8()
		if arg_6_0.lastTimes > 0 then
			local var_9_0 = arg_6_0

			var_0.gameInit(var_9_0)
		else
			pg = var_0

			local var_9_1 = var_0.MsgboxMgr.GetInstance()
			local var_9_2 = var_0.ShowMsgBox
			local var_9_3 = {}

			i18n = var_2_10004
			var_9_3.content = var_2_10004("card_pairs_tips")

			function var_9_3.onYes()
				local var_10_0 = arg_6_0

				var_0.gameInit(var_10_0)

				return
			end

			var_9_2(var_9_1, var_9_3)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_6, var_6_7, var_6_8, var_1_10006)

	Timer = var_1_10001
	arg_6_0.updateTimer = var_1_10001.New(function()
		local var_11_0 = arg_6_0

		var_0.updateTimes(var_11_0)

		return
	end, 10, -1)

	local var_6_9 = arg_6_0.updateTimer

	var_1.Start(var_6_9)

	arg_6_0.showCards = {}
	arg_6_0.showingCards = {}
	arg_6_0.cardList = {}
	UIItemList = var_1
	arg_6_0.cardUIList = var_1.New(arg_6_0.cardCon, arg_6_0.cardTpl)

	local var_6_10 = arg_6_0.cardUIList

	var_1.make(var_6_10, function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			if arg_6_0.cardList[arg_12_1 + 1] ~= nil then
				var_3:initCard(arg_6_0.cardIndexList[arg_12_1 + 1][1])
			else
				table = var_4

				local var_12_0 = var_4.insert
				local var_12_1 = arg_6_0.cardList
				local var_12_2 = arg_12_1 + 1

				CardPairsCard = var_2_10008

				var_12_0(var_12_1, var_12_2, var_2_10008.New(arg_12_2, arg_6_0.pics, arg_6_0.cardIndexList[arg_12_1 + 1][1], function(arg_13_0)
					if arg_6_0.gameState == arg_6_0.GAME_STATE_GAMING then
						if arg_6_0.isFrist then
							arg_6_0.isFrist = false

							local var_13_0 = arg_6_0

							Time = var_2
							var_13_0.beginTime = var_2.realtimeSinceStartup

							local var_13_1 = arg_6_0

							Timer = var_2
							var_13_1.countTimer = var_2.New(function()
								math = var_4_10000

								local var_14_0 = var_4_10000.floor

								Time = var_4_10002

								local var_14_1 = var_14_0((var_4_10002.realtimeSinceStartup - arg_6_0.beginTime) * 1000)
								local var_14_2 = arg_6_0

								var_1.setTimeTxt(var_14_2, var_14_1)

								return
							end, 0.12, -1)

							local var_13_2 = arg_6_0.countTimer

							var_1.Start(var_13_2)
						end

						if arg_13_0.canClick and arg_13_0.enable and #arg_6_0.showCards < 2 then
							local var_13_3 = arg_13_0
							local var_13_4 = arg_13_0.aniShowBack
							local var_13_5 = arg_13_0.cardState

							CardPairsCard = var_3_10005

							var_13_4(var_13_3, var_13_5 == var_3_10005.CARD_STATE_BACK)
						end
					end

					return
				end, function(arg_15_0, arg_15_1)
					if arg_6_0.gameState == arg_6_0.GAME_STATE_GAMING then
						arg_15_0:setEnable(false)

						if arg_15_1 then
							table = var_2

							var_2.insert(arg_6_0.showCards, #arg_6_0.showCards + 1, arg_15_0)

							if #arg_6_0.showCards == 2 then
								local var_15_0 = arg_6_0

								var_2.setAllCardEnale(var_15_0, false)
							end
						end
					end

					return
				end, function(arg_16_0, arg_16_1)
					if arg_6_0.gameState == arg_6_0.GAME_STATE_GAMING then
						local var_16_0

						if arg_16_1 then
							arg_16_0:setOutline(true)

							table = var_16_0

							var_16_0.insert(arg_6_0.showingCards, #arg_6_0.showingCards + 1, arg_16_0)

							if #arg_6_0.showingCards % 2 == 0 then
								var_16_0 = #arg_6_0.showingCards

								local var_16_1 = #arg_6_0.showingCards - 1
								local var_16_2 = arg_6_0.showingCards[var_16_1]
								local var_16_3 = arg_6_0.showingCards[var_16_0]

								table = var_6

								var_6.remove(arg_6_0.showingCards, var_16_0)

								table = var_6

								var_6.remove(arg_6_0.showingCards, var_16_1)

								if var_16_2:getCardIndex() == var_16_3:getCardIndex() then
									var_16_2:setClear(true)
									var_16_3:setClear(true)

									arg_6_0.curValue = arg_6_0.curValue + 2

									if arg_6_0.curValue >= arg_6_0.CARD_NUM then
										local var_16_4 = arg_6_0

										var_6.gameEndHandler(var_16_4)
									else
										for iter_16_0 = #arg_6_0.showCards, 0, -1 do
											table = var_3_10010

											var_3_10010.remove(arg_6_0.showCards, iter_16_0)
										end

										local var_16_5 = arg_6_0

										var_6.setAllCardEnale(var_16_5, true)
									end
								else
									var_16_2:aniShowBack(false, false, arg_6_0.showingTime)
									var_16_3:aniShowBack(false, false, arg_6_0.showingTime)
								end
							end
						else
							table = var_16_0

							var_16_0.remove(arg_6_0.showCards, #arg_6_0.showCards)

							local var_16_6 = arg_6_0

							var_2.setAllCardEnale(var_16_6, #arg_6_0.showingCards == 0)
						end
					end

					return
				end))
			end
		end

		return
	end)

	if not arg_6_0:tryFirstPlayStory() then
		triggerButton = var_1

		var_1(arg_6_0.maskBtn)
	end

	return
end

function var_0_1.setAllCardEnale(arg_17_0, arg_17_1)
	pairs = var_1_10002

	for iter_17_0, iter_17_1 in var_1_10002(arg_17_0.cardList) do
		iter_17_1:setEnable(arg_17_1)
	end

	return
end

function var_0_1.setTimeTxt(arg_18_0, arg_18_1)
	setText = var_1_10002

	var_1_10002(arg_18_0.timeTxt, arg_18_0:getTimeFormat(arg_18_1))

	return
end

function var_0_1.getTimeFormat(arg_19_0, arg_19_1)
	math = var_1_10002

	local var_19_0 = var_1_10002.floor(arg_19_1 / 60000)

	var_19_0 = 10 <= var_19_0 and var_19_0 or "0" .. var_19_0
	math = var_3

	local var_19_1 = var_3.floor(arg_19_1 % 60000 / 1000)

	var_19_1 = 10 <= var_19_1 and var_19_1 or "0" .. var_19_1
	math = var_4

	local var_19_2 = var_4.floor(arg_19_1 % 1000 / 10) >= 10 and var_19_2 or "0" .. var_19_2

	return var_19_0 .. "'" .. var_19_1 .. "'" .. var_19_2
end

function var_0_1.updateTimes(arg_20_0)
	os = var_1_10001

	local var_20_0 = var_1_10001.difftime

	pg = var_1_10003

	local var_20_1 = var_1_10003.TimeMgr.GetInstance()
	local var_20_2 = var_20_0(var_3.GetServerTime(var_20_1), arg_20_0.activityData.data3)

	math = var_1_10002

	local var_20_3 = var_1_10002.ceil(var_20_2 / 0) < 0 and 0 or var_20_3

	var_20_3 = var_20_3 > arg_20_0.cardEffectTimesMax and arg_20_0.cardEffectTimesMax or var_20_3
	arg_20_0.lastTimes = var_20_3 - arg_20_0.activityData.data2
	setText = var_3

	local var_20_4 = arg_20_0.timesTxt
	local var_20_5

	if not (arg_20_0.lastTimes >= 0) or not arg_20_0.lastTimes then
		var_20_5 = 0
	end

	var_3(var_20_4, var_20_5)

	return
end

function var_0_1.gameInit(arg_21_0)
	setActive = var_1_10001

	var_1_10001(arg_21_0.maskBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_21_0.endTips, false)

	arg_21_0.isFrist = true
	arg_21_0.curValue = 0
	arg_21_0.showCards = {}
	arg_21_0.showingCards = {}
	arg_21_0.cardIndexList = {}

	for iter_21_0 = 1, arg_21_0.CARD_NUM / 2 do
		table = var_1_10005
		var_1_10005 = var_1_10005.insert

		local var_21_0 = arg_21_0.cardIndexList
		local var_21_1 = #arg_21_0.cardIndexList + 1
		local var_21_2 = {
			iter_21_0
		}

		math = var_1_10010
		var_21_2[2] = var_1_10010.random(0, 100)

		var_1_10005(var_21_0, var_21_1, var_21_2)

		table = var_1_10005
		var_1_10005 = var_1_10005.insert

		local var_21_3 = arg_21_0.cardIndexList
		local var_21_4 = #arg_21_0.cardIndexList + 1
		local var_21_5 = {
			iter_21_0
		}

		math = var_1_10010
		var_21_5[2] = var_1_10010.random(0, 100)

		var_1_10005(var_21_3, var_21_4, var_21_5)
	end

	table = var_1

	var_1.sort(arg_21_0.cardIndexList, function(arg_22_0, arg_22_1)
		if arg_22_0[2] > arg_22_1[2] then
			return true
		end

		return false
	end)
	arg_21_0:setTimeTxt(0)
	arg_21_0:clearCountTimer()
	arg_21_0:clearAllCard()

	local var_21_6 = arg_21_0.cardUIList

	var_1.align(var_21_6, arg_21_0.CARD_NUM)

	arg_21_0.gameState = arg_21_0.GAME_STATE_BEGIN

	arg_21_0:checkGameState()

	return
end

function var_0_1.checkGameState(arg_23_0)
	if arg_23_0.gameState == arg_23_0.GAME_STATE_BEGIN then
		arg_23_0:showAllCard()
	elseif arg_23_0.gameState == arg_23_0.GAME_STATE_GAMING then
		-- block empty
	elseif arg_23_0.gameState == arg_23_0.GAME_STATE_END then
		arg_23_0:clearCountTimer()
	end

	return
end

function var_0_1.gameEndHandler(arg_24_0)
	arg_24_0.gameState = arg_24_0.GAME_STATE_END

	arg_24_0:checkGameState()

	setActive = var_1

	var_1(arg_24_0.maskBtn, true)

	math = var_1

	local var_24_0 = var_1.floor

	Time = var_3

	local var_24_1 = var_24_0((var_3.realtimeSinceStartup - arg_24_0.beginTime) * 1000) < 0 and 9 * arg_24_0.aniTime or var_24_1

	arg_24_0:setTimeTxt(var_24_1)

	local var_24_2

	if not (arg_24_0.lastTimes > 0) or not (arg_24_0.activityData.data2 + 1) then
		var_24_2 = arg_24_0.activityData.data2
	end

	var_24_2 = var_24_2 > arg_24_0.cardEffectTimesMax and arg_24_0.cardEffectTimesMax or var_24_2

	local var_24_4

	if arg_24_0.lastTimes > 0 or var_24_1 < arg_24_0.activityData.data4 then
		local var_24_3 = arg_24_0

		var_24_4 = arg_24_0.emit
		CardPairsMediator = var_1_10006

		var_24_4(var_24_3, var_1_10006.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_24_0.activityData.id,
			arg1 = var_24_2,
			arg2 = var_24_1
		})
	end

	setActive = var_24_4

	var_24_4(arg_24_0.endTips, true)

	return
end

function var_0_1.showAllCard(arg_25_0)
	arg_25_0:setAllCardEnale(false)

	Timer = var_1
	arg_25_0.timer = var_1.New(function()
		pairs = var_2_10000

		for iter_26_0, iter_26_1 in var_2_10000(arg_25_0.cardList) do
			iter_26_1:aniShowBack(true)
		end

		local var_26_0 = arg_25_0

		Timer = var_1
		var_26_0.timer = var_1.New(function()
			pairs = var_3_10000

			for iter_27_0, iter_27_1 in var_3_10000(arg_25_0.cardList) do
				iter_27_1:aniShowBack()
			end

			local var_27_0 = arg_25_0

			Timer = var_1
			var_27_0.timer = var_1.New(function()
				arg_25_0.gameState = arg_25_0.GAME_STATE_GAMING

				local var_28_0 = arg_25_0

				var_0.checkGameState(var_28_0)

				local var_28_1 = arg_25_0

				var_0.setAllCardEnale(var_28_1, true)

				return
			end, arg_25_0.aniTime, 1)

			local var_27_1 = arg_25_0.timer

			var_0.Start(var_27_1)

			return
		end, arg_25_0.firstShowingTime, 1)

		local var_26_1 = arg_25_0.timer

		var_0.Start(var_26_1)

		return
	end, 0.5, 1)

	local var_25_0 = arg_25_0.timer

	var_1.Start(var_25_0)

	return
end

function var_0_1.clearAllCard(arg_29_0, arg_29_1)
	if arg_29_0.timer ~= nil then
		local var_29_0 = arg_29_0.timer

		var_2.Stop(var_29_0)

		arg_29_0.timer = nil
	end

	if arg_29_1 then
		pairs = var_2

		for iter_29_0, iter_29_1 in var_2(arg_29_0.cardList) do
			iter_29_1:destroy()
		end

		arg_29_0.cardList = {}
	else
		pairs = var_2

		for iter_29_2, iter_29_3 in var_2(arg_29_0.cardList) do
			iter_29_3:clear()
		end
	end

	return
end

function var_0_1.hideChild(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1.childCount

	for iter_30_0 = 0, var_30_0 - 1 do
		local var_30_1 = arg_30_1:GetChild(iter_30_0)

		setActive = var_1_10008

		var_1_10008(var_30_1, false)
	end

	return
end

function var_0_1.tryFirstPlayStory(arg_31_0)
	local var_31_0 = arg_31_0.activityData

	if var_1.getConfig(var_31_0, "config_client")[1] then
		local var_31_1 = arg_31_0.activityData

		if var_1.getConfig(var_31_1, "config_client")[1][1] ~= nil then
			pg = var_1_10002

			local var_31_2 = var_1_10002.NewStoryMgr.GetInstance()

			if not var_2.IsPlayed(var_31_2, var_1) then
				pg = var_2

				local var_31_3 = var_2.NewStoryMgr.GetInstance()

				var_2.Play(var_31_3, var_1, function()
					triggerButton = var_2_10000

					var_2_10000(arg_31_0.maskBtn)

					return
				end)

				return true
			end
		end

		return false
	else
		return false
	end

	return
end

function var_0_1.clearCountTimer(arg_33_0)
	if arg_33_0.countTimer ~= nil then
		local var_33_0 = arg_33_0.countTimer

		var_1.Stop(var_33_0)

		arg_33_0.countTimer = nil
	end

	return
end

function var_0_1.willExit(arg_34_0)
	arg_34_0:clearAllCard(true)
	arg_34_0:clearCountTimer()

	if arg_34_0.updateTimer ~= nil then
		local var_34_0 = arg_34_0.updateTimer

		var_1.Stop(var_34_0)

		arg_34_0.updateTimer = nil
	end

	return
end

return var_0_1
