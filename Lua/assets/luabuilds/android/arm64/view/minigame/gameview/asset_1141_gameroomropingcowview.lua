local RopingCowGameView = class("RopingCowGameView", import("..BaseMiniGameView"))
local var_0_1 = "story-richang-westdaily"
local var_0_2 = "event:/ui/ddldaoshu2"
local var_0_3 = "event:/ui/niujiao"
local var_0_4 = "event:/ui/taosheng"
local var_0_5 = 60
local var_0_6 = {
	{
		20,
		{
			0,
			0.25
		}
	},
	{
		40,
		{
			0.5,
			0.5
		}
	},
	{
		50,
		{
			0.5,
			1
		}
	},
	{
		60,
		{
			1,
			1.5
		}
	}
}
local var_0_7 = {
	{
		speed = 800,
		score = 300
	},
	{
		speed = 700,
		score = 200
	},
	{
		speed = 600,
		score = 100
	},
	{
		speed = 500,
		score = 50
	}
}
local var_0_8 = {
	{
		20,
		{
			300,
			300,
			200,
			200
		}
	},
	{
		40,
		{
			200,
			300,
			300,
			200
		}
	},
	{
		50,
		{
			150,
			250,
			300,
			300
		}
	},
	{
		60,
		{
			100,
			100,
			400,
			400
		}
	}
}
local var_0_9 = {
	-50,
	50
}
local var_0_10 = 0.75
local var_0_11 = 1700
local var_0_12 = 4
local var_0_13 = 0
local var_0_14 = 1
local var_0_15 = 2
local var_0_16 = "cow_event_capture"
local var_0_18 = "player_event_get"
local var_0_19 = "player_event_miss"
local var_0_20 = "player_event_cd"
local var_0_21 = "idol"
local var_0_22 = "miss"
local var_0_23 = "get"
local var_0_24 = "throw"
local var_0_25 = "event_capture"
local var_0_26 = "scene_item_type_time"
local var_0_27 = "scene_item_type_event"
local var_0_28 = {}
local var_0_29 = {
	name = "backGround/2/jiujiuA"
}

var_0_29.type = "scene_item_type_time"
var_0_29.params = {
	15,
	20
}
var_0_29.states = {
	1,
	2,
	3
}
var_0_28[1] = var_0_29
var_0_28[2] = {
	name = "backGround/2/jiujiuB",
	type = "scene_item_type_time",
	params = {
		15,
		20
	},
	states = {
		1,
		2
	}
}
var_0_28[3] = {
	name = "backGround/2/jiujiuC",
	trigger = true,
	type = "scene_item_type_time",
	params = {
		15,
		20
	}
}
var_0_28[4] = {
	name = "backGround/3/jiujiuD",
	trigger = true,
	type = "scene_item_type_time",
	params = {
		20,
		22
	}
}
var_0_28[5] = {
	name = "backGround/3/train",
	trigger = true,
	type = "scene_item_type_time",
	params = {
		20,
		23
	}
}
var_0_28[6] = {
	name = "backGround/2/saloon",
	type = "scene_item_type_time",
	params = {
		15,
		20
	},
	states = {
		1,
		2,
		3
	}
}
var_0_28[7] = {
	name = "backGround/1/meow",
	type = "scene_item_type_time",
	params = {
		15,
		20
	},
	states = {
		1,
		2
	}
}
var_0_28[8] = {
	name = "backGround/1/sheriff",
	type = "scene_item_type_event",
	events = {
		"player_event_miss",
		"player_event_get",
		"player_event_cd"
	},
	states = {
		1,
		2,
		3
	}
}

local var_0_30 = "state"
local var_0_31 = "trigger"

local function var_0_32(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		ctor = function(self)
			self._tplCows = arg_1_0
			self._container = arg_1_1
			self._event = arg_1_2
			self.cows = {}
			self.cowWeights = {}

			for iter_2_0 = 1, #var_0_8 do
				self.cowWeights[iter_2_0] = {}

				local var_2_0 = 0

				for iter_2_1, iter_2_2 in ipairs(var_0_8[iter_2_0][2]) do
					var_2_0 = var_2_0 + iter_2_2

					table.insert(self.cowWeights[iter_2_0], var_2_0)
				end
			end

			return
		end,
		start = function(self)
			self.nextCreateTime = 0
			self.lastTime = var_0_5

			self:clear()

			return
		end,
		step = function(self, arg_4_1)
			self.lastTime = self.lastTime - Time.deltaTime

			if arg_4_1 > self.nextCreateTime then
				self.nextCreateTime = arg_4_1 + self:getNextCreateCowTime()

				self:createCow()
			end

			for iter_4_0 = 1, #self.cows do
				self.cows[iter_4_0].tf.anchoredPosition.x = self.cows[iter_4_0].tf.anchoredPosition.x - self.cows[iter_4_0].data.speed * Time.deltaTime

				if self.cows[iter_4_0].tf.anchoredPosition.x >= 0 and self.cows[iter_4_0].tf.anchoredPosition.x <= 0 then
					self:setCowAniamtion(self.cows[iter_4_0].tf, var_0_15)
				end

				self.cows[iter_4_0].tf.anchoredPosition = self.cows[iter_4_0].tf.anchoredPosition
			end

			for iter_4_1 = #self.cows, 1, -1 do
				if self.cows[iter_4_1].tf.anchoredPosition.x <= -var_0_11 then
					self:cowLeave(table.remove(self.cows, iter_4_1).tf)
				end
			end

			return
		end,
		captureCow = function(self, arg_5_1)
			local var_5_0

			for iter_5_0 = #self.cows, 1, -1 do
				if self.cows[iter_5_0].tf.anchoredPosition.x >= var_0_9[1] and self.cows[iter_5_0].tf.anchoredPosition.x <= var_0_9[2] then
					if not var_5_0 then
						var_5_0 = iter_5_0
					elseif self.cows[var_5_0].tf.anchoredPosition.x - self.cows[iter_5_0].tf.anchoredPosition.x >= 0 then
						var_5_0 = iter_5_0
					end
				end
			end

			if var_5_0 then
				local var_5_2 = table.remove(self.cows, var_5_0)

				self:setCowAniamtion(var_5_2.tf, var_0_14)

				if arg_5_1 then
					arg_5_1(true)
				end

				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)
				self._event:emit(var_0_16, var_5_2.data.score)
			elseif arg_5_1 then
				arg_5_1(false)
			end

			return
		end,
		clear = function(self)
			for iter_6_0 = 1, #self.cows do
				Destroy(self.cows[iter_6_0].tf)
			end

			self.cows = {}

			return
		end,
		destroy = function(self)
			self:clear()

			return
		end,
		createCow = function(self)
			local var_8_0 = self.cowWeights[self:getCowWeightIndex()]
			local var_8_1 = math.random(0, var_8_0[#var_8_0])
			local var_8_2

			for iter_8_0 = 1, #var_8_0 do
				if var_8_1 < var_8_0[iter_8_0] then
					var_8_2 = iter_8_0

					break
				end
			end

			var_8_2 = var_8_2 or math.random(1, #var_0_7)

			local var_8_3 = tf(Instantiate(self._tplCows[var_8_2]))

			SetActive(var_8_3, true)
			SetParent(var_8_3, self._container)

			var_8_3.anchoredPosition = Vector3(var_0_11, 0, 0)

			self:setCowAniamtion(var_8_3, var_0_13)
			GetOrAddComponent(findTF(var_8_3, "anim"), typeof(DftAniEvent)):SetEndEvent(function()
				self:cowLeave(var_8_3)

				return
			end)
			table.insert(self.cows, {
				tf = var_8_3,
				data = Clone(var_0_7[var_8_2])
			})

			return
		end,
		getCowWeightIndex = function(self)
			for iter_10_0 = 1, #var_0_8 do
				if self.lastTime and self.lastTime < var_0_8[iter_10_0][1] then
					return iter_10_0
				end
			end

			return #var_0_8
		end,
		getNextCreateCowTime = function(self)
			for iter_11_0 = 1, #var_0_6 do
				if self.lastTime < var_0_6[iter_11_0][1] then
					return 0.3 + var_0_6[iter_11_0][2][1] + math.random() * (var_0_6[iter_11_0][2][2] - var_0_6[iter_11_0][2][1])
				end
			end

			return math.random(var_0_6[#var_0_6][2][1], var_0_6[#var_0_6][2][2])
		end,
		setCowAniamtion = function(arg_12_0, arg_12_1, arg_12_2)
			GetComponent(findTF(arg_12_1, "anim"), typeof(Animator)):SetInteger("state", arg_12_2)

			return
		end,
		cowLeave = function(arg_13_0, arg_13_1)
			Destroy(arg_13_1)

			return
		end
	}

	var_1_0:ctor()

	return var_1_0
end

local function var_0_33(arg_14_0, arg_14_1)
	local var_14_0 = {
		ctor = function(self)
			self._playerTf = arg_14_0
			self._initPosition = self._playerTf.anchoredPosition
			self._animator = GetComponent(findTF(self._playerTf, "img"), typeof(Animator))

			self:setPlayerAnim(var_0_21)

			self._event = arg_14_1
			self.playerDft = GetOrAddComponent(findTF(self._playerTf, "img"), typeof(DftAniEvent))

			self.playerDft:SetTriggerEvent(function()
				self._event:emit(var_0_25, nil, function(arg_17_0)
					if arg_17_0 then
						self:setPlayerAnim(var_0_23)
						self._event:emit(var_0_18)
					else
						self:setPlayerAnim(var_0_22)
					end

					return
				end)

				return
			end)
			self.playerDft:SetEndEvent(function()
				self._event:emit(var_0_19)

				return
			end)

			return
		end,
		throw = function(self)
			if self.captureCdTime then
				return
			end

			self.captureCdTime = var_0_10

			self:setPlayerAnim(var_0_24)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_4)

			return
		end,
		setPlayerAnim = function(self, arg_20_1)
			self._animator:SetTrigger(arg_20_1)

			return
		end,
		start = function(arg_21_0)
			arg_21_0.captureCdTime = 0

			return
		end,
		getThrowTime = function(self)
			return self.captureCdTime
		end,
		step = function(self, arg_23_1)
			if self.captureCdTime then
				if self.captureCdTime < 0 then
					self.captureCdTime = nil

					self:setPlayerAnim(var_0_21)
					self._event:emit(var_0_20)
				else
					self.captureCdTime = self.captureCdTime - Time.deltaTime
				end
			end

			return
		end,
		destory = function(arg_24_0)
			return
		end
	}

	var_14_0:ctor()

	return var_14_0
end

local function var_0_34(arg_25_0)
	local var_25_0 = {
		ctor = function(self)
			self._backSceneTf = arg_25_0

			if not self.sceneItems then
				self.sceneItems = {}

				for iter_26_0 = 1, #var_0_28 do
					table.insert(self.sceneItems, {
						tf = findTF(self._backSceneTf, var_0_28[iter_26_0].name),
						data = var_0_28[iter_26_0]
					})
				end
			end

			return
		end,
		onEventHandle = function(self, arg_27_1)
			for iter_27_0 = 1, #self.sceneItems do
				if self.sceneItems[iter_27_0].data.type == var_0_27 then
					for iter_27_1, iter_27_2 in ipairs(self.sceneItems[iter_27_0].data.events) do
						if iter_27_2 == arg_27_1 and self.sceneItems[iter_27_0].data.states then
							self:changeSceneItemAnim(var_0_30, self.sceneItems[iter_27_0].data.states[iter_27_1], self.sceneItems[iter_27_0].tf)
						end
					end
				end
			end

			return
		end,
		step = function(self, arg_28_1)
			for iter_28_0 = 1, #self.sceneItems do
				if self.sceneItems[iter_28_0].data.type == var_0_26 then
					if not self.sceneItems[iter_28_0].time then
						self.sceneItems[iter_28_0].time = math.random(self.sceneItems[iter_28_0].data.params[1], self.sceneItems[iter_28_0].data.params[2])
					elseif self.sceneItems[iter_28_0].time > 0 then
						self.sceneItems[iter_28_0].time = self.sceneItems[iter_28_0].time - Time.deltaTime
					else
						self.sceneItems[iter_28_0].time = math.random(self.sceneItems[iter_28_0].data.params[1], self.sceneItems[iter_28_0].data.params[2])

						if self.sceneItems[iter_28_0].data.states then
							self:changeSceneItemAnim(var_0_30, self.sceneItems[iter_28_0].data.states[math.random(1, #self.sceneItems[iter_28_0].data.states)], self.sceneItems[iter_28_0].tf)
						elseif self.sceneItems[iter_28_0].data.trigger then
							self:changeSceneItemAnim(var_0_31, nil, self.sceneItems[iter_28_0].tf)
						end
					end
				end
			end

			return
		end,
		changeSceneItemAnim = function(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
			local var_29_0 = GetComponent(arg_29_3, typeof(Animator))

			if arg_29_1 == var_0_30 then
				var_29_0:SetInteger("state", arg_29_2)
			elseif arg_29_1 == var_0_31 then
				var_29_0:SetTrigger("trigger")
			end

			return
		end
	}

	var_25_0:ctor()

	return var_25_0
end

function RopingCowGameView:getUIName()
	return "GameRoomRopingCowUI"
end

function RopingCowGameView:getBGM()
	return var_0_1
end

function RopingCowGameView:didEnter()
	self:initEvent()
	self:initData()
	self:initUI()
	self:initGameUI()
	self:updateMenuUI()
	self:openMenuUI()

	return
end

function RopingCowGameView:initEvent()
	self:bind(var_0_16, function(arg_34_0, arg_34_1, arg_34_2)
		self:addScore(arg_34_1)
		self:onEventHandle(var_0_16)

		return
	end)
	self:bind(var_0_25, function(arg_35_0, arg_35_1, arg_35_2)
		if self._cowController then
			self._cowController:captureCow(arg_35_2)
		end

		self:onEventHandle(var_0_25)

		return
	end)
	self:bind(var_0_18, function(arg_36_0, arg_36_1, arg_36_2)
		self:onEventHandle(var_0_18)

		return
	end)
	self:bind(var_0_19, function(arg_37_0, arg_37_1, arg_37_2)
		self:onEventHandle(var_0_19)

		return
	end)
	self:bind(var_0_20, function(arg_38_0, arg_38_1, arg_38_2)
		self:onEventHandle(var_0_20)

		return
	end)

	return
end

function RopingCowGameView:onEventHandle(arg_39_1)
	if self._sceneItemController then
		self._sceneItemController:onEventHandle(arg_39_1)
	end

	return
end

function RopingCowGameView:initData()
	local var_40_0 = Application.targetFrameRate or 60

	if var_40_0 > 60 then
		var_40_0 = 60
	end

	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 1 / var_40_0, -1)

	return
end

function RopingCowGameView:initUI()
	self.backSceneTf = findTF(self._tf, "scene_background")
	self.sceneTf = findTF(self._tf, "scene")
	self.clickMask = findTF(self._tf, "clickMask")
	self.countUI = findTF(self._tf, "pop/CountUI")
	self.countAnimator = GetComponent(findTF(self.countUI, "count"), typeof(Animator))
	self.countDft = GetOrAddComponent(findTF(self.countUI, "count"), typeof(DftAniEvent))

	self.countDft:SetTriggerEvent(function()
		return
	end)
	self.countDft:SetEndEvent(function()
		setActive(self.countUI, false)
		self:gameStart()

		return
	end)

	self.leaveUI = findTF(self._tf, "pop/LeaveUI")

	onButton(self, findTF(self.leaveUI, "ad/btnOk"), function()
		self:resumeGame()
		self:onGameOver()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.leaveUI, "ad/btnCancel"), function()
		self:resumeGame()

		return
	end, SFX_CANCEL)

	self.pauseUI = findTF(self._tf, "pop/pauseUI")

	onButton(self, findTF(self.pauseUI, "ad/btnOk"), function()
		setActive(self.pauseUI, false)
		self:resumeGame()

		return
	end, SFX_CANCEL)

	self.settlementUI = findTF(self._tf, "pop/SettleMentUI")

	onButton(self, findTF(self.settlementUI, "ad/btnOver"), function()
		setActive(self.settlementUI, false)
		self:openMenuUI()

		return
	end, SFX_CANCEL)

	self.menuUI = findTF(self._tf, "pop/menuUI")
	self.battleScrollRect = GetComponent(findTF(self.menuUI, "battList"), typeof(ScrollRect))
	self.totalTimes = self:getGameTotalTime()

	scrollTo(self.battleScrollRect, 0, 1 - (self:getGameUsedTimes() - 4 < 0 and 0 or self:getGameUsedTimes() - 4) / (self.totalTimes - 4))
	onButton(self, findTF(self.menuUI, "rightPanelBg/arrowUp"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y + 1 / (self.totalTimes - 4) > 1 or nil) and 1)

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "rightPanelBg/arrowDown"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y - 1 / (self.totalTimes - 4) < 0 or nil) and 0)

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnBack"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnRule"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = self:getGameRoomData().game_help
		})

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnStart"), function()
		setActive(self.menuUI, false)
		self:openCoinLayer(false)
		self:readyStart()

		return
	end, SFX_CANCEL)

	local var_42_0 = findTF(self.menuUI, "tplBattleItem")

	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	return
end

function RopingCowGameView:initGameUI()
	self.gameUI = findTF(self._tf, "ui/gameUI")

	onButton(self, findTF(self.gameUI, "topRight/btnStop"), function()
		self:stopGame()
		setActive(self.pauseUI, true)

		return
	end)
	onButton(self, findTF(self.gameUI, "btnLeave"), function()
		self:stopGame()
		setActive(self.leaveUI, true)

		return
	end)

	self.gameTimeS = findTF(self.gameUI, "top/time/s")
	self.scoreTf = findTF(self.gameUI, "top/score")
	self.btnCapture = findTF(self.gameUI, "btnCapture")
	self.captureButton = GetOrAddComponent(self.btnCapture, "EventTriggerListener")

	self.captureButton:AddPointDownFunc(function(arg_57_0, arg_57_1)
		if self._playerController then
			self._playerController:throw()
		end

		return
	end)

	local var_54_0 = {}

	for iter_54_0 = 1, var_0_12 do
		table.insert(var_54_0, (findTF(self.sceneTf, "cow" .. iter_54_0)))
	end

	self.sceneScoreTf = findTF(self.sceneTf, "score")
	self._playerController = var_0_33(findTF(self.sceneTf, "player"), self)
	self._cowController = var_0_32(var_54_0, findTF(self.sceneTf, "cowContainer"), self)
	self._sceneItemController = var_0_34(self.backSceneTf)

	return
end

function RopingCowGameView:Update()
	self:AddDebugInput()

	return
end

function RopingCowGameView:AddDebugInput()
	if self.gameStop or self.settlementFlag then
		return
	end

	if IsUnityEditor and Input.GetKeyDown(KeyCode.S) and self._playerController then
		self._playerController:throw()
	end

	return
end

function RopingCowGameView:updateMenuUI()
	local var_60_0 = self:getGameUsedTimes()
	local var_60_1 = self:getGameTimes()

	return
end

function RopingCowGameView:CheckGet()
	setActive(findTF(self.menuUI, "got"), false)

	if self:getUltimate() and self:getUltimate() ~= 0 then
		setActive(findTF(self.menuUI, "got"), true)
	end

	if self:getUltimate() == 0 then
		if self:getGameTotalTime() > self:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = self:GetMGHubData().id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(self.menuUI, "got"), true)
	end

	return
end

function RopingCowGameView:openMenuUI()
	setActive(findTF(self._tf, "scene_front"), false)
	setActive(findTF(self._tf, "scene_background"), false)
	setActive(findTF(self._tf, "scene"), false)
	setActive(self.gameUI, false)
	setActive(self.menuUI, true)
	self:openCoinLayer(true)
	self:updateMenuUI()

	return
end

function RopingCowGameView:clearUI()
	setActive(self.sceneTf, false)
	setActive(self.settlementUI, false)
	setActive(self.countUI, false)
	setActive(self.menuUI, false)
	self:openCoinLayer(false)
	setActive(self.gameUI, false)

	return
end

function RopingCowGameView:readyStart()
	setActive(self.countUI, true)
	self.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_2)

	return
end

function RopingCowGameView:gameStart()
	setActive(findTF(self._tf, "scene_front"), true)
	setActive(findTF(self._tf, "scene_background"), true)
	setActive(findTF(self._tf, "scene"), true)
	setActive(self.gameUI, true)

	self.gameStartFlag = true
	self.scoreNum = 0
	self.playerPosIndex = 2
	self.gameStepTime = 0
	self.heart = 3
	self.gameTime = var_0_5

	if self._cowController then
		self._cowController:start()
	end

	if self._playerController then
		self._playerController:start()
	end

	self:updateGameUI()
	self:timerStart()

	return
end

function RopingCowGameView:getGameTimes()
	return self:GetMGHubData().count
end

function RopingCowGameView:getGameUsedTimes()
	return self:GetMGHubData().usedtime
end

function RopingCowGameView:getUltimate()
	return self:GetMGHubData().ultimate
end

function RopingCowGameView:getGameTotalTime()
	return (self:GetMGHubData():getConfig("reward_need"))
end

function RopingCowGameView:changeSpeed(arg_70_1)
	return
end

function RopingCowGameView:onTimer()
	self:gameStep()

	return
end

function RopingCowGameView:gameStep()
	self.gameTime = self.gameTime - Time.deltaTime

	if self.gameTime < 0 then
		self.gameTime = 0
	end

	self.gameStepTime = self.gameStepTime + Time.deltaTime

	if self._cowController then
		self._cowController:step(self.gameStepTime)
	end

	if self._playerController then
		self._playerController:step(self.gameStepTime)
	end

	if self._sceneItemController then
		self._sceneItemController:step(self.gameStepTime)
	end

	self:updateGameUI()

	if self.gameTime <= 0 then
		self:onGameOver()

		return
	end

	return
end

function RopingCowGameView:timerStart()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function RopingCowGameView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	return
end

function RopingCowGameView:updateGameUI()
	setText(self.scoreTf, self.scoreNum)
	setText(self.gameTimeS, math.ceil(self.gameTime))

	self.captureCdMaskImg = self.captureCdMaskImg or GetComponent(findTF(self.btnCapture, "cd"), typeof(Image))

	if self._playerController then
		local var_75_0 = self._playerController:getThrowTime()

		self.captureCdMaskImg.fillAmount = var_75_0 and var_75_0 > 0 and var_75_0 / var_0_10 or 0
	end

	return
end

function RopingCowGameView:addScore(arg_76_1)
	self.scoreNum = self.scoreNum + arg_76_1

	if self.scoreNum < 0 then
		self.scoreNum = 0
	end

	setActive(self.sceneScoreTf, false)

	for iter_76_0 = 0, self.sceneScoreTf.childCount - 1 do
		local var_76_0 = self.sceneScoreTf:GetChild(iter_76_0)

		if var_76_0.name == tostring(arg_76_1) then
			setActive(var_76_0, true)
		else
			setActive(var_76_0, false)
		end
	end

	setActive(self.sceneScoreTf, true)

	return
end

function RopingCowGameView:onGameOver()
	if self.settlementFlag then
		return
	end

	self:timerStop()

	self.settlementFlag = true

	setActive(self.sceneScoreTf, false)
	setActive(self.clickMask, true)

	if self._cowController then
		self._cowController:clear()
	end

	LeanTween.delayedCall(go(self._tf), 0.1, System.Action(function()
		self.settlementFlag = false
		self.gameStartFlag = false

		setActive(self.clickMask, false)
		self:showSettlement()

		return
	end))

	return
end

function RopingCowGameView:showSettlement()
	setActive(self.settlementUI, true)
	GetComponent(findTF(self.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_79_0 = self.scoreNum
	local var_79_1 = getProxy(GameRoomProxy):getRoomScore(self:getGameRoomData().id)

	setActive(findTF(self.settlementUI, "ad/new"), var_79_1 < self.scoreNum)

	if var_79_1 <= var_79_0 then
		var_79_1 = var_79_0

		self:StoreDataToServer({
			var_79_0
		})
	end

	setText(findTF(self.settlementUI, "ad/highText"), var_79_1)
	setText(findTF(self.settlementUI, "ad/currentText"), var_79_0)

	self.sendSuccessFlag = true

	self:SendSuccess(var_79_0 or 0)

	return
end

function RopingCowGameView:resumeGame()
	self.gameStop = false

	setActive(self.leaveUI, false)
	self:changeSpeed(1)
	self:timerStart()

	return
end

function RopingCowGameView:stopGame()
	self.gameStop = true

	self:timerStop()
	self:changeSpeed(0)

	return
end

function RopingCowGameView:checkOverflow(arg_82_1, arg_82_2)
	local var_82_0 = getProxy(PlayerProxy):getRawData()
	local var_82_1, var_82_2 = Task.StaticJudgeOverflow(var_82_0.gold, var_82_0.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, {
		arg_82_1
	})

	if var_82_1 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_ITEM_BOX,
			content = i18n("award_max_warning_minigame"),
			items = var_82_2,
			onYes = arg_82_2
		})
	else
		arg_82_2()
	end

	return
end

function RopingCowGameView:onBackPressed()
	if not self.gameStartFlag then
		self:emit(RopingCowGameView.ON_BACK_PRESSED)
	else
		if self.settlementFlag then
			return
		end

		if isActive(self.pauseUI) then
			setActive(self.pauseUI, false)
		end

		self:stopGame()
		setActive(self.leaveUI, true)
	end

	return
end

function RopingCowGameView:willExit()
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

return RopingCowGameView
