local var_0_0 = class("TowerClimbingController")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.view = TowerClimbingView.New(arg_1_0)

	return
end

function var_0_0.SetCallBack(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.OnGameEndCallBack = arg_2_1
	arg_2_0.OnOverMapScore = arg_2_2

	return
end

function var_0_0.setGameStateCallback(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.startGameCalback = arg_3_1
	arg_3_0.endGameCallback = arg_3_2

	return
end

function var_0_0.setRoomTip(arg_4_0, arg_4_1)
	arg_4_0.view:setRoomTip(arg_4_1)

	return
end

function var_0_0.SetUp(arg_5_0, arg_5_1)
	arg_5_0:NetUpdateData(arg_5_1)
	arg_5_0.view:OnEnter()

	return
end

function var_0_0.NetUpdateData(arg_6_0, arg_6_1)
	arg_6_0.data = arg_6_1

	return
end

function var_0_0.StartGame(arg_7_0, arg_7_1)
	if arg_7_0.enterGame then
		return
	end

	arg_7_0.enterGame = true

	seriesAsync({
		function(arg_8_0)
			arg_7_0.map = TowerClimbingMapVO.New(arg_7_1, arg_7_0.view)

			arg_7_0.view:OnCreateMap(arg_7_0.map, arg_8_0)

			return
		end,
		function(arg_9_0)
			arg_7_0.map:Init(arg_7_0.data, arg_9_0)

			if arg_7_0.startGameCalback then
				arg_7_0.startGameCalback()
			end

			return
		end,
		function(arg_10_0)
			arg_7_0.view:DoEnter(arg_10_0)

			return
		end
	}, function()
		arg_7_0.IsStarting = true

		arg_7_0:MainLoop()
		arg_7_0.view:OnStartGame()

		return
	end)

	return
end

function var_0_0.EnterBlock(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.map:GetPlayer():IsFatalInjured() then
		return
	end

	local var_12_0 = arg_12_0.map:GetPlayer()

	if var_12_0:IsDeath() then
		return
	end

	if arg_12_1.normal == Vector2.up then
		arg_12_0.map:GetPlayer():UpdateStand(true)

		arg_12_0.level = arg_12_2

		arg_12_0.map:SetCurrentLevel(arg_12_2)
	end

	return
end

function var_0_0.StayBlock(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0.map:GetPlayer():IsFatalInjured() then
		return
	end

	local var_13_0 = arg_13_0.map:GetPlayer()

	if var_13_0:IsDeath() then
		return
	end

	if _.any(arg_13_1, function(arg_14_0)
		return arg_14_0.normal == Vector2.up
	end) then
		if not arg_13_0.map:GetPlayer():IsIdle() and arg_13_2 == Vector2(0, 0) then
			arg_13_0.map:GetPlayer():Idle()
		end
	end

	return
end

function var_0_0.ExitBlock(arg_15_0, arg_15_1)
	if arg_15_0.map:GetPlayer():IsFatalInjured() then
		return
	end

	local var_15_0 = arg_15_0.map:GetPlayer()

	if var_15_0:IsDeath() then
		return
	end

	if arg_15_0.level == arg_15_1 then
		arg_15_0.map:GetPlayer():UpdateStand(false)
	end

	return
end

function var_0_0.EnterAttacker(arg_16_0)
	if arg_16_0.map:GetPlayer():IsFatalInjured() then
		return
	end

	local var_16_0 = arg_16_0.map:GetPlayer()

	if var_16_0:IsDeath() then
		return
	end

	arg_16_0.map:GetPlayer():BeInjured()
	arg_16_0.map:GetPlayer():AddInvincibleEffect(TowerClimbingGameSettings.INVINCEIBLE_TIME)

	return
end

function var_0_0.EnterGround(arg_17_0)
	if arg_17_0.map:GetPlayer():IsFatalInjured() then
		return
	end

	local var_17_0 = arg_17_0.map:GetPlayer()

	if var_17_0:IsDeath() then
		return
	end

	arg_17_0.map:GetPlayer():BeFatalInjured(function()
		if not arg_17_0.map:GetPlayer():IsDeath() then
			arg_17_0.map:GetPlayer():AddInvincibleEffect(TowerClimbingGameSettings.INVINCEIBLE_TIME)
			arg_17_0.map:GetPlayer():UpdateStand(true)
			arg_17_0.map:ReBornPlayer()
			arg_17_0.map:GetPlayer():Idle()
		end

		return
	end)

	if not arg_17_0.map:GetPlayer():IsDeath() then
		arg_17_0.map:SetGroundSleep(TowerClimbingGameSettings.GROUND_SLEEP_TIME)
	end

	return
end

function var_0_0.OnStickChange(arg_19_0, arg_19_1)
	if arg_19_0.map:GetPlayer():IsFatalInjured() then
		return
	end

	if arg_19_1 > 0.05 then
		arg_19_0.map:GetPlayer():MoveRight()
	elseif arg_19_1 < -0.05 then
		arg_19_0.map:GetPlayer():MoveLeft()
	end

	return
end

function var_0_0.MainLoop(arg_20_0)
	arg_20_0.handle = arg_20_0.handle or UpdateBeat:CreateListener(arg_20_0.Update, arg_20_0)

	UpdateBeat:AddListener(arg_20_0.handle)

	return
end

function var_0_0.Update(arg_21_0)
	arg_21_0.view:Update()
	arg_21_0.map:Update()

	local var_21_0 = Application.targetFrameRate or 60

	Physics2D.Simulate(1 / var_21_0)

	if arg_21_0.IsStarting then
		if arg_21_0.map:GetPlayer():IsDeath() then
			arg_21_0:EndGame()
		end
	end

	return
end

function var_0_0.PlayerJump(arg_22_0)
	arg_22_0.map:GetPlayer():Jump()

	return
end

function var_0_0.PlayerIdle(arg_23_0)
	arg_23_0.map:GetPlayer():Idle()

	return
end

local function var_0_1(arg_24_0)
	arg_24_0.IsStarting = false

	if arg_24_0.handle then
		UpdateBeat:RemoveListener(arg_24_0.handle)
	end

	return
end

function var_0_0.EndGame(arg_25_0)
	var_0_1(arg_25_0)

	local var_25_0 = arg_25_0.map:GetPlayer()

	arg_25_0.view:OnEndGame(var_25_0.score, var_25_0.mapScore, arg_25_0.map.id)

	if arg_25_0.OnGameEndCallBack then
		arg_25_0.OnGameEndCallBack(var_25_0.score, var_25_0.higestscore, var_25_0.pageIndex, arg_25_0.map.id)
	end

	if arg_25_0.OnOverMapScore and var_25_0:IsOverMapScore() then
		arg_25_0.OnOverMapScore(arg_25_0.map.id, var_25_0.score)
	end

	return
end

function var_0_0.updateHighScore(arg_26_0, arg_26_1)
	arg_26_0.highScores = arg_26_1

	arg_26_0.view:SetHighScore(arg_26_1)

	return
end

function var_0_0.ExitGame(arg_27_0)
	var_0_1(arg_27_0)
	arg_27_0.view:OnExitGame()

	if arg_27_0.map then
		arg_27_0.map:Dispose()

		arg_27_0.map = nil
	end

	arg_27_0.enterGame = nil

	if arg_27_0.endGameCallback then
		arg_27_0.endGameCallback()
	end

	return
end

function var_0_0.onBackPressed(arg_28_0)
	return arg_28_0.view:onBackPressed()
end

function var_0_0.Dispose(arg_29_0)
	arg_29_0:ExitGame()
	arg_29_0.view:Dispose()

	return
end

return var_0_0
