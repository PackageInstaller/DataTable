local GameRoomShootingView = class("GameRoomShootingView", import("..BaseMiniGameView"))

GameRoomShootingView.animTime = 0.3333333333333333
GameRoomShootingView.moveModulus = 120

function GameRoomShootingView:getUIName()
	return "GameRoomShootingUI"
end

function GameRoomShootingView:init()
	self.uiMGR = pg.UIMgr.GetInstance()
	self.blurPanel = self._tf:Find("noAdaptPanel/blur_panel")
	self.top = self.blurPanel:Find("top")
	self.backBtn = self.top:Find("back")
	self.scoreTF = self.top:Find("score/Text")

	setText(self.scoreTF, 0)

	self.bestScoreTF = self.top:Find("score_heightest/Text")
	self.ticketTF = self.top:Find("ticket/Text")
	self.helpBtn = self.top:Find("help_btn")

	setActive(self.helpBtn, false)

	self.sightTF = self.blurPanel:Find("MoveArea/Sight")

	setActive(self.sightTF, false)

	self.corners = self.blurPanel:Find("Corners")
	self.shootAreaTF = self._tf:Find("noAdaptPanel/ShootArea")
	self.targetPanel = self.shootAreaTF:Find("target_panel")
	self.targetTpl = {}

	local var_2_0 = self.shootAreaTF:Find("tpl")

	for iter_2_0 = 1, var_2_0.childCount do
		self.targetTpl[iter_2_0] = var_2_0:GetChild(iter_2_0 - 1)
	end

	setActive(var_2_0, false)

	self.startMaskTF = self._tf:Find("noAdaptPanel/blur_panel/start_mask")
	self.countdownTF = self._tf:Find("noAdaptPanel/blur_panel/countUI")
	self.lastTimeTF = self.shootAreaTF:Find("time_word")
	self.bottomTF = self._tf:Find("noAdaptPanel/bottom")
	self.joyStrickTF = self.bottomTF:Find("Stick")
	self.fireBtn = self.bottomTF:Find("fire/ActCtl")
	self.fireBtnDelegate = GetOrAddComponent(self.fireBtn, "EventTriggerListener")

	setActive(self.fireBtn:Find("block"), false)

	self.resultPanel = self._tf:Find("result_panel")

	setText(findTF(self.resultPanel, "main/right/score/Text"), i18n("game_room_shooting_tip"))
	setActive(self.resultPanel, false)

	return
end

function GameRoomShootingView:initData()
	self.tempConfig = self:GetMGData():getConfig("simple_config_data")
	self.tempConfig.waitCountdown = 3
	self.tempConfig.half = 56

	return
end

function GameRoomShootingView:addTimer(arg_4_1, arg_4_2, arg_4_3)
	self.timerList = self.timerList or {}

	assert(self.timerList[arg_4_1] == nil, "error Timers")
	assert(arg_4_2 > 0, "duration must >0")

	self.timerList[arg_4_1] = {
		timeMark = Time.realtimeSinceStartup + arg_4_2,
		func = arg_4_3
	}

	return
end

function GameRoomShootingView:updateTimers()
	for iter_5_0, iter_5_1 in pairs(self.timerList) do
		if Time.realtimeSinceStartup > iter_5_1.timeMark then
			self.timerList[iter_5_0] = nil

			iter_5_1.func()
		end
	end

	return
end

function GameRoomShootingView:stopTimers()
	self.isStopped = true

	for iter_6_0, iter_6_1 in pairs(self.timerList) do
		iter_6_1.timeMark = iter_6_1.timeMark - Time.realtimeSinceStartup
	end

	return
end

function GameRoomShootingView:restartTimers()
	self.isStopped = false

	for iter_7_0, iter_7_1 in pairs(self.timerList) do
		iter_7_1.timeMark = iter_7_1.timeMark + Time.realtimeSinceStartup
	end

	return
end

function GameRoomShootingView:clearTimers()
	self.timerList = {}

	return
end

function GameRoomShootingView:didEnter()
	onButton(self, self.backBtn, function()
		if self.isPlaying then
			self:stopTimers()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("tips_summergame_exit"),
				onYes = function()
					self.lastTime = 0

					self:restartTimers()
					self:gameFinish()

					return
				end,
				onNo = function()
					self:restartTimers()

					return
				end
			})
		else
			self:closeView()
		end

		return
	end)
	onButton(self, findTF(self.startMaskTF, "startGame"), function()
		if not self.isPlaying then
			self:openCoinLayer(false)
			self:gameStart()
		end

		return
	end)

	if self:getGameRoomData() then
		self.gameHelpTip = self:getGameRoomData().game_help
	end

	onButton(self, findTF(self.startMaskTF, "ruleGame"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = self.gameHelpTip
		})

		return
	end)
	self:initData()
	self:updateCount()
	self:resetTime()
	self:initFireFunc()
	self:setFireLink(false)
	self:changeStartMaskUI(true)

	return
end

function GameRoomShootingView:changeStartMaskUI(arg_15_1)
	setActive(self.bottomTF, not arg_15_1)
	setActive(self.startMaskTF, arg_15_1)

	return
end

function GameRoomShootingView:onBackPressed()
	triggerButton(self.backBtn)

	return
end

local function var_0_1(arg_17_0, arg_17_1)
	return Vector2(math.clamp(arg_17_0.x, -arg_17_1.x, arg_17_1.x), math.clamp(arg_17_0.y, -arg_17_1.y, arg_17_1.y))
end

function GameRoomShootingView:update()
	local var_18_0 = Time.GetTimestamp()

	if not self.isStopped then
		if self.isAfterCount and self.sightTimeMark then
			local var_18_4
			local var_18_3
			local var_18_2

			if not self.moveRect then
				local var_18_1 = tf(self.sightTF.parent)

				self.moveRect = Vector2(var_18_1.rect.width - self.sightTF.rect.width, var_18_1.rect.height - self.sightTF.rect.height) / 2
				var_18_2 = self.sightTF
				var_18_3 = var_0_1
				var_18_4 = self.sightTF.anchoredPosition
			end

			var_18_2.anchoredPosition = var_18_3(var_18_4 + Vector2(self.uiMGR.hrz, self.uiMGR.vtc) * self.tempConfig.moveSpeed * (var_18_0 - self.sightTimeMark) * GameRoomShootingView.moveModulus * (self.isDown and 0.5 or 1), self.moveRect)
		end

		self:updateTimers()
	end

	self.sightTimeMark = var_18_0

	return
end

function GameRoomShootingView:resetTime()
	self.countdown = self.tempConfig.waitCountdown

	setText(findTF(self.countdownTF, "count"), self.countdown)

	self.lastTime = self.tempConfig.baseTime

	setText(self.lastTimeTF, self.lastTime)

	return
end

function GameRoomShootingView:gameStart()
	self.isPlaying = true

	self:changeStartMaskUI(false)
	UpdateBeat:Add(self.update, self)
	setActive(self.countdownTF, true)

	local function var_20_0(arg_21_0)
		self:addTimer("start countdown", 1, function()
			self.countdown = self.countdown - 1

			setText(findTF(self.countdownTF, "count"), self.countdown)

			if self.countdown > 0 then
				arg_21_0(arg_21_0)
			else
				self:afterCountDown()
			end

			return
		end)

		return
	end

	var_20_0(var_20_0)

	return
end

function GameRoomShootingView:afterCountDown()
	self.isAfterCount = true

	self.uiMGR:AttachStickOb(self.joyStrickTF)
	setActive(self.sightTF, true)
	setActive(self.countdownTF, false)
	setAnchoredPosition(self.sightTF, Vector2.zero)
	self:setFireLink(true)

	self.score = 0

	self:flushTarget(true)

	local function var_23_0(arg_24_0)
		self:addTimer("gamefinish", 1, function()
			self.lastTime = self.lastTime - 1

			setText(self.lastTimeTF, self.lastTime)

			if self.lastTime > 0 then
				arg_24_0(arg_24_0)
			else
				self:gameFinish()
			end

			return
		end)

		return
	end

	var_23_0(var_23_0)

	return
end

function GameRoomShootingView:gameFinish(arg_26_1)
	if self.isAfterCount then
		self:setFireLink(false)
		self.uiMGR:ClearStick()

		self.isAfterCount = false
	end

	self:clearTimers()
	UpdateBeat:Remove(self.update, self)
	setActive(self.sightTF, false)
	setActive(self.countdownTF, false)
	self:resetTime()

	self.isPlaying = false

	if not arg_26_1 then
		for iter_26_0 = 1, 3 do
			for iter_26_1 = 1, 6 do
				if self.cell[iter_26_0][iter_26_1] then
					self.targetPanel:Find("line_" .. iter_26_0):GetChild(iter_26_1 - 1):GetChild(0):GetComponent(typeof(Animator)):Play("targetDown")
				end
			end
		end

		Timer.New(function()
			self:changeStartMaskUI(true)

			return
		end, GameRoomShootingView.animTime):Start()
		self:resultFinish()
	end

	return
end

function GameRoomShootingView:resultFinish()
	local var_28_0 = 1

	for iter_28_0 = 1, #self.tempConfig.score_level do
		if self.score >= self.tempConfig.score_level[iter_28_0] then
			var_28_0 = iter_28_0
		end
	end

	self.awardLevel = var_28_0

	self:SendSuccess(self.score)
	self:showResultPanel({})

	return
end

function GameRoomShootingView:showResultPanel(arg_29_1, arg_29_2)
	local function var_29_0()
		setActive(self.resultPanel, false)
		self:openCoinLayer(true)

		if arg_29_2 then
			arg_29_2()
		else
			self:updateCount()
		end

		return
	end

	onButton(self, self.resultPanel:Find("bg"), var_29_0)
	onButton(self, self.resultPanel:Find("main/btn_confirm"), var_29_0)

	local var_29_1 = self.resultPanel:Find("main")

	if self.score > self.bestScore then
		self:StoreDataToServer({
			self.score
		})
		GetImageSpriteFromAtlasAsync("ui/minigameui/shootinggameui_atlas", "new_recode", var_29_1:Find("success"), true)
	else
		GetImageSpriteFromAtlasAsync("ui/minigameui/shootinggameui_atlas", "success", var_29_1:Find("success"), true)
	end

	GetImageSpriteFromAtlasAsync("ui/minigameui/shootinggameui_atlas", "level_" .. self.awardLevel, var_29_1:Find("success/level"), true)
	setText(var_29_1:Find("right/score/number"), self.score)
	setActive(var_29_1:Find("right/awards/list"), #arg_29_1 > 0)
	setActive(var_29_1:Find("right/awards/nothing"), #arg_29_1 == 0)

	self.itemList = self.itemList or UIItemList.New(var_29_1:Find("right/awards/list"), var_29_1:Find("right/awards/list/item"))

	self.itemList:make(function(arg_31_0, arg_31_1, arg_31_2)
		if arg_31_0 == UIItemList.EventUpdate then
			updateDrop(arg_31_2, arg_29_1[arg_31_1 + 1])
			setText(arg_31_2:Find("number"), "x" .. arg_29_1[arg_31_1 + 1].count)
		end

		return
	end)
	self.itemList:align(#arg_29_1)
	setActive(self.resultPanel, true)

	return
end

function GameRoomShootingView:OnSendMiniGameOPDone(arg_32_1)
	self:updateCount()

	return
end

function GameRoomShootingView:updateCount()
	setText(self.ticketTF, self:GetMGHubData().count)

	self.bestScore = getProxy(GameRoomProxy):getRoomScore(self:getGameRoomData().id)

	setText(self.bestScoreTF, self.bestScore)

	return
end

function GameRoomShootingView:initFireFunc()
	local var_34_0 = pg.TipsMgr.GetInstance()
	local var_34_1 = pg.TimeMgr.GetInstance()
	local var_34_2 = self.sightTF:Find("sight_base")
	local var_34_3 = self.sightTF:Find("sight_ready")

	setImageAlpha(var_34_2, 1)
	setImageAlpha(var_34_3, 0)

	local function var_34_4()
		setActive(self.corners, true)
		LeanTween.scale(var_34_2, Vector3(1.95, 1.95, 1), 0.1):setOnComplete(System.Action(function()
			LeanTween.alpha(var_34_2, 0, 0.1)
			LeanTween.alpha(var_34_3, 1, 0.1)

			return
		end))

		return
	end

	local function var_34_5()
		setActive(self.corners, false)
		LeanTween.alpha(var_34_2, 1, 0.1)
		LeanTween.alpha(var_34_3, 0, 0.1):setOnComplete(System.Action(function()
			LeanTween.scale(var_34_2, Vector3.one, 0.1)

			return
		end))

		return
	end

	function self._downFunc()
		var_34_4()

		return
	end

	function self._upFunc()
		LeanTween.scale(var_34_3, Vector3(2, 2, 2), 0.03):setOnComplete(System.Action(function()
			LeanTween.scale(var_34_3, Vector3.one, 0.07):setOnComplete(System.Action(function()
				var_34_5()

				return
			end))

			return
		end))

		local var_40_0, var_40_1, var_40_2 = self:checkHit()

		if var_40_0 then
			self.cell[var_40_1][var_40_2] = nil
			self.score = self.score + self.tempConfig.targetScore[self.cell[var_40_1][var_40_2]]
			self.targetCount[self.cell[var_40_1][var_40_2]] = self.targetCount[self.cell[var_40_1][var_40_2]] - 1
			self.lastTime = self.lastTime + self.tempConfig.bonusTime

			setText(self.lastTimeTF, self.lastTime)
			self.targetPanel:Find("line_" .. var_40_1):GetChild(var_40_2 - 1):GetChild(0):GetComponent(typeof(Animator)):Play("targetDown")
			self:addTimer("flush call", 0.2 + GameRoomShootingView.animTime, function()
				self:flushTarget()

				return
			end)

			if not _.any(self.targetCount, function(arg_44_0)
				return arg_44_0 > 0
			end) then
				self:gameFinish()
			end
		end

		self:setFireLink(false)
		self:addTimer("fire cd", self.tempConfig.fireCD, function()
			self:setFireLink(true)

			return
		end)

		return
	end

	function self._cancelFunc()
		var_34_5()

		return
	end

	self._emptyFunc = nil

	return
end

function GameRoomShootingView:setFireLink(arg_47_1)
	if arg_47_1 then
		setButtonEnabled(self.fireBtn, true)

		if self._downFunc ~= nil then
			self.fireBtnDelegate:AddPointDownFunc(function()
				self.isDown = true

				if self._main_cannon_sound then
					self._main_cannon_sound:Stop(true)
				end

				self._main_cannon_sound = pg.CriMgr.GetInstance():PlaySE_V3("battle-cannon-main-prepared")

				self._downFunc()

				return
			end)
		end

		if self._upFunc ~= nil then
			self.fireBtnDelegate:AddPointUpFunc(function()
				if self.isDown then
					if self._main_cannon_sound then
						self._main_cannon_sound:Stop(true)
					end

					pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/battle/boom2")

					self.isDown = false

					self._upFunc()
				end

				return
			end)
		end

		if self._cancelFunc ~= nil then
			self.fireBtnDelegate:AddPointExitFunc(function()
				if self.isDown then
					if self._main_cannon_sound then
						self._main_cannon_sound:Stop(true)
					end

					self.isDown = false

					self._cancelFunc()
				end

				return
			end)
		end
	else
		if self.isDown then
			self.isDown = false

			self._cancelFunc()
		end

		setButtonEnabled(self.fireBtn, false)
		self.fireBtnDelegate:RemovePointDownFunc()
		self.fireBtnDelegate:RemovePointUpFunc()
		self.fireBtnDelegate:RemovePointExitFunc()
	end

	return
end

function GameRoomShootingView:flushTarget(arg_51_1)
	if arg_51_1 then
		self.targetCount = {
			2,
			4,
			6
		}
	end

	for iter_51_0 = 1, 3 do
		for iter_51_1 = 1, 6 do
			removeAllChildren(self.targetPanel:Find("line_" .. iter_51_0):GetChild(iter_51_1 - 1))
		end
	end

	local var_51_0 = {
		0,
		0,
		0
	}

	self.cell = {
		{},
		{},
		{}
	}

	for iter_51_2, iter_51_3 in ipairs(self.targetCount) do
		for iter_51_4 = 1, iter_51_3 do
			local var_51_1 = math.random(3)
			local var_51_2 = math.random(6)

			while self.cell[var_51_1][var_51_2] or arg_51_1 and var_51_0[var_51_1] >= 4 do
				var_51_2 = math.random(6)
				var_51_1 = math.random(3)
			end

			var_51_0[var_51_1] = var_51_0[var_51_1] + 1
			self.cell[var_51_1][var_51_2] = iter_51_2

			cloneTplTo(self.targetTpl[iter_51_2], self.targetPanel:Find("line_" .. var_51_1):GetChild(var_51_2 - 1))
		end
	end

	setText(self.scoreTF, self.score)

	return
end

function GameRoomShootingView:checkHit()
	for iter_52_0 = 1, 3 do
		for iter_52_1 = 1, 6 do
			if self.cell[iter_52_0][iter_52_1] then
				local var_52_0 = self.targetPanel:Find("line_" .. iter_52_0):GetChild(iter_52_1 - 1):GetChild(0):Find("icon/face")
				local var_52_1 = self.sightTF:InverseTransformPoint(var_52_0:TransformPoint(var_52_0.position))

				if var_52_1.x * var_52_1.x + var_52_1.y * var_52_1.y < self.tempConfig.half * self.tempConfig.half then
					return true, iter_52_0, iter_52_1
				end
			end
		end
	end

	return
end

function GameRoomShootingView:willExit()
	return
end

return GameRoomShootingView
