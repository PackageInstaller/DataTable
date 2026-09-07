local CardPairsScene = class("CardPairsScene", import("..base.BaseUI"))

CardPairsScene.CARD_NUM = 18
CardPairsScene.GAME_STATE_BEGIN = 0
CardPairsScene.GAME_STATE_GAMING = 1
CardPairsScene.GAME_STATE_END = 2
CardPairsScene.config_init = false

function CardPairsScene:getUIName()
	return "CardPairsUI"
end

function CardPairsScene:setPlayerData(arg_2_1)
	self.playerData = arg_2_1

	return
end

function CardPairsScene:setActivityData(arg_3_1)
	self.activityData = arg_3_1

	if not self.config_init then
		local var_3_0 = self.activityData:getConfig("config_client")[2]

		if var_3_0 then
			self.firstShowingTime = var_3_0.firstShowingTime
			self.showingTime = var_3_0.showingTime
			self.aniTime = var_3_0.aniTime
			self.cardEffectTimesMax = self.activityData:getConfig("config_data")[4]
		else
			self.firstShowingTime = 2
			self.showingTime = 0.3
			self.aniTime = 0.2
			self.cardEffectTimesMax = 7
		end

		CardPairsCard.ANI_TIME = self.aniTime
		self.config_init = true
	end

	self:updateTimes()

	if self.activityData.data4 <= 0 then
		setText(self.bestTxt, "--'--'--")
	else
		setText(self.bestTxt, self:getTimeFormat(self.activityData.data4))
	end

	return
end

function CardPairsScene:checkActivityEnd()
	return
end

function CardPairsScene:init()
	self.backBtn = self._tf:Find("top/back")
	self.cardTpl = self._tf:Find("res/card")
	self.cardCon = self._tf:Find("card_con/layout")
	self.pics = self._tf:Find("res/pics")
	self.helpBtn = self._tf:Find("top/help_btn")
	self.timesTxt = self._tf:Find("num_txt")
	self.timeTxt = self._tf:Find("time_txt")
	self.bestTxt = self._tf:Find("best_txt")
	self.maskBtn = self._tf:Find("mask_btn")
	self.endTips = self._tf:Find("end_tips")

	self:hideChild(self._tf:Find("res"))

	return
end

function CardPairsScene:didEnter()
	onButton(self, self.backBtn, function()
		self:emit(CardPairsScene.ON_BACK)

		return
	end, SOUND_BACK)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("card_pairs_help_tip")
		})

		return
	end, SFX_PANEL)
	onButton(self, self.maskBtn, function()
		if self.lastTimes > 0 then
			self:gameInit()
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("card_pairs_tips"),
				onYes = function()
					self:gameInit()

					return
				end
			})
		end

		return
	end, SFX_PANEL)

	self.updateTimer = Timer.New(function()
		self:updateTimes()

		return
	end, 10, -1)

	self.updateTimer:Start()

	self.showCards = {}
	self.showingCards = {}
	self.cardList = {}
	self.cardUIList = UIItemList.New(self.cardCon, self.cardTpl)

	self.cardUIList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			if self.cardList[arg_12_1 + 1] ~= nil then
				self.cardList[arg_12_1 + 1]:initCard(self.cardIndexList[arg_12_1 + 1][1])
			else
				table.insert(self.cardList, arg_12_1 + 1, CardPairsCard.New(arg_12_2, self.pics, self.cardIndexList[arg_12_1 + 1][1], function(arg_13_0)
					if self.gameState == self.GAME_STATE_GAMING then
						if self.isFrist then
							self.isFrist = false
							self.beginTime = Time.realtimeSinceStartup
							self.countTimer = Timer.New(function()
								self:setTimeTxt((math.floor((Time.realtimeSinceStartup - self.beginTime) * 1000)))

								return
							end, 0.12, -1)

							self.countTimer:Start()
						end

						if arg_13_0.canClick and arg_13_0.enable and #self.showCards < 2 then
							arg_13_0:aniShowBack(arg_13_0.cardState == CardPairsCard.CARD_STATE_BACK)
						end
					end

					return
				end, function(arg_15_0, arg_15_1)
					if self.gameState == self.GAME_STATE_GAMING then
						arg_15_0:setEnable(false)

						if arg_15_1 then
							table.insert(self.showCards, #self.showCards + 1, arg_15_0)

							if #self.showCards == 2 then
								self:setAllCardEnale(false)
							end
						end
					end

					return
				end, function(arg_16_0, arg_16_1)
					if self.gameState == self.GAME_STATE_GAMING then
						if arg_16_1 then
							arg_16_0:setOutline(true)
							table.insert(self.showingCards, #self.showingCards + 1, arg_16_0)

							if #self.showingCards % 2 == 0 then
								table.remove(self.showingCards, #self.showingCards)
								table.remove(self.showingCards, #self.showingCards - 1)

								if self.showingCards[#self.showingCards - 1]:getCardIndex() == self.showingCards[#self.showingCards]:getCardIndex() then
									self.showingCards[#self.showingCards - 1]:setClear(true)
									self.showingCards[#self.showingCards]:setClear(true)

									self.curValue = self.curValue + 2

									if self.curValue >= self.CARD_NUM then
										self:gameEndHandler()
									else
										for iter_16_0 = #self.showCards, 0, -1 do
											table.remove(self.showCards, iter_16_0)
										end

										self:setAllCardEnale(true)
									end
								else
									self.showingCards[#self.showingCards - 1]:aniShowBack(false, false, self.showingTime)
									self.showingCards[#self.showingCards]:aniShowBack(false, false, self.showingTime)
								end
							end
						else
							table.remove(self.showCards, #self.showCards)
							self:setAllCardEnale(#self.showingCards == 0)
						end
					end

					return
				end))
			end
		end

		return
	end)

	if not self:tryFirstPlayStory() then
		triggerButton(self.maskBtn)
	end

	return
end

function CardPairsScene:setAllCardEnale(arg_17_1)
	for iter_17_0, iter_17_1 in pairs(self.cardList) do
		iter_17_1:setEnable(arg_17_1)
	end

	return
end

function CardPairsScene:setTimeTxt(arg_18_1)
	setText(self.timeTxt, self:getTimeFormat(arg_18_1))

	return
end

function CardPairsScene:getTimeFormat(arg_19_1)
	local var_19_0 = math.floor(arg_19_1 / 60000)

	var_19_0 = var_19_0 >= 10 and var_19_0 or "0" .. var_19_0

	local var_19_1 = math.floor(arg_19_1 % 60000 / 1000)

	var_19_1 = var_19_1 >= 10 and var_19_1 or "0" .. var_19_1

	local var_19_2 = math.floor(arg_19_1 % 1000 / 10)

	var_19_2 = var_19_2 >= 10 and var_19_2 or "0" .. var_19_2

	return var_19_0 .. "'" .. var_19_1 .. "'" .. var_19_2
end

function CardPairsScene:updateTimes()
	local var_20_0 = math.ceil(os.difftime(pg.TimeMgr.GetInstance():GetServerTime(), self.activityData.data3) / 0)

	var_20_0 = var_20_0 < 0 and 0 or var_20_0
	var_20_0 = var_20_0 > self.cardEffectTimesMax and self.cardEffectTimesMax or var_20_0
	self.lastTimes = var_20_0 - self.activityData.data2

	setText(self.timesTxt, (self.lastTimes >= 0 or nil) and (self.lastTimes or 0))

	return
end

function CardPairsScene:gameInit()
	setActive(self.maskBtn, false)
	setActive(self.endTips, false)

	self.isFrist = true
	self.curValue = 0
	self.showCards = {}
	self.showingCards = {}
	self.cardIndexList = {}

	for iter_21_0 = 1, self.CARD_NUM / 2 do
		table.insert(self.cardIndexList, #self.cardIndexList + 1, {
			iter_21_0,
			math.random(0, 100)
		})
		table.insert(self.cardIndexList, #self.cardIndexList + 1, {
			iter_21_0,
			math.random(0, 100)
		})
	end

	table.sort(self.cardIndexList, function(arg_22_0, arg_22_1)
		if arg_22_0[2] > arg_22_1[2] then
			return true
		end

		return false
	end)
	self:setTimeTxt(0)
	self:clearCountTimer()
	self:clearAllCard()
	self.cardUIList:align(self.CARD_NUM)

	self.gameState = self.GAME_STATE_BEGIN

	self:checkGameState()

	return
end

function CardPairsScene:checkGameState()
	if self.gameState == self.GAME_STATE_BEGIN then
		self:showAllCard()
	elseif self.gameState == self.GAME_STATE_GAMING then
		-- block empty
	elseif self.gameState == self.GAME_STATE_END then
		self:clearCountTimer()
	end

	return
end

function CardPairsScene:gameEndHandler()
	self.gameState = self.GAME_STATE_END

	self:checkGameState()
	setActive(self.maskBtn, true)

	local var_24_0 = math.floor((Time.realtimeSinceStartup - self.beginTime) * 1000)

	var_24_0 = var_24_0 < 0 and 9 * self.aniTime or var_24_0

	self:setTimeTxt(var_24_0)

	local var_24_1

	if self.lastTimes > 0 then
		var_24_1 = self.activityData.data2 + 1 or self.activityData.data2
	end

	var_24_1 = var_24_1 > self.cardEffectTimesMax and self.cardEffectTimesMax or var_24_1

	if self.lastTimes > 0 or var_24_0 < self.activityData.data4 then
		self:emit(CardPairsMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = self.activityData.id,
			arg1 = var_24_1,
			arg2 = var_24_0
		})
	end

	setActive(self.endTips, true)

	return
end

function CardPairsScene:showAllCard()
	self:setAllCardEnale(false)

	self.timer = Timer.New(function()
		for iter_26_0, iter_26_1 in pairs(self.cardList) do
			iter_26_1:aniShowBack(true)
		end

		self.timer = Timer.New(function()
			for iter_27_0, iter_27_1 in pairs(self.cardList) do
				iter_27_1:aniShowBack()
			end

			self.timer = Timer.New(function()
				self.gameState = self.GAME_STATE_GAMING

				self:checkGameState()
				self:setAllCardEnale(true)

				return
			end, self.aniTime, 1)

			self.timer:Start()

			return
		end, self.firstShowingTime, 1)

		self.timer:Start()

		return
	end, 0.5, 1)

	self.timer:Start()

	return
end

function CardPairsScene:clearAllCard(arg_29_1)
	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	if arg_29_1 then
		for iter_29_0, iter_29_1 in pairs(self.cardList) do
			iter_29_1:destroy()
		end

		self.cardList = {}
	else
		for iter_29_2, iter_29_3 in pairs(self.cardList) do
			iter_29_3:clear()
		end
	end

	return
end

function CardPairsScene:hideChild(arg_30_1)
	for iter_30_0 = 0, arg_30_1.childCount - 1 do
		setActive(arg_30_1:GetChild(iter_30_0), false)
	end

	return
end

function CardPairsScene:tryFirstPlayStory()
	if self.activityData:getConfig("config_client")[1] then
		local var_31_0 = self.activityData:getConfig("config_client")[1][1]

		if var_31_0 ~= nil then
			if not pg.NewStoryMgr.GetInstance():IsPlayed(var_31_0) then
				pg.NewStoryMgr.GetInstance():Play(var_31_0, function()
					triggerButton(self.maskBtn)

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

function CardPairsScene:clearCountTimer()
	if self.countTimer ~= nil then
		self.countTimer:Stop()

		self.countTimer = nil
	end

	return
end

function CardPairsScene:willExit()
	self:clearAllCard(true)
	self:clearCountTimer()

	if self.updateTimer ~= nil then
		self.updateTimer:Stop()

		self.updateTimer = nil
	end

	return
end

return CardPairsScene
