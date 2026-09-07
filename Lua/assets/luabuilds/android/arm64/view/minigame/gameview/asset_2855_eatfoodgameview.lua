local EatFoodGameView = class("EatFoodGameView", import("..BaseMiniGameView"))
local var_0_1 = "xinnong-1"
local var_0_2 = "event:/ui/ddldaoshu2"
local var_0_3 = "event:/ui/zhengque"
local var_0_4 = "event:/ui/shibai2"
local var_0_5 = "event:/ui/deshou"
local var_0_6 = "event:/ui/shibai"
local var_0_7 = 60
local var_0_10 = 2.5
local var_0_11 = 3.75
local var_0_12 = {
	0,
	600
}
local var_0_13 = {
	150,
	150,
	150,
	140,
	140,
	140,
	130,
	130,
	130,
	120,
	120,
	120,
	110,
	110,
	100
}
local var_0_14 = {
	8,
	8,
	9,
	9,
	10,
	10,
	11,
	11,
	12,
	12,
	13,
	13,
	14,
	15,
	16,
	17,
	18,
	20
}
local var_0_15 = 400
local var_0_16 = 1
local var_0_17 = "event touch"
local var_0_18 = {
	15,
	25,
	40,
	75
}
local var_0_19 = {
	500,
	300,
	150,
	50
}
local var_0_20 = {
	-400,
	-300,
	-200,
	-100
}
local var_0_21 = {
	20,
	40,
	60,
	100
}
local var_0_22 = 0.8
local var_0_23 = 0.05
local var_0_24 = 1.4
local var_0_25 = {
	{
		id = 1,
		next_time = {
			3.5,
			4
		}
	},
	{
		id = 2,
		next_time = {
			3.5,
			4
		}
	},
	{
		id = 4,
		next_time = {
			3.5,
			4
		}
	}
}
local var_0_26 = 2
local var_0_27 = {
	1,
	3
}
local var_0_28 = 15
local var_0_29 = {
	3,
	6,
	9,
	11,
	13,
	15
}
local var_0_30 = 10
local var_0_31 = {
	{
		id = 3
	}
}
local var_0_32 = "event game over"

local function var_0_33(arg_1_0, arg_1_1)
	local var_1_0 = {
		ctor = function(self)
			self._tf = arg_1_0
			self._event = arg_1_1

			setActive(self._tf, false)

			self.sliderTouch = findTF(self._tf, "touch")

			setActive(self.sliderTouch, true)

			self.sliderRange = findTF(self._tf, "range")
			self.sliderRange.anchoredPosition = Vector2(var_0_15, 0)

			return
		end,
		start = function(self)
			self.sliderIndex = 1
			self.nextSliderTime = var_0_11
			self.sliderTouchPos = Vector2(var_0_12[1], 0)

			self:setSliderBarVisible(false)

			return
		end,
		step = function(self)
			if self.nextSliderTime then
				self.nextSliderTime = self.nextSliderTime - Time.deltaTime

				if self.nextSliderTime <= 0 then
					self:setSliderBarVisible(true)
					self:startSliderBar()

					self.nextSliderTime = self.nextSliderTime + var_0_10
				end
			end

			if self.sliderBeginning then
				self.sliderTouchPos.x = self.sliderTouchPos.x + self.speed
				self.sliderTouch.anchoredPosition = self.sliderTouchPos

				if self.sliderTouchPos.x > var_0_12[2] then
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
			if self.sliderIndex > #var_0_13 then
				self.sliderIndex = 1
			end

			self.sliderWidth = var_0_13[self.sliderIndex]
			self.speed = var_0_14[self.sliderIndex]
			self.sliderTouchPos.x = var_0_12[1]
			self.sliderBeginning = true
			self.sliderRange.sizeDelta = Vector2(self.sliderWidth, self.sliderRange.sizeDelta.y)

			return
		end,
		touch = function(self, arg_7_1)
			if not self.sliderBeginning then
				return
			end

			self.sliderBeginning = false

			self:setSliderBarVisible(false)

			local var_7_1 = 0
			local var_7_2 = math.abs(self.sliderTouchPos.x - var_0_15)
			local var_7_3

			if var_7_2 < self.sliderWidth / 2 then
				var_7_1 = self:getScore(var_7_2)
				self.sliderIndex = self.sliderIndex + 1
				var_7_3 = true
			else
				if self.sliderTouchPos.x < 100 or self.sliderTouchPos.x > var_0_12[2] - 100 then
					var_7_1 = self:getSubScore(self.sliderTouchPos.x)
				end

				self.nextSliderTime = self.nextSliderTime + var_0_16
				var_7_3 = false
			end

			if var_7_3 then
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_5)
			else
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_6)
			end

			if arg_7_1 then
				self._event:emit(var_0_17, {
					flag = var_7_3,
					score = var_7_1
				}, function()
					return
				end)
			end

			return
		end,
		getSubScore = function(arg_9_0, arg_9_1)
			local var_9_0 = arg_9_1 <= 100 and arg_9_1 or var_0_12[2] - arg_9_1

			for iter_9_0 = 1, #var_0_21 do
				if var_9_0 < var_0_21[iter_9_0] then
					return var_0_20[iter_9_0]
				end
			end

			return 0
		end,
		getScore = function(arg_10_0, arg_10_1)
			for iter_10_0 = 1, #var_0_18 do
				if arg_10_1 < var_0_18[iter_10_0] then
					return var_0_19[iter_10_0]
				end
			end

			return 0
		end,
		destroy = function(arg_11_0)
			return
		end
	}

	var_1_0:ctor()

	return var_1_0
end

local function var_0_34(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = {
		ctor = function(arg_13_0)
			arg_13_0._charTpls = arg_12_0
			arg_13_0._foodTpl = arg_12_1
			arg_13_0._container = arg_12_2
			arg_13_0._event = arg_12_3

			return
		end,
		start = function(self)
			self:clear()

			self.player = nil
			self.chars = {}
			self.animateSpeed = var_0_22
			self.playerNextStepTimes = {}

			self:create()

			return
		end,
		step = function(self)
			for iter_15_0 = 1, #self.chars do
				if not self.chars[iter_15_0].nextTime then
					self.chars[iter_15_0].nextTime = math.random(self.chars[iter_15_0].next_time[1], self.chars[iter_15_0].next_time[2])
				else
					self.chars[iter_15_0].nextTime = self.chars[iter_15_0].nextTime - Time.deltaTime

					if self.chars[iter_15_0].nextTime <= 0 then
						self.chars[iter_15_0].nextTime = nil
						self.chars[iter_15_0].stepIndex = self.chars[iter_15_0].stepIndex + 1

						if table.contains(var_0_29, self.chars[iter_15_0].stepIndex) then
							self.chars[iter_15_0].tfAnimator:SetTrigger("next")
						end

						if self.chars[iter_15_0].stepIndex == var_0_30 then
							self.chars[iter_15_0].tfAnimator:SetBool("eat", false)
							self.chars[iter_15_0].tfAnimator:SetBool("bite", true)
						end

						if self.chars[iter_15_0].stepIndex >= var_0_28 then
							self:setWinChar(self.chars[iter_15_0])
						end
					end
				end
			end

			return
		end,
		setWinChar = function(self, arg_16_1)
			local var_16_0 = false

			if arg_16_1 then
				var_16_0 = arg_16_1.isPlayer
				arg_16_1.foodState = 6

				arg_16_1.foodTfAnimator:SetInteger("state", arg_16_1.foodState)
			end

			if self.player == arg_16_1 then
				self.player.tfAnimator:SetTrigger("victory")
			else
				self.player.tfAnimator:SetTrigger("defeat")
			end

			for iter_16_0 = 1, #self.chars do
				if self.chars[iter_16_0] == arg_16_1 then
					self.chars[iter_16_0].tfAnimator:SetTrigger("victory")
				else
					self.chars[iter_16_0].tfAnimator:SetTrigger("defeat")
				end
			end

			self._event:emit(var_0_32, var_16_0, function()
				return
			end)

			return
		end,
		onPlayerTouch = function(self, arg_18_1)
			if self.player then
				if arg_18_1.flag then
					self.player.stepIndex = self.player.stepIndex + 1

					if table.contains(var_0_29, self.player.stepIndex) and not table.contains(self.playerNextStepTimes, self.player.stepIndex) then
						table.insert(self.playerNextStepTimes, self.player.stepIndex)
						self.player.tfAnimator:SetTrigger("next")
					end

					if self.player.stepIndex == var_0_30 then
						self.player.tfAnimator:SetBool("eat", false)
						self.player.tfAnimator:SetBool("bite", true)
					end

					if self.player.stepIndex >= var_0_28 then
						self:setWinChar(self.player)
					end

					self.animateSpeed = self.animateSpeed + var_0_23

					if self.animateSpeed > var_0_24 then
						self.animateSpeed = var_0_24
					end

					self.player.tfAnimator.speed = self.animateSpeed
				else
					self.animateSpeed = self.animateSpeed - var_0_23

					if self.animateSpeed < var_0_22 then
						self.animateSpeed = var_0_22
					end

					self.player.tfAnimator.speed = self.animateSpeed

					self.player.tfAnimator:SetTrigger("miss")
				end
			end

			return
		end,
		create = function(self)
			local var_19_0 = Clone(var_0_31)

			self.player = self:getCharById(table.remove(var_19_0, math.random(1, #var_19_0)), var_0_26)

			local var_19_1 = Clone(var_0_25)

			for iter_19_0 = 1, #var_0_27 do
				table.insert(self.chars, (self:getCharById(table.remove(var_19_1, math.random(1, #var_19_1)), var_0_27[iter_19_0])))
			end

			return
		end,
		getCharById = function(self, arg_20_1, arg_20_2)
			local var_20_0 = {}
			local var_20_1 = tf(instantiate(findTF(self._charTpls, "char" .. arg_20_1.id)))
			local var_20_2 = tf(instantiate(self._foodTpl))

			setParent(var_20_1, findTF(self._container, tostring(arg_20_2)))
			setActive(var_20_1, true)
			setParent(var_20_2, findTF(self._container, tostring(arg_20_2)))
			setActive(var_20_2, true)

			var_20_2.anchoredPosition = Vector2(0, -300)
			var_20_1.anchoredPosition = Vector2(0, 0)
			var_20_0.tf = var_20_1
			var_20_0.tfAnimator = GetComponent(findTF(var_20_1, "anim"), typeof(Animator))
			var_20_0.tfAnimator.speed = self.animateSpeed
			var_20_0.foodTf = var_20_2
			var_20_0.foodTfAnimator = GetComponent(findTF(var_20_2, "anim"), typeof(Animator))
			var_20_0.foodTfAnimator.speed = var_0_22
			var_20_0.next_time = arg_20_1.next_time

			if not var_20_0.next_time then
				var_20_0.isPlayer = true
			else
				var_20_0.nextTime = math.random(0, arg_20_1.next_time[2] - arg_20_1.next_time[1]) + arg_20_1.next_time[1] + var_0_11
			end

			var_20_0.foodState = 0
			var_20_0.stepIndex = 0

			local var_20_3 = GetComponent(findTF(var_20_1, "anim"), typeof(DftAniEvent))

			var_20_3:SetStartEvent(function()
				var_20_0.foodState = var_20_0.foodState + 1

				var_20_0.foodTfAnimator:SetInteger("state", var_20_0.foodState)

				return
			end)
			var_20_3:SetTriggerEvent(function()
				return
			end)
			var_20_3:SetEndEvent(function()
				return
			end)

			return var_20_0
		end,
		stop = function(self)
			if self.player then
				self.player.tfAnimator.speed = 0
			end

			if self.chars and #self.chars > 0 then
				for iter_24_0 = 1, #self.chars do
					self.chars[iter_24_0].tfAnimator.speed = 0
				end
			end

			return
		end,
		resume = function(self)
			if self.player then
				self.player.tfAnimator.speed = self.animateSpeed
			end

			if self.chars and #self.chars > 0 then
				for iter_25_0 = 1, #self.chars do
					self.chars[iter_25_0].tfAnimator.speed = var_0_22
				end
			end

			return
		end,
		onTimeOut = function(self)
			local var_26_0 = self.player
			local var_26_1 = self.player.stepIndex or 0

			for iter_26_0 = 1, #self.chars do
				if var_26_1 < self.chars[iter_26_0].stepIndex then
					var_26_0 = self.chars[iter_26_0]
					var_26_1 = self.chars[iter_26_0].stepIndex
				end
			end

			self:setWinChar(var_26_0)

			return
		end,
		clear = function(self)
			if self.player then
				destroy(self.player.tf)
				destroy(self.player.foodTf)
			end

			if self.chars then
				for iter_27_0 = 1, #self.chars do
					destroy(self.chars[iter_27_0].tf)
					destroy(self.chars[iter_27_0].foodTf)
				end
			end

			return
		end
	}

	var_12_0:ctor()

	return var_12_0
end

function EatFoodGameView:getUIName()
	return "EatFoodGameUI"
end

function EatFoodGameView:getBGM()
	return var_0_1
end

function EatFoodGameView:didEnter()
	self:initEvent()
	self:initData()
	self:initUI()
	self:initGameUI()
	self:readyStart()

	return
end

function EatFoodGameView:OnGetAwardDone()
	self:CheckGet()

	return
end

function EatFoodGameView:OnSendMiniGameOPDone(arg_32_1)
	return
end

function EatFoodGameView:initEvent()
	self:bind(var_0_32, function(arg_34_0, arg_34_1, arg_34_2)
		self:setGameOver(arg_34_1)

		return
	end)
	self:bind(var_0_17, function(arg_35_0, arg_35_1, arg_35_2)
		if arg_35_1.score and arg_35_1.score ~= 0 then
			self:addScore(arg_35_1.score)
		end

		if self.charController then
			self.charController:onPlayerTouch(arg_35_1)
		end

		return
	end)

	return
end

function EatFoodGameView:initData()
	self.dropData = pg.mini_game[self:GetMGData().id].simple_config_data.drop

	local var_36_0 = Application.targetFrameRate or 60

	if var_36_0 > 60 then
		var_36_0 = 60
	end

	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 1 / var_36_0, -1)

	return
end

function EatFoodGameView:initUI()
	self.backSceneTf = findTF(self._tf, "scene_container/scene_background")
	self.sceneTf = findTF(self._tf, "scene_container/scene")
	self.bgTf = findTF(self._tf, "bg")
	self.clickMask = findTF(self._tf, "clickMask")
	self.countUI = findTF(self._tf, "pop/CountUI")
	self.countAnimator = GetComponent(findTF(self.countUI, "count"), typeof(Animator))
	self.countDft = GetOrAddComponent(findTF(self.countUI, "count"), typeof(DftAniEvent))

	self.countDft:SetTriggerEvent(function()
		return
	end)
	self.countDft:SetEndEvent(function()
		setActive(self.countUI, false)

		self.readyStart = false

		return
	end)
	SetActive(self.countUI, false)

	self.leaveUI = findTF(self._tf, "pop/LeaveUI")

	onButton(self, findTF(self.leaveUI, "ad/btnOk"), function()
		self:resumeGame()

		if self.charController then
			self.charController:stop()
		end

		self:onGameOver(0)

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.leaveUI, "ad/btnCancel"), function()
		self:resumeGame()

		return
	end, SFX_CANCEL)
	SetActive(self.leaveUI, false)

	self.pauseUI = findTF(self._tf, "pop/pauseUI")

	onButton(self, findTF(self.pauseUI, "ad/btnOk"), function()
		setActive(self.pauseUI, false)
		self:resumeGame()

		return
	end, SFX_CANCEL)
	SetActive(self.pauseUI, false)

	self.resultUI = findTF(self._tf, "pop/resultUI")

	SetActive(self.resultUI, false)

	self.settlementUI = findTF(self._tf, "pop/SettleMentUI")

	onButton(self, findTF(self.settlementUI, "ad/btnOver"), function()
		setActive(self.settlementUI, false)
		self:closeView()

		return
	end, SFX_CANCEL)
	SetActive(self.settlementUI, false)

	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	return
end

function EatFoodGameView:initGameUI()
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

	self.dragDelegate = GetOrAddComponent(self.sceneTf, "EventTriggerListener")
	self.dragDelegate.enabled = true

	self.dragDelegate:AddPointDownFunc(function(arg_48_0, arg_48_1)
		if self.sliderController then
			self.sliderController:touch(true)
		end

		return
	end)

	self.gameTimeS = findTF(self.gameUI, "top/time/s")
	self.scoreTf = findTF(self.gameUI, "top/score")
	self.sceneScoreTf = findTF(self.sceneTf, "score")
	self.sliderController = var_0_33(findTF(self.sceneTf, "collider"), self)
	self.charController = var_0_34(findTF(self.sceneTf, "tpls"), findTF(self.sceneTf, "food"), findTF(self.sceneTf, "container"), self)

	return
end

function EatFoodGameView:Update()
	self:AddDebugInput()

	return
end

function EatFoodGameView:AddDebugInput()
	if self.gameStop or self.settlementFlag then
		return
	end

	if IsUnityEditor then
		-- block empty
	end

	return
end

function EatFoodGameView:updateMenuUI()
	return
end

function EatFoodGameView:CheckGet()
	if self:getUltimate() == 0 then
		if self:getGameTotalTime() > self:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = self:GetMGHubData().id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

function EatFoodGameView:openMenuUI()
	setActive(findTF(self._tf, "scene_container"), false)
	setActive(findTF(self.bgTf, "on"), true)
	setActive(self.gameUI, false)
	setActive(self.menuUI, true)

	return
end

function EatFoodGameView:clearUI()
	setActive(self.sceneTf, false)
	setActive(self.settlementUI, false)
	setActive(self.countUI, false)
	setActive(self.menuUI, false)
	setActive(self.gameUI, false)

	return
end

function EatFoodGameView:readyStart()
	setActive(self.countUI, true)
	self.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_2)

	self.readyStart = true

	self:gameStart()

	return
end

function EatFoodGameView:getGameTimes()
	return self:GetMGHubData().count
end

function EatFoodGameView:getGameUsedTimes()
	return self:GetMGHubData().usedtime
end

function EatFoodGameView:getUltimate()
	return self:GetMGHubData().ultimate
end

function EatFoodGameView:getGameTotalTime()
	return (self:GetMGHubData():getConfig("reward_need"))
end

function EatFoodGameView:gameStart()
	setActive(findTF(self._tf, "scene_container"), true)
	setActive(findTF(self.bgTf, "on"), false)
	setActive(self.gameUI, true)

	self.gameStartFlag = true
	self.scoreNum = 0
	self.playerPosIndex = 2
	self.gameStepTime = 0
	self.gameTime = var_0_7

	if self.sliderController then
		self.sliderController:start()
	end

	if self.charController then
		self.charController:start()
	end

	self:updateGameUI()
	self:timerStart()

	return
end

function EatFoodGameView:transformColor(arg_61_1)
	return Color.New(tonumber(string.sub(arg_61_1, 1, 2), 16) / 255, tonumber(string.sub(arg_61_1, 3, 4), 16) / 255, tonumber(string.sub(arg_61_1, 5, 6), 16) / 255)
end

function EatFoodGameView:addScore(arg_62_1, arg_62_2)
	setActive(self.sceneScoreTf, false)

	if arg_62_1 then
		self.scoreNum = self.scoreNum + arg_62_1

		setText(findTF(self.sceneScoreTf, "img"), (arg_62_1 >= 0 or nil) and ("+" .. arg_62_1 or tostring(arg_62_1)))
		setActive(self.sceneScoreTf, true)
	end

	self:updateGameUI()

	return
end

function EatFoodGameView:onTimer()
	self:gameStep()

	return
end

function EatFoodGameView:gameStep()
	if not self.readyStart then
		self.gameTime = self.gameTime - Time.deltaTime
		self.gameStepTime = self.gameStepTime + Time.deltaTime
	end

	if self.gameTime < 0 then
		self.gameTime = 0
	end

	self:updateGameUI()

	if self.sliderController then
		self.sliderController:step()
	end

	if self.charController then
		self.charController:step()
	end

	if self.gameTime <= 0 then
		if self.charController then
			self.charController:onTimeOut()
		end

		return
	end

	return
end

function EatFoodGameView:timerStart()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function EatFoodGameView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	return
end

function EatFoodGameView:updateGameUI()
	setText(self.scoreTf, self.scoreNum)
	setText(self.gameTimeS, math.ceil(self.gameTime))

	return
end

function EatFoodGameView:setGameOver(arg_68_1)
	self:onGameOver(3.5)

	local var_68_0
	local var_68_1 = Application.targetFrameRate or 60

	seriesAsync({
		function(arg_69_0)
			local var_69_0 = 0

			var_68_0 = Timer.New(function()
				var_69_0 = var_69_0 + 15

				if var_69_0 > 1400 then
					arg_69_0()
				end

				return
			end, 1 / var_68_1, -1)

			var_68_0:Start()

			return
		end,
		function(arg_71_0)
			if var_68_0 then
				var_68_0:Stop()

				var_68_0 = nil
			end

			if arg_68_1 then
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)
			else
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_4)
			end

			setActive(findTF(self.resultUI, "ad/victory"), arg_68_1)
			setActive(findTF(self.resultUI, "ad/defeat"), not arg_68_1)
			setActive(self.resultUI, true)
			GetComponent(findTF(self.resultUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

			local var_71_0 = 0

			var_68_0 = Timer.New(function()
				var_71_0 = var_71_0 + 15

				if var_71_0 > 1400 then
					setActive(self.resultUI, false)
					arg_71_0()
				end

				return
			end, 1 / var_68_1, -1)

			var_68_0:Start()

			return
		end
	}, function()
		if var_68_0 then
			var_68_0:Stop()

			var_68_0 = nil
		end

		return
	end)

	return
end

function EatFoodGameView:onGameOver(arg_74_1)
	if self.settlementFlag then
		return
	end

	self:timerStop()

	self.settlementFlag = true

	setActive(self.clickMask, true)
	LeanTween.delayedCall(go(self._tf), arg_74_1, System.Action(function()
		self.settlementFlag = false
		self.gameStartFlag = false

		setActive(self.clickMask, false)
		self:showSettlement()

		return
	end))

	return
end

function EatFoodGameView:showSettlement()
	setActive(self.settlementUI, true)
	GetComponent(findTF(self.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_76_0 = self:GetMGData():GetRuntimeData("elements")
	local var_76_1 = self.scoreNum
	local var_76_2

	if var_76_0 and #var_76_0 > 0 then
		var_76_2 = var_76_0[1] or 0
	end

	setActive(findTF(self.settlementUI, "ad/new"), var_76_2 < var_76_1)

	if var_76_2 <= var_76_1 then
		var_76_2 = var_76_1

		self:StoreDataToServer({
			var_76_1
		})
	end

	setText(findTF(self.settlementUI, "ad/highText"), var_76_2)
	setText(findTF(self.settlementUI, "ad/currentText"), var_76_1)

	if self:getGameTimes() and self:getGameTimes() > 0 then
		self.sendSuccessFlag = true

		self:SendSuccess(0)

		local var_76_3 = self:getGameTotalTime()
		local var_76_4 = self:getGameUsedTimes()
	end

	return
end

function EatFoodGameView:resumeGame()
	self.gameStop = false

	setActive(self.leaveUI, false)

	if self.charController then
		self.charController:resume()
	end

	self:timerStart()

	return
end

function EatFoodGameView:stopGame()
	self.gameStop = true

	if self.charController then
		self.charController:stop()
	end

	self:timerStop()

	return
end

function EatFoodGameView:onBackPressed()
	if not self.gameStartFlag then
		self:emit(EatFoodGameView.ON_BACK_PRESSED)
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

function EatFoodGameView:willExit()
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

return EatFoodGameView
