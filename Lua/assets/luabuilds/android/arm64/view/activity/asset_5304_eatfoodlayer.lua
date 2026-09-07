local EatFoodLayer = class("EatFoodLayer", import("..base.BaseUI"))
local var_0_1 = {
	"ui-mini_throw",
	"ui-paishou_qing",
	"ui-paishou"
}
local var_0_3 = 60
local var_0_5 = 67
local var_0_6
local var_0_7 = 4
local var_0_8 = 3
local var_0_9 = {
	0,
	630
}
local var_0_10 = {
	150,
	120,
	100,
	120,
	100,
	80,
	150,
	100,
	90,
	150,
	80,
	150,
	80,
	100,
	70
}
local var_0_11 = {
	8,
	10,
	15,
	9,
	12,
	18,
	11,
	13,
	15,
	15,
	8,
	17,
	15,
	10,
	18,
	10,
	18,
	20
}
local var_0_12 = {
	{
		-50,
		50
	},
	{
		-80,
		80
	},
	{
		-50,
		90
	},
	{
		-50,
		50
	},
	{
		-50,
		50
	},
	{
		-50,
		100
	},
	{
		-50,
		80
	},
	{
		-50,
		80
	},
	{
		-50,
		70
	},
	{
		-50,
		80
	},
	{
		-50,
		80
	},
	{
		-50,
		80
	},
	{
		-50,
		50
	},
	{
		-50,
		70
	},
	{
		-50,
		90
	}
}
local var_0_13 = 400
local var_0_14 = 0
local var_0_15 = "event touch"
local var_0_16 = {
	35,
	100
}
local var_0_17 = {
	300,
	10
}
local var_0_19 = {
	1000
}
local var_0_20 = {
	-100
}
local var_0_22 = {
	{
		126,
		530,
		2
	},
	{
		-100,
		110,
		3
	},
	{
		530,
		1000,
		3
	}
}
local var_0_23 = {
	300,
	10,
	-100
}
local var_0_24 = {
	"add_1",
	"add_2",
	"sub_1"
}
local var_0_28 = 100

local function var_0_29(arg_1_0, arg_1_1)
	local var_1_0 = {
		ctor = function(self)
			self._tf = arg_1_0
			self._event = arg_1_1

			setActive(self._tf, false)

			self.sliderTouch = findTF(self._tf, "touch")

			setActive(self.sliderTouch, true)

			self.sliderRange = findTF(self._tf, "range")
			self.sliderRange.anchoredPosition = Vector2(0, var_0_13)

			return
		end,
		start = function(self)
			self.sliderIndex = 1
			self.nextSliderTime = var_0_8
			self.sliderTouchPos = Vector2(var_0_9[1], 0)

			self:setSliderBarVisible(false)

			return
		end,
		step = function(self)
			if self.nextSliderTime then
				self.nextSliderTime = self.nextSliderTime - var_0_6

				if self.nextSliderTime <= 0 then
					self:setSliderBarVisible(true)
					self:startSliderBar()

					self.nextSliderTime = self.nextSliderTime + var_0_7
				end
			end

			if self.sliderBeginning then
				self.sliderTouchPos.y = self.sliderTouchPos.y + self.speed
				self.sliderTouch.anchoredPosition = self.sliderTouchPos

				if self.sliderTouchPos.y > var_0_9[2] then
					self:touch(false)
				end
			end

			return
		end,
		setSliderBarVisible = function(self, arg_5_1)
			setActive(self._tf, arg_5_1)

			return
		end,
		startSliderBar = function(self)
			if self.sliderIndex > #var_0_10 then
				self.sliderIndex = #var_0_10
			end

			self.sliderWidth = var_0_10[self.sliderIndex]
			self.speed = var_0_11[self.sliderIndex]
			self.speed = var_0_11[self.sliderIndex]
			self.sliderTouchPos.y = var_0_9[1]
			self.sliderBeginning = true
			self.sliderRange.sizeDelta = Vector2(self.sliderRange.sizeDelta.x, self.sliderWidth)
			self.sliderRange.anchoredPosition = Vector2(0, var_0_13 + math.random(var_0_12[self.sliderIndex][1], var_0_12[self.sliderIndex][2]))

			return
		end,
		touch = function(self, arg_7_1)
			if not self.sliderBeginning then
				return
			end

			self.sliderBeginning = false

			self:setSliderBarVisible(false)

			local var_7_0 = false
			local var_7_1 = 0
			local var_7_2 = 1
			local var_7_4 = 1

			if math.abs(self.sliderTouchPos.y - self.sliderRange.anchoredPosition.y) < self.sliderWidth / 2 then
				var_7_2 = 1
				var_7_1 = var_0_23[1]
				self.sliderIndex = self.sliderIndex + 1
				var_7_0 = true
			else
				for iter_7_0, iter_7_1 in ipairs(var_0_22) do
					if self.sliderTouchPos.y >= iter_7_1[1] and self.sliderTouchPos.y <= iter_7_1[2] then
						var_7_4 = iter_7_1[3]
					end
				end

				var_7_2 = var_7_4
				var_7_1 = var_0_23[var_7_4]
				self.nextSliderTime = self.nextSliderTime + var_0_14
				var_7_0 = false
			end

			pg.CriMgr.GetInstance():PlaySE_V3(var_0_1[var_7_4])
			self._event:emit(var_0_15, {
				flag = var_7_0,
				score = var_7_1,
				hit_index = var_7_2,
				hit_area = var_7_4
			}, function()
				return
			end)

			return
		end,
		getSubScore = function(arg_9_0, arg_9_1)
			local var_9_0 = var_0_20[1]
			local var_9_1 = 1

			for iter_9_0 = #var_0_19, 1, -1 do
				if arg_9_1 < var_0_19[iter_9_0] then
					var_9_0 = var_0_20[iter_9_0]
					var_9_1 = iter_9_0

					return var_0_20[iter_9_0], iter_9_0
				end
			end

			return var_9_0, var_9_1
		end,
		getScore = function(arg_10_0, arg_10_1)
			local var_10_0 = 0
			local var_10_1 = #var_0_16

			for iter_10_0 = 1, #var_0_16 do
				if arg_10_1 < var_0_16[iter_10_0] then
					var_10_0 = var_0_17[iter_10_0]
					var_10_1 = iter_10_0

					print("hit range" .. arg_10_1)

					return var_10_0, var_10_1
				end
			end

			return var_10_0, var_10_1
		end,
		destroy = function(arg_11_0)
			return
		end
	}

	var_1_0:ctor()

	return var_1_0
end

function EatFoodLayer:getUIName()
	return "EatFoodLayerUI"
end

function EatFoodLayer:didEnter()
	self:initEvent()
	self:initData()
	self:initUI()
	self:initGameUI()
	self:readyStart()

	return
end

function EatFoodLayer:initEvent()
	self:bind(var_0_15, function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_1.score and arg_15_1.score ~= 0 then
			self:addScore(arg_15_1.score, arg_15_1.hit_index, arg_15_1.hit_area)
		end

		return
	end)

	return
end

function EatFoodLayer:initData()
	local var_16_0 = Application.targetFrameRate or 60

	if var_16_0 > 60 then
		var_16_0 = 60
	end

	self.stepCount = 1 / var_16_0 * 0.9
	self.realTimeStartUp = Time.realtimeSinceStartup
	self.timer = Timer.New(function()
		if Time.realtimeSinceStartup - self.realTimeStartUp > self.stepCount then
			self:onTimer()

			self.realTimeStartUp = Time.realtimeSinceStartup
		end

		return
	end, 1 / var_16_0, -1)

	return
end

function EatFoodLayer:initUI()
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

	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	return
end

function EatFoodLayer:initGameUI()
	self.gameUI = findTF(self._tf, "ui/gameUI")

	onButton(self, findTF(self.gameUI, "btnLeave"), function()
		self:checkGameExit()

		return
	end)

	self.dragDelegate = GetOrAddComponent(self.sceneTf, "EventTriggerListener")
	self.dragDelegate.enabled = true

	self.dragDelegate:AddPointDownFunc(function(arg_22_0, arg_22_1)
		if self.sliderController then
			self.sliderController:touch(true)
		end

		return
	end)

	self.gameTimeS = findTF(self.gameUI, "top/time/s")
	self.scoreTf = findTF(self.gameUI, "top/score")
	self.scoreTextTf = findTF(self.scoreTf, "text")
	self.sceneScoreTf = findTF(self.sceneTf, "score")

	setActive(self.sceneScoreTf, false)

	self.sliderController = var_0_29(findTF(self.sceneTf, "collider"), self)

	return
end

function EatFoodLayer:Update()
	self:AddDebugInput()

	return
end

function EatFoodLayer:AddDebugInput()
	if self.gameStop or self.settlementFlag then
		return
	end

	if IsUnityEditor then
		-- block empty
	end

	return
end

function EatFoodLayer:clearUI()
	setActive(self.sceneTf, false)
	setActive(self.settlementUI, false)
	setActive(self.gameUI, false)

	return
end

function EatFoodLayer:readyStart()
	self:gameStart()

	return
end

function EatFoodLayer:gameStart()
	setActive(findTF(self._tf, "scene_container"), true)
	setActive(findTF(self.bgTf, "on"), false)
	setActive(self.gameUI, true)

	self.gameStartFlag = true
	self.scoreNum = 0
	self.playerPosIndex = 2
	self.gameStepTime = 0
	self.gameTime = var_0_3

	if self.sliderController then
		self.sliderController:start()
	end

	self:updateGameUI()
	self:timerStart()

	return
end

function EatFoodLayer:transformColor(arg_28_1)
	return Color.New(tonumber(string.sub(arg_28_1, 1, 2), 16) / 255, tonumber(string.sub(arg_28_1, 3, 4), 16) / 255, tonumber(string.sub(arg_28_1, 5, 6), 16) / 255)
end

function EatFoodLayer:addScore(arg_29_1, arg_29_2, arg_29_3)
	setActive(self.sceneScoreTf, false)

	if arg_29_1 then
		self.scoreNum = self.scoreNum + arg_29_1

		setActive(findTF(self.sceneScoreTf, "anim/add_1"), false)
		setActive(findTF(self.sceneScoreTf, "anim/add_2"), false)
		setActive(findTF(self.sceneScoreTf, "anim/sub_1"), false)

		local var_29_1

		if arg_29_1 >= 0 then
			setActive(findTF(self.sceneScoreTf, "anim/" .. var_0_24[arg_29_3]), true)

			var_29_1 = true
		else
			setActive(findTF(self.sceneScoreTf, "anim/" .. var_0_24[arg_29_3]), true)

			var_29_1 = false
		end

		self:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
			operationCode = "GAME_HIT_AREA",
			success = var_29_1,
			index = arg_29_3,
			miniGameId = var_0_5
		})
		setActive(self.sceneScoreTf, true)
	end

	self:updateGameUI()

	return
end

function EatFoodLayer:onTimer()
	self:gameStep()

	return
end

function EatFoodLayer:gameStep()
	var_0_6 = Time.realtimeSinceStartup - self.realTimeStartUp
	self.gameTime = self.gameTime - var_0_6
	self.gameStepTime = self.gameStepTime + var_0_6

	if self.gameTime < 0 then
		self.gameTime = 0
	end

	self:updateGameUI()

	if self.sliderController then
		self.sliderController:step()
	end

	if self.gameTime <= 0 then
		self:onGameOver(0)

		return
	end

	return
end

function EatFoodLayer:timerStart()
	if not self.timer.running then
		self.realTimeStartUp = Time.realtimeSinceStartup

		self.timer:Start()
	end

	return
end

function EatFoodLayer:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	return
end

function EatFoodLayer:updateGameUI()
	setText(self.scoreTextTf, self.scoreNum)
	setText(self.gameTimeS, math.ceil(self.gameTime))

	return
end

function EatFoodLayer:onGameOver(arg_35_1)
	if self.settlementFlag then
		return
	end

	self:timerStop()

	self.settlementFlag = true

	setActive(self.clickMask, true)
	setActive(findTF(self._tf, "scene_container"), false)
	setActive(self.gameUI, false)
	LeanTween.delayedCall(go(self._tf), arg_35_1, System.Action(function()
		self.settlementFlag = false
		self.gameStartFlag = false

		setActive(self.clickMask, false)
		self:showSettlement()

		return
	end))

	return
end

function EatFoodLayer:showSettlement()
	self:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
		operationCode = "GAME_RESULT",
		win = self.scoreNum >= var_0_28,
		score = self.scoreNum,
		miniGameId = var_0_5
	})
	setActive(self.settlementUI, true)

	local var_37_0 = self.scoreNum
	local var_37_1 = getProxy(PlayerProxy):getPlayerId()
	local var_37_2 = PlayerPrefs.GetInt("mg_score_" .. tostring(var_37_1) .. "_" .. var_0_5) or 0

	setActive(findTF(self.settlementUI, "ad/new"), var_37_2 < self.scoreNum)

	if var_37_2 <= var_37_0 then
		var_37_2 = var_37_0

		PlayerPrefs.SetInt("mg_score_" .. tostring(var_37_1) .. "_" .. var_0_5, var_37_0)
	end

	setText(findTF(self.settlementUI, "ad/highText"), var_37_2)
	setText(findTF(self.settlementUI, "ad/currentText"), var_37_0)

	return
end

function EatFoodLayer:resumeGame()
	self.gameStop = false

	self:timerStart()

	return
end

function EatFoodLayer:stopGame()
	self.gameStop = true

	self:timerStop()

	return
end

function EatFoodLayer:getMiniGameData()
	self._mgData = self._mgData or getProxy(MiniGameProxy):GetMiniGameData(var_0_5)

	return self._mgData
end

function EatFoodLayer:onBackPressed()
	self:checkGameExit()

	return
end

function EatFoodLayer:checkGameExit()
	if not self.gameStartFlag then
		self:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
			operationCode = "GAME_CLOSE",
			doTrack = true,
			miniGameId = var_0_5
		})
		self:emit(EatFoodLayer.ON_BACK_PRESSED)
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
						miniGameId = var_0_5
					})
					self:emit(EatFoodLayer.ON_BACK_PRESSED)

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
						miniGameId = var_0_5
					})
					self:emit(EatFoodLayer.ON_BACK_PRESSED)

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

function EatFoodLayer:willExit()
	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
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

return EatFoodLayer
