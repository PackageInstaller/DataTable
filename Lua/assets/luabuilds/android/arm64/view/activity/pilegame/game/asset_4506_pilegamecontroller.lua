local PileGameController = class("PileGameController")

PileGameController.STATE_IDLE = 0
PileGameController.STATE_PREPARE = 1
PileGameController.STATE_START = 2
PileGameController.STATE_DROPING = 3
PileGameController.STATE_STOP_DROP = 4
PileGameController.STATE_SINK = 5
PileGameController.STATE_SINK_DONE = 6
PileGameController.STATE_STOP_SHAKE = 7
PileGameController.STATE_END = 8
PileGameController.STATE_EXIT = 9
PileGameController.DROP_AREA_SAFE = 1
PileGameController.DROP_AREA_WARN = 2
PileGameController.DROP_AREA_DANGER = 3

function PileGameController:Ctor()
	self.model = PileGameModel.New(self)
	self.view = PileGameView.New(self)
	self.state = PileGameController.STATE_IDLE
	self.locked = false
	self.time = 0
	self.shakePositions = {}

	return
end

function PileGameController:SetUp(arg_2_1, arg_2_2)
	self.model:NetData(arg_2_1)
	self.view:OnEnterGame(arg_2_1)

	self.gameEndCb = arg_2_2

	return
end

function PileGameController:StartGame()
	seriesAsync({
		function(arg_4_0)
			self.locked = false

			self:OnInitGame()
			self.view:DoCurtain(arg_4_0)

			if self.gameStateCallback then
				self.gameStateCallback(false)
			end

			return
		end,
		function(arg_5_0)
			self:OnPrepare(arg_5_0)

			return
		end,
		function(arg_6_0)
			self.state = PileGameController.STATE_PREPARE

			self.view:OnGameStart()

			return
		end
	})

	return
end

function PileGameController:setGameStartCallback(arg_7_1)
	self.gameStateCallback = arg_7_1

	return
end

function PileGameController:ExitGame()
	self.locked = false
	self.shakePositions = {}
	self.state = PileGameController.STATE_EXIT

	for iter_8_0, iter_8_1 in ipairs(self.model.items) do
		self.view:OnRemovePile(iter_8_1)
	end

	if self.gameStateCallback then
		self.gameStateCallback(true)
	end

	self.model:Clear()
	self.view:OnGameExited()

	return
end

function PileGameController:Drop()
	if self.state == PileGameController.STATE_START and not self.locked then
		self.state = PileGameController.STATE_DROPING

		self:OnStartDrop()
	end

	return
end

function PileGameController:OnInitGame()
	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)
	self.model:AddDeathLineRight()
	self.model:AddDeathLineLeft()
	self.model:AddSafeLineRight()
	self.model:AddSafeLineLeft()
	self.model:AddGround()
	self.view:InitSup(self.model)

	return
end

function PileGameController:OnPrepare(arg_11_1)
	seriesAsync({
		function(arg_12_0)
			self.view:UpdateScore(self.model.score)
			self.view:UpdateFailedCnt(self.model.maxFailedCnt, self.model.failedCnt)
			arg_12_0()

			return
		end,
		function(arg_13_0)
			self.item = self.model:AddHeadPile()
			self.item.position = Vector3(0, -self.model.screen.y / 2, 0)

			self.view:AddPile(self.item, true, function()
				self.view:OnItemPositionChange(self.item)
				arg_13_0()

				return
			end)

			return
		end,
		function(arg_15_0)
			self.item = self.model:AddPileByRandom()
			self.item.position = Vector3(0, -self.model.screen.y / 2 + self.item.sizeDelta.y, 0)

			self.view:AddPile(self.item, false, function()
				self.view:OnItemPositionChange(self.item)
				arg_15_0()

				return
			end)

			return
		end
	}, arg_11_1)

	return
end

function PileGameController:OnStartGame(arg_17_1)
	local function var_17_0()
		self.state = PileGameController.STATE_SINK_DONE
		self.item = self.model:AddPileByRandom()

		self.view:AddPile(self.item, false, function()
			self.state = PileGameController.STATE_START

			return
		end)

		return
	end

	if self.model:ShouldSink() then
		self.state = PileGameController.STATE_SINK

		self:DoSink(var_17_0)
	else
		var_17_0()
	end

	self:RemoveLockTimer()

	if arg_17_1 then
		self.locked = true
		self.lockTimer = Timer.New(function()
			self.locked = false

			return
		end, PileGameConst.BAN_OP_TIME, 1)

		self.lockTimer:Start()
	end

	return
end

function PileGameController:RemoveLockTimer()
	if self.lockTimer then
		self.lockTimer:Stop()

		self.lockTimer = nil
	end

	return
end

function PileGameController:OnEndGame(arg_22_1)
	self.state = PileGameController.STATE_END
	self.time = 0
	self.shakePositions = {}
	self.locked = false

	local function var_22_0()
		self.view:OnGameEnd(self.model.score, self.model.highestScore)

		if self.model.score > self.model.highestScore then
			self.model:UpdateHighestScore()
		end

		self.model.score = 0

		return
	end

	if self.gameEndCb then
		self.gameEndCb(self.model.score, self.model.highestScore)
	end

	if arg_22_1 then
		self.view:OnCollapse(self.model:GetFirstItem().position.x, self.item.position.x > 0 and 1 or 0, var_22_0)
	else
		var_22_0()
	end

	return
end

function PileGameController:Update()
	if self.state == PileGameController.STATE_PREPARE then
		self:OnStartGame()
	elseif self.state == PileGameController.STATE_START then
		self:Shuffling()
	elseif self.state == PileGameController.STATE_DROPING then
		self:Droping()
	elseif self.state == PileGameController.STATE_STOP_DROP then
		self:CheckCollide()
	end

	if #self.shakePositions > 0 then
		self:DoShake()
	end

	if self.state >= PileGameController.STATE_START and self.state < PileGameController.STATE_END then
		if self.time >= PileGameConst.PLAY_SPE_ACTION_TIME then
			self:PlaySpeAction()

			self.time = 0
		end

		self.time = self.time + Time.deltaTime
	end

	return
end

function PileGameController:PlaySpeAction()
	for iter_25_0, iter_25_1 in pairs(self.model.items) do
		if iter_25_1 ~= self.item then
			self.view:PlaySpeAction(iter_25_1)
		end
	end

	return
end

function PileGameController:StopShake()
	for iter_26_0, iter_26_1 in ipairs(self.shakePositions) do
		iter_26_1[1].onTheMove = false
	end

	self.shakePositions = {}

	return
end

function PileGameController:CheckRock()
	if self.model:GetDropArea((self.model:GetTailItem())) == PileGameController.DROP_AREA_WARN then
		self.shakePositions = self.model:GetInitPos()
	end

	return
end

function PileGameController:DoShake()
	for iter_28_0, iter_28_1 in ipairs(self.shakePositions) do
		local var_28_0 = iter_28_1[1]
		local var_28_1 = Vector3(iter_28_1[2], iter_28_1[1].position.y, 0)
		local var_28_2 = Vector3(iter_28_1[3], iter_28_1[1].position.y, 0)

		var_28_0.position = iter_28_1[1].onTheMove == true and Vector3.MoveTowards(var_28_0.position, var_28_1, Time.deltaTime * PileGameConst.SHAKE_SPEED) or Vector3.MoveTowards(var_28_0.position, var_28_2, Time.deltaTime * PileGameConst.SHAKE_SPEED)

		if var_28_0.position.x == var_28_2.x and var_28_0.onTheMove == false then
			var_28_0.onTheMove = true
		elseif var_28_0.position.x == var_28_1.x and var_28_0.onTheMove == true then
			var_28_0.onTheMove = false
		end

		self.view:OnItemPositionChange(var_28_0)
	end

	if self.shakePositions[1][1].position.x ~= self.shakePositions[1][1].position.x then
		self.view:OnShake(self.shakePositions[1][1].position.x - self.shakePositions[1][1].position.x)
	end

	return
end

function PileGameController:DoSink(arg_29_1)
	local var_29_0 = {}

	for iter_29_0 = 1, #self.model.items do
		table.insert(var_29_0, function(arg_30_0)
			self.model.items[iter_29_0].position = self.model:GetNextPos(iter_29_0)

			self.view:OnItemPositionChangeWithAnim(self.model.items[iter_29_0], arg_30_0)

			return
		end)
	end

	parallelAsync({
		function(arg_31_0)
			seriesAsync(var_29_0, arg_31_0)

			return
		end,
		function(arg_32_0)
			self.view:DoSink(self.model:GetFirstItem().sizeDelta.y, arg_32_0)

			return
		end
	}, function()
		self.view:OnRemovePile((self.model:RemoveFirstItem()))
		arg_29_1()

		return
	end)

	return
end

function PileGameController:Shuffling()
	local var_34_0 = self.item.leftMaxPosition
	local var_34_1 = self.item.rightMaxPosition

	self.item.position = self.item.onTheMove == false and Vector3.MoveTowards(self.item.position, var_34_1, Time.deltaTime * self.item.speed) or Vector3.MoveTowards(self.item.position, var_34_0, Time.deltaTime * self.item.speed)

	if self.item.position.x == var_34_1.x and self.item.onTheMove == false then
		self.item.onTheMove = true
	elseif self.item.position.x == var_34_0.x and self.item.onTheMove == true then
		self.item.onTheMove = false
	end

	self.view:OnItemPositionChange(self.item)
	self.view:OnItemIndexPositionChange(self.item)

	return
end

function PileGameController:OnStartDrop()
	local var_35_0 = self.model:GetDropArea(self.item)

	if var_35_0 then
		self.view:OnStartDrop(self.item, var_35_0, (self.model:CanDropOnPrev(self.item)))
	end

	return
end

function PileGameController:Droping()
	self.item.onTheMove = false
	self.item.position = Vector3.MoveTowards(self.item.position, Vector3(self.item.position.x, self.model.ground.position.y - 100, 0), Time.deltaTime * self.item.dropSpeed)

	self.view:OnItemPositionChange(self.item)

	if self.model:IsOverTailItem(self.item) and #self.shakePositions > 0 then
		self:StopShake()
	end

	if self.model:IsStopDrop(self.item) then
		self.state = PileGameController.STATE_STOP_DROP
	end

	return
end

function PileGameController:CheckCollide()
	local var_37_0 = self.model:IsOnGround(self.item)
	local var_37_1 = self.model:GetIndex() == 1
	local var_37_2 = self.model:IsOverDeathLine(self.item)

	if var_37_1 and var_37_0 then
		self:OnStartGame(true)
	elseif not var_37_1 and var_37_0 then
		self.model:AddFailedCnt()
		self.view:UpdateFailedCnt(self.model.maxFailedCnt, self.model.failedCnt, true, self.item)
		self.model:RemoveTailItem()
		self.view:OnRemovePile(self.item)

		if self.model:IsMaxfailedCnt() then
			self:OnEndGame(false)
		else
			self:CheckRock()
			self:OnStartGame(true)
		end
	elseif not var_37_0 and var_37_2 then
		self:OnEndGame(true)
	elseif not var_37_0 and not var_37_2 then
		self.model:AddScore()

		if self.model:IsExceedingTheHighestScore() then
			self.view:OnExceedingTheHighestScore()
		end

		self.view:UpdateScore(self.model.score, self.item)
		self:CheckRock()
		self:OnStartGame(true)
	else
		assert(false, "Why is it running here?")
	end

	return
end

function PileGameController:onBackPressed()
	return self.view:onBackPressed()
end

function PileGameController:Dispose()
	self.gameEndCb = nil
	self.locked = false

	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	self:ExitGame()
	self.model:Dispose()
	self.view:Dispose()
	self:RemoveLockTimer()

	self.shakePositions = {}

	return
end

return PileGameController
