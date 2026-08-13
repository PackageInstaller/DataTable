class = var_0_10000

local var_0_0 = var_0_10000("TowerClimbingController")

function var_0_0.Ctor(arg_1_0)
	TowerClimbingView = var_1_10001
	arg_1_0.view = var_1_10001.New(arg_1_0)

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
	local var_4_0 = arg_4_0.view

	var_2.setRoomTip(var_4_0, arg_4_1)

	return
end

function var_0_0.SetUp(arg_5_0, arg_5_1)
	arg_5_0:NetUpdateData(arg_5_1)

	local var_5_0 = arg_5_0.view

	var_2.OnEnter(var_5_0)

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
	seriesAsync = var_2

	var_2({
		function(arg_8_0)
			local var_8_0 = arg_7_0

			TowerClimbingMapVO = var_2_10002
			var_8_0.map = var_2_10002.New(arg_7_1, arg_7_0.view)

			local var_8_1 = arg_7_0.view

			var_1.OnCreateMap(var_8_1, arg_7_0.map, arg_8_0)

			return
		end,
		function(arg_9_0)
			local var_9_0 = arg_7_0.map

			var_1.Init(var_9_0, arg_7_0.data, arg_9_0)

			if arg_7_0.startGameCalback then
				arg_7_0.startGameCalback()
			end

			return
		end,
		function(arg_10_0)
			local var_10_0 = arg_7_0.view

			var_1.DoEnter(var_10_0, arg_10_0)

			return
		end
	}, function()
		arg_7_0.IsStarting = true

		local var_11_0 = arg_7_0

		var_0.MainLoop(var_11_0)

		local var_11_1 = arg_7_0.view

		var_0.OnStartGame(var_11_1)

		return
	end)

	return
end

function var_0_0.EnterBlock(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.map
	local var_12_1 = var_3.GetPlayer(var_12_0)

	if var_3.IsFatalInjured(var_12_1) then
		return
	end

	local var_12_2 = arg_12_0.map
	local var_12_3 = var_3.GetPlayer(var_12_2)

	if var_3.IsDeath(var_12_3) then
		return
	end

	local var_12_4 = arg_12_1.normal

	Vector2 = var_12_3

	if var_12_4 == var_12_3.up then
		local var_12_5 = arg_12_0.map
		local var_12_6 = var_3.GetPlayer(var_12_5)

		var_3.UpdateStand(var_12_6, true)

		arg_12_0.level = arg_12_2

		local var_12_7 = arg_12_0.map

		var_3.SetCurrentLevel(var_12_7, arg_12_2)
	end

	return
end

function var_0_0.StayBlock(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.map
	local var_13_1 = var_3.GetPlayer(var_13_0)

	if var_3.IsFatalInjured(var_13_1) then
		return
	end

	local var_13_2 = arg_13_0.map
	local var_13_3 = var_3.GetPlayer(var_13_2)

	if var_3.IsDeath(var_13_3) then
		return
	end

	_ = var_3

	if var_3.any(arg_13_1, function(arg_14_0)
		local var_14_0 = arg_14_0.normal

		Vector2 = var_2_10002

		return var_14_0 == var_2_10002.up
	end) then
		local var_13_4 = arg_13_0.map
		local var_13_5 = var_3.GetPlayer(var_13_4)

		if not var_3.IsIdle(var_13_5) then
			Vector2 = var_3

			if arg_13_2 == var_3(0, 0) then
				local var_13_6 = arg_13_0.map
				local var_13_7 = var_3.GetPlayer(var_13_6)

				var_3.Idle(var_13_7)
			end
		end
	end

	return
end

function var_0_0.ExitBlock(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.map
	local var_15_1 = var_2.GetPlayer(var_15_0)

	if var_2.IsFatalInjured(var_15_1) then
		return
	end

	local var_15_2 = arg_15_0.map
	local var_15_3 = var_2.GetPlayer(var_15_2)

	if var_2.IsDeath(var_15_3) then
		return
	end

	if arg_15_0.level == arg_15_1 then
		local var_15_4 = arg_15_0.map
		local var_15_5 = var_2.GetPlayer(var_15_4)

		var_2.UpdateStand(var_15_5, false)
	end

	return
end

function var_0_0.EnterAttacker(arg_16_0)
	local var_16_0 = arg_16_0.map
	local var_16_1 = var_1.GetPlayer(var_16_0)

	if var_1.IsFatalInjured(var_16_1) then
		return
	end

	local var_16_2 = arg_16_0.map
	local var_16_3 = var_1.GetPlayer(var_16_2)

	if var_1.IsDeath(var_16_3) then
		return
	end

	local var_16_4 = arg_16_0.map
	local var_16_5 = var_1.GetPlayer(var_16_4)

	var_1.BeInjured(var_16_5)

	local var_16_6 = arg_16_0.map
	local var_16_7 = var_1.GetPlayer(var_16_6)
	local var_16_8 = var_1.AddInvincibleEffect

	TowerClimbingGameSettings = var_1_10003

	var_16_8(var_16_7, var_1_10003.INVINCEIBLE_TIME)

	return
end

function var_0_0.EnterGround(arg_17_0)
	local var_17_0 = arg_17_0.map
	local var_17_1 = var_1.GetPlayer(var_17_0)

	if var_1.IsFatalInjured(var_17_1) then
		return
	end

	local var_17_2 = arg_17_0.map
	local var_17_3 = var_1.GetPlayer(var_17_2)

	if var_1.IsDeath(var_17_3) then
		return
	end

	local var_17_4 = arg_17_0.map
	local var_17_5 = var_1.GetPlayer(var_17_4)

	var_1.BeFatalInjured(var_17_5, function()
		local var_18_0 = arg_17_0.map
		local var_18_1 = var_0.GetPlayer(var_18_0)

		if not var_0.IsDeath(var_18_1) then
			local var_18_2 = arg_17_0.map
			local var_18_3 = var_0.GetPlayer(var_18_2)
			local var_18_4 = var_0.AddInvincibleEffect

			TowerClimbingGameSettings = var_2_10002

			var_18_4(var_18_3, var_2_10002.INVINCEIBLE_TIME)

			local var_18_5 = arg_17_0.map
			local var_18_6 = var_0.GetPlayer(var_18_5)

			var_0.UpdateStand(var_18_6, true)

			local var_18_7 = arg_17_0.map

			var_0.ReBornPlayer(var_18_7)

			local var_18_8 = arg_17_0.map
			local var_18_9 = var_0.GetPlayer(var_18_8)

			var_0.Idle(var_18_9)
		end

		return
	end)

	local var_17_6 = arg_17_0.map
	local var_17_7 = var_1.GetPlayer(var_17_6)

	if not var_1.IsDeath(var_17_7) then
		local var_17_8 = arg_17_0.map
		local var_17_9 = var_1.SetGroundSleep

		TowerClimbingGameSettings = var_3

		var_17_9(var_17_8, var_3.GROUND_SLEEP_TIME)
	end

	return
end

function var_0_0.OnStickChange(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.map
	local var_19_1 = var_2.GetPlayer(var_19_0)

	if var_2.IsFatalInjured(var_19_1) then
		return
	end

	if arg_19_1 > 0.05 then
		local var_19_2 = arg_19_0.map
		local var_19_3 = var_2.GetPlayer(var_19_2)

		var_2.MoveRight(var_19_3)
	elseif arg_19_1 < -0.05 then
		local var_19_4 = arg_19_0.map
		local var_19_5 = var_2.GetPlayer(var_19_4)

		var_2.MoveLeft(var_19_5)
	end

	return
end

function var_0_0.MainLoop(arg_20_0)
	if not arg_20_0.handle then
		UpdateBeat = var_1
		arg_20_0.handle = var_1:CreateListener(arg_20_0.Update, arg_20_0)
	end

	UpdateBeat = var_1

	var_1:AddListener(arg_20_0.handle)

	return
end

function var_0_0.Update(arg_21_0)
	local var_21_0 = arg_21_0.view

	var_1.Update(var_21_0)

	local var_21_1 = arg_21_0.map

	var_1.Update(var_21_1)

	Physics2D = var_1

	local var_21_2 = var_1.Simulate

	Application = var_21_1

	local var_21_3

	if not var_21_1.targetFrameRate then
		var_21_3 = 60
	end

	var_21_2(1 / var_21_3)

	if arg_21_0.IsStarting then
		local var_21_4 = arg_21_0.map
		local var_21_5 = var_1.GetPlayer(var_21_4)

		if var_1.IsDeath(var_21_5) then
			arg_21_0:EndGame()
		end
	end

	return
end

function var_0_0.PlayerJump(arg_22_0)
	local var_22_0 = arg_22_0.map
	local var_22_1 = var_1.GetPlayer(var_22_0)

	var_1.Jump(var_22_1)

	return
end

function var_0_0.PlayerIdle(arg_23_0)
	local var_23_0 = arg_23_0.map
	local var_23_1 = var_1.GetPlayer(var_23_0)

	var_1.Idle(var_23_1)

	return
end

local function var_0_1(arg_24_0)
	arg_24_0.IsStarting = false

	if arg_24_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_24_0.handle)
	end

	return
end

function var_0_0.EndGame(arg_25_0)
	var_0_1(arg_25_0)

	local var_25_0 = arg_25_0.map
	local var_25_1 = var_1.GetPlayer(var_25_0)
	local var_25_2 = arg_25_0.view

	var_2.OnEndGame(var_25_2, var_25_1.score, var_25_1.mapScore, arg_25_0.map.id)

	if arg_25_0.OnGameEndCallBack then
		arg_25_0.OnGameEndCallBack(var_25_1.score, var_25_1.higestscore, var_25_1.pageIndex, arg_25_0.map.id)
	end

	if arg_25_0.OnOverMapScore and var_25_1:IsOverMapScore() then
		arg_25_0.OnOverMapScore(arg_25_0.map.id, var_25_1.score)
	end

	return
end

function var_0_0.updateHighScore(arg_26_0, arg_26_1)
	arg_26_0.highScores = arg_26_1

	local var_26_0 = arg_26_0.view

	var_2.SetHighScore(var_26_0, arg_26_1)

	return
end

function var_0_0.ExitGame(arg_27_0)
	var_0_1(arg_27_0)

	local var_27_0 = arg_27_0.view

	var_1.OnExitGame(var_27_0)

	if arg_27_0.map then
		local var_27_1 = arg_27_0.map

		var_1.Dispose(var_27_1)

		arg_27_0.map = nil
	end

	arg_27_0.enterGame = nil

	if arg_27_0.endGameCallback then
		arg_27_0.endGameCallback()
	end

	return
end

function var_0_0.onBackPressed(arg_28_0)
	local var_28_0 = arg_28_0.view

	return var_1.onBackPressed(var_28_0)
end

function var_0_0.Dispose(arg_29_0)
	arg_29_0:ExitGame()

	local var_29_0 = arg_29_0.view

	var_1.Dispose(var_29_0)

	return
end

return var_0_0
