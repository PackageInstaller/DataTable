local TowerClimbingController = class("TowerClimbingController")

function TowerClimbingController:Ctor()
	self.view = TowerClimbingView.New(self)

	return
end

function TowerClimbingController:SetCallBack(arg_2_1, arg_2_2)
	self.OnGameEndCallBack = arg_2_1
	self.OnOverMapScore = arg_2_2

	return
end

function TowerClimbingController:setGameStateCallback(arg_3_1, arg_3_2)
	self.startGameCalback = arg_3_1
	self.endGameCallback = arg_3_2

	return
end

function TowerClimbingController:setRoomTip(arg_4_1)
	self.view:setRoomTip(arg_4_1)

	return
end

function TowerClimbingController:SetUp(arg_5_1)
	self:NetUpdateData(arg_5_1)
	self.view:OnEnter()

	return
end

function TowerClimbingController:NetUpdateData(arg_6_1)
	self.data = arg_6_1

	return
end

function TowerClimbingController:StartGame(arg_7_1)
	if self.enterGame then
		return
	end

	self.enterGame = true

	seriesAsync({
		function(arg_8_0)
			self.map = TowerClimbingMapVO.New(arg_7_1, self.view)

			self.view:OnCreateMap(self.map, arg_8_0)

			return
		end,
		function(arg_9_0)
			self.map:Init(self.data, arg_9_0)

			if self.startGameCalback then
				self.startGameCalback()
			end

			return
		end,
		function(arg_10_0)
			self.view:DoEnter(arg_10_0)

			return
		end
	}, function()
		self.IsStarting = true

		self:MainLoop()
		self.view:OnStartGame()

		return
	end)

	return
end

function TowerClimbingController:EnterBlock(arg_12_1, arg_12_2)
	if self.map:GetPlayer():IsFatalInjured() then
		return
	end

	if self.map:GetPlayer():IsDeath() then
		return
	end

	if arg_12_1.normal == Vector2.up then
		self.map:GetPlayer():UpdateStand(true)

		self.level = arg_12_2

		self.map:SetCurrentLevel(arg_12_2)
	end

	return
end

function TowerClimbingController:StayBlock(arg_13_1, arg_13_2)
	if self.map:GetPlayer():IsFatalInjured() then
		return
	end

	if self.map:GetPlayer():IsDeath() then
		return
	end

	if _.any(arg_13_1, function(arg_14_0)
		return arg_14_0.normal == Vector2.up
	end) then
		if not self.map:GetPlayer():IsIdle() and arg_13_2 == Vector2(0, 0) then
			self.map:GetPlayer():Idle()
		end
	end

	return
end

function TowerClimbingController:ExitBlock(arg_15_1)
	if self.map:GetPlayer():IsFatalInjured() then
		return
	end

	if self.map:GetPlayer():IsDeath() then
		return
	end

	if self.level == arg_15_1 then
		self.map:GetPlayer():UpdateStand(false)
	end

	return
end

function TowerClimbingController:EnterAttacker()
	if self.map:GetPlayer():IsFatalInjured() then
		return
	end

	if self.map:GetPlayer():IsDeath() then
		return
	end

	self.map:GetPlayer():BeInjured()
	self.map:GetPlayer():AddInvincibleEffect(TowerClimbingGameSettings.INVINCEIBLE_TIME)

	return
end

function TowerClimbingController:EnterGround()
	if self.map:GetPlayer():IsFatalInjured() then
		return
	end

	if self.map:GetPlayer():IsDeath() then
		return
	end

	self.map:GetPlayer():BeFatalInjured(function()
		if not self.map:GetPlayer():IsDeath() then
			self.map:GetPlayer():AddInvincibleEffect(TowerClimbingGameSettings.INVINCEIBLE_TIME)
			self.map:GetPlayer():UpdateStand(true)
			self.map:ReBornPlayer()
			self.map:GetPlayer():Idle()
		end

		return
	end)

	if not self.map:GetPlayer():IsDeath() then
		self.map:SetGroundSleep(TowerClimbingGameSettings.GROUND_SLEEP_TIME)
	end

	return
end

function TowerClimbingController:OnStickChange(arg_19_1)
	if self.map:GetPlayer():IsFatalInjured() then
		return
	end

	if arg_19_1 > 0.05 then
		self.map:GetPlayer():MoveRight()
	elseif arg_19_1 < -0.05 then
		self.map:GetPlayer():MoveLeft()
	end

	return
end

function TowerClimbingController:MainLoop()
	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	return
end

function TowerClimbingController:Update()
	self.view:Update()
	self.map:Update()
	Physics2D.Simulate(1 / (Application.targetFrameRate or 60))

	if self.IsStarting then
		if self.map:GetPlayer():IsDeath() then
			self:EndGame()
		end
	end

	return
end

function TowerClimbingController:PlayerJump()
	self.map:GetPlayer():Jump()

	return
end

function TowerClimbingController:PlayerIdle()
	self.map:GetPlayer():Idle()

	return
end

local function var_0_1(arg_24_0)
	arg_24_0.IsStarting = false

	if arg_24_0.handle then
		UpdateBeat:RemoveListener(arg_24_0.handle)
	end

	return
end

function TowerClimbingController:EndGame()
	var_0_1(self)

	local var_25_0 = self.map:GetPlayer()

	self.view:OnEndGame(var_25_0.score, var_25_0.mapScore, self.map.id)

	if self.OnGameEndCallBack then
		self.OnGameEndCallBack(var_25_0.score, var_25_0.higestscore, var_25_0.pageIndex, self.map.id)
	end

	if self.OnOverMapScore and var_25_0:IsOverMapScore() then
		self.OnOverMapScore(self.map.id, var_25_0.score)
	end

	return
end

function TowerClimbingController:updateHighScore(arg_26_1)
	self.highScores = arg_26_1

	self.view:SetHighScore(arg_26_1)

	return
end

function TowerClimbingController:ExitGame()
	var_0_1(self)
	self.view:OnExitGame()

	if self.map then
		self.map:Dispose()

		self.map = nil
	end

	self.enterGame = nil

	if self.endGameCallback then
		self.endGameCallback()
	end

	return
end

function TowerClimbingController:onBackPressed()
	return self.view:onBackPressed()
end

function TowerClimbingController:Dispose()
	self:ExitGame()
	self.view:Dispose()

	return
end

return TowerClimbingController
