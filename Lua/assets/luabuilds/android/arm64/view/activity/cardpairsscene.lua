local var_0_0 = class("CardPairsScene", import("..base.BaseUI"))

var_0_0.CARD_NUM = 18
var_0_0.GAME_STATE_BEGIN = 0
var_0_0.GAME_STATE_GAMING = 1
var_0_0.GAME_STATE_END = 2
var_0_0.config_init = false

function var_0_0.getUIName(arg_1_0)
	return "CardPairsUI"
end

function var_0_0.setPlayerData(arg_2_0, arg_2_1)
	arg_2_0.playerData = arg_2_1

	return
end

function var_0_0.setActivityData(arg_3_0, arg_3_1)
	arg_3_0.activityData = arg_3_1

	if not arg_3_0.config_init then
		local var_3_0 = arg_3_0.activityData:getConfig("config_client")[2]

		if var_3_0 then
			arg_3_0.firstShowingTime = var_3_0.firstShowingTime
			arg_3_0.showingTime = var_3_0.showingTime
			arg_3_0.aniTime = var_3_0.aniTime
			arg_3_0.cardEffectTimesMax = arg_3_0.activityData:getConfig("config_data")[4]
		else
			arg_3_0.firstShowingTime = 2
			arg_3_0.showingTime = 0.3
			arg_3_0.aniTime = 0.2
			arg_3_0.cardEffectTimesMax = 7
		end

		CardPairsCard.ANI_TIME = arg_3_0.aniTime
		arg_3_0.config_init = true
	end

	arg_3_0:updateTimes()

	if arg_3_0.activityData.data4 <= 0 then
		setText(arg_3_0.bestTxt, "--'--'--")
	else
		setText(arg_3_0.bestTxt, arg_3_0:getTimeFormat(arg_3_0.activityData.data4))
	end

	return
end

function var_0_0.checkActivityEnd(arg_4_0)
	return
end

function var_0_0.init(arg_5_0)
	arg_5_0.backBtn = arg_5_0._tf:Find("top/back")
	arg_5_0.cardTpl = arg_5_0._tf:Find("res/card")
	arg_5_0.cardCon = arg_5_0._tf:Find("card_con/layout")
	arg_5_0.pics = arg_5_0._tf:Find("res/pics")
	arg_5_0.helpBtn = arg_5_0._tf:Find("top/help_btn")
	arg_5_0.timesTxt = arg_5_0._tf:Find("num_txt")
	arg_5_0.timeTxt = arg_5_0._tf:Find("time_txt")
	arg_5_0.bestTxt = arg_5_0._tf:Find("best_txt")
	arg_5_0.maskBtn = arg_5_0._tf:Find("mask_btn")
	arg_5_0.endTips = arg_5_0._tf:Find("end_tips")

	arg_5_0:hideChild(arg_5_0._tf:Find("res"))

	return
end

function var_0_0.didEnter(arg_6_0)
	onButton(arg_6_0, arg_6_0.backBtn, function()
		arg_6_0:emit(var_0_0.ON_BACK)

		return
	end, SOUND_BACK)
	onButton(arg_6_0, arg_6_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("card_pairs_help_tip")
		})

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.maskBtn, function()
		if arg_6_0.lastTimes > 0 then
			arg_6_0:gameInit()
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("card_pairs_tips"),
				onYes = function()
					arg_6_0:gameInit()

					return
				end
			})
		end

		return
	end, SFX_PANEL)

	arg_6_0.updateTimer = Timer.New(function()
		arg_6_0:updateTimes()

		return
	end, 10, -1)

	arg_6_0.updateTimer:Start()

	arg_6_0.showCards = {}
	arg_6_0.showingCards = {}
	arg_6_0.cardList = {}
	arg_6_0.cardUIList = UIItemList.New(arg_6_0.cardCon, arg_6_0.cardTpl)

	arg_6_0.cardUIList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			if arg_6_0.cardList[arg_12_1 + 1] ~= nil then
				arg_6_0.cardList[arg_12_1 + 1]:initCard(arg_6_0.cardIndexList[arg_12_1 + 1][1])
			else
				table.insert(arg_6_0.cardList, arg_12_1 + 1, CardPairsCard.New(arg_12_2, arg_6_0.pics, arg_6_0.cardIndexList[arg_12_1 + 1][1], function(arg_13_0)
					if arg_6_0.gameState == arg_6_0.GAME_STATE_GAMING then
						if arg_6_0.isFrist then
							arg_6_0.isFrist = false
							arg_6_0.beginTime = Time.realtimeSinceStartup
							arg_6_0.countTimer = Timer.New(function()
								arg_6_0:setTimeTxt((math.floor((Time.realtimeSinceStartup - arg_6_0.beginTime) * 1000)))

								return
							end, 0.12, -1)

							arg_6_0.countTimer:Start()
						end

						if arg_13_0.canClick and arg_13_0.enable and #arg_6_0.showCards < 2 then
							arg_13_0:aniShowBack(arg_13_0.cardState == CardPairsCard.CARD_STATE_BACK)
						end
					end

					return
				end, function(arg_15_0, arg_15_1)
					if arg_6_0.gameState == arg_6_0.GAME_STATE_GAMING then
						arg_15_0:setEnable(false)

						if arg_15_1 then
							table.insert(arg_6_0.showCards, #arg_6_0.showCards + 1, arg_15_0)

							if #arg_6_0.showCards == 2 then
								arg_6_0:setAllCardEnale(false)
							end
						end
					end

					return
				end, function(arg_16_0, arg_16_1)
					if arg_6_0.gameState == arg_6_0.GAME_STATE_GAMING then
						if arg_16_1 then
							arg_16_0:setOutline(true)
							table.insert(arg_6_0.showingCards, #arg_6_0.showingCards + 1, arg_16_0)

							if #arg_6_0.showingCards % 2 == 0 then
								table.remove(arg_6_0.showingCards, #arg_6_0.showingCards)
								table.remove(arg_6_0.showingCards, #arg_6_0.showingCards - 1)

								if arg_6_0.showingCards[#arg_6_0.showingCards - 1]:getCardIndex() == arg_6_0.showingCards[#arg_6_0.showingCards]:getCardIndex() then
									arg_6_0.showingCards[#arg_6_0.showingCards - 1]:setClear(true)
									arg_6_0.showingCards[#arg_6_0.showingCards]:setClear(true)

									arg_6_0.curValue = arg_6_0.curValue + 2

									if arg_6_0.curValue >= arg_6_0.CARD_NUM then
										arg_6_0:gameEndHandler()
									else
										for iter_16_0 = #arg_6_0.showCards, 0, -1 do
											table.remove(arg_6_0.showCards, iter_16_0)
										end

										arg_6_0:setAllCardEnale(true)
									end
								else
									arg_6_0.showingCards[#arg_6_0.showingCards - 1]:aniShowBack(false, false, arg_6_0.showingTime)
									arg_6_0.showingCards[#arg_6_0.showingCards]:aniShowBack(false, false, arg_6_0.showingTime)
								end
							end
						else
							table.remove(arg_6_0.showCards, #arg_6_0.showCards)
							arg_6_0:setAllCardEnale(#arg_6_0.showingCards == 0)
						end
					end

					return
				end))
			end
		end

		return
	end)

	if not arg_6_0:tryFirstPlayStory() then
		triggerButton(arg_6_0.maskBtn)
	end

	return
end

function var_0_0.setAllCardEnale(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.cardList) do
		iter_17_1:setEnable(arg_17_1)
	end

	return
end

function var_0_0.setTimeTxt(arg_18_0, arg_18_1)
	setText(arg_18_0.timeTxt, arg_18_0:getTimeFormat(arg_18_1))

	return
end

function var_0_0.getTimeFormat(arg_19_0, arg_19_1)
	local var_19_0 = math.floor(arg_19_1 / 60000)

	var_19_0 = var_19_0 >= 10 and var_19_0 or "0" .. var_19_0

	local var_19_1 = math.floor(arg_19_1 % 60000 / 1000)

	var_19_1 = var_19_1 >= 10 and var_19_1 or "0" .. var_19_1

	local var_19_2 = math.floor(arg_19_1 % 1000 / 10)

	var_19_2 = var_19_2 >= 10 and var_19_2 or "0" .. var_19_2

	return var_19_0 .. "'" .. var_19_1 .. "'" .. var_19_2
end

function var_0_0.updateTimes(arg_20_0)
	local var_20_0 = math.ceil(os.difftime(pg.TimeMgr.GetInstance():GetServerTime(), arg_20_0.activityData.data3) / 0)

	var_20_0 = var_20_0 < 0 and 0 or var_20_0
	var_20_0 = var_20_0 > arg_20_0.cardEffectTimesMax and arg_20_0.cardEffectTimesMax or var_20_0
	arg_20_0.lastTimes = var_20_0 - arg_20_0.activityData.data2

	local var_20_2 = arg_20_0.timesTxt

	if arg_20_0.lastTimes >= 0 then
		local var_20_3 = arg_20_0.lastTimes or 0

		var_20_1(var_20_2, var_20_3)

		return
	end
end

function var_0_0.gameInit(arg_21_0)
	setActive(arg_21_0.maskBtn, false)
	setActive(arg_21_0.endTips, false)

	arg_21_0.isFrist = true
	arg_21_0.curValue = 0
	arg_21_0.showCards = {}
	arg_21_0.showingCards = {}
	arg_21_0.cardIndexList = {}

	for iter_21_0 = 1, arg_21_0.CARD_NUM / 2 do
		table.insert(arg_21_0.cardIndexList, #arg_21_0.cardIndexList + 1, {
			iter_21_0,
			math.random(0, 100)
		})
		table.insert(arg_21_0.cardIndexList, #arg_21_0.cardIndexList + 1, {
			iter_21_0,
			math.random(0, 100)
		})
	end

	table.sort(arg_21_0.cardIndexList, function(arg_22_0, arg_22_1)
		if arg_22_0[2] > arg_22_1[2] then
			return true
		end

		return false
	end)
	arg_21_0:setTimeTxt(0)
	arg_21_0:clearCountTimer()
	arg_21_0:clearAllCard()
	arg_21_0.cardUIList:align(arg_21_0.CARD_NUM)

	arg_21_0.gameState = arg_21_0.GAME_STATE_BEGIN

	arg_21_0:checkGameState()

	return
end

function var_0_0.checkGameState(arg_23_0)
	if arg_23_0.gameState == arg_23_0.GAME_STATE_BEGIN then
		arg_23_0:showAllCard()
	elseif arg_23_0.gameState == arg_23_0.GAME_STATE_GAMING then
		-- block empty
	elseif arg_23_0.gameState == arg_23_0.GAME_STATE_END then
		arg_23_0:clearCountTimer()
	end

	return
end

function var_0_0.gameEndHandler(arg_24_0)
	arg_24_0.gameState = arg_24_0.GAME_STATE_END

	arg_24_0:checkGameState()
	setActive(arg_24_0.maskBtn, true)

	local var_24_0 = math.floor((Time.realtimeSinceStartup - arg_24_0.beginTime) * 1000)

	var_24_0 = var_24_0 < 0 and 9 * arg_24_0.aniTime or var_24_0

	arg_24_0:setTimeTxt(var_24_0)

	if arg_24_0.lastTimes > 0 then
		local var_24_1 = arg_24_0.activityData.data2 + 1 or arg_24_0.activityData.data2

		var_24_1 = var_24_1 > arg_24_0.cardEffectTimesMax and arg_24_0.cardEffectTimesMax or var_24_1

		if arg_24_0.lastTimes > 0 or var_24_0 < arg_24_0.activityData.data4 then
			arg_24_0:emit(CardPairsMediator.EVENT_OPERATION, {
				cmd = 1,
				activity_id = arg_24_0.activityData.id,
				arg1 = var_24_1,
				arg2 = var_24_0
			})
		end

		setActive(arg_24_0.endTips, true)

		return
	end
end

function var_0_0.showAllCard(arg_25_0)
	arg_25_0:setAllCardEnale(false)

	arg_25_0.timer = Timer.New(function()
		for iter_26_0, iter_26_1 in pairs(arg_25_0.cardList) do
			iter_26_1:aniShowBack(true)
		end

		arg_25_0.timer = Timer.New(function()
			for iter_27_0, iter_27_1 in pairs(arg_25_0.cardList) do
				iter_27_1:aniShowBack()
			end

			arg_25_0.timer = Timer.New(function()
				arg_25_0.gameState = arg_25_0.GAME_STATE_GAMING

				arg_25_0:checkGameState()
				arg_25_0:setAllCardEnale(true)

				return
			end, arg_25_0.aniTime, 1)

			arg_25_0.timer:Start()

			return
		end, arg_25_0.firstShowingTime, 1)

		arg_25_0.timer:Start()

		return
	end, 0.5, 1)

	arg_25_0.timer:Start()

	return
end

function var_0_0.clearAllCard(arg_29_0, arg_29_1)
	if arg_29_0.timer ~= nil then
		arg_29_0.timer:Stop()

		arg_29_0.timer = nil
	end

	if arg_29_1 then
		for iter_29_0, iter_29_1 in pairs(arg_29_0.cardList) do
			iter_29_1:destroy()
		end

		arg_29_0.cardList = {}
	else
		for iter_29_2, iter_29_3 in pairs(arg_29_0.cardList) do
			iter_29_3:clear()
		end
	end

	return
end

function var_0_0.hideChild(arg_30_0, arg_30_1)
	for iter_30_0 = 0, arg_30_1.childCount - 1 do
		setActive(arg_30_1:GetChild(iter_30_0), false)
	end

	return
end

function var_0_0.tryFirstPlayStory(arg_31_0)
	if arg_31_0.activityData:getConfig("config_client")[1] then
		local var_31_0 = arg_31_0.activityData:getConfig("config_client")[1][1]

		if var_31_0 ~= nil then
			if not pg.NewStoryMgr.GetInstance():IsPlayed(var_31_0) then
				pg.NewStoryMgr.GetInstance():Play(var_31_0, function()
					triggerButton(arg_31_0.maskBtn)

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

function var_0_0.clearCountTimer(arg_33_0)
	if arg_33_0.countTimer ~= nil then
		arg_33_0.countTimer:Stop()

		arg_33_0.countTimer = nil
	end

	return
end

function var_0_0.willExit(arg_34_0)
	arg_34_0:clearAllCard(true)
	arg_34_0:clearCountTimer()

	if arg_34_0.updateTimer ~= nil then
		arg_34_0.updateTimer:Stop()

		arg_34_0.updateTimer = nil
	end

	return
end

return var_0_0
