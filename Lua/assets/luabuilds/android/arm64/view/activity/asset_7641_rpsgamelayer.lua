local RPSGameLayer = class("RPSGameLayer", import("..base.BaseUI"))
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
	local var_1_0 = {
		Ctor = function(self)
			self._tf = arg_1_0
			self._event = arg_1_1
			self._topCardTpl = arg_1_3
			self._bottomCardTpl = arg_1_2

			setActive(self._tf, false)
			GetComponent(findTF(self._tf, "top/bg/desc/img"), typeof(Image)):SetNativeSize()
			GetComponent(findTF(self._tf, "bottom/bg/desc/img"), typeof(Image)):SetNativeSize()

			self._topContent = findTF(self._tf, "top/content")
			self._bottomContent = findTF(self._tf, "bottom/content")
			self.topCards = {}
			self.bottomCards = {}

			for iter_2_0 = 1, var_0_8 do
				local var_2_0 = tf(instantiate(self._topCardTpl))
				local var_2_1 = tf(instantiate(self._bottomCardTpl))

				SetParent(var_2_0, self._topContent)
				SetParent(var_2_1, self._bottomContent)
				setActive(var_2_0, true)
				setActive(var_2_1, true)
				table.insert(self.topCards, var_2_0)
				table.insert(self.bottomCards, var_2_1)
			end

			return
		end,
		setCardData = function(self, arg_3_1)
			for iter_3_0 = 1, var_0_8 do
				self:setCardChildsVisible(findTF(self.topCards[iter_3_0], "ad"), false)
				self:setCardChildsVisible(findTF(self.bottomCards[iter_3_0], "ad"), false)
				setActive(findTF(self.topCards[iter_3_0], "ad/" .. arg_3_1.other_cards[iter_3_0]), true)
				setActive(findTF(self.bottomCards[iter_3_0], "ad/" .. arg_3_1.my_cards[iter_3_0]), true)
			end

			return
		end,
		setCardChildsVisible = function(arg_4_0, arg_4_1, arg_4_2)
			for iter_4_0 = 1, arg_4_1.childCount do
				setActive(arg_4_1:GetChild(iter_4_0 - 1), arg_4_2)
			end

			return
		end,
		start = function(self)
			self._countTime = var_0_9

			self:setVisible(true)

			return
		end,
		step = function(self, arg_6_1)
			if self._countTime then
				self._countTime = self._countTime - arg_6_1

				if self._countTime <= 0 then
					self._countTime = nil

					self:setVisible(false)
					self._event:emit(var_0_16)

					return
				end
			end

			return
		end,
		setVisible = function(self, arg_7_1)
			setActive(self._tf, arg_7_1)

			return
		end
	}

	var_1_0:Ctor()

	return var_1_0
end

local function var_0_21(arg_8_0, arg_8_1)
	local var_8_0 = {
		Ctor = function(self)
			self._tf = arg_8_0
			self._event = arg_8_1
			self.btnTake = findTF(self._tf, "btnTake")

			setText(findTF(self.btnTake, "txt"), i18n("rps_game_take_card"))
			onButton(self._event, self.btnTake, function()
				self:takeMyCard()

				return
			end, SFX_CONFIRM)

			self.myCardTfs = {}

			for iter_9_0 = 1, var_0_8 do
				local var_9_0 = findTF(self._tf, "bottomCard/cardContent/" .. iter_9_0)

				table.insert(self.myCardTfs, var_9_0)
				onButton(self._event, var_9_0, function()
					if self.lockSelect then
						return
					end

					self.cardSelectIndex = iter_9_0

					self:updateSelectCard()

					return
				end, SFX_CONFIRM)
			end

			self.otherCardTfs = {}

			for iter_9_1 = 1, var_0_8 do
				table.insert(self.otherCardTfs, findTF(self._tf, "topCard/cardContent/" .. iter_9_1))
			end

			self.myHearts = {}
			self.otherHearts = {}

			for iter_9_2 = 1, var_0_10 do
				table.insert(self.myHearts, findTF(self._tf, "bottomStatus/heart/" .. iter_9_2))
				table.insert(self.otherHearts, findTF(self._tf, "topStatus/heart/" .. iter_9_2))
			end

			self.takeTimeText = findTF(self._tf, "takeTime/text")
			self.compareTf = findTF(self._tf, "compare")
			self.spineAnimTf = findTF(self._tf, "compare/mask/RPSSpine")
			self.spineAnim = GetComponent(self.spineAnimTf, typeof(SpineAnimUI))

			return
		end,
		updateSelectCard = function(self)
			for iter_12_0 = 1, #self.myCardTfs do
				if self.cardSelectIndex and self.cardSelectIndex == iter_12_0 then
					self.myCardTfs[iter_12_0].anchoredPosition = Vector2(self.myCardTfs[iter_12_0].anchoredPosition.x, 100)

					setActive(findTF(self.myCardTfs[iter_12_0], "AD/select"), true)
				else
					self.myCardTfs[iter_12_0].anchoredPosition = Vector2(self.myCardTfs[iter_12_0].anchoredPosition.x, 0)

					setActive(findTF(self.myCardTfs[iter_12_0], "AD/select"), false)
				end
			end

			return
		end,
		updateDetail = function(self, arg_13_1)
			local var_13_0 = arg_13_1.other_cards
			local var_13_1 = arg_13_1.my_heart
			local var_13_2 = arg_13_1.other_heart

			self.myCardNum = #arg_13_1.my_cards
			self.otherCardNum = #var_13_0

			setActive(self.btnTake, #arg_13_1.my_cards ~= 0)

			for iter_13_0 = 1, #self.myCardTfs do
				if iter_13_0 <= #arg_13_1.my_cards then
					self:updateCardIndex(self.myCardTfs[iter_13_0], arg_13_1.my_cards[iter_13_0], false)
				end

				setActive(self.myCardTfs[iter_13_0], iter_13_0 <= #arg_13_1.my_cards)
			end

			for iter_13_1 = 1, #self.otherCardTfs do
				self:updateCardCount(self.otherCardTfs[iter_13_1], #var_13_0)

				if self.otherCardNum <= 0 then
					setActive(self.otherCardTfs[iter_13_1], false)
				else
					setActive(self.otherCardTfs[iter_13_1], iter_13_1 <= 1)
				end
			end

			for iter_13_2 = 1, #self.myHearts do
				setActive(self.myHearts[iter_13_2], iter_13_2 <= var_13_1)
			end

			for iter_13_3 = 1, #self.otherHearts do
				setActive(self.otherHearts[iter_13_3], iter_13_3 <= var_13_2)
			end

			self.takeTimeText.anchoredPosition = Vector2(-(var_0_8 - self.myCardNum) * var_0_15, 0)

			return
		end,
		updateCardCount = function(arg_14_0, arg_14_1, arg_14_2)
			setText(findTF(arg_14_1, "text"), tostring(arg_14_2))

			return
		end,
		updateCardIndex = function(self, arg_15_1, arg_15_2)
			self:setCardChildsVisible(findTF(arg_15_1, "AD"), false)
			setActive(findTF(arg_15_1, "AD/" .. arg_15_2), true)

			return
		end,
		setCardChildsVisible = function(arg_16_0, arg_16_1, arg_16_2)
			for iter_16_0 = 1, arg_16_1.childCount do
				setActive(arg_16_1:GetChild(iter_16_0 - 1), arg_16_2)
			end

			return
		end,
		start = function(self)
			self.cardSelectIndex = nil

			self:updateLock(false)
			self:setVisible(false)
			setActive(self.compareTf, false)

			return
		end,
		step = function(self, arg_18_1)
			if self.myCardTime and not self.myCardCompared and self.myCardTime > 0 then
				self.myCardTime = self.myCardTime - arg_18_1

				if self.myCardTime <= 0 then
					self.myCardTime = nil
					self.cardSelectIndex = math.random(1, self.myCardNum)

					self:takeMyCard()
				end
			end

			if not self.comparedShowTime and self.myCardCompared and self.otherCardCompared then
				self.comparedShowTime = var_0_11
			end

			if self.comparedShowTime and self.comparedShowTime > 0 then
				self.comparedShowTime = self.comparedShowTime - arg_18_1

				if self.comparedShowTime <= 0 then
					self.comparedShowTime = 0

					setActive(self.compareTf, true)
					self:SetActionWithFinishCallback(self.spineAnim, var_0_19[self.myCardCompared .. self.otherCardCompared], 0, function()
						setActive(self.compareTf, false)

						self.comparedStepTime = var_0_12

						return
					end, true, function()
						return
					end)
				end
			end

			if self.comparedStepTime and self.comparedStepTime > 0 then
				self.comparedStepTime = self.comparedStepTime - arg_18_1

				if self.comparedStepTime and self.comparedStepTime <= 0 then
					self.comparedStepTime = nil
					self.comparedShowTime = nil
					self.myCardCompared = nil
					self.otherCardCompared = nil

					self._event:emit(var_0_18)
				end
			end

			if self.myCardTime then
				setText(self.takeTimeText, tostring(math.ceil(self.myCardTime)))
			else
				setText(self.takeTimeText, "")
			end

			if self.myCardCompared and isActive(self.btnTake) then
				setActive(self.btnTake, false)
			elseif not self.myCardCompared and not isActive(self.btnTake) then
				setActive(self.btnTake, true)
			end

			return
		end,
		startUp = function(self)
			self.myCardTime = var_0_14

			self:setVisible(true)

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
		takeMyCard = function(self)
			if self.lockSelect then
				return
			end

			if self.myCardNum == 1 and not self.cardSelectIndex then
				self.cardSelectIndex = 1
			end

			if self.cardSelectIndex then
				self._event:emit(var_0_17, self.cardSelectIndex)

				self.cardSelectIndex = nil

				self:updateLock(true)
				self:updateSelectCard()
			end

			return
		end,
		updateLock = function(arg_25_0, arg_25_1)
			if not arg_25_1 then
				arg_25_0.myCardTime = var_0_14 or nil
			end

			arg_25_0.lockSelect = arg_25_1

			return
		end,
		setVisible = function(self, arg_26_1)
			setActive(self._tf, arg_26_1)

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
		dispose = function(self)
			self.spineAnim:SetActionCallBack(nil)

			return
		end
	}

	var_8_0:Ctor()

	return var_8_0
end

function RPSGameLayer:getUIName()
	return "RPSGameUI"
end

function RPSGameLayer:didEnter()
	self:initEvent()
	self:initData()
	self:initUI()
	self:initGameUI()
	self:readyStart()

	return
end

function RPSGameLayer:initEvent()
	self:bind(var_0_18, function(arg_33_0, arg_33_1, arg_33_2)
		if self.myTakeCard == self.otherTakeCard + 1 or self.myTakeCard + 2 == self.otherTakeCard then
			self.gameData.my_heart = self.gameData.my_heart - 1

			self:sendGamingNotice(2)
		elseif self.myTakeCard ~= self.otherTakeCard then
			self.gameData.other_heart = self.gameData.other_heart - 1

			self:sendGamingNotice(1)
		else
			self:sendGamingNotice(3)
		end

		self.detailPanel:updateDetail(self.gameData)

		if self.gameData.my_heart == 0 or self.gameData.other_heart == 0 or #self.gameData.my_cards == 0 then
			self.gameState = var_0_7
			self.gameStartFlag = false

			self:showSettlement()
		else
			self.gameState = var_0_5
			self.myTakeCard, self.otherTakeCard = nil

			self.detailPanel:updateLock(false)
		end

		return
	end)
	self:bind(var_0_16, function(arg_34_0, arg_34_1, arg_34_2)
		self.gameState = var_0_5

		if self.detailPanel then
			self.detailPanel:startUp()
		end

		return
	end)
	self:bind(var_0_17, function(arg_35_0, arg_35_1, arg_35_2)
		if self.gameState == var_0_5 then
			self.gameState = var_0_6
			self.myTakeCard = table.remove(self.gameData.my_cards, arg_35_1)

			self.detailPanel:setMyCompareCard(self.myTakeCard)
			self.detailPanel:updateDetail(self.gameData)
		end

		return
	end)

	return
end

function RPSGameLayer:sendGamingNotice(arg_36_1)
	self:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
		operationCode = "GAME_RPS_RESULT",
		index = arg_36_1,
		miniGameId = var_0_3
	})

	return
end

function RPSGameLayer:initData()
	local var_37_0

	if Application.targetFrameRate <= 60 then
		var_37_0 = Application.targetFrameRate or 60
	end

	self.stepCount = 1 / var_37_0
	self.realTimeStartUp = Time.realtimeSinceStartup
	self.timer = Timer.New(function()
		if Time.realtimeSinceStartup - self.realTimeStartUp > self.stepCount then
			self:onTimer()

			self.realTimeStartUp = Time.realtimeSinceStartup
		end

		return
	end, 1 / var_37_0, -1)

	return
end

function RPSGameLayer:initUI()
	self.backSceneTf = findTF(self._tf, "scene_container/scene_background")
	self.sceneTf = findTF(self._tf, "scene_container/scene")
	self.bgTf = findTF(self._tf, "bg")
	self.clickMask = findTF(self._tf, "clickMask")
	self.settlementUI = findTF(self._tf, "pop/SettleMentUI")

	onButton(self, findTF(self.settlementUI, "btnOver"), function()
		self:checkGameExit()

		return
	end, SFX_CANCEL)
	SetActive(self.settlementUI, false)

	return
end

function RPSGameLayer:initGameUI()
	self.gameUI = findTF(self._tf, "ui/gameUI")

	onButton(self, findTF(self.gameUI, "btnLeave"), function()
		self:checkGameExit()

		return
	end)

	self.dragDelegate = GetOrAddComponent(self.sceneTf, "EventTriggerListener")
	self.dragDelegate.enabled = true

	self.dragDelegate:AddPointDownFunc(function(arg_43_0, arg_43_1)
		return
	end)

	self.showPanel = var_0_20(findTF(self.sceneTf, "showPanel"), self, findTF(self.sceneTf, "tpls/card_1"), findTF(self.sceneTf, "tpls/card_2"))
	self.detailPanel = var_0_21(findTF(self.sceneTf, "detailPanel"), self)

	return
end

function RPSGameLayer:Update()
	if self.gameStop or self.settlementFlag then
		return
	end

	if IsUnityEditor then
		-- block empty
	end

	return
end

function RPSGameLayer:clearUI()
	setActive(self.sceneTf, false)
	setActive(self.settlementUI, false)
	setActive(self.gameUI, false)

	return
end

function RPSGameLayer:readyStart()
	self:gameStart()

	return
end

function RPSGameLayer:gameStart()
	setActive(findTF(self._tf, "scene_container"), true)
	setActive(findTF(self.bgTf, "on"), false)
	setActive(self.gameUI, true)

	self.gameStartFlag = true
	self.scoreNum = 0
	self.gameStepTime = 0
	self.gameTime = var_0_1
	self.gameData = self:createGameData()
	self.gameState = var_0_4

	self.showPanel:setCardData(self.gameData)
	self.detailPanel:updateDetail(self.gameData)
	self:updateGameUI()
	self:timerStart()

	if self.showPanel then
		self.showPanel:start()
	end

	if self.detailPanel then
		self.detailPanel:start()
	end

	return
end

function RPSGameLayer:createGameData()
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

	for iter_48_0 = 4, var_0_8 do
		table.insert(var_48_0, math.random(1, 3))
		table.insert(var_48_1, math.random(1, 3))
	end

	table.sort(var_48_0, function(arg_49_0, arg_49_1)
		return arg_49_0 < arg_49_1
	end)
	table.sort(var_48_1, function(arg_50_0, arg_50_1)
		return arg_50_0 < arg_50_1
	end)

	return {
		other_cards = var_48_0,
		my_cards = var_48_1,
		my_heart = var_0_10,
		other_heart = var_0_10
	}
end

function RPSGameLayer:transformColor(arg_51_1)
	return Color.New(tonumber(string.sub(arg_51_1, 1, 2), 16) / 255, tonumber(string.sub(arg_51_1, 3, 4), 16) / 255, tonumber(string.sub(arg_51_1, 5, 6), 16) / 255)
end

function RPSGameLayer:onTimer()
	self:gameStep()

	return
end

function RPSGameLayer:gameStep()
	self.deltaTime = Time.realtimeSinceStartup - self.realTimeStartUp
	self.gameTime = self.gameTime - self.deltaTime
	self.gameStepTime = self.gameStepTime + self.deltaTime

	if self.gameTime < 0 then
		self.gameTime = 0
	end

	self:updateGameUI()

	if self.showPanel then
		self.showPanel:step(self.deltaTime)
	end

	if self.detailPanel then
		self.detailPanel:step(self.deltaTime)
	end

	self:updateOtherTakeCard()

	if self.gameTime <= 0 then
		self:onGameOver(0)

		return
	end

	return
end

function RPSGameLayer:updateOtherTakeCard()
	if self.gameState == var_0_5 or self.gameState == var_0_6 then
		if not self.otherTakeCard and not self.otherTakeTime then
			self.otherTakeTime = math.random(1, var_0_13)
		end

		if self.otherTakeTime and self.otherTakeTime > 0 then
			self.otherTakeTime = self.otherTakeTime - self.deltaTime

			if self.otherTakeTime <= 0 then
				self.otherTakeCard = table.remove(self.gameData.other_cards, math.random(1, #self.gameData.other_cards))

				self.detailPanel:updateDetail(self.gameData)
				self.detailPanel:setOtherCompareCard(self.otherTakeCard)

				self.otherTakeTime = nil
			end
		end
	end

	return
end

function RPSGameLayer:timerStart()
	if not self.timer.running then
		self.realTimeStartUp = Time.realtimeSinceStartup

		self.timer:Start()
	end

	return
end

function RPSGameLayer:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	return
end

function RPSGameLayer:updateGameUI()
	return
end

function RPSGameLayer:onGameOver(arg_58_1)
	if self.settlementFlag then
		return
	end

	self:timerStop()

	self.settlementFlag = true

	setActive(self.clickMask, true)
	setActive(findTF(self._tf, "scene_container"), false)
	setActive(self.gameUI, false)
	LeanTween.delayedCall(go(self._tf), arg_58_1, System.Action(function()
		self.settlementFlag = false
		self.gameStartFlag = false

		setActive(self.clickMask, false)
		self:showSettlement()

		return
	end))

	return
end

function RPSGameLayer:showSettlement()
	local var_60_0 = var_0_10 - self.gameData.other_heart
	local var_60_1 = var_0_10 - self.gameData.my_heart

	setText(findTF(self.settlementUI, "ad/score/score_1"), var_0_10 - self.gameData.other_heart)
	setText(findTF(self.settlementUI, "ad/score/score_2"), var_60_1)
	setActive(findTF(self.settlementUI, "ad/win"), var_60_1 <= var_60_0)
	setActive(findTF(self.settlementUI, "ad/defeat"), var_60_0 < var_60_1)
	self.detailPanel:setVisible(false)

	local var_60_2 = getProxy(PlayerProxy):getPlayerId()
	local var_60_3 = PlayerPrefs.GetInt("mg_score_" .. tostring(var_60_2) .. "_" .. var_0_3) or 0

	if var_60_3 <= var_60_0 then
		var_60_3 = var_60_0

		PlayerPrefs.SetInt("mg_score_" .. tostring(var_60_2) .. "_" .. var_0_3, var_60_0)
	end

	self:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
		operationCode = "GAME_RESULT",
		win = var_60_1 <= var_60_0,
		score = var_60_0,
		high_score = var_60_3,
		miniGameId = var_0_3
	})
	setActive(self.settlementUI, true)

	return
end

function RPSGameLayer:resumeGame()
	self.gameStop = false

	self:timerStart()

	return
end

function RPSGameLayer:stopGame()
	self.gameStop = true

	self:timerStop()

	return
end

function RPSGameLayer:getMiniGameData()
	self._mgData = self._mgData or getProxy(MiniGameProxy):GetMiniGameData(var_0_3)

	return self._mgData
end

function RPSGameLayer:onBackPressed()
	self:checkGameExit()

	return
end

function RPSGameLayer:checkGameExit()
	if not self.gameStartFlag then
		self:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
			operationCode = "GAME_CLOSE",
			doTrack = true,
			miniGameId = var_0_3
		})
		self:emit(RPSGameLayer.ON_BACK_PRESSED)
	else
		if self.gameStop then
			return
		end

		self:stopGame()

		if self.contextData.isDorm3d then
			pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_MSGBOX, {
				contentText = i18n("mini_game_leave"),
				onConfirm = function()
					self:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
						operationCode = "GAME_CLOSE",
						doTrack = false,
						miniGameId = var_0_3
					})
					self:emit(RPSGameLayer.ON_BACK_PRESSED)

					return
				end,
				onClose = function()
					self:resumeGame()

					return
				end
			})
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("mini_game_leave"),
				onYes = function()
					self:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
						operationCode = "GAME_CLOSE",
						doTrack = false,
						miniGameId = var_0_3
					})
					self:emit(RPSGameLayer.ON_BACK_PRESSED)

					return
				end,
				onNo = function()
					self:resumeGame()

					return
				end
			})
		end
	end

	return
end

function RPSGameLayer:willExit()
	if self.detailPanel then
		self.detailPanel:dispose()
	end

	if self._tf and LeanTween.isTweening(go(self._tf)) then
		LeanTween.cancel(go(self._tf))
	end

	if self.timer and self.timer.running then
		self.timer:Stop()
	end

	Time.timeScale = 1
	self.timer = nil

	return
end

return RPSGameLayer
